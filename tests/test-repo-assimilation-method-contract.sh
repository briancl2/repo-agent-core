#!/usr/bin/env bash
# Verify the repo assimilation method umbrella contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/repo-assimilation-method-contract.md"
TEMPLATE="$REPO_ROOT/templates/repo-assimilation-method.md"
CLEAN_FIXTURE="$REPO_ROOT/tests/fixtures/ASSIMILATION_SOLO_NATIVE_ARCHITECTURE_CLEAN.json"
STALE_FIXTURE="$REPO_ROOT/tests/fixtures/ASSIMILATION_STALE_NATIVE_CONSTRAINT_FOUND.json"
ENTERPRISE_FIXTURE="$REPO_ROOT/tests/fixtures/ASSIMILATION_SOLO_REJECTS_ENTERPRISE_ARCHITECTURE.json"

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
    "operator_count",
    "host_count",
    "actual_concurrency",
    "unattended_runtime_need",
    "smallest_native_architecture",
    "stale_native_constraint_intake",
    "skeleton_steps_applied",
    "mechanics_applied",
    "seeded_hypotheses",
    "finding_classification",
    "maturity_claim_class",
    "validated_domain_outcome_delta",
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
    "domain-outcome eval gate",
    "true lever",
    "prompt instruction",
    "832cfcd",
    "same-judge",
    "one operator on one laptop",
    "reject_enterprise_without_observed_need",
    "update_stale_constraint",
    "preserve_valid_authority_boundary",
    "conditionally mandatory",
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
assert payload["operator_count"] == 1
assert payload["host_count"] == 1
assert isinstance(payload["actual_concurrency"], int) and payload["actual_concurrency"] >= 1
assert payload["unattended_runtime_need"]["state"] in {"none_observed", "observed"}
architecture = payload["smallest_native_architecture"]
for key in [
    "candidate",
    "larger_proposed_shape",
    "enterprise_components",
    "concrete_observed_need",
    "disposition",
]:
    assert key in architecture, key
assert architecture["disposition"] == "admit_smallest_native"
intake = payload["stale_native_constraint_intake"]
for key in [
    "status",
    "old_constraint",
    "current_native_activation_rule",
    "proof_boundary",
    "authority_boundary",
    "touched_validator_or_test",
    "owner_surface_evidence",
    "disposition",
]:
    assert key in intake, key
assert intake["status"] == "clean"
assert intake["disposition"] == "no_change"
assert payload["n_evidence"] == 2
assert payload["decision_state"] == "adopt"
assert payload["maturity_claim_class"] == "operating-model-progress"
delta = payload["validated_domain_outcome_delta"]
assert delta["result_class"] in {
    "confirmed",
    "null-reported",
    "negative-reported",
    "not-applicable",
}, delta["result_class"]
assert delta["result_class"] == "confirmed"
for key in [
    "domain_enhancement",
    "outcome_lever",
    "rejected_proxy",
    "target_variable",
    "pre_registered_metric",
    "target_own_eval",
    "measured_delta",
    "owner_contract_respected",
]:
    assert key in delta, key
assert payload["mechanics_applied"]["closure_ceremony_portability"].startswith("checked:")
assert any("external repo path coupling" in item for item in payload["seeded_hypotheses"])
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "n=2 observation",
    "does not query or mutate github",
    "does not replace github issue/pr/check/merge truth",
    "does not require local sibling repo paths",
]:
    assert phrase in claims, phrase
PY
}

assert_solo_native_fixtures() {
    python3 - "$CLEAN_FIXTURE" "$STALE_FIXTURE" "$ENTERPRISE_FIXTURE" <<'PY'
import json
import sys

clean, stale, enterprise = [json.load(open(path, encoding="utf-8")) for path in sys.argv[1:]]

required = {
    "operator_count",
    "host_count",
    "actual_concurrency",
    "unattended_runtime_need",
    "smallest_native_architecture",
    "stale_native_constraint_intake",
}
for payload in [clean, stale, enterprise]:
    assert required <= payload.keys(), required - payload.keys()
    assert isinstance(payload["operator_count"], int) and payload["operator_count"] >= 1
    assert isinstance(payload["host_count"], int) and payload["host_count"] >= 1
    assert isinstance(payload["actual_concurrency"], int) and payload["actual_concurrency"] >= 1

# A still-current native constraint is a clean control, not migration friction.
clean_intake = clean["stale_native_constraint_intake"]
assert clean_intake["status"] == "clean"
assert clean_intake["disposition"] == "no_change"
assert clean_intake["old_constraint"] == clean_intake["current_native_activation_rule"]
assert clean_intake["touched_validator_or_test"] == []

# A positive migration-friction finding is evidence-complete and names executable glue.
stale_intake = stale["stale_native_constraint_intake"]
assert stale_intake["status"] == "migration_friction_found"
assert stale_intake["disposition"] == "update_stale_constraint"
for key in [
    "old_constraint",
    "current_native_activation_rule",
    "proof_boundary",
    "authority_boundary",
    "touched_validator_or_test",
    "owner_surface_evidence",
]:
    assert stale_intake[key], key
assert stale_intake["old_constraint"] != stale_intake["current_native_activation_rule"]

# One operator on one host with no observed need must reject enterprise machinery.
assert enterprise["operator_count"] == 1
assert enterprise["host_count"] == 1
assert enterprise["unattended_runtime_need"]["state"] == "none_observed"
architecture = enterprise["smallest_native_architecture"]
assert architecture["enterprise_components"]
assert architecture["concrete_observed_need"] == []
assert architecture["disposition"] == "reject_enterprise_without_observed_need"
PY
}

echo "=== Repo Assimilation Method Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves method semantics" assert_contract_semantics
check "template preserves method semantics" assert_template_semantics
check "solo native architecture and stale-constraint fixtures pass" assert_solo_native_fixtures
check "contract records domain-outcome eval gate field" grep -Fq "validated_domain_outcome_delta" "$CONTRACT"
check "template records domain-outcome eval gate field" grep -Fq "validated_domain_outcome_delta" "$TEMPLATE"
check "README points to contract" grep -Fq "repo-assimilation-method-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "repo-assimilation-method.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/repo-assimilation-method-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/repo-assimilation-method.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-repo-assimilation-method-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
