#!/usr/bin/env bash
# Verify the integrated native capability acceptance contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/integrated-native-capability-acceptance-contract.md"
TEMPLATE="$REPO_ROOT/templates/integrated-native-capability-acceptance.md"

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
    "INTEGRATED_NATIVE_CAPABILITY_ACCEPTANCE",
    "task_e_6a34120847c4832b94a1a08423530556",
    "codex_cloud_proof_disposition=accepted_ready_no_diff",
    "codex_remote_proof_disposition=deferred_not_validated",
    "external_intelligence_sidecar_disposition=failed_prompt_generation_deferred_outside_arc5",
    "failed prompt generation",
    "sidecar prompting",
    "GitHub issue/PR/check/merge truth",
    "Arc 5 Carrier 2",
    "repo-auditor",
    "repo-upgrade-advisor",
]:
    assert phrase in text, phrase

for field in [
    "artifact",
    "schema_version",
    "source_issue_or_pr",
    "parent_campaign_url",
    "carrier_child_url",
    "owner_issue_url",
    "cloud_proof",
    "codex_cloud_proof_disposition",
    "codex_remote_proof_disposition",
    "external_intelligence_sidecar_disposition",
    "github_truth",
    "arc_gate_matrix",
    "promotion_gate",
    "demotion_rejection_trigger",
    "kill_switch",
    "bounded_non_claims",
    "next_owner_action",
]:
    assert field in text, field

for forbidden in [
    "remote accepted",
    "sidecar accepted",
    "official docs prove live",
    "gbrain canonicality accepted",
    "hermes primary owner accepted",
    "starts a controller",
    "starts a scheduler",
    "starts a queue",
    "starts a daemon",
    "hidden registry tracks",
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

assert payload["artifact"] == "INTEGRATED_NATIVE_CAPABILITY_ACCEPTANCE"
assert payload["schema_version"] == 1
assert payload["source_issue_or_pr"].endswith("/911")
assert payload["parent_campaign_url"].endswith("/164")
assert payload["carrier_child_url"].endswith("/909")
assert payload["owner_issue_url"].endswith("/76")
assert payload["codex_cloud_proof_disposition"] == "accepted_ready_no_diff"
assert payload["codex_remote_proof_disposition"] == "deferred_not_validated"
assert payload["external_intelligence_sidecar_disposition"] == "failed_prompt_generation_deferred_outside_arc5"

cloud = payload["cloud_proof"]
assert cloud["task_id"] == "task_e_6a34120847c4832b94a1a08423530556"
assert cloud["hosted_repo"] == "briancl2/build-meta-analysis"
assert cloud["commit"] == "5d5bc96609e8b059b327c2309da7d07171c99f0c"
assert cloud["agents_md_present"] is True
assert cloud["preflight_helper_available"] is True
assert cloud["files_changed"] == 0
assert cloud["lines_added"] == 0
assert cloud["lines_removed"] == 0
assert cloud["task_status"] == "READY"
assert cloud["diff_disposition"] == "no diff"

assert len(payload["arc_gate_matrix"]) == 5
assert any(row["arc"].startswith("Arc 3") and "remote_deferred" in row["disposition"] for row in payload["arc_gate_matrix"])
assert any(row["arc"].startswith("Arc 4") and "sidecar_failed_outside_arc5" in row["disposition"] for row in payload["arc_gate_matrix"])

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not prove live codex remote execution",
    "does not accept external-intelligence sidecar output",
    "does not run or authorize live deep research api",
    "does not use official documentation as live proof",
    "does not claim gbrain canonical memory",
    "does not grant hermes primary ownership",
    "does not create a controller",
    "retained closeout package",
    "downstream mutation grant",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Integrated Native Capability Acceptance Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves integrated acceptance semantics" assert_contract_semantics
check "template preserves bounded acceptance semantics" assert_template_semantics
check "README points to contract" grep -Fq "integrated-native-capability-acceptance-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "integrated-native-capability-acceptance.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/integrated-native-capability-acceptance-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/integrated-native-capability-acceptance.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-integrated-native-capability-acceptance-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
