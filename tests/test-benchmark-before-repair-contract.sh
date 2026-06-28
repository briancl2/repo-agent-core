#!/usr/bin/env bash
# Verify the benchmark-before-repair contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/benchmark-before-repair-contract.md"
TEMPLATE="$REPO_ROOT/templates/benchmark-before-repair.md"

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
    "benchmark_dimensions",
    "defined_before_selection",
    "repair_candidates",
    "selected_repair",
    "rejected_repairs",
    "selection_changed",
    "before_after_delta",
    "decision_state",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "benchmark-before-repair",
    "selection_changed",
    "repair-selection discipline",
    "operating-model",
    "n=2",
    "repo-auditor",
    "repo-upgrade-advisor",
]:
    assert phrase in lower, phrase

for forbidden in [
    "starts a daemon",
    "creates a queue",
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

assert payload["artifact"] == "BENCHMARK_BEFORE_REPAIR_RECORD"
assert payload["schema_version"] == 1
assert payload["decision_state"] == "adopt"
assert payload["selection_changed"] is True
assert payload["defined_before_selection"] is True
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "n=2 observation",
    "does not query or mutate github",
    "does not replace github issue/pr/check/merge truth",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Benchmark-Before-Repair Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves benchmark semantics" assert_contract_semantics
check "template preserves benchmark semantics" assert_template_semantics
check "README points to contract" grep -Fq "benchmark-before-repair-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "benchmark-before-repair.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/benchmark-before-repair-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/benchmark-before-repair.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-benchmark-before-repair-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
