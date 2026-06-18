#!/usr/bin/env bash
# Verify the Deep Research/source-intelligence native corpus contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/deep-research-source-intelligence-native-corpus-contract.md"
TEMPLATE="$REPO_ROOT/templates/deep-research-source-intelligence-native-corpus.md"

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
    "DEEP_RESEARCH_SOURCE_INTELLIGENCE_NATIVE_CORPUS",
    "SOURCE_INSIGHT_PACKET",
    "sidecar-prompt-ab-response-shaped-contract.md",
    "public/no-auth",
    "bounded authenticated exact-url",
    "19 exact X URLs",
    "manual Deep Research sidecar prompt only",
    "deep_research_api_disposition=rescoped_failed_not_authorized",
    "raw authenticated DOM",
    "Codex Cloud",
    "Codex remote",
    "repo-auditor",
    "repo-upgrade-advisor",
    "repo-optimizer",
    "GitHub issue/PR/check/merge truth",
]:
    assert phrase in text, phrase

for field in [
    "artifact",
    "schema_version",
    "source_issue_or_pr",
    "parent_campaign_url",
    "carrier_child_url",
    "owner_issue_url",
    "corpus_identity",
    "source_access_policy",
    "per_source_disposition_requirements",
    "source_insight_packet_mapping",
    "deep_research_sidecar",
    "deep_research_api_disposition",
    "official_docs_context",
    "raw_evidence_requirements",
    "consumer_routes",
    "validation_scope",
    "fallback",
    "bounded_non_claims",
    "next_owner_action",
]:
    assert field in text, field

for forbidden in [
    "authorizes live deep research api",
    "proves live codex cloud",
    "proves live codex remote",
    "creates a crawler",
    "creates a source registry",
    "starts a scheduler",
    "starts a daemon",
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

assert payload["artifact"] == "DEEP_RESEARCH_SOURCE_INTELLIGENCE_NATIVE_CORPUS"
assert payload["schema_version"] == 1
assert payload["source_issue_or_pr"].endswith("/74")
assert payload["parent_campaign_url"].endswith("/164")
assert payload["carrier_child_url"].endswith("/901")
assert payload["owner_issue_url"].endswith("/74")
assert payload["corpus_identity"]["source_count"] == 19
assert payload["deep_research_api_disposition"] == "rescoped_failed_not_authorized"
assert payload["deep_research_sidecar"]["mode"] == "manual_sidecar_only"
assert payload["deep_research_sidecar"]["pasteback_status"] == "not_supplied"
assert payload["source_insight_packet_mapping"]["schema"] == "SOURCE_INSIGHT_PACKET"
assert payload["source_access_policy"]["public_no_auth_first"] is True

for item in [
    "raw authenticated DOM",
    "HTML",
    "screenshots",
    "account context",
]:
    assert item in payload["source_access_policy"]["forbidden_retention"], item

for owner in ["repo-agent-core", "repo-auditor", "repo-upgrade-advisor", "repo-optimizer"]:
    assert any(route["owner"] == owner for route in payload["consumer_routes"]), owner

docs = {row["name"]: row["use"] for row in payload["official_docs_context"]}
assert docs["Deep Research"] == "capability context only"
assert docs["Web Search"] == "capability context only"
assert docs["Codex Cloud Environments"] == "future Arc 5 placement context only"

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not run deep research",
    "does not call the deep research api",
    "does not prove live codex cloud execution",
    "does not prove live codex remote execution",
    "does not create a crawler",
    "does not create issues or pull requests automatically",
    "does not auto-merge",
    "does not mutate downstream repos",
    "does not replace github issue/pr/check/merge truth",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Deep Research Source-Intelligence Native Corpus Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves corpus semantics" assert_contract_semantics
check "template preserves bounded corpus semantics" assert_template_semantics
check "README points to contract" grep -Fq "deep-research-source-intelligence-native-corpus-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "deep-research-source-intelligence-native-corpus.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/deep-research-source-intelligence-native-corpus-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/deep-research-source-intelligence-native-corpus.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-deep-research-source-intelligence-native-corpus-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
