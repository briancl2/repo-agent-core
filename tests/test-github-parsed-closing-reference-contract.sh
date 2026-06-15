#!/usr/bin/env bash
# Verify the GitHub parsed closing-reference contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/github-parsed-closing-reference-contract.md"
TEMPLATE="$REPO_ROOT/templates/github-parsed-closing-reference.md"

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
    "source_issue_or_pr",
    "parent_campaign_url",
    "child_issue_url",
    "pr_url",
    "pr_intended_role",
    "github_parsed_closing_references",
    "raw_reference_evidence",
    "human_intent_summary",
    "parsed_vs_intent_disposition",
    "non_final_child_closure_allowed",
    "final_child_closure_required",
    "closure_keyword_hazard_classes",
    "required_action",
    "owner_routing",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "GitHub parsed truth outranks",
    "must not close it",
    "negated or narrative PR body text",
    "non_final_carrier_pr",
    "final_child_closure_pr",
    "unknown",
    "GitHub-visible blocker",
    "negated_closure_keyword",
    "quoted_or_example_closure_keyword",
    "checklist_closure_keyword",
    "historical_closure_summary",
    "cross_issue_crosstalk",
    "repo-auditor",
    "repo-upgrade-advisor",
]:
    assert phrase.lower() in lower, phrase

for forbidden in [
    "local text interpretation outranks github",
    "non-final child closure allowed",
    "may auto-merge",
    "starts a daemon",
    "starts a scheduler",
    "hidden registry tracks",
    "background sync keeps",
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

assert payload["artifact"] == "GITHUB_PARSED_CLOSING_REFERENCE_REVIEW"
assert payload["schema_version"] == 1
assert payload["parent_campaign_url"].endswith("/164")
assert payload["child_issue_url"].endswith("/798")
assert payload["pr_intended_role"] == "non_final_carrier_pr"
assert payload["github_parsed_closing_references"] == []
assert payload["parsed_vs_intent_disposition"] == "match"
assert payload["non_final_child_closure_allowed"] is False
assert payload["final_child_closure_required"] is False

for hazard in [
    "negated_closure_keyword",
    "quoted_or_example_closure_keyword",
    "checklist_closure_keyword",
    "historical_closure_summary",
    "cross_issue_crosstalk",
]:
    assert hazard in payload["closure_keyword_hazard_classes"], hazard

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not parse github without a github/api/check readback",
    "does not close or reopen issues",
    "does not merge prs",
    "does not replace github issue/pr/check/merge truth",
    "does not mutate downstream repos",
    "does not create automatic issue or pr creation behavior",
    "does not start a daemon",
]:
    assert phrase in claims, phrase
PY
}

echo "=== GitHub Parsed Closing Reference Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves parsed closing-reference semantics" assert_contract_semantics
check "template preserves parsed closing-reference semantics" assert_template_semantics
check "README points to contract" grep -Fq "github-parsed-closing-reference-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "github-parsed-closing-reference.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/github-parsed-closing-reference-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/github-parsed-closing-reference.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-github-parsed-closing-reference-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
