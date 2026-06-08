#!/usr/bin/env bash
# Verify the repo-star downstream genericity proof contract stays bounded and non-mutating.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/repo-star-downstream-genericity-proof-contract.md"
TEMPLATE="$REPO_ROOT/templates/repo-star-downstream-genericity-proof-receipt.md"
SAMPLE="$REPO_ROOT/tests/samples/REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT.json"

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
    "target_identities",
    "target_git_state_matrix",
    "target_native_gate_matrix",
    "repo_star_command_list",
    "output_roots",
    "privacy_redaction_note",
    "bma_ceremony_leakage_checklist",
    "github_summary_surface",
    "owner_routing",
    "genericity_verdict",
    "bounded_non_claims",
]:
    assert field in text, field

for state in [
    "no_retained_gate",
    "parseable_pass",
    "parseable_warning",
    "parseable_fail",
    "partial_run",
    "stale_fleet_metric",
    "true_target_risk",
    "amendment_required_unknown",
]:
    assert state in text, state

for phrase in [
    "exactly two real non-bma targets",
    "writes generated evidence only outside target repositories",
    "read-only success requires exact before/after matches",
    "instead of flattening ambiguity into a generic",
    "do not force repo-upgrade-advisor without auditor evidence",
    "do not force repo-optimizer without a patch-ready owner row",
    "never applies patches",
    "bma labels",
    "issue #164 task-closure semantics",
    "retained report packages",
    "completion manifests",
    "local closeout receipts",
    "campaign-sync machinery",
    "privacy redaction",
    "repo-agent-core for shared",
    "repo-auditor for detection",
    "repo-upgrade-advisor for recommendation",
    "repo-optimizer for",
    "copy-sync or citation only",
    "no daemon",
    "no scheduler",
    "no queue",
    "no controller",
    "no background sync",
    "no automatic github",
]:
    assert phrase in lower, phrase

for forbidden in [
    "may apply patches",
    "can apply patches",
    "opens downstream prs",
    "creates downstream issues",
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

assert payload["artifact"] == "REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT"
assert len(payload["target_identities"]) == 2
assert len(payload["target_git_state_matrix"]) == 2
assert len(payload["target_native_gate_matrix"]) == 2
assert all(row["read_only_state_preserved"] is True for row in payload["target_git_state_matrix"])
states = {row["target_gate_state"] for row in payload["target_native_gate_matrix"]}
assert {"parseable_pass", "amendment_required_unknown"}.issubset(states)
checklist = " ".join(payload["bma_ceremony_leakage_checklist"]).lower()
for phrase in ["bma labels", "issue #164", "completion manifests", "campaign-sync machinery"]:
    assert phrase in checklist, phrase
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in ["does not mutate downstream targets", "does not apply patches", "does not open downstream prs"]:
    assert phrase in claims, phrase
PY
}

assert_sample_semantics() {
    python3 - "$SAMPLE" <<'PY'
import json
import sys

payload = json.load(open(sys.argv[1], encoding="utf-8"))
assert payload["artifact"] == "REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT"
assert len(payload["target_identities"]) == 2
assert {row["target_key"] for row in payload["target_identities"]} == {"portfolio_advisor", "customer-newsletter"}
assert all(row["target_is_non_bma"] is True for row in payload["target_identities"])
for row in payload["target_git_state_matrix"]:
    assert row["git_head_before"] == row["git_head_after"]
    assert row["git_status_before"] == row["git_status_after"]
    assert row["read_only_state_preserved"] is True
states = {row["target_gate_state"] for row in payload["target_native_gate_matrix"]}
assert "amendment_required_unknown" in states
owners = {row["owner_surface"] for row in payload["owner_routing"]}
assert {"repo-agent-core", "repo-auditor", "repo-upgrade-advisor", "repo-optimizer"}.issubset(owners)
privacy = payload["privacy_redaction_note"].lower()
for phrase in ["target-relative paths", "portfolio values", "proprietary newsletter content"]:
    assert phrase in privacy, phrase
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not mutate downstream targets",
    "does not apply patches",
    "does not open downstream prs or issues",
    "does not make gbrain canonical",
    "does not adopt hermes -z",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Repo-Star Downstream Genericity Proof Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "sample exists" test -s "$SAMPLE"
check "contract preserves required semantics" assert_contract_semantics
check "template preserves required semantics" assert_template_semantics
check "sample preserves read-only downstream semantics" assert_sample_semantics
check "sample validates against schema" bash "$REPO_ROOT/scripts/validate-artifacts.sh" "$SAMPLE" REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT
check "README points to contract" grep -Fq "repo-star-downstream-genericity-proof-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "repo-star-downstream-genericity-proof-receipt.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/repo-star-downstream-genericity-proof-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to schema" grep -Fq "schemas/REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT.schema.json" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-repo-star-downstream-genericity-proof-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
