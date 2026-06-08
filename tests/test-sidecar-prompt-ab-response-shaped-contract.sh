#!/usr/bin/env bash
# Verify the sidecar Prompt A/B response-shaped contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/sidecar-prompt-ab-response-shaped-contract.md"
TEMPLATE="$REPO_ROOT/templates/sidecar-prompt-ab-response-shaped.md"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

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
check "contract requires single-paste invariant" grep -Fq "Single-paste invariant" "$CONTRACT"
check "contract says no additional files are required" grep -Fq "no additional files are required" "$CONTRACT"
check "contract assigns evidence assembly repo-side" grep -Fq "repo-side coordinator/tooling owns evidence assembly" "$CONTRACT"
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
check "template starts Prompt A as a paste-ready artifact" grep -Fq "Paste this entire file into ChatGPT Pro. No other files are required." "$TEMPLATE"
check "template assigns evidence assembly repo-side" grep -Fq "repo-side tooling/coordinator owns evidence assembly" "$TEMPLATE"
check "template keeps file assembly repo-side" grep -Fq "Keep report, ledger, transcript, excerpt, and evidence-file assembly on the" "$TEMPLATE"
check "template requires actual Prompt A response" grep -Fq "actual Prompt A response exists" "$TEMPLATE"
check "template carries response-shaped Prompt B mode" grep -Fq 'Prompt B mode: `response-shaped`' "$TEMPLATE"
check "template carries hypothetical draft boundary" grep -Fq "Hypothetical Draft Boundary" "$TEMPLATE"
check "template blocks campaign direction from draft" grep -Fq "must not be treated as campaign direction" "$TEMPLATE"
check "README points to contract" grep -Fq "sidecar-prompt-ab-response-shaped-contract.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/sidecar-prompt-ab-response-shaped-contract.md" "$REPO_ROOT/AGENTS.md"

bad_prompt="$TMP_DIR/bad-prompt-a.md"
cat > "$bad_prompt" <<'EOF_BAD_PROMPT'
# Prompt A

The operator should gather the report, the runtime ledger, and transcript
excerpts before pasting this prompt.
EOF_BAD_PROMPT

if grep -Eiq 'operator[[:space:]]+(should|must|has to|needs to)?[[:space:]]*(gather|assemble|collect).*(file|files|evidence|ledger|ledgers|transcript|transcripts|report|reports|excerpt|excerpts)' "$bad_prompt"; then
    echo "  PASS: negative fixture catches operator file-gathering prompt"
    PASS=$((PASS + 1))
else
    echo "  FAIL: negative fixture did not catch operator file-gathering prompt"
    FAIL=$((FAIL + 1))
fi

if grep -Eiq 'operator[[:space:]]+(should|must|has to|needs to)?[[:space:]]*(gather|assemble|collect).*(file|files|evidence|ledger|ledgers|transcript|transcripts|report|reports|excerpt|excerpts)' "$CONTRACT" "$TEMPLATE"; then
    echo "  FAIL: contract/template contain operator file-gathering prompt language"
    FAIL=$((FAIL + 1))
else
    echo "  PASS: contract/template avoid operator file-gathering prompt language"
    PASS=$((PASS + 1))
fi

echo ""
echo "=== test-sidecar-prompt-ab-response-shaped-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
