#!/usr/bin/env bash
# Verify validation-integrity format tracking stays fail-closed and non-detector-backed.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/validation-integrity-format-tracking-contract.md"
TEMPLATE="$REPO_ROOT/templates/validation-integrity-format-tracking.md"

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

for section in [
    "## purpose",
    "## receipt/distribution shape",
    "## validation rules",
    "## bounded non-claims",
    "## owner routing",
    "## copy-sync boundary",
]:
    assert section in lower, section

for field in [
    "artifact",
    "schema_version",
    "source_issue_or_pr",
    "format_binding_ref",
    "drift_regression_ref",
    "format_drift_status",
    "detector_disposition",
    "saved_run_fixture",
    "fail_closed_checks",
    "producer_validator_coupling",
    "validation_command",
    "owner_routing",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "briancl2/transcript_processor-private#56",
    "briancl2/transcript_processor-private#58",
    "no live validation-integrity drift was observed",
    "not_as_56_detector_backed_this_round",
    "fail-closed",
    "saved-run fixture",
    "unique-id",
    "ledger-text",
    "compact-mismatch",
    "do not present this as as-56 detector evidence",
    "copy-sync",
]:
    assert phrase in lower, phrase

for forbidden in [
    "may create a controller",
    "starts a scheduler",
    "runs a queue",
    "runs a daemon",
    "as-56 exists.",
    "canonical validation ledger is authoritative",
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

assert payload["artifact"] == "VALIDATION_INTEGRITY_FORMAT_TRACKING_RECEIPT"
assert payload["schema_version"] == 1
assert payload["source_issue_or_pr"].endswith("/99")
assert payload["format_binding_ref"] == "briancl2/transcript_processor-private#56"
assert payload["drift_regression_ref"] == "briancl2/transcript_processor-private#58"
assert payload["format_drift_status"] == "no_live_drift_observed"
assert payload["detector_disposition"] == "not_as_56_detector_backed_this_round"
fixture = payload["saved_run_fixture"]
assert fixture["required"] is True
assert fixture["kind"] == "saved_run_fixture"
checks = payload["fail_closed_checks"]
assert set(checks) == {"unique_id", "ledger_text", "compact_mismatch"}
assert all(row["required"] is True for row in checks.values())
assert "Phase-3 producer format" in payload["producer_validator_coupling"]
assert "saved-run fixture" in payload["validation_command"]
assert "GitHub-visible blocker" in payload["owner_routing"]["fallback"]
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not claim validation-integrity had live d3 drift",
    "does not claim as-56 exists or graduated this round",
    "does not replace briancl2/transcript_processor-private#56",
    "does not mandate a shared runtime schema",
    "does not mutate downstream repositories",
    "does not create a controller",
    "does not make local fixtures",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Validation Integrity Format Tracking Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves fail-closed format-tracking semantics" assert_contract_semantics
check "template preserves receipt shape" assert_template_semantics
check "README points to contract" grep -Fq "validation-integrity-format-tracking-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "validation-integrity-format-tracking.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/validation-integrity-format-tracking-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/validation-integrity-format-tracking.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-validation-integrity-format-tracking-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
