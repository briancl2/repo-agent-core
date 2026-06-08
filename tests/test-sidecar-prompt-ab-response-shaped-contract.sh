#!/usr/bin/env bash
# Verify the sidecar Prompt A/B response-shaped contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/sidecar-prompt-ab-response-shaped-contract.md"
TEMPLATE="$REPO_ROOT/templates/sidecar-prompt-ab-response-shaped.md"

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

echo "=== Sidecar Prompt A/B Response-Shaped Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract names Prompt A objective" grep -Fq "Prompt A objective" "$CONTRACT"
check "contract requires actual Prompt A response evidence" grep -Fq "Prompt A response evidence" "$CONTRACT"
check "contract names Prompt A acceptance check" grep -Fq "Prompt A acceptance check" "$CONTRACT"
check "contract names Prompt B mode" grep -Fq "Prompt B mode" "$CONTRACT"
check "contract defines response-shaped mode" grep -Fq "response-shaped" "$CONTRACT"
check "contract defines hypothetical-draft mode" grep -Fq "hypothetical-draft" "$CONTRACT"
check "contract requires Prompt B inputs" grep -Fq "Prompt B inputs" "$CONTRACT"
check "contract requires reconciliation task" grep -Fq "Prompt B reconciliation task" "$CONTRACT"
check "contract requires current-truth check" grep -Fq "Current-truth check" "$CONTRACT"
check "contract requires one exact owner action" grep -Fq "one exact owner-surface action" "$CONTRACT"
check "contract blocks pre-response reconciliation claims" grep -Fq "cannot claim reconciliation" "$CONTRACT"
check "contract routes shared gap to repo-agent-core" grep -Fq "Shared protocol gap: repo-agent-core" "$CONTRACT"
check "contract routes BMA consumption gap" grep -Fq "BMA campaign consumption gap: build-meta-analysis" "$CONTRACT"
check "contract forbids controller regrowth" grep -Fq "controller" "$CONTRACT"
check "contract forbids scheduler regrowth" grep -Fq "scheduler" "$CONTRACT"
check "contract forbids queue regrowth" grep -Fq "queue" "$CONTRACT"
check "contract forbids daemon regrowth" grep -Fq "daemon" "$CONTRACT"
check "contract forbids background sync" grep -Fq "background sync" "$CONTRACT"
check "template requires Prompt A assumption gaps" grep -Fq "assumption gaps" "$TEMPLATE"
check "template requires actual Prompt A response" grep -Fq "actual Prompt A response exists" "$TEMPLATE"
check "template carries response-shaped Prompt B mode" grep -Fq 'Prompt B mode: `response-shaped`' "$TEMPLATE"
check "template carries hypothetical draft boundary" grep -Fq "Hypothetical Draft Boundary" "$TEMPLATE"
check "template blocks campaign direction from draft" grep -Fq "must not be treated as campaign direction" "$TEMPLATE"
check "README points to contract" grep -Fq "sidecar-prompt-ab-response-shaped-contract.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/sidecar-prompt-ab-response-shaped-contract.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-sidecar-prompt-ab-response-shaped-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
