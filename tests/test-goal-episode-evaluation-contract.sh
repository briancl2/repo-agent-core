#!/usr/bin/env bash
# Verify the shared Goal episode evaluation contract stays explicit.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/goal-episode-evaluation-contract.md"
TEMPLATE="$REPO_ROOT/templates/goal-episode-evaluation.md"

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

echo "=== Goal Episode Evaluation Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract names Goal objective" grep -Fq "Goal objective" "$CONTRACT"
check "contract requires PRs merged" grep -Fq "PRs merged" "$CONTRACT"
check "contract requires repos touched" grep -Fq "Repos touched" "$CONTRACT"
check "contract requires owner PR count" grep -Fq "Owner PR count" "$CONTRACT"
check "contract requires BMA PR count" grep -Fq "BMA PR count" "$CONTRACT"
check "contract requires raw runtime evidence" grep -Fq "Raw runtime evidence" "$CONTRACT"
check "contract requires operator interventions" grep -Fq "Operator interventions" "$CONTRACT"
check "contract requires next exact owner-surface action" grep -Fq "Next exact owner-surface action" "$CONTRACT"
check "contract separates owner mutation from read-only validation" grep -Fq "read-only validation targets" "$CONTRACT"
check "contract forbids controller regrowth" grep -Fq "controller" "$CONTRACT"
check "contract forbids scheduler regrowth" grep -Fq "scheduler" "$CONTRACT"
check "contract forbids queue regrowth" grep -Fq "queue" "$CONTRACT"
check "self-healing routes known failures to owner surface" grep -Fq "If the failing owner surface is known" "$CONTRACT"
check "template carries runtime health grade table" grep -Fq "| Runtime health |" "$TEMPLATE"
check "template carries bounded non-claims" grep -Fq "Bounded Non-Claims" "$TEMPLATE"

echo ""
echo "=== test-goal-episode-evaluation-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
