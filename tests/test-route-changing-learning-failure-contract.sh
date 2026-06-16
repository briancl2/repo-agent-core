#!/usr/bin/env bash
# Verify the route-changing learning/failure contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/route-changing-learning-failure-contract.md"
TEMPLATE="$REPO_ROOT/templates/route-changing-learning-failure.md"

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
    "route_changed",
    "route_change_reason",
    "github_surface",
    "raw_evidence",
    "hermes_failure_routing",
    "gbrain_search_disposition",
    "gbrain_exact_handle_replay",
    "gbrain_slug_or_no_capture_reason",
    "fallback_without_memory",
    "owner_action",
    "literal_safe_github_readback",
    "learning_recovery_block",
    "admission_disposition",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "route-changing",
    "foreground hermes failure routing",
    "gbrain exact-handle replay",
    "fallback without memory",
    "learning / recovery",
    "literal-safe github status-comment/readback",
    "broad gbrain search miss is not proof",
    "hERMES_FOREGROUND_RUN_RECEIPT".lower(),
    "hERMES_FOREGROUND_FAILURE_GUIDANCE".lower(),
    "before codex fallback",
    "shell backticks",
    "read the posted github body back",
    "corrected comment",
    "repo-auditor",
    "repo-upgrade-advisor",
]:
    assert phrase in lower, phrase

for forbidden in [
    "starts a daemon",
    "creates a queue",
    "automatically repairs issue state",
    "gbrain is canonical",
    "hermes is the campaign owner",
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

assert payload["artifact"] == "ROUTE_CHANGING_LEARNING_FAILURE_RECEIPT"
assert payload["schema_version"] == 1
assert payload["source_issue_or_pr"].endswith("/821")
assert payload["parent_campaign_url"].endswith("/164")
assert payload["route_changed"] is True
assert payload["github_surface"].endswith("issuecomment-4713816039")
assert "as40-bma-final-main-after-all-repairs.json" in payload["raw_evidence"][0]
assert payload["hermes_failure_routing"]["status"] == "not_applicable"
assert payload["gbrain_search_disposition"]["found_route_changing_record"] is False
assert "does not prove exact handles are absent" in payload["gbrain_search_disposition"]["note"]
replay = payload["gbrain_exact_handle_replay"][0]
assert replay["slug"] == "bma/issue164/learning/hermes-failure-visible-fallback-2026-06-14"
assert replay["advisory_status"] == "advisory"
assert payload["gbrain_slug_or_no_capture_reason"] == replay["slug"]
assert "github issue/pr/check/merge truth" in payload["fallback_without_memory"].lower()
literal = payload["literal_safe_github_readback"]
assert literal["required"] is True
assert literal["superseded_comment_url"].endswith("issuecomment-4713814172")
assert literal["readback_status"] == "matched"
assert "fired=false" in literal["expected_literals"]
block = payload["learning_recovery_block"]
assert block["optional_gbrain_slug"] == replay["slug"]
assert block["no_capture_reason"] == ""
assert "literal-bearing github status comments" in block["reusable_learning_text"].lower()
assert payload["admission_disposition"] == "admit"
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not query github by itself",
    "does not mutate github",
    "does not run hermes",
    "does not run gbrain",
    "does not create a retained local closeout package",
    "does not make gbrain canonical",
    "does not make hermes the campaign owner",
    "does not replace github issue/pr/check/merge truth",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Route-Changing Learning Failure Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves route-changing semantics" assert_contract_semantics
check "template preserves route-changing semantics" assert_template_semantics
check "README points to contract" grep -Fq "route-changing-learning-failure-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "route-changing-learning-failure.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/route-changing-learning-failure-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/route-changing-learning-failure.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-route-changing-learning-failure-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
