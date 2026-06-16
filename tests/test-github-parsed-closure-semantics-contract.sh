#!/usr/bin/env bash
# Verify the GitHub parsed closure semantics contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/github-parsed-closure-semantics-contract.md"
TEMPLATE="$REPO_ROOT/templates/github-parsed-closure-semantics.md"

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
    "pr_url",
    "pr_state",
    "pr_merged",
    "campaign_sync_status",
    "target_child_issue_url",
    "active_child_issue_url",
    "pr_body_closure_keyword_scan",
    "closing_issues_references",
    "campaign_sync_completed_track_readback",
    "allowed_closing_issue_urls",
    "unexpected_closing_issue_urls",
    "issue_state_before",
    "issue_state_after",
    "state_drift_detected",
    "repair_action",
    "admission_disposition",
    "closure_truth",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "does not close #798",
    "negated wording",
    "closingissuesreferences",
    "non-final issue #164 carrier prs have no parsed closing references",
    "final campaign sync prs may have parsed closing references only for their own target child issue",
    "completed latest track:",
    "matched: true",
    "loose body substring",
    "before/after issue state",
    "repair_action` is present",
    "evidence only and does not replace github issue/pr/check/merge truth",
    "repo-auditor",
    "repo-upgrade-advisor",
]:
    assert phrase in lower, phrase

for forbidden in [
    "starts a daemon",
    "creates a queue",
    "automatically repairs issue state",
    "comments are closure truth",
    "local closeout package is closure truth",
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

assert payload["artifact"] == "GITHUB_PARSED_CLOSURE_SEMANTICS_RECEIPT"
assert payload["schema_version"] == 1
assert payload["source_issue_or_pr"].endswith("/56")
assert payload["parent_campaign_url"].endswith("/164")
assert payload["pr_url"].endswith("/807")
assert payload["campaign_sync_status"] == "non_final"
assert payload["target_child_issue_url"].endswith("/806")
assert payload["active_child_issue_url"].endswith("/798")
assert payload["pr_body_closure_keyword_scan"]["scan_performed"] is True
hazard = payload["pr_body_closure_keyword_scan"]["hazards"][0]
assert hazard["matched_text"] == "does not close #798"
assert hazard["hazard"] == "negated_closure_keyword_near_issue_reference"
assert payload["closing_issues_references"][0]["issue_url"].endswith("/798")
completed_track = payload["campaign_sync_completed_track_readback"]
assert completed_track["required_when"] == "campaign_sync_status == final_for_own_child"
assert completed_track["status"] == "not_applicable_non_final"
assert completed_track["campaign_marker"] == "Completed latest track:"
assert completed_track["matched"] is None
assert "matched true" in completed_track["note"].lower()
assert "loose body substring" in completed_track["note"].lower()
assert payload["allowed_closing_issue_urls"] == []
assert payload["unexpected_closing_issue_urls"] == [
    "https://github.com/briancl2/build-meta-analysis/issues/798"
]
assert payload["issue_state_before"][payload["active_child_issue_url"]] == "OPEN"
assert payload["issue_state_after"][payload["active_child_issue_url"]] == "OPEN"
assert payload["repair_action"]["required"] is True
assert payload["admission_disposition"] == "block_non_final_parsed_closure"
assert "evidence only" in payload["closure_truth"].lower()
assert "issue/pr/check/merge truth" in payload["closure_truth"].lower()
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not query github by itself",
    "does not mutate github",
    "does not create issues or pull requests",
    "does not post comments",
    "does not merge pull requests",
    "does not close issues",
    "does not repair issue state",
    "does not create a retained local closeout package",
    "does not start a daemon",
    "does not mutate downstream repos",
    "does not replace github issue/pr/check/merge truth",
]:
    assert phrase in claims, phrase
PY
}

echo "=== GitHub Parsed Closure Semantics Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves parsed closure semantics" assert_contract_semantics
check "template preserves parsed closure semantics" assert_template_semantics
check "README points to contract" grep -Fq "github-parsed-closure-semantics-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "github-parsed-closure-semantics.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/github-parsed-closure-semantics-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/github-parsed-closure-semantics.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-github-parsed-closure-semantics-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
