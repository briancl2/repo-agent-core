#!/usr/bin/env bash
# Verify the closure/runtime distribution contract stays bounded and owner-actionable.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/repo-star-closure-runtime-distribution-contract.md"
TEMPLATE="$REPO_ROOT/templates/repo-star-closure-runtime-distribution.md"

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
    "closure_ceremony_regrowth_classes",
    "runtime_drift_classes",
    "coordinator_autonomy_acceptance_classes",
    "native_evidence_before_verdict_classes",
    "owner_surface_recommendations",
    "validation_scope",
    "fallback_routes",
    "gbrain_policy",
    "downstream_mutation_policy",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "local work packages",
    "completion manifests",
    "ser or session-end report",
    "handoff-sync facts",
    "retained report packages",
    "local duplicate closure receipts",
    "pointer-file compatibility",
    "stale direct-closure self-heal artifacts",
    "fresh coordinator launch missing explicit transfer mode",
    "live issue #164/child/pr/check truth not rechecked before mutation",
    "goal state omitted without a goal-null fallback",
    "canonical `/tmp/issue164-*` run root",
    "progress-ledger.jsonl",
    "heartbeat created before the child issue or run root exists",
    "ci polling and green-clean merge-or-blocker discipline",
    "category, such as \"do real delivery\"",
    "acceptance verdict missing or outside",
    "non-`not_applicable` verdict missing github issue/pr/check/merge truth",
    "raw runtime evidence, goal or goal-null",
    "demotion trigger or next exact owner-surface action",
    "canonical gbrain memory",
    "docs readback alone",
    "local doctor output",
    "keyword-stuffing",
    "not-production-ready",
    "fallback-required",
    "verdict-bearing issue/pr/comment/readout",
    "native-evidence-before-verdict-contract.md",
    "exact_owner_surface",
    "first_deliverable",
    "github_issue_routing",
    "source_citation",
    "canonical_records_written` must remain `0`",
    "copy-sync or citation only",
]:
    assert phrase in lower, phrase

for forbidden in [
    "may mutate downstream",
    "can mutate downstream",
    "starts a controller",
    "starts a scheduler",
    "starts a queue",
    "background memory process keeps",
    "auto-merges",
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

assert payload["artifact"] == "REPO_STAR_CLOSURE_RUNTIME_DISTRIBUTION"
assert payload["schema_version"] == 1
assert payload["gbrain_policy"]["canonical_records_written"] == 0
assert len(payload["closure_ceremony_regrowth_classes"]) >= 2
assert len(payload["runtime_drift_classes"]) >= 2
acceptance_classes = payload["coordinator_autonomy_acceptance_classes"]
assert len(acceptance_classes) >= 3
assert {row["class"] for row in acceptance_classes} >= {
    "missing_or_invalid_acceptance_verdict",
    "unsupported_foreground_acceptance_claim",
    "background_or_tool_primary_autonomy_overclaim",
}
native_classes = payload["native_evidence_before_verdict_classes"]
assert {row["class"] for row in native_classes} >= {
    "docs_readback_only_verdict",
    "verdict_bearing_surface_missing_native_evidence",
}
recommendations = payload["owner_surface_recommendations"]
assert {row["exact_owner_surface"] for row in recommendations} >= {"repo-auditor", "repo-upgrade-advisor", "repo-optimizer"}
for row in recommendations:
    for field in [
        "exact_owner_surface",
        "first_deliverable",
        "validation_scope",
        "fallback",
        "github_issue_routing",
        "bounded_non_claims",
        "source_citation",
    ]:
        assert row.get(field), field
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not mutate downstream target repositories",
    "does not open downstream prs or issues",
    "does not make gbrain canonical",
    "does not start persistent memory automation",
    "does not create a controller",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Repo-Star Closure Runtime Distribution Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves required semantics" assert_contract_semantics
check "template preserves owner-actionable receipt semantics" assert_template_semantics
check "README points to contract" grep -Fq "repo-star-closure-runtime-distribution-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "repo-star-closure-runtime-distribution.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/repo-star-closure-runtime-distribution-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/repo-star-closure-runtime-distribution.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-repo-star-closure-runtime-distribution-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
