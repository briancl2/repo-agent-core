#!/usr/bin/env bash
# Verify the GBrain advisory pilot outcome learning-loop contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/gbrain-advisory-pilot-outcome-learning-loop-contract.md"
TEMPLATE="$REPO_ROOT/templates/gbrain-advisory-pilot-outcome-learning-loop.md"
SAMPLE="$REPO_ROOT/tests/samples/GBRAIN_ADVISORY_PILOT_OUTCOME_LEARNING_LOOP_RECEIPT.json"

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
    "pilot_outcomes",
    "gbrain_read_commands",
    "gbrain_capture_candidates",
    "capture_summary",
    "citation_summary",
    "learning_recovery_blocks",
    "owner_routing",
    "no_background_commands_used",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "gbrain remains advisory",
    "foreground `gbrain stats`",
    "`gbrain search`",
    "`gbrain get`",
    "`gbrain put`",
    "draft",
    "shadow_canonical",
    "canonical_records_written` must be `0`",
    "github surface and raw evidence",
    "explicit no-capture reason",
    "runs gbrain lookup sequentially",
    "source/citation/provenance",
    "repo-agent-core",
    "build-meta-analysis",
    "repo-auditor",
    "repo-upgrade-advisor",
    "repo-optimizer",
    "copy-sync or cite",
]:
    assert phrase in lower, phrase

for forbidden in [
    "makes gbrain canonical",
    "background memory behavior is allowed",
    "starts a daemon",
    "starts a scheduler",
    "mutates downstream",
    "automatic patch application is allowed",
    "auto-merge is allowed",
]:
    assert forbidden not in lower, forbidden
PY
}

assert_payload_semantics() {
    python3 - "$1" <<'PY'
import json
import re
import sys

text_or_path = sys.argv[1]
if text_or_path.endswith(".md"):
    text = open(text_or_path, encoding="utf-8").read()
    match = re.search(r"```json\n(.*?)\n```", text, re.S)
    assert match, "template JSON fence"
    payload = json.loads(match.group(1))
else:
    payload = json.load(open(text_or_path, encoding="utf-8"))

assert payload["artifact"] == "GBRAIN_ADVISORY_PILOT_OUTCOME_LEARNING_LOOP_RECEIPT"
assert payload["advisory_status"].lower() == "gbrain remains advisory"
assert payload["no_background_commands_used"] is True
assert payload["capture_summary"]["canonical_records_written"] == 0
assert payload["capture_summary"]["records_written_count"] <= 3
assert set(payload["capture_summary"]["allowed_record_states"]) == {"draft", "shadow_canonical"}
assert payload["pilot_outcomes"], "pilot outcomes required"
assert payload["learning_recovery_blocks"], "learning recovery block required"
for row in payload["pilot_outcomes"]:
    assert row["github_surface"].startswith("https://github.com/")
    assert row["raw_evidence"]
    assert row.get("gbrain_slug") or row.get("no_capture_reason")
for row in payload["gbrain_capture_candidates"]:
    assert row["state"] in {"draft", "shadow_canonical"}
    assert row["source_refs"], row
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not make gbrain canonical",
    "does not write canonical records",
    "does not bulk-import",
    "does not mutate downstream target repos",
    "does not authorize automatic github issue creation",
]:
    assert phrase in claims, phrase
for forbidden in ["autopilot", "dream", "jobs worker", "mcp serving", "background memory"]:
    assert forbidden in claims, forbidden
PY
}

echo "=== GBrain Advisory Pilot Outcome Learning Loop Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "sample exists" test -s "$SAMPLE"
check "contract preserves advisory pilot learning semantics" assert_contract_semantics
check "template preserves receipt semantics" assert_payload_semantics "$TEMPLATE"
check "sample preserves receipt semantics" assert_payload_semantics "$SAMPLE"
check "sample validates against schema" bash "$REPO_ROOT/scripts/validate-artifacts.sh" "$SAMPLE" GBRAIN_ADVISORY_PILOT_OUTCOME_LEARNING_LOOP_RECEIPT
check "README points to contract" grep -Fq "gbrain-advisory-pilot-outcome-learning-loop-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "gbrain-advisory-pilot-outcome-learning-loop.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/gbrain-advisory-pilot-outcome-learning-loop-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to schema" grep -Fq "schemas/GBRAIN_ADVISORY_PILOT_OUTCOME_LEARNING_LOOP_RECEIPT.schema.json" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-gbrain-advisory-pilot-outcome-learning-loop-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
