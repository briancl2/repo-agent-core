#!/usr/bin/env bash
# Verify the shared foreground learning/recovery contract stays anchored and bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/foreground-learning-and-recovery-contract.md"
TEMPLATE="$REPO_ROOT/templates/foreground-learning-and-recovery-block.md"

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

echo "=== Foreground Learning Recovery Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract requires decision changed" grep -Fq "Decision changed" "$CONTRACT"
check "contract requires GitHub surface" grep -Fq "GitHub surface" "$CONTRACT"
check "contract requires raw evidence" grep -Fq "Raw evidence" "$CONTRACT"
check "contract names optional GBrain slug" grep -Fq "Optional GBrain slug" "$CONTRACT"
check "contract requires no-capture reason" grep -Fq "No-capture reason" "$CONTRACT"
check "contract requires reusable learning text" grep -Fq "Reusable learning text" "$CONTRACT"
check "contract requires owner action" grep -Fq "Owner action" "$CONTRACT"
check "contract requires bounded non-claims" grep -Fq "Bounded non-claims" "$CONTRACT"
check "contract keeps GitHub as owner truth" grep -Fq "GitHub issue/PR/check/merge state remains the owner surface" "$CONTRACT"
check "contract captures only decision-changing learning" grep -Fq "Capture to GBrain only when the learning is reusable and decision-changing" "$CONTRACT"
check "contract records no-capture reason for routine events" grep -Fq "Routine \"no learning\" notes" "$CONTRACT"
check "contract routes known blockers to owner action" grep -Fq "route to owner action first" "$CONTRACT"
check "contract forbids watch" grep -Fq "gbrain sync --watch" "$CONTRACT"
check "contract forbids daemon" grep -Fq "daemon" "$CONTRACT"
check "contract forbids scheduler" grep -Fq "schedulers" "$CONTRACT"
check "contract forbids queue" grep -Fq "queues" "$CONTRACT"
check "contract forbids controller" grep -Fq "controllers" "$CONTRACT"
check "template includes no-capture reason" grep -Fq "No-capture reason" "$TEMPLATE"
check "template includes owner action" grep -Fq "Owner action" "$TEMPLATE"
check "AGENTS points to contract" grep -Fq "docs/foreground-learning-and-recovery-contract.md" "$REPO_ROOT/AGENTS.md"
check "README points to template" grep -Fq "foreground-learning-and-recovery-block.md" "$REPO_ROOT/README.md"

echo ""
echo "=== test-foreground-learning-and-recovery-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
