#!/usr/bin/env bash
# Verify the upstream capability intake contract stays bounded and field-complete.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/upstream-capability-intake-contract.md"
TEMPLATE="$REPO_ROOT/templates/upstream-capability-intake.md"

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

echo "=== Upstream Capability Intake Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "names component identity" grep -Fq "Component identity" "$CONTRACT"
check "names local version" grep -Fq "Local version" "$CONTRACT"
check "names upstream reference" grep -Fq "Upstream reference" "$CONTRACT"
check "names behindness signal" grep -Fq "Behindness signal" "$CONTRACT"
check "names source refs" grep -Fq "Source refs" "$CONTRACT"
check "names delta clusters" grep -Fq "Delta clusters" "$CONTRACT"
check "names capability decisions" grep -Fq "Capability decisions" "$CONTRACT"
check "names update action" grep -Fq "Update action" "$CONTRACT"
check "names validation" grep -Fq "Validation" "$CONTRACT"
check "names adoption-plan refs" grep -Fq "Adoption-plan refs" "$CONTRACT"
check "names owner routes" grep -Fq "Owner routes" "$CONTRACT"
check "names non-claims" grep -Fq "Non-claims" "$CONTRACT"
check "names out-of-bounds surfaces" grep -Fq "Out-of-bounds surfaces" "$CONTRACT"
check "defines adopt state" grep -Fq "| Adopt |" "$CONTRACT"
check "defines owner-route state" grep -Fq "| Owner-route |" "$CONTRACT"
check "defines delete/sunset state" grep -Fq "| Delete/sunset |" "$CONTRACT"
check "requires current local validation" grep -Fq "current local validation" "$CONTRACT"
check "distinguishes source facts from inference" grep -Fq "facts from local inference" "$CONTRACT"
check "requires owner routing for blockers" grep -Fq "known owner surface for a blocker" "$CONTRACT"
check "forbids controller regrowth" grep -Fq "controller" "$CONTRACT"
check "forbids scheduler regrowth" grep -Fq "scheduler" "$CONTRACT"
check "forbids generated inventory" grep -Fq "generated inventory" "$CONTRACT"
check "template includes component identity" grep -Fq "Component identity" "$TEMPLATE"
check "template includes validation receipt" grep -Fq "Validation receipt" "$TEMPLATE"
check "template includes owner action" grep -Fq "Owner action" "$TEMPLATE"
check "template includes fallback" grep -Fq "Fallback if blocked" "$TEMPLATE"
check "template includes no background sync boundary" grep -Fq "background sync" "$TEMPLATE"

echo ""
echo "=== test-upstream-capability-intake-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
