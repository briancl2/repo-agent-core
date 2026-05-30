#!/usr/bin/env bash
# Verify the Issue #164 core-five owner-surface contract stays explicit.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/core-five-owner-surface-contract.md"

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

echo "=== Core-Five Owner-Surface Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "names BMA" grep -Fq "build-meta-analysis" "$CONTRACT"
check "names repo-agent-core" grep -Fq "repo-agent-core" "$CONTRACT"
check "names repo-auditor" grep -Fq "repo-auditor" "$CONTRACT"
check "names repo-upgrade-advisor" grep -Fq "repo-upgrade-advisor" "$CONTRACT"
check "names repo-optimizer" grep -Fq "repo-optimizer" "$CONTRACT"
check "states read-only reciprocal target rule" grep -Fq "read-only validation target" "$CONTRACT"
check "states owner issue branch PR checks merge" grep -Fq "issue, branch, PR, checks, and merge" "$CONTRACT"
check "defines capability-home table" grep -Fq "| Capability family | Owner surface | First deliverable shape |" "$CONTRACT"
check "forbids runtime dependency" grep -Fq "not a runtime dependency" "$CONTRACT"
check "forbids controller regrowth" grep -Fq "controller" "$CONTRACT"

echo ""
echo "=== test-core-five-owner-surface-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
