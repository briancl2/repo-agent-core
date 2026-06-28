#!/usr/bin/env bash
# Verify the repair decision-block contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/repair-decision-block-contract.md"
TEMPLATE="$REPO_ROOT/templates/repair-decision-block.md"

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
import sys

text = open(sys.argv[1], encoding="utf-8").read()
lower = text.lower()

for field in [
    "artifact",
    "schema_version",
    "outcome",
    "failing_observable",
    "rejected_alternatives",
    "expected_metric",
    "issue_branch_pr_check_path",
    "bounded_non_claim",
    "triggers_decision_block",
    "decision_state",
]:
    assert field in text, field

for phrase in [
    "decision block",
    "first-in-family",
    "selection-changing",
    "n=2",
    "repo-auditor",
    "repo-upgrade-advisor",
]:
    assert phrase in lower, phrase

for forbidden in [
    "starts a daemon",
    "creates a queue",
    "gbrain is canonical",
    "hermes is the campaign owner",
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

assert payload["artifact"] == "REPAIR_DECISION_BLOCK_RECORD"
assert payload["schema_version"] == 1
assert payload["decision_state"] == "adopt"
assert payload["triggers_decision_block"] is True
for field in [
    "outcome",
    "failing_observable",
    "expected_metric",
    "issue_branch_pr_check_path",
    "bounded_non_claim",
]:
    assert isinstance(payload[field], str) and payload[field], field
claims = " ".join(payload["record_bounded_non_claims"]).lower()
for phrase in [
    "n=2 observation",
    "does not query or mutate github",
    "does not replace github issue/pr/check/merge truth",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Repair Decision-Block Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves repair decision-block semantics" assert_contract_semantics
check "template preserves repair decision-block semantics" assert_template_semantics
check "README points to contract" grep -Fq "repair-decision-block-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "repair-decision-block.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/repair-decision-block-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/repair-decision-block.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-repair-decision-block-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
