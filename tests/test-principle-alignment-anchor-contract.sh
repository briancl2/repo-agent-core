#!/usr/bin/env bash
# Verify the principle-alignment anchor contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/principle-alignment-anchor-contract.md"
TEMPLATE="$REPO_ROOT/templates/principle-alignment-anchor.md"

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
    "repo_identity",
    "imported_canon",
    "reconciliation_table",
    "revealed_principles",
    "principle_gap_matrix",
    "codification_target",
    "selection_gate",
    "right_sizing_basis",
    "validation",
    "decision_state",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "principle-alignment anchor",
    "native-before-custom",
    "present-but-scattered",
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

assert payload["artifact"] == "PRINCIPLE_ALIGNMENT_ANCHOR_RECORD"
assert payload["schema_version"] == 1
assert payload["repo_identity"]["repo"] == "transcript_processor"
assert payload["imported_canon"]["source"].endswith("/164")
assert payload["decision_state"] == "adopt"
assert payload["codification_target"]["native_before_custom"] is True
assert "gap severity" in payload["selection_gate"]["chosen_by"]
assert "reconstructed" in payload["right_sizing_basis"]["bounded_non_claim"]
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "n=2 observation",
    "does not query or mutate github",
    "does not replace github issue/pr/check/merge truth",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Principle-Alignment Anchor Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves anchor semantics" assert_contract_semantics
check "template preserves anchor semantics" assert_template_semantics
check "README points to contract" grep -Fq "principle-alignment-anchor-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "principle-alignment-anchor.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/principle-alignment-anchor-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/principle-alignment-anchor.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-principle-alignment-anchor-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
