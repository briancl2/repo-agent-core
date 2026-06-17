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
check "contract requires coordinator autonomy acceptance verdict" grep -Fq "Coordinator autonomy acceptance verdict" "$CONTRACT"
check "contract defines accepted verdict" grep -Fq 'accepted' "$CONTRACT"
check "contract defines partial verdict" grep -Fq 'partial' "$CONTRACT"
check "contract defines rejected verdict" grep -Fq 'rejected' "$CONTRACT"
check "contract defines not applicable verdict" grep -Fq 'not_applicable' "$CONTRACT"
check "contract requires PRs merged" grep -Fq "PRs merged" "$CONTRACT"
check "contract requires repos touched" grep -Fq "Repos touched" "$CONTRACT"
check "contract requires owner PR count" grep -Fq "Owner PR count" "$CONTRACT"
check "contract requires BMA PR count" grep -Fq "BMA PR count" "$CONTRACT"
check "contract requires raw runtime evidence" grep -Fq "Raw runtime evidence" "$CONTRACT"
check "contract requires Goal or Goal-null state for acceptance" grep -Fq "Goal state or Goal-null fallback" "$CONTRACT"
check "contract requires run root ledger for acceptance" grep -Fq 'run root plus `progress-ledger.jsonl`' "$CONTRACT"
check "contract requires heartbeat disposition for acceptance" grep -Fq "Heartbeat capture/disposition" "$CONTRACT"
check "contract requires demotion trigger for acceptance" grep -Fq "Demotion trigger" "$CONTRACT"
check "contract requires operator interventions" grep -Fq "Operator interventions" "$CONTRACT"
check "contract requires next exact owner-surface action" grep -Fq "Next exact owner-surface action" "$CONTRACT"
check "contract separates owner mutation from read-only validation" grep -Fq "read-only validation targets" "$CONTRACT"
check "contract forbids controller regrowth" grep -Fq "controller" "$CONTRACT"
check "contract forbids scheduler regrowth" grep -Fq "scheduler" "$CONTRACT"
check "contract forbids queue regrowth" grep -Fq "queue" "$CONTRACT"
check "contract forbids background acceptance overclaims" grep -Fq "Hermes-primary ownership" "$CONTRACT"
check "self-healing routes known failures to owner surface" grep -Fq "If the failing owner surface is known" "$CONTRACT"
check "template carries runtime health grade table" grep -Fq "| Runtime health |" "$TEMPLATE"
check "template carries coordinator autonomy acceptance section" grep -Fq "Coordinator Autonomy Acceptance" "$TEMPLATE"
check "template carries no background issue creation non-claim" grep -Fq "automatic issue/PR creator" "$TEMPLATE"
check "template carries bounded non-claims" grep -Fq "Bounded Non-Claims" "$TEMPLATE"

echo ""
echo "=== test-goal-episode-evaluation-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
