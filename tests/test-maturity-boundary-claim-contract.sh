#!/usr/bin/env bash
# Verify the maturity-boundary claim contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/maturity-boundary-claim-contract.md"
TEMPLATE="$REPO_ROOT/templates/maturity-boundary-claim.md"

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
    "claim_class",
    "claim_text",
    "proof_provided",
    "proof_required",
    "overclaim_guard",
    "decision_state",
    "bounded_non_claims",
]:
    assert field in text, field

for claim_class in [
    "operating-model-progress",
    "repo-agent-readiness",
    "repo-agent-capability",
    "stack-integrated-capability",
]:
    assert claim_class in lower, claim_class

for phrase in [
    "progress, but it is not autonomy",
    "overclaim",
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

assert payload["artifact"] == "MATURITY_BOUNDARY_CLAIM_RECORD"
assert payload["schema_version"] == 1
assert payload["claim_class"] == "operating-model-progress"
assert payload["decision_state"] == "adopt"
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "n=2 observation",
    "does not query or mutate github",
    "does not replace github issue/pr/check/merge truth",
    "does not claim repo-agent-capability",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Maturity-Boundary Claim Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves maturity-boundary semantics" assert_contract_semantics
check "template preserves maturity-boundary semantics" assert_template_semantics
check "README points to contract" grep -Fq "maturity-boundary-claim-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "maturity-boundary-claim.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/maturity-boundary-claim-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/maturity-boundary-claim.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-maturity-boundary-claim-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
