#!/usr/bin/env bash
# Verify the capability-placement contract stays advisory and bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/capability-placement-contract.md"
TEMPLATE="$REPO_ROOT/templates/capability-placement.md"

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
    "carrier_child_url",
    "advisory_status",
    "best_current_owner",
    "best_future_owner",
    "local_remote",
    "foreground_scheduled",
    "allowed_reach_now",
    "native_signal",
    "promotion_gate",
    "demotion_rejection_trigger",
    "kill_switch",
    "why_not_alternatives",
    "operator_value_hypothesis",
    "forbidden_mode",
    "gbrain_slug_or_no_capture_reason",
    "routing_use",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "CAPABILITY_PLACEMENT_PREVIEW",
    "advisory",
    "copy-sync or cite",
    "repo-agent-core",
    "repo-auditor",
    "repo-upgrade-advisor",
    "repo-optimizer",
    "best current owner",
    "best future owner",
    "allowed reach now",
    "native signal",
    "promotion gate",
    "demotion/rejection trigger",
    "kill switch",
    "gbrain slug/no-capture reason",
    "boilerplate",
    "GitHub issue/PR/check/merge truth",
]:
    assert phrase.lower() in lower, phrase

for forbidden in [
    "creates a dashboard",
    "creates a registry",
    "starts a scheduler",
    "starts a daemon",
    "runs hermes automatically",
    "runs gbrain automatically",
    "auto-merges pull requests",
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

assert payload["artifact"] == "CAPABILITY_PLACEMENT_PREVIEW"
assert payload["schema_version"] == 1
assert payload["advisory_status"] == "advisory"
assert payload["source_issue_or_pr"].endswith("/834")
assert payload["parent_campaign_url"].endswith("/164")
assert payload["carrier_child_url"].endswith("/64")

for field in [
    "best_current_owner",
    "best_future_owner",
    "local_remote",
    "foreground_scheduled",
    "allowed_reach_now",
    "native_signal",
    "promotion_gate",
    "demotion_rejection_trigger",
    "kill_switch",
    "why_not_alternatives",
    "operator_value_hypothesis",
    "forbidden_mode",
    "gbrain_slug_or_no_capture_reason",
    "routing_use",
    "bounded_non_claims",
]:
    assert payload[field], field

for phrase in [
    "controller",
    "scheduler",
    "queue",
    "daemon",
    "registry",
    "dashboard",
    "central autonomy ledger",
    "background Hermes/GBrain",
    "automatic issue/PR creation",
    "auto-merge",
    "Codex cloud/background write authority",
    "downstream mutation",
    "replacement closure truth",
]:
    assert phrase in payload["forbidden_mode"], phrase

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not create a ci gate",
    "does not grant codex cloud or background write authority",
    "does not mutate downstream repos",
    "does not replace github issue/pr/check/merge truth",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Capability Placement Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves advisory placement semantics" assert_contract_semantics
check "template preserves bounded placement semantics" assert_template_semantics
check "README points to contract" grep -Fq "capability-placement-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "capability-placement.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/capability-placement-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/capability-placement.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-capability-placement-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
