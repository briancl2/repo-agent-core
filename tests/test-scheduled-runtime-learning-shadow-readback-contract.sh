#!/usr/bin/env bash
# Verify the scheduled Runtime Learning Shadow readback contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/scheduled-runtime-learning-shadow-readback-contract.md"
TEMPLATE="$REPO_ROOT/templates/scheduled-runtime-learning-shadow-readback.md"

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
    "target_issue_url",
    "child_issue_url",
    "event_name",
    "workflow_name",
    "run_id",
    "run_number",
    "run_attempt",
    "run_url",
    "commit_sha",
    "node24_opt_in",
    "artifact_name",
    "artifact_source",
    "generated_issue_comment_count",
    "generated_issue_comment_path",
    "posted_comment_url",
    "git_before",
    "git_after",
    "git_state_preserved",
    "hermes_capture",
    "gbrain_readback",
    "actionability_classification",
    "closure_truth",
    "promotion_disposition",
    "four_run_review",
    "owner_routing",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "event_name` is exactly `schedule`",
    "workflow_dispatch` receipts are useful implementation or smoke evidence",
    "must not satisfy schedule proof",
    "generated_issue_comment_count` is exactly `1`",
    "runner temp",
    "evidence only, not task closure truth",
    "keep_with_named_value",
    "reduce_frequency",
    "demote_to_manual_only",
    "repair_specific_failure",
    "clean no-op results do not justify retention by themselves",
    "workflow evidence-path drift",
    "foreground failure-to-issue",
    "repo-auditor",
    "repo-upgrade-advisor",
]:
    assert phrase.lower() in lower, phrase

for forbidden in [
    "may close issue #798",
    "comments are closure truth",
    "artifacts are closure truth",
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

assert payload["artifact"] == "SCHEDULED_RUNTIME_LEARNING_SHADOW_READBACK"
assert payload["schema_version"] == 1
assert payload["event_name"] == "schedule"
assert payload["target_issue_url"].endswith("/164")
assert payload["child_issue_url"].endswith("/798")
assert payload["generated_issue_comment_count"] == 1
assert "Runtime Learning Shadow" in payload["artifact_name"]
assert payload["run_id"] in payload["artifact_name"]
assert payload["run_number"] in payload["artifact_name"]
assert payload["run_attempt"] in payload["artifact_name"]
assert payload["artifact_source"].startswith("runner_temp:")
assert payload["git_before"]["head"] == payload["git_after"]["head"]
assert payload["git_before"]["status"] == payload["git_after"]["status"]
assert payload["git_state_preserved"] is True
assert payload["hermes_capture"]["no_capture_reason"]
assert payload["gbrain_readback"]["no_capture_reason"]
assert "evidence only" in payload["closure_truth"].lower()
assert "closure truth" in payload["closure_truth"].lower()
allowed = payload["four_run_review"]["allowed_dispositions"]
assert allowed == [
    "keep_with_named_value",
    "reduce_frequency",
    "demote_to_manual_only",
    "repair_specific_failure",
]
assert payload["four_run_review"]["clean_no_op_retention_allowed_without_named_value"] is False
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not create or install a schedule",
    "does not treat comments or artifacts as closure truth",
    "does not close issue #798",
    "does not mutate downstream repos",
    "does not adopt hermes -z",
    "does not start a daemon",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Scheduled Runtime Learning Shadow Readback Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves required readback semantics" assert_contract_semantics
check "template preserves scheduled readback semantics" assert_template_semantics
check "README points to contract" grep -Fq "scheduled-runtime-learning-shadow-readback-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "scheduled-runtime-learning-shadow-readback.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/scheduled-runtime-learning-shadow-readback-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/scheduled-runtime-learning-shadow-readback.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-scheduled-runtime-learning-shadow-readback-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
