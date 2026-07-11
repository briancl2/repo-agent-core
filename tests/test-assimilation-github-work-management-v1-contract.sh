#!/usr/bin/env bash
# Verify the assimilation GitHub work-management V1 contract stays small,
# evidence-backed, permission-aware, and candidate-only for autonomous merge.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/assimilation-github-work-management-v1-contract.md"
TEMPLATE="$REPO_ROOT/templates/assimilation-github-work-management-v1.md"
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

for section in [
    "## purpose",
    "## related contracts",
    "## receipt/distribution shape",
    "### github_closure_reconciliation",
    "### required_ci_and_reviewer_model",
    "### shared_fact_control",
    "### autonomous_merge_eligibility_candidate",
    "## validation rules",
    "## owner routing",
    "## bounded non-claims",
    "## copy-sync boundary",
]:
    assert section in lower, section

domain_fields = [
    "github_closure_reconciliation",
    "required_ci_and_reviewer_model",
    "shared_fact_control",
    "autonomous_merge_eligibility_candidate",
]
for field in domain_fields:
    assert field in text, field

assert "only four work-management fields" in lower, "small V1 field claim"
assert "#118" not in text, "must not blend adjacent issue #118 into arc"

for field in [
    "artifact",
    "schema_version",
    "source_issue_or_pr",
    "parent_campaign_url",
    "consuming_repo",
    "operator_count",
    "host_count",
    "actual_concurrency",
    "unattended_runtime_need",
    "smallest_native_architecture",
    "stale_native_constraint_intake",
    "generated_at",
    "evidence_refs",
    "permission_insufficient",
    "validation_scope",
    "owner_routing",
    "next_owner_action",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "repo-agent-core#117",
    "build-meta-analysis#1318",
    "cross-session/cross-pr",
    "gh pr list --state all",
    "p2+/medium-and-above",
    "local staged-diff review",
    "pre-check",
    "one source of truth",
    "permission_insufficient",
    "not a repo-quality gap",
    "candidate-only",
    "github issue/pr/check/review/merge truth is\nauthoritative",
    "later repo-auditor, repo-upgrade-advisor, repo-optimizer, or bma acceptance",
    "one-operator, one-laptop",
    "reject_enterprise_without_observed_need",
    "update_stale_constraint",
    "clean constraint",
]:
    assert phrase in lower, phrase

for forbidden in [
    "automatically merges all open prs",
    "auto-merge is enabled",
    "starts a scheduler",
    "runs a queue",
    "runs a daemon",
    "creates a dashboard",
    "permission limits are quality gaps",
    "local review is authoritative",
    "work-close output is closure truth",
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
assert "#118" not in text, "must not blend adjacent issue #118 into template"
match = re.search(r"```json\n(.*?)\n```", text, re.S)
assert match, "template JSON fence"
payload = json.loads(match.group(1))

assert payload["artifact"] == "ASSIMILATION_GITHUB_WORK_MANAGEMENT_V1"
assert payload["schema_version"] == 1
assert payload["source_issue_or_pr"].endswith("/117")
assert payload["parent_campaign_url"].endswith("/1318")
assert payload["consuming_repo"].startswith("briancl2/")
assert payload["operator_count"] == 1
assert payload["host_count"] == 1
assert isinstance(payload["actual_concurrency"], int) and payload["actual_concurrency"] >= 1
assert payload["unattended_runtime_need"]["state"] in {"none_observed", "observed"}
architecture = payload["smallest_native_architecture"]
assert architecture["disposition"] == "admit_smallest_native"
assert architecture["enterprise_components"] == []
assert architecture["concrete_observed_need"] == []
intake = payload["stale_native_constraint_intake"]
assert intake["status"] == "clean"
assert intake["disposition"] == "no_change"
for field in [
    "old_constraint",
    "current_native_activation_rule",
    "proof_boundary",
    "authority_boundary",
    "touched_validator_or_test",
    "owner_surface_evidence",
]:
    assert field in intake, field

domain_fields = {
    "github_closure_reconciliation",
    "required_ci_and_reviewer_model",
    "shared_fact_control",
    "autonomous_merge_eligibility_candidate",
}
for field in domain_fields:
    assert field in payload, field

perm = payload["permission_insufficient"]
assert perm["status"] is False
assert "blocked_fields" in perm
assert "owner_action" in perm

closure = payload["github_closure_reconciliation"]
for field in [
    "github_pr_list_readback",
    "cross_pr_consistency_checked",
    "superset_subset_disposition",
    "open_review_threads",
    "closing_issue_references",
    "issue_state_reconciliation",
    "closure_disposition",
]:
    assert field in closure, field
assert closure["github_pr_list_readback"]["state_filter"] == "all"
assert closure["issue_state_reconciliation"]["closure_truth"].lower().startswith("github")

ci = payload["required_ci_and_reviewer_model"]
for field in [
    "repo_native_gate",
    "required_checks",
    "required_reviewer_model",
    "local_review_role",
    "required_review_threshold",
    "review_truth_source",
]:
    assert field in ci, field
assert ci["local_review_role"] == "pre_check_only_not_cross_pr_authority"
assert ci["required_review_threshold"] == "P2+ | medium_and_above | repo_policy"

shared = payload["shared_fact_control"]
for field in [
    "fact_name",
    "owning_source",
    "consuming_artifacts",
    "drift_check",
    "duplicate_copy_disposition",
]:
    assert field in shared, field
assert "single_source" in shared["duplicate_copy_disposition"]
assert "blocked_duplicate_without_gate" in shared["duplicate_copy_disposition"]

merge = payload["autonomous_merge_eligibility_candidate"]
for field in [
    "candidate_state",
    "repo_native_gate_green",
    "spec_id_or_spec_exempt_commit_discipline",
    "required_review_findings_resolved",
    "merge_conflicts_resolved_and_verified",
    "human_approval_role",
    "autonomous_merge_authority",
]:
    assert field in merge, field
assert merge["autonomous_merge_authority"] == "candidate_only"
assert "candidate" in merge["candidate_state"]

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not implement repo-auditor, repo-upgrade-advisor, repo-optimizer, or bma acceptance arcs",
    "does not score a repo as deficient when github evidence is unreadable because of permission limits",
    "does not replace github issue/pr/check/review/merge truth",
    "does not make local staged-diff review authoritative for cross-pr consistency",
    "does not make local work-close output closure truth",
    "does not authorize autonomous merge, auto-merge, background merge loops, or a broad waiver of human review",
    "does not create issues, pull requests, comments, merges, or closures",
    "does not mutate downstream repositories",
    "does not create a controller",
]:
    assert phrase in claims, phrase

assert "do not start it from this receipt" in payload["next_owner_action"].lower()
PY
}

assert_operating_context_fixtures() {
    python3 - "$CLEAN_FIXTURE" "$STALE_FIXTURE" "$ENTERPRISE_FIXTURE" <<'PY'
import json
import sys

clean, stale, enterprise = [json.load(open(path, encoding="utf-8")) for path in sys.argv[1:]]

clean_intake = clean["stale_native_constraint_intake"]
assert clean_intake["status"] == "clean"
assert clean_intake["disposition"] == "no_change"
assert clean_intake["old_constraint"] == clean_intake["current_native_activation_rule"]

stale_intake = stale["stale_native_constraint_intake"]
assert stale_intake["status"] == "migration_friction_found"
assert stale_intake["disposition"] == "update_stale_constraint"
assert stale_intake["touched_validator_or_test"]
assert stale_intake["owner_surface_evidence"]
assert stale_intake["proof_boundary"]
assert stale_intake["authority_boundary"]

assert enterprise["operator_count"] == 1
assert enterprise["host_count"] == 1
architecture = enterprise["smallest_native_architecture"]
assert architecture["enterprise_components"]
assert architecture["concrete_observed_need"] == []
assert architecture["disposition"] == "reject_enterprise_without_observed_need"
PY
}

echo "=== Assimilation GitHub Work Management V1 Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves V1 semantics" assert_contract_semantics
check "template preserves receipt shape" assert_template_semantics
check "operating-context fixtures distinguish clean, stale, and rejected enterprise cases" assert_operating_context_fixtures
check "README points to contract" grep -Fq "assimilation-github-work-management-v1-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "assimilation-github-work-management-v1.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/assimilation-github-work-management-v1-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/assimilation-github-work-management-v1.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-assimilation-github-work-management-v1-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
