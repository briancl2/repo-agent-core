#!/usr/bin/env bash
# Verify the Hermes doer + GBrain-distributed instruction contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/hermes-doer-gbrain-distributed-instructions-contract.md"
TEMPLATE="$REPO_ROOT/templates/hermes-doer-gbrain-distributed-instructions.md"

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
    "consuming_repo",
    "instruction_surfaces",
    "gbrain_distribution_contract",
    "gbrain_records_or_no_capture_reason",
    "hermes_launcher_contract",
    "hermes_receipt",
    "failure_guidance",
    "repo_native_validation",
    "owner_routing",
    "advisory_status",
    "hermes_campaign_owner",
    "canonical_override_allowed",
    "background_gbrain_behavior_used",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "hermes remains a foreground implementation attempt",
    "gbrain remains advisory memory",
    "repo-local instruction surfaces",
    "bounded foreground first-attempt doer",
    "source, citation, provenance, or github surface references",
    "codex",
    "selection, synthesis, validation, pr/ci/merge closure, and recovery",
    "hermes -z",
    "repo-agent-core",
    "repo-auditor",
    "repo-upgrade-advisor",
    "repo-optimizer",
]:
    assert phrase in lower, phrase

for forbidden in [
    "gbrain is canonical",
    "gbrain is source of truth",
    "gbrain overrides local instructions",
    "background gbrain behavior is allowed",
    "hermes is the campaign owner",
    "hermes primary-doer autonomy is proven",
    "starts a daemon",
    "starts a scheduler",
    "mcp server keeps copies aligned",
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

assert payload["artifact"] == "HERMES_DOER_WITH_GBRAIN_DISTRIBUTED_REPO_LOCAL_INSTRUCTIONS"
assert payload["schema_version"] == 1
assert payload["advisory_status"].lower() == "gbrain remains advisory"
assert payload["hermes_campaign_owner"] is False
assert payload["canonical_override_allowed"] is False
assert payload["background_gbrain_behavior_used"] is False
assert payload["instruction_surfaces"]
assert payload["gbrain_distribution_contract"].endswith("gbrain-repo-local-instruction-distribution-contract.md")
assert payload["hermes_launcher_contract"].endswith("hermes-foreground-launcher-contract.md")
assert payload["hermes_receipt"]
assert payload["repo_native_validation"]

owners = {row["owner_surface"] for row in payload["owner_routing"]}
assert "repo-agent-core" in owners

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not make hermes the campaign owner",
    "does not prove hermes primary-doer autonomy",
    "does not make gbrain canonical",
    "does not let gbrain override operator intent",
    "does not adopt hermes -z",
    "does not add a runtime dependency",
]:
    assert phrase in claims, phrase
for forbidden in ["sync --watch", "autopilot", "dream", "jobs worker", "mcp serving"]:
    assert forbidden in claims, forbidden
PY
}

echo "=== Hermes Doer With GBrain-Distributed Instructions Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves bounded composition semantics" assert_contract_semantics
check "template preserves bounded receipt semantics" assert_template_semantics
check "README points to contract" grep -Fq "hermes-doer-gbrain-distributed-instructions-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "hermes-doer-gbrain-distributed-instructions.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/hermes-doer-gbrain-distributed-instructions-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/hermes-doer-gbrain-distributed-instructions.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-hermes-doer-gbrain-distributed-instructions-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
