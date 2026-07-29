#!/usr/bin/env bash
# test-floor-receipt-conformance.sh — Assert this repo's own fleet
# consistency-floor receipt passes the canonical static validator.
#
# Auto-picked-up by `make test` (for t in tests/test-*.sh). This is the
# per-repo static-conformance gate for repo-agent-core (BMA #1214 Phase 4
# item b): it rides inside the already-required `test` check, adding no new
# required status context.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VALIDATOR="$REPO_ROOT/scripts/validate-floor-receipt.sh"
FLEET_AUDIT="$REPO_ROOT/scripts/fleet-floor-conformance-audit.sh"
RECEIPT="$REPO_ROOT/docs/repo-agent-fleet-consistency-floor-receipt.md"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/floor-receipt-conformance.XXXXXX")"
trap 'rm -rf "$TMP_ROOT"' EXIT

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

check_fails() {
    local desc="$1"
    shift
    if "$@" >/dev/null 2>&1; then
        echo "  FAIL: $desc"
        FAIL=$((FAIL + 1))
    else
        echo "  PASS: $desc"
        PASS=$((PASS + 1))
    fi
}

write_receipt() {
    local path="$1"
    local version="$2"
    local json="$3"
    printf '%s\n' "$version" '```json' "$json" '```' > "$path"
}

echo "=== Floor receipt conformance (self) ==="

check "canonical validator script exists" test -f "$VALIDATOR"
check "fleet audit script exists" test -f "$FLEET_AUDIT"
check "floor receipt exists" test -f "$RECEIPT"
check "canonical validator has valid shell syntax" bash -n "$VALIDATOR"
check "fleet audit has valid shell syntax" bash -n "$FLEET_AUDIT"
check "fleet audit names the canonical validator path" \
    grep -Fq 'scripts/validate-floor-receipt.sh' "$FLEET_AUDIT"
check "canonical validator names its fleet drift guard" \
    grep -Fq 'scripts/fleet-floor-conformance-audit.sh' "$VALIDATOR"
check "receipt conforms to floor v0.2 (static validator)" \
    bash "$VALIDATOR" "$RECEIPT"

VALID_JSON='{"schema_version":1,"ci_check_contract":{"branch_protection_required_checks":["test"]},"domain_outcome_delta":{"result_class":"bounded"}}'
write_receipt "$TMP_ROOT/valid.md" "floor v0.2" "$VALID_JSON"
check "minimal valid receipt passes" bash "$VALIDATOR" "$TMP_ROOT/valid.md"

check_fails "missing receipt fails closed" \
    bash "$VALIDATOR" "$TMP_ROOT/missing.md"

write_receipt "$TMP_ROOT/old-version.md" "floor v0.1" "$VALID_JSON"
check_fails "missing v0.2 declaration fails closed" \
    bash "$VALIDATOR" "$TMP_ROOT/old-version.md"

write_receipt "$TMP_ROOT/malformed.md" "floor v0.2" '{"schema_version":'
check_fails "malformed JSON fails closed" \
    bash "$VALIDATOR" "$TMP_ROOT/malformed.md"

write_receipt "$TMP_ROOT/empty-checks.md" "floor v0.2" \
    '{"schema_version":1,"ci_check_contract":{"branch_protection_required_checks":[]},"domain_outcome_delta":{"result_class":"bounded"}}'
check_fails "empty required-check set fails closed" \
    bash "$VALIDATOR" "$TMP_ROOT/empty-checks.md"

write_receipt "$TMP_ROOT/missing-domain.md" "floor v0.2" \
    '{"schema_version":1,"ci_check_contract":{"branch_protection_required_checks":["test"]}}'
check_fails "missing domain outcome fails closed" \
    bash "$VALIDATOR" "$TMP_ROOT/missing-domain.md"

echo ""
echo "Passed: $PASS  Failed: $FAIL"
[ "$FAIL" -eq 0 ]
