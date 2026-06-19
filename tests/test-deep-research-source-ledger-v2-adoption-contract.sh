#!/usr/bin/env bash
# Verify the Deep Research source-ledger v2 adoption contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/deep-research-source-ledger-v2-adoption-contract.md"
TEMPLATE="$REPO_ROOT/templates/deep-research-source-ledger-v2-adoption.md"

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

for phrase in [
    "DEEP_RESEARCH_SOURCE_LEDGER_V2_ADOPTION",
    "STANDALONE_EXTERNAL_INTELLIGENCE_SIDECAR",
    "Deep Research Source-Ledger V2 Adoption Contract",
    "https://github.com/briancl2/build-meta-analysis/issues/921",
    "https://github.com/briancl2/build-meta-analysis/pull/922",
    "https://github.com/briancl2/build-meta-analysis/issues/923",
    "https://github.com/briancl2/build-meta-analysis/pull/924",
    "41532809f055cecfa00a34ae625db8899a781d5d",
    "https://github.com/briancl2/repo-agent-core/issues/80",
    "3/4",
    "1/2",
    "1/3",
    "consulted_on_date",
    "exclusion_rationale",
    "recommendation_effect",
    "GitHub issue/PR/check/merge truth",
    "repo-auditor",
    "repo-upgrade-advisor",
]:
    assert phrase in text, phrase

for field in [
    "artifact",
    "schema_version",
    "source_issue_or_pr",
    "parent_campaign_url",
    "owner_issue_url",
    "accepted_decision_class",
    "manual_trial_evidence",
    "prompt_tier_disposition",
    "source_ledger_v2_fields",
    "source_rules",
    "advisory_boundary",
    "github_truth",
    "promotion_gate",
    "demotion_rejection_trigger",
    "kill_switch",
    "bounded_non_claims",
    "next_owner_action",
]:
    assert field in text, field

for forbidden in [
    "authorizes deep research api",
    "proves future standalone prompts",
    "validates authenticated-source capture",
    "authorizes a crawler",
    "authorizes a source registry",
    "starts a scheduler",
    "starts a daemon",
    "auto-merges pull requests",
    "authorizes downstream mutation",
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

assert payload["artifact"] == "DEEP_RESEARCH_SOURCE_LEDGER_V2_ADOPTION"
assert payload["schema_version"] == 1
assert payload["source_issue_or_pr"].endswith("/924")
assert payload["parent_campaign_url"].endswith("/164")
assert payload["owner_issue_url"].endswith("/80")

decision = payload["accepted_decision_class"]
assert decision["surface"] == "manual Deep Research"
assert decision["source_access"] == "public/no-auth only"
assert "Deep Research API execution" in decision["forbidden_expansion"]
assert "sidecar closure truth" in decision["forbidden_expansion"]

tiers = payload["prompt_tier_disposition"]
assert tiers["default"] == "3/4"
assert tiers["bounded_transport_fit_fallback"] == "1/2"
assert tiers["not_accepted_as_default"] == "1/3"
assert "source-ledger fields remain present" in tiers["fallback_requirements"]

fields = payload["source_ledger_v2_fields"]
for field in [
    "source_id",
    "url",
    "consulted_on_date",
    "exclusion_rationale",
    "recommendation_effect",
]:
    assert field in fields, field

evidence = payload["manual_trial_evidence"]
assert any(row["issue"].endswith("/919") and row["prompt_tier"] == "3/4" for row in evidence)
quality = next(row for row in evidence if row["issue"].endswith("/921"))
assert quality["trial_1"]["prompt_tier"] == "3/4"
assert quality["trial_1"]["citations"] == 8
assert quality["trial_1"]["searches"] == 87
assert quality["trial_1"]["score"] == "3.0/3"
assert quality["trial_2"]["prompt_tier"] == "1/2"
assert quality["trial_2"]["citations"] == 10
assert quality["trial_2"]["searches"] == 108
assert quality["trial_2"]["score"] == "3.0/3"
assert "no unresolved CRITICAL or HIGH" in quality["critique"]

assert payload["source_rules"]["public_sources_only"] is True
assert payload["source_rules"]["no_hidden_required_context"] is True
assert "advisory evidence only" in payload["advisory_boundary"]
assert payload["github_truth"]["bma_live_adoption_merge"] == "41532809f055cecfa00a34ae625db8899a781d5d"

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not run deep research",
    "does not call or authorize the deep research api",
    "does not prove future standalone prompts are semantically sufficient",
    "does not validate authenticated-source capture",
    "does not inspect private repositories or local files",
    "does not create a source registry",
    "does not mutate bma #832",
    "does not mutate bma pr #801",
    "does not replace github issue/pr/check/merge truth",
]:
    assert phrase in claims, phrase

assert payload["next_owner_action"] == "repo-auditor detector propagation for Deep Research source-ledger v2 adoption gaps"
PY
}

echo "=== Deep Research Source-Ledger V2 Adoption Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves source-ledger v2 adoption semantics" assert_contract_semantics
check "template preserves bounded adoption semantics" assert_template_semantics
check "README points to contract" grep -Fq "deep-research-source-ledger-v2-adoption-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "deep-research-source-ledger-v2-adoption.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/deep-research-source-ledger-v2-adoption-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/deep-research-source-ledger-v2-adoption.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-deep-research-source-ledger-v2-adoption-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
