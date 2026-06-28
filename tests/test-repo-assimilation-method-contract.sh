#!/usr/bin/env bash
# Verify the repo assimilation method umbrella contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/repo-assimilation-method-contract.md"
TEMPLATE="$REPO_ROOT/templates/repo-assimilation-method.md"

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
    "target_repo",
    "skeleton_steps_applied",
    "mechanics_applied",
    "seeded_hypotheses",
    "finding_classification",
    "maturity_claim_class",
    "n_evidence",
    "decision_state",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "candidate assimilation skeleton",
    "benchmark changed selection",
    "finding classification",
    "seeded hypotheses",
    "progress, but it is not autonomy",
    "n=2",
    "repo-auditor",
    "repo-upgrade-advisor",
]:
    assert phrase in lower, phrase

# The umbrella must cite all five mechanic contracts.
for mechanic in [
    "principle-alignment-anchor-contract.md",
    "repo-anthropology-contract.md",
    "benchmark-before-repair-contract.md",
    "repair-decision-block-contract.md",
    "maturity-boundary-claim-contract.md",
]:
    assert mechanic in text, mechanic

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

assert payload["artifact"] == "REPO_ASSIMILATION_METHOD_RECORD"
assert payload["schema_version"] == 1
assert payload["target_repo"] == "transcript_processor"
assert payload["n_evidence"] == 2
assert payload["decision_state"] == "adopt"
assert payload["maturity_claim_class"] == "operating-model-progress"
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "n=2 observation",
    "does not query or mutate github",
    "does not replace github issue/pr/check/merge truth",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Repo Assimilation Method Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves method semantics" assert_contract_semantics
check "template preserves method semantics" assert_template_semantics
check "README points to contract" grep -Fq "repo-assimilation-method-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "repo-assimilation-method.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/repo-assimilation-method-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/repo-assimilation-method.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-repo-assimilation-method-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
