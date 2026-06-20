#!/usr/bin/env bash
# Verify the scheduled-readback owner proof contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/scheduled-readback-owner-proof-contract.md"
TEMPLATE="$REPO_ROOT/templates/scheduled-readback-owner-proof.md"

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
    "SCHEDULED_READBACK_OWNER_PROOF",
    "workflow_dispatch",
    "must never",
    "event=schedule",
    "owner_issue_url",
    "candidate_id",
    "schedule_source",
    "allowed_event",
    "event_filter",
    "cadence",
    "evidence_fields",
    "admission_disposition",
    "blocker_rule",
    "promotion_gate",
    "demotion_trigger",
    "kill_switch",
    "github_truth",
    "bounded_non_claims",
    "repo-auditor",
    "repo-upgrade-advisor",
]:
    assert phrase in text, phrase

for forbidden in [
    "workflow_dispatch counts as scheduled proof",
    "creates a scheduler",
    "starts a daemon",
    "auto-merges pull requests",
    "replaces github issue/pr/check/merge truth",
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

assert payload["artifact"] == "SCHEDULED_READBACK_OWNER_PROOF"
assert payload["schema_version"] == 1
assert payload["source_issue_or_pr"].endswith("/943")
assert payload["parent_campaign_url"].endswith("/164")
assert payload["owner_issue_url"].endswith("/943")
assert payload["candidate_id"] == "runtime_shadow_schedule_readback"
assert payload["allowed_event"] == "schedule"
assert payload["event_filter"]["workflow_dispatch_counts_as_scheduled"] is False
assert payload["event_filter"]["non_scheduled_events_are_context_only"] is True
assert payload["cadence"]["expected"] == "daily"
assert payload["admission_disposition"]["value"] in {
    "admit_candidate",
    "blocked_no_new_scheduled_run",
    "blocked_already_admitted",
    "blocked_stale",
    "blocked_failed_run",
}
for field in [
    "run_id",
    "event",
    "status",
    "conclusion",
    "created_at",
    "run_url",
    "head_sha",
]:
    assert field in payload["evidence_fields"], field
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not create or install a schedule",
    "does not run a workflow",
    "does not treat workflow_dispatch as scheduled proof",
    "does not mutate downstream repos",
    "does not start a daemon",
    "does not auto-merge pull requests",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Scheduled Readback Owner Proof Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves scheduled-readback semantics" assert_contract_semantics
check "template preserves bounded owner-proof semantics" assert_template_semantics
check "README points to contract" grep -Fq "scheduled-readback-owner-proof-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "scheduled-readback-owner-proof.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/scheduled-readback-owner-proof-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/scheduled-readback-owner-proof.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-scheduled-readback-owner-proof-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
