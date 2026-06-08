#!/usr/bin/env bash
# Verify the downstream read-only recovery-runtime pilot contract stays compact and bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/downstream-read-only-recovery-runtime-pilot-contract.md"
TEMPLATE="$REPO_ROOT/templates/downstream-read-only-recovery-runtime-pilot.md"

PASS=0
FAIL=0

check() {
    local desc="$1"
    shift
    if "$@"; then
        echo "  PASS: $desc"
        PASS=$((PASS + 1))
    else
        echo "  FAIL: $desc"
        FAIL=$((FAIL + 1))
    fi
}

assert_contract_semantics() {
    python3 - "$CONTRACT" <<'PY'
import re
import sys

text = open(sys.argv[1], encoding="utf-8").read()
lower = text.lower()

required_fields = [
    "source_issue_or_pr",
    "target_repo_identity",
    "target_path_or_name",
    "target_repo_commit",
    "target_git_head_before",
    "target_git_head_after",
    "target_dirty_count_before",
    "target_dirty_count_after",
    "pilot_purpose",
    "selected_repo_star_tools",
    "hermes_foreground_receipt_path",
    "gbrain_advisory_inputs",
    "commands_run",
    "auditor_as_replay_artifact_path",
    "advisor_artifact_path",
    "optimizer_replay_receipt_path",
    "generated_patch_pack_path",
    "patch_metadata_path",
    "blocker_path",
    "apply_check_result_path",
    "github_summary_surface",
    "local_artifact_retention_policy",
    "bma_ceremony_leakage_checklist",
    "bounded_non_claims",
]
for field in required_fields:
    assert field in text, field

for phrase in [
    "only outside the target repo",
    "usually /tmp",
    "never applies patches",
    "never opens downstream prs/issues",
    "copy-sync or citation only",
    "no daemon",
    "no scheduler",
    "no queue",
    "no controller",
    "no retry loop",
    "no hidden registry",
    "no background sync",
    "no mcp server",
    "no automatic github issue creation",
    "gbrain remains advisory",
    "repo-optimizer without a patch-ready materialization gap",
    "github carries the compact outcome",
    "local /tmp artifacts remain",
    "bma labels",
    "issue #164 task-closure semantics",
    "completion manifests",
    "retained report packages",
    "campaign-sync machinery",
]:
    assert phrase in lower, phrase

# The contract must describe generated patch artifacts as receipts only, not as
# permission to mutate the downstream checkout.
non_claims = lower[lower.index("bounded non-claims"):]
for phrase in [
    "does not apply patches",
    "does not open downstream prs or issues",
    "does not mutate the target repo",
    "does not install hooks",
    "does not export bma labels",
    "does not make gbrain canonical",
    "does not make hermes the campaign owner",
    "does not start a daemon",
]:
    assert phrase in non_claims, phrase

# Avoid positive regrowth language that would convert the pilot into a control plane.
for forbidden in [
    "may apply patches",
    "can apply patches",
    "it opens downstream prs",
    "it creates downstream issues",
    "starts a daemon",
    "starts a scheduler",
    "background sync keeps",
    "hidden registry tracks",
]:
    assert forbidden not in lower, forbidden
PY
}

assert_template_semantics() {
    python3 - "$TEMPLATE" <<'PY'
import json
import re
import sys

text = open(sys.argv[1], encoding="utf-8").read()
match = re.search(r"```json\n(.*?)\n```", text, re.S)
assert match, "template JSON fence"
payload = json.loads(match.group(1))

assert payload["artifact"] == "DOWNSTREAM_READ_ONLY_RECOVERY_RUNTIME_PILOT_RECEIPT"
assert payload["schema_version"] == 1
assert payload["target_repo_commit"]
assert payload["target_git_head_before"] == payload["target_git_head_after"]
assert payload["target_dirty_count_before"] == payload["target_dirty_count_after"]
assert payload["hermes_foreground_receipt_path"]
assert payload["gbrain_advisory_inputs"]
assert payload["commands_run"]
assert payload["github_summary_surface"]
assert "closure truth" in payload["local_artifact_retention_policy"].lower()

tools = {row["tool"]: row["participation"] for row in payload["selected_repo_star_tools"]}
assert tools["repo-auditor"] == "used"
assert tools["repo-optimizer"] == "skipped_without_patch_ready_gap"

checklist = " ".join(payload["bma_ceremony_leakage_checklist"]).lower()
for phrase in [
    "issue #164 labels",
    "completion manifests",
    "retained closeout/report packages",
    "local closeout receipts",
    "campaign-sync machinery",
]:
    assert phrase in checklist, phrase

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not mutate the target repo",
    "does not apply patches",
    "does not open downstream prs or issues",
    "does not export bma labels",
    "does not make gbrain canonical",
    "does not make hermes the campaign owner",
    "does not start a daemon",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Downstream Read-Only Recovery Runtime Pilot Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves required receipt semantics" assert_contract_semantics
check "template preserves required receipt semantics" assert_template_semantics

for composed in \
    "docs/foreground-recovery-runtime-contract.md" \
    "docs/hermes-foreground-launcher-contract.md" \
    "docs/interruption-recovery-and-batch-reconstitution-contract.md"; do
    check "contract cites related contract $composed" grep -Fq "$composed" "$CONTRACT"
done

for field in \
    "artifact" \
    "schema_version" \
    "generated_at" \
    "source_issue_or_pr" \
    "target_repo_identity" \
    "target_path_or_name" \
    "target_repo_commit" \
    "target_git_head_before" \
    "target_git_head_after" \
    "target_dirty_count_before" \
    "target_dirty_count_after" \
    "pilot_purpose" \
    "selected_repo_star_tools" \
    "hermes_foreground_receipt_path" \
    "gbrain_advisory_inputs" \
    "commands_run" \
    "auditor_as_replay_artifact_path" \
    "advisor_artifact_path" \
    "optimizer_replay_receipt_path" \
    "generated_patch_pack_path" \
    "patch_metadata_path" \
    "blocker_path" \
    "apply_check_result_path" \
    "github_summary_surface" \
    "local_artifact_retention_policy" \
    "bma_ceremony_leakage_checklist" \
    "bounded_non_claims"; do
    check "contract includes receipt field $field" grep -Fq "$field" "$CONTRACT"
done

for boundary in \
    "only outside the target repo" \
    "usually /tmp" \
    "never applies patches" \
    "never opens downstream PRs/issues" \
    "copy-sync or citation only" \
    "runtime dependency" \
    "daemon" \
    "scheduler" \
    "queue" \
    "controller" \
    "retry loop" \
    "hidden registry" \
    "background sync" \
    "MCP server" \
    "automatic GitHub issue creation" \
    "GBrain remains advisory" \
    "patch-ready materialization gap" \
    "GitHub carries the compact outcome" \
    "BMA labels" \
    "Issue #164 task-closure semantics" \
    "completion manifests" \
    "retained report packages" \
    "campaign-sync machinery"; do
    check "contract includes boundary text: $boundary" grep -Fq "$boundary" "$CONTRACT"
done

check "README points to contract" grep -Fq "downstream-read-only-recovery-runtime-pilot-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "downstream-read-only-recovery-runtime-pilot.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/downstream-read-only-recovery-runtime-pilot-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/downstream-read-only-recovery-runtime-pilot.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-downstream-read-only-recovery-runtime-pilot-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
