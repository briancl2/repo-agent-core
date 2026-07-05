#!/usr/bin/env bash
# fleet-floor-conformance-audit.sh — On-demand, READ-ONLY live-drift fleet
# self-audit for the repo-agent consistency floor (BMA #1214 Phase 4 item b).
#
# Usage: bash fleet-floor-conformance-audit.sh
#
# For each of the 5 fleet repos it reads LIVE GitHub truth (read-only) and
# asserts, per repo:
#   * the floor receipt on `main` passes the canonical static validator
#     (floor v0.2, one parsing json block, schema_version 1,
#      non-empty ci_check_contract.branch_protection_required_checks,
#      domain_outcome_delta with a result_class);
#   * set(receipt branch_protection_required_checks) == set(live GitHub
#     required_status_checks.contexts) — this catches the exact drift class
#     BMA #1214 Phase 4(a) exposed (a receipt claiming stale protection);
#   * (consumers only) the vendored scripts/validate-floor-receipt.sh is
#     byte-identical to core's canonical copy (copy-sync drift guard, D2).
#
# Prints a per-repo table and EXITS NON-ZERO if any repo drifts or fails static
# conformance.
#
# This command is manual / on-demand only. It is NOT a CI check and creates no
# controller, scheduler, queue, daemon, cron job, registry, watcher, or
# background process. It never mutates any repo. It requires an ambient gh token
# with read access to the 5 repos.
#
# Env overrides (optional):
#   FLEET_OWNER            GitHub owner (default: briancl2)
#   CANONICAL_VALIDATOR    Local path to treat as the canonical validator
#                          (default: fetch scripts/validate-floor-receipt.sh
#                          from repo-agent-core main). Useful for pre-merge
#                          smoke tests from a branch checkout.

set -euo pipefail

command -v gh >/dev/null 2>&1 || { echo "ERROR: gh CLI not found" >&2; exit 2; }
command -v python3 >/dev/null 2>&1 || { echo "ERROR: python3 not found" >&2; exit 2; }

FLEET_OWNER="${FLEET_OWNER:-briancl2}" \
CANONICAL_VALIDATOR="${CANONICAL_VALIDATOR:-}" \
python3 - <<'PY'
import base64
import json
import os
import subprocess
import sys
import tempfile

OWNER = os.environ.get("FLEET_OWNER", "briancl2")
CANONICAL_LOCAL = os.environ.get("CANONICAL_VALIDATOR", "").strip()

CORE = "repo-agent-core"
REPOS = [
    "repo-agent-core",
    "repo-upgrade-advisor",
    "repo-optimizer",
    "repo-auditor",
    "build-meta-analysis",
]
RECEIPT = "docs/repo-agent-fleet-consistency-floor-receipt.md"
VALIDATOR = "scripts/validate-floor-receipt.sh"


def gh_contents(repo, path):
    """Return decoded file text from <owner>/<repo>@main, or None if absent."""
    try:
        out = subprocess.run(
            ["gh", "api", f"repos/{OWNER}/{repo}/contents/{path}?ref=main",
             "--jq", ".content"],
            capture_output=True, text=True, check=True,
        ).stdout.strip()
    except subprocess.CalledProcessError:
        return None
    if not out:
        return None
    return base64.b64decode(out).decode("utf-8", errors="replace")


def gh_contexts(repo):
    """Return the sorted list of live required-status-check contexts, or None."""
    try:
        out = subprocess.run(
            ["gh", "api", f"repos/{OWNER}/{repo}/branches/main/protection",
             "--jq", ".required_status_checks.contexts"],
            capture_output=True, text=True, check=True,
        ).stdout.strip()
    except subprocess.CalledProcessError:
        # No branch protection (404) or other read error → unreadable.
        return None
    try:
        parsed = json.loads(out)
    except json.JSONDecodeError:
        return None
    # A protected branch with no required status checks yields null/None here;
    # a non-list is not a usable context set, so treat it as unreadable
    # (fail-closed to DRIFT) rather than crashing on sorted(None).
    if not isinstance(parsed, list):
        return None
    return sorted(parsed)


tmp = tempfile.mkdtemp(prefix="fleet-floor-audit-")

# Resolve the canonical validator.
if CANONICAL_LOCAL:
    with open(CANONICAL_LOCAL, encoding="utf-8") as fh:
        canonical_text = fh.read()
    canonical_src = f"local:{CANONICAL_LOCAL}"
else:
    canonical_text = gh_contents(CORE, VALIDATOR)
    canonical_src = f"{OWNER}/{CORE}@main:{VALIDATOR}"
    if canonical_text is None:
        print(f"ERROR: canonical validator not found at {canonical_src}",
              file=sys.stderr)
        print("       (run after the core PR merges, or set CANONICAL_VALIDATOR)",
              file=sys.stderr)
        sys.exit(2)

validator_path = os.path.join(tmp, "validate-floor-receipt.sh")
with open(validator_path, "w", encoding="utf-8") as fh:
    fh.write(canonical_text)


def receipt_contexts(text):
    """Extract branch_protection_required_checks from a receipt's json block."""
    import re
    blocks = re.findall(r"```json\s*(.*?)```", text, re.DOTALL)
    if len(blocks) != 1:
        return None
    try:
        data = json.loads(blocks[0])
    except json.JSONDecodeError:
        return None
    checks = data.get("ci_check_contract", {}).get("branch_protection_required_checks")
    if not isinstance(checks, list):
        return None
    return sorted(checks)


rows = []
any_fail = False

for repo in REPOS:
    static_ok = False
    set_match = None
    vendor_ok = None  # None = N/A (core), True/False for consumers
    live = gh_contexts(repo)
    recorded = None

    text = gh_contents(repo, RECEIPT)
    if text is None:
        rows.append((repo, "-", "-", "MISSING", "receipt not found on main"))
        any_fail = True
        continue

    receipt_file = os.path.join(tmp, f"receipt-{repo}.md")
    with open(receipt_file, "w", encoding="utf-8") as fh:
        fh.write(text)

    res = subprocess.run(["bash", validator_path, receipt_file],
                         capture_output=True, text=True)
    static_ok = res.returncode == 0
    static_msg = "" if static_ok else res.stderr.strip().splitlines()[-1] if res.stderr.strip() else "static fail"

    recorded = receipt_contexts(text)

    if live is None:
        set_match = False
        note = "live protection unreadable"
    elif recorded is None:
        set_match = False
        note = "receipt contexts unreadable"
    else:
        set_match = set(recorded) == set(live)
        note = "" if set_match else f"recorded={recorded} live={live}"

    if repo != CORE:
        vendored = gh_contents(repo, VALIDATOR)
        if vendored is None:
            vendor_ok = False
            note = (note + "; " if note else "") + "vendored validator missing"
        else:
            vendor_ok = (vendored == canonical_text)
            if not vendor_ok:
                note = (note + "; " if note else "") + "vendored validator drift"

    verdict_ok = static_ok and bool(set_match) and (vendor_ok is not False)
    if not verdict_ok:
        any_fail = True
        if static_msg and not note:
            note = static_msg
        elif static_msg:
            note = static_msg + "; " + note

    recorded_disp = ",".join(recorded) if recorded else "-"
    live_disp = ",".join(live) if live else "-"
    verdict = "OK" if verdict_ok else "DRIFT"
    vendor_disp = {True: "match", False: "DRIFT", None: "n/a"}[vendor_ok]
    rows.append((repo, recorded_disp, live_disp, verdict,
                 f"static={'ok' if static_ok else 'FAIL'} vendored={vendor_disp}"
                 + (f"; {note}" if note else "")))

# Render table.
print(f"Fleet floor conformance audit — owner={OWNER}, canonical={canonical_src}")
print("=" * 100)
w = max(len(r[0]) for r in rows)
for repo, rec, liv, verdict, detail in rows:
    print(f"{repo:<{w}}  {verdict:<6}  recorded[{rec}]  live[{liv}]")
    if detail:
        print(f"{'':<{w}}          {detail}")
print("=" * 100)

ok_count = sum(1 for r in rows if r[3] == "OK")
print(f"Result: {ok_count}/{len(REPOS)} conform")

if any_fail:
    print("FAIL: fleet floor drift detected — route to owner-surface truth.")
    sys.exit(1)
print("PASS: fleet floor conforms (no drift).")
PY
