#!/usr/bin/env bash
# Verify the repo-star genericity proof contract stays bounded and non-mutating.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/repo-star-genericity-proof-contract.md"
SAMPLE="$REPO_ROOT/tests/samples/REPO_STAR_GENERICITY_PROOF_RECEIPT.json"

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
    "target_repo_identity",
    "target_path_or_name",
    "target_is_non_bma",
    "target_git_head_before",
    "target_git_head_after",
    "target_dirty_count_before",
    "target_dirty_count_after",
    "evidence_written_outside_target",
    "target_mutation_performed",
    "auditor_artifact_path",
    "advisor_artifact_path",
    "optimizer_artifact_path",
    "apply_check_result_path",
    "blocker_path",
    "owner_routing",
    "genericity_verdict",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "controlled non-bma",
    "under `/tmp`",
    "outside the target repo",
    "must match before for read-only success",
    "never applies patches",
    "repo-auditor for detection",
    "repo-upgrade-advisor for recommendation",
    "repo-optimizer for patch-pack",
    "repo-agent-core for shared receipt-contract gaps",
    "copy-sync or citation only",
    "no daemon",
    "no scheduler",
    "no queue",
    "no controller",
    "no background sync",
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

assert_sample_semantics() {
    python3 - "$SAMPLE" <<'PY'
import json
import sys

payload = json.load(open(sys.argv[1], encoding="utf-8"))
assert payload["artifact"] == "REPO_STAR_GENERICITY_PROOF_RECEIPT"
assert payload["target_is_non_bma"] is True
assert payload["target_mutation_performed"] is False
assert payload["evidence_written_outside_target"] is True
assert payload["target_git_head_before"] == payload["target_git_head_after"]
assert payload["target_dirty_count_before"] == payload["target_dirty_count_after"]
owners = {row["owner_surface"] for row in payload["owner_routing"]}
assert {"repo-agent-core", "repo-auditor", "repo-upgrade-advisor", "repo-optimizer"}.issubset(owners)
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in ["does not mutate", "does not apply patches", "does not open downstream prs"]:
    assert phrase in claims, phrase
PY
}

echo "=== Repo-Star Genericity Proof Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "sample exists" test -s "$SAMPLE"
check "contract preserves required semantics" assert_contract_semantics
check "sample preserves read-only genericity semantics" assert_sample_semantics
check "sample validates against schema" bash "$REPO_ROOT/scripts/validate-artifacts.sh" "$SAMPLE" REPO_STAR_GENERICITY_PROOF_RECEIPT
check "README points to contract" grep -Fq "repo-star-genericity-proof-contract.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/repo-star-genericity-proof-contract.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-repo-star-genericity-proof-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1

