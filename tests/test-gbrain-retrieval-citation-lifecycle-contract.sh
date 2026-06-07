#!/usr/bin/env bash
# Verify the GBrain retrieval/citation lifecycle contract stays advisory and bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/gbrain-retrieval-citation-lifecycle-contract.md"
TEMPLATE="$REPO_ROOT/templates/gbrain-retrieval-citation-lifecycle.md"

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
    "proof_root",
    "source_issue_or_contract",
    "gbrain_version",
    "advisory_status",
    "allowed_record_states",
    "canonical_records_written",
    "records_written",
    "typed_links_written",
    "timeline_entries_written",
    "baseline_stats",
    "postwrite_stats",
    "seed_question_count",
    "baseline_expected_record_hits",
    "postwrite_expected_record_hits",
    "baseline_citation_hits",
    "postwrite_citation_hits",
    "retrieval_pass_threshold",
    "citation_pass_threshold",
    "command_receipts",
    "no_background_commands_used",
    "owner_routing",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "gbrain remains advisory",
    "draft",
    "shadow_canonical",
    "canonical_records_written",
    "must be `0`",
    "foreground `gbrain stats`",
    "`gbrain put`",
    "do not claim savings or adoption quality",
    "before/after",
    "copy-sync or citation only",
    "repo-agent-core",
    "repo-auditor",
    "repo-upgrade-advisor",
    "repo-optimizer",
]:
    assert phrase in lower, phrase

for forbidden in [
    "makes gbrain canonical",
    "write canonical records by default",
    "bulk import is allowed",
    "starts a daemon",
    "starts a scheduler",
    "background memory behavior is allowed",
    "mutates downstream target repos",
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

assert payload["artifact"] == "GBRAIN_RETRIEVAL_CITATION_LIFECYCLE"
assert payload["schema_version"] == 1
assert payload["advisory_status"].lower() == "gbrain remains advisory"
assert payload["allowed_record_states"] == ["draft", "shadow_canonical"]
assert payload["canonical_records_written"] == 0
assert payload["no_background_commands_used"] is True
assert payload["postwrite_expected_record_hits"] >= payload["baseline_expected_record_hits"]
assert payload["postwrite_citation_hits"] >= payload["baseline_citation_hits"]
assert payload["retrieval_pass_threshold"] > 0
assert payload["citation_pass_threshold"] > 0

owners = {row["owner_surface"] for row in payload["owner_routing"]}
assert "repo-agent-core" in owners

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not make gbrain canonical",
    "does not write canonical records",
    "does not bulk-import",
    "does not mutate downstream target repos",
]:
    assert phrase in claims, phrase
for forbidden in ["autopilot", "dream", "jobs worker", "mcp serving"]:
    assert forbidden in claims, forbidden
PY
}

echo "=== GBrain Retrieval/Citation Lifecycle Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves advisory lifecycle semantics" assert_contract_semantics
check "template preserves measured advisory receipt semantics" assert_template_semantics
check "README points to contract" grep -Fq "gbrain-retrieval-citation-lifecycle-contract.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/gbrain-retrieval-citation-lifecycle-contract.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-gbrain-retrieval-citation-lifecycle-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
