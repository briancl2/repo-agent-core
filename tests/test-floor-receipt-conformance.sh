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
echo "=== Fleet floor role separation (offline) ==="

FAKE_GH_ROOT="$TMP_ROOT/fake-gh"
FAKE_BIN="$TMP_ROOT/bin"
mkdir -p "$FAKE_BIN"
for repo in \
    repo-agent-core \
    repo-upgrade-advisor \
    repo-optimizer \
    repo-auditor \
    build-meta-analysis
do
    mkdir -p "$FAKE_GH_ROOT/$repo/docs" "$FAKE_GH_ROOT/$repo/scripts"
    printf '%s\n' '["test"]' > "$FAKE_GH_ROOT/$repo/protection.json"
done

for repo in repo-agent-core repo-upgrade-advisor repo-auditor build-meta-analysis; do
    write_receipt "$FAKE_GH_ROOT/$repo/docs/repo-agent-fleet-consistency-floor-receipt.md" \
        "floor v0.2" "$VALID_JSON"
done
for repo in repo-upgrade-advisor repo-optimizer repo-auditor build-meta-analysis; do
    cp "$VALIDATOR" "$FAKE_GH_ROOT/$repo/scripts/validate-floor-receipt.sh"
done

printf '%s\n' \
    '#!/usr/bin/env bash' \
    'set -euo pipefail' \
    '[ "$1" = "api" ]' \
    'endpoint="$2"' \
    'prefix="repos/${FLEET_OWNER}/"' \
    'rest="${endpoint#"$prefix"}"' \
    'repo="${rest%%/*}"' \
    'case "$endpoint" in' \
    '  */contents/*\?ref=main)' \
    '    relative="${rest#*/contents/}"' \
    '    relative="${relative%\?ref=main}"' \
    '    fixture="$FAKE_GH_ROOT/$repo/$relative"' \
    '    [ -f "$fixture" ] || exit 1' \
    '    base64 < "$fixture" | tr -d "\n"' \
    '    ;;' \
    '  */branches/main/protection)' \
    '    cat "$FAKE_GH_ROOT/$repo/protection.json"' \
    '    ;;' \
    '  *) exit 1 ;;' \
    'esac' \
    > "$FAKE_BIN/gh"
chmod +x "$FAKE_BIN/gh"

run_fleet_audit() {
    env \
        PATH="$FAKE_BIN:$PATH" \
        FLEET_OWNER="fixture-owner" \
        FAKE_GH_ROOT="$FAKE_GH_ROOT" \
        CANONICAL_VALIDATOR="$VALIDATOR" \
        bash "$FLEET_AUDIT"
}

AUDIT_OUTPUT="$TMP_ROOT/fleet-audit.out"
if run_fleet_audit > "$AUDIT_OUTPUT" 2>&1; then
    check "accepted Optimizer validator-only role passes" \
        grep -Fq 'repo-optimizer        OK' "$AUDIT_OUTPUT"
    check "Optimizer receipt is not required while its validator matches" \
        grep -Fq 'static=n/a vendored=match' "$AUDIT_OUTPUT"
    for repo in repo-agent-core repo-upgrade-advisor repo-auditor build-meta-analysis; do
        check "unrelated receipt participant remains conformant: $repo" \
            grep -Eq "^${repo}[[:space:]]+OK" "$AUDIT_OUTPUT"
    done
else
    echo "  FAIL: accepted Optimizer validator-only role passes"
    sed -n '1,40p' "$AUDIT_OUTPUT"
    FAIL=$((FAIL + 1))
fi

rm "$FAKE_GH_ROOT/repo-optimizer/scripts/validate-floor-receipt.sh"
check_fails "missing Optimizer validator fails closed" run_fleet_audit
run_fleet_audit > "$AUDIT_OUTPUT" 2>&1 || true
check "missing Optimizer validator is diagnosed" \
    grep -Fq 'vendored validator missing' "$AUDIT_OUTPUT"
cp "$VALIDATOR" "$FAKE_GH_ROOT/repo-optimizer/scripts/validate-floor-receipt.sh"

printf '%s\n' 'validator drift' \
    > "$FAKE_GH_ROOT/repo-optimizer/scripts/validate-floor-receipt.sh"
check_fails "hash-drifted Optimizer validator fails closed" run_fleet_audit
run_fleet_audit > "$AUDIT_OUTPUT" 2>&1 || true
check "hash-drifted Optimizer validator is diagnosed" \
    grep -Fq 'vendored validator drift' "$AUDIT_OUTPUT"
cp "$VALIDATOR" "$FAKE_GH_ROOT/repo-optimizer/scripts/validate-floor-receipt.sh"

rm "$FAKE_GH_ROOT/repo-upgrade-advisor/docs/repo-agent-fleet-consistency-floor-receipt.md"
check_fails "required receipt participant missing its receipt fails closed" \
    run_fleet_audit
run_fleet_audit > "$AUDIT_OUTPUT" 2>&1 || true
check "missing required receipt is diagnosed" \
    grep -Fq 'receipt not found on main' "$AUDIT_OUTPUT"

echo ""
echo "Passed: $PASS  Failed: $FAIL"
[ "$FAIL" -eq 0 ]
