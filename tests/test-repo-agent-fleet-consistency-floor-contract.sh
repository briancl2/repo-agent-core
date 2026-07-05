#!/usr/bin/env bash
# Verify the repo-agent fleet consistency floor contract stays bounded,
# evidence-backed, keeps the candidate 6th dimension advisory (not required),
# and carries the v0.2 declare-mandatory 7th dimension (domain_outcome_delta).

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/repo-agent-fleet-consistency-floor-contract.md"
TEMPLATE="$REPO_ROOT/templates/repo-agent-fleet-consistency-floor.md"

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

for section in [
    "## purpose",
    "## floor dimensions",
    "## receipt/distribution shape",
    "## validation rules",
    "## owner routing",
    "## bounded non-claims",
    "## copy-sync boundary",
]:
    assert section in lower, section

# All floor dimension field names must be named (dims 1-7).
for field in [
    "closure_model",
    "ci_check_contract",
    "gitignore_baseline",
    "learning_extraction_gate",
    "review_safety_net",
    "serialization_discipline",
    "domain_outcome_delta",
]:
    assert field in text, field

# The receipt schema fields must be defined in the contract.
for field in [
    "artifact",
    "schema_version",
    "generated_at",
    "source_issue_or_contract",
    "consuming_repo",
    "evidence_refs",
    "repo_native_validation",
    "owner_routing",
    "bounded_non_claims",
]:
    assert field in text, field

# Evidence anchoring + boundary language.
for phrase in [
    "as-56",
    "phase 0",
    "issue/pr/check/merge truth",
    "copy-sync",
    "make any repo conform",
]:
    assert phrase in lower, phrase

# The 6th dimension must be marked candidate/advisory and NOT required.
assert "candidate/advisory" in lower, "candidate/advisory marker"
assert "advisory in v0.1" in lower, "advisory in v0.1"
assert "not required for conformance" in lower, "not required for conformance"

# v0.2 ratification: header bump + declare-mandatory dimension 7.
assert "version: 0.2" in lower, "version 0.2 header"
assert "declare-mandatory" in lower, "dimension 7 declare-mandatory marker"

# The candidate dimension must not be silently promoted to mandatory.
for forbidden in [
    "serialization discipline is mandatory",
    "may create a controller",
    "starts a scheduler",
    "runs a daemon",
    "automatically creates issues",
    "makes every repo conform",
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

assert payload["artifact"] == "REPO_AGENT_FLEET_CONSISTENCY_FLOOR"
assert payload["schema_version"] == 1
assert payload["source_issue_or_contract"].endswith("/1214")
assert payload["consuming_repo"].startswith("briancl2/")

# Every receipt field the contract defines must be present in the template.
for field in [
    "artifact",
    "schema_version",
    "generated_at",
    "source_issue_or_contract",
    "consuming_repo",
    "evidence_refs",
    "closure_model",
    "ci_check_contract",
    "gitignore_baseline",
    "learning_extraction_gate",
    "review_safety_net",
    "serialization_discipline",
    "domain_outcome_delta",
    "repo_native_validation",
    "owner_routing",
    "bounded_non_claims",
]:
    assert field in payload, field

# The five mandatory dimensions expose their sub-shape.
assert "model" in payload["closure_model"]
assert "branch_protection_required_checks" in payload["ci_check_contract"]
entries = payload["gitignore_baseline"]["required_entries_present"]
for entry in ["work/", "__pycache__/", "*.pyc", ".DS_Store"]:
    assert entry in entries, entry
assert payload["learning_extraction_gate"]["available"] in (True, False)
assert payload["review_safety_net"]["automated_review_expected"] in (True, False)

# The candidate 6th dimension is advisory, never asserted as mandatory here.
ser = payload["serialization_discipline"]
assert "candidate" in ser["status"], ser["status"]
assert "advisory" in ser.get("notes", "").lower()

# The v0.2 declare-mandatory 7th dimension binds to the eval gate via result_class.
dod = payload["domain_outcome_delta"]
assert "result_class" in dod, "domain_outcome_delta.result_class"

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not make the repo conform",
    "does not require identical implementation",
    "advisory in v0.1 and is not required for conformance",
    "do not replace github issue/pr/check/merge truth",
    "not a controller",
    "does not mutate downstream repositories",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Repo-Agent Fleet Consistency Floor Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves floor semantics" assert_contract_semantics
check "template preserves receipt shape" assert_template_semantics
check "README points to contract" grep -Fq "repo-agent-fleet-consistency-floor-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "repo-agent-fleet-consistency-floor.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/repo-agent-fleet-consistency-floor-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/repo-agent-fleet-consistency-floor.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-repo-agent-fleet-consistency-floor-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
