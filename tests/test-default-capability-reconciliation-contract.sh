#!/usr/bin/env bash
# Verify the default capability reconciliation contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/default-capability-reconciliation-contract.md"
TEMPLATE="$REPO_ROOT/templates/default-capability-reconciliation.md"

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

echo "=== Default Capability Reconciliation Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "names capability source" grep -Fq "Capability source" "$CONTRACT"
check "names upstream-main proof" grep -Fq "Upstream-main proof" "$CONTRACT"
check "names local proof" grep -Fq "Local proof" "$CONTRACT"
check "names local same-version proof" grep -Fq "Local same-version proof" "$CONTRACT"
check "names native evidence before verdict" grep -Fq "Native evidence before verdict" "$CONTRACT"
check "names default/substitute decision" grep -Fq "Default/substitute decision" "$CONTRACT"
check "names owner surface" grep -Fq "Owner surface" "$CONTRACT"
check "names first deliverable" grep -Fq "First deliverable" "$CONTRACT"
check "names fallback if blocked" grep -Fq "Fallback if blocked" "$CONTRACT"
check "names fallback path" grep -Fq "fallback path" "$CONTRACT"
check "names validation scope" grep -Fq "Validation scope" "$CONTRACT"
check "names validation receipt" grep -Fq "validation receipt" "$CONTRACT"
check "names regrowth boundary" grep -Fq "Regrowth boundary" "$CONTRACT"
check "defines adoption state" grep -Fq "| Adopt |" "$CONTRACT"
check "defines quarantine state" grep -Fq "| Quarantine |" "$CONTRACT"
check "requires current local proof" grep -Fq "current local proof" "$CONTRACT"
check "requires production default upstream-main proof" grep -Fq "Production default adoption requires upstream-main proof" "$CONTRACT"
check "requires production default local same-version proof" grep -Fq "local same-version" "$CONTRACT"
check "requires native command or blocker on verdict surface" grep -Fq "native command/workflow output or a concrete owner-surface blocker" "$CONTRACT"
check "requires issue truth on known owner surface" grep -Fq "truth on that owner surface" "$CONTRACT"
check "forbids controller regrowth" grep -Fq "controller" "$CONTRACT"
check "forbids scheduler regrowth" grep -Fq "scheduler" "$CONTRACT"
check "forbids queue regrowth" grep -Fq "queue" "$CONTRACT"
check "template includes upstream-main proof" grep -Fq "Upstream-main proof" "$TEMPLATE"
check "template includes local same-version proof" grep -Fq "Local same-version proof" "$TEMPLATE"
check "template includes native evidence before verdict" grep -Fq "Native evidence before verdict" "$TEMPLATE"
check "template includes fallback path" grep -Fq "Fallback path" "$TEMPLATE"
check "template includes validation receipt" grep -Fq "Validation receipt" "$TEMPLATE"
check "template includes regrowth boundary" grep -Fq "Regrowth boundary" "$TEMPLATE"

echo ""
echo "=== test-default-capability-reconciliation-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
