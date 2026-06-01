#!/usr/bin/env bash
# Verify the shared interruption recovery contract stays concrete and bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/interruption-recovery-and-batch-reconstitution-contract.md"
TEMPLATE="$REPO_ROOT/templates/interruption-recovery-and-batch-reconstitution.md"

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

echo "=== Interruption Recovery Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract requires original objective" grep -Fq "Original objective" "$CONTRACT"
check "contract requires blocker class" grep -Fq "Blocker class" "$CONTRACT"
check "contract requires Goal state" grep -Fq "Goal state" "$CONTRACT"
check "contract requires replacement objective" grep -Fq "Replacement objective" "$CONTRACT"
check "contract requires first owner PR" grep -Fq "First owner PR" "$CONTRACT"
check "contract requires intentional serial/parallel plan" grep -Fq "Intentional serial/parallel plan" "$CONTRACT"
check "contract requires learning trigger" grep -Fq "Learning trigger" "$CONTRACT"
check "contract requires fallback" grep -Fq "Fallback" "$CONTRACT"
check "contract requires validation" grep -Fq "Validation" "$CONTRACT"
check "contract converts blockers to GitHub issue truth" grep -Fq "Convert the concrete blocker to owner GitHub issue truth" "$CONTRACT"
check "contract prevents fractured serial continuation" grep -Fq "Do not silently shrink a multi-PR episode" "$CONTRACT"
check "contract rejects operator handback categories" grep -Fq "Do not ask the operator to pick a category" "$CONTRACT"
check "contract stops on fresh permission boundaries" grep -Fq "A fresh permission boundary stops" "$CONTRACT"
check "contract forbids controller regrowth" grep -Fq "controller" "$CONTRACT"
check "contract forbids scheduler regrowth" grep -Fq "scheduler" "$CONTRACT"
check "contract forbids queue regrowth" grep -Fq "queue" "$CONTRACT"
check "contract forbids background sync" grep -Fq "background sync" "$CONTRACT"
check "template includes GitHub blocker issue field" grep -Fq "GitHub blocker issue" "$TEMPLATE"
check "template includes recovery complete condition" grep -Fq "Recovery complete when" "$TEMPLATE"
check "template carries bounded non-claims" grep -Fq "Bounded Non-Claims" "$TEMPLATE"

echo ""
echo "=== test-interruption-recovery-and-batch-reconstitution-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
