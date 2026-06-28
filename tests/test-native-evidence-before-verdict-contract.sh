#!/usr/bin/env bash
# Verify the native-evidence-before-verdict contract stays bounded and evidence-first.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/native-evidence-before-verdict-contract.md"
TEMPLATE="$REPO_ROOT/templates/native-evidence-before-verdict.md"

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
    "component_identity",
    "intended_operator_outcome",
    "verdict_class",
    "current_upstream_docs_checked",
    "native_model_mapped",
    "native_attempt_or_blocker",
    "verdict_bearing_evidence",
    "owner_surface",
    "validation_scope",
    "advisory_gbrain_ref",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "docs readback is necessary but not sufficient",
    "current upstream docs and root instructions",
    "native architecture, setup/configuration model, trust boundaries",
    "safe documented native attempt",
    "concrete owner-surface blocker",
    "real command output, native result evidence, or concrete blocker",
    "negative claims as verdicts",
    "not production-ready",
    "not ga",
    "fallback required",
    "bma/issue164/native-evidence-before-verdict",
    "repo-auditor",
    "repo-upgrade-advisor",
    "repo-optimizer",
    "gbrain does not override operator intent",
    "copy-sync/citation guidance",
]:
    assert phrase in lower, phrase

for forbidden in [
    "gbrain is canonical",
    "gbrain overrides operator intent",
    "background gbrain is allowed",
    "starts a controller",
    "starts a scheduler",
    "auto-creates issues",
    "may mutate downstream",
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

assert payload["artifact"] == "NATIVE_EVIDENCE_BEFORE_VERDICT"
assert payload["schema_version"] == 1
for field in [
    "component_identity",
    "intended_operator_outcome",
    "verdict_class",
    "current_upstream_docs_checked",
    "native_model_mapped",
    "native_attempt_or_blocker",
    "verdict_bearing_evidence",
    "owner_surface",
    "validation_scope",
    "advisory_gbrain_ref",
    "bounded_non_claims",
]:
    assert payload.get(field), field

assert len(payload["current_upstream_docs_checked"]) >= 3
assert payload["native_attempt_or_blocker"]["kind"] in {"native_attempt", "concrete_blocker"}
assert payload["verdict_bearing_evidence"]["contains_native_output_or_blocker"] is True
assert payload["advisory_gbrain_ref"]["slug"] == "bma/issue164/native-evidence-before-verdict"

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not make gbrain canonical",
    "does not let gbrain override operator intent",
    "does not prove production readiness",
    "does not authorize background gbrain sync/watch",
    "does not create a controller",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Native Evidence Before Verdict Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves native-evidence semantics" assert_contract_semantics
check "template preserves native-evidence receipt semantics" assert_template_semantics
check "README points to contract" grep -Fq "native-evidence-before-verdict-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "native-evidence-before-verdict.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/native-evidence-before-verdict-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/native-evidence-before-verdict.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-native-evidence-before-verdict-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
