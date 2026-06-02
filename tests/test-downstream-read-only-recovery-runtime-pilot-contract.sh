#!/usr/bin/env bash
# Verify the downstream read-only recovery-runtime pilot contract stays compact and bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/downstream-read-only-recovery-runtime-pilot-contract.md"

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
    "target_repo_identity",
    "target_path_or_name",
    "target_git_head_before",
    "target_git_head_after",
    "target_dirty_count_before",
    "target_dirty_count_after",
    "auditor_as_replay_artifact_path",
    "advisor_artifact_path",
    "optimizer_replay_receipt_path",
    "generated_patch_pack_path",
    "patch_metadata_path",
    "blocker_path",
    "apply_check_result_path",
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

echo "=== Downstream Read-Only Recovery Runtime Pilot Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "contract preserves required receipt semantics" assert_contract_semantics

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
    "target_repo_identity" \
    "target_path_or_name" \
    "target_git_head_before" \
    "target_git_head_after" \
    "target_dirty_count_before" \
    "target_dirty_count_after" \
    "auditor_as_replay_artifact_path" \
    "advisor_artifact_path" \
    "optimizer_replay_receipt_path" \
    "generated_patch_pack_path" \
    "patch_metadata_path" \
    "blocker_path" \
    "apply_check_result_path" \
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
    "automatic GitHub issue creation"; do
    check "contract includes boundary text: $boundary" grep -Fq "$boundary" "$CONTRACT"
done

check "README points to contract" grep -Fq "downstream-read-only-recovery-runtime-pilot-contract.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/downstream-read-only-recovery-runtime-pilot-contract.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-downstream-read-only-recovery-runtime-pilot-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
