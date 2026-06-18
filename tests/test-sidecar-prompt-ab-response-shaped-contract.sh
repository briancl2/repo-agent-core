#!/usr/bin/env bash
# Verify the standalone external-intelligence sidecar contract stays bounded.

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

echo "=== Standalone External-Intelligence Sidecar Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract names v2 token" grep -Fq "STANDALONE_EXTERNAL_INTELLIGENCE_SIDECAR" "$CONTRACT"
check "contract supersedes v1" grep -Fq "Supersedes: Sidecar Prompt A/B Response-Shaped Contract v1.0" "$CONTRACT"
check "contract preserves Prompt A mode" grep -Fq "Prompt A mode" "$CONTRACT"
check "contract preserves Prompt B mode" grep -Fq "Prompt B mode" "$CONTRACT"
check "contract adds singleton mode" grep -Fq "Singleton mode" "$CONTRACT"
check "contract adds Deep Research mode" grep -Fq "Deep Research mode" "$CONTRACT"
check "contract requires pure prompt invariant" grep -Fq "Pure prompt invariant" "$CONTRACT"
check "contract forbids operator wrapper text" grep -Fq "operator wrapper text" "$CONTRACT"
check "contract denies local filesystem access" grep -Fq "no local filesystem access" "$CONTRACT"
check "contract denies private repository access" grep -Fq "no private repository access" "$CONTRACT"
check "contract denies GitHub issue access" grep -Fq "no GitHub issue access" "$CONTRACT"
check "contract requires embedded context" grep -Fq "All required context" "$CONTRACT"
check "contract marks public URLs optional" grep -Fq "Public URLs may appear only as optional" "$CONTRACT"
check "contract marks URLs non-load-bearing" grep -Fq "non-load-bearing" "$CONTRACT"
check "contract requires definitions" grep -Fq "Project jargon and acronyms are defined" "$CONTRACT"
check "contract blocks prompt-layer confusion" grep -Fq "not to review, critique, or improve the prompt itself" "$CONTRACT"
check "contract requires actual Prompt A output" grep -Fq "actual Prompt A output" "$CONTRACT"
check "contract invalidates Prompt B without Prompt A" grep -Fq "Prompt B without actual Prompt A output is invalid" "$CONTRACT"
check "contract requires research targets" grep -Fq "research targets" "$CONTRACT"
check "contract requires source rules" grep -Fq "source rules" "$CONTRACT"
check "contract requires source-ledger response shape" grep -Fq "source-ledger response shape" "$CONTRACT"
check "contract preserves advisory boundary" grep -Fq "Sidecar output is advisory" "$CONTRACT"
check "contract routes detector gap to repo-auditor" grep -Fq "repo-auditor" "$CONTRACT"
check "contract routes advisor family" grep -Fq "standalone_external_intelligence_sidecar_gap" "$CONTRACT"
check "contract forbids controller regrowth" grep -Fq "controller" "$CONTRACT"
check "contract forbids scheduler regrowth" grep -Fq "scheduler" "$CONTRACT"
check "contract forbids queue regrowth" grep -Fq "queue" "$CONTRACT"
check "contract forbids daemon regrowth" grep -Fq "daemon" "$CONTRACT"
check "contract forbids background sync" grep -Fq "background sync" "$CONTRACT"

check "template addresses external intelligence" grep -Fq "You are an external intelligence receiving a standalone prompt" "$TEMPLATE"
check "template denies local filesystem access" grep -Fq "You do not have local filesystem access" "$TEMPLATE"
check "template has mode section" grep -Fq "## Mode" "$TEMPLATE"
check "template has definitions section" grep -Fq "## Definitions And Glossary" "$TEMPLATE"
check "template has embedded context section" grep -Fq "## Embedded Context" "$TEMPLATE"
check "template has optional source section" grep -Fq "## Optional Non-Load-Bearing Public Sources" "$TEMPLATE"
check "template has Prompt A instructions" grep -Fq "## Prompt A Instructions" "$TEMPLATE"
check "template has actual Prompt A output section" grep -Fq "## Actual Prompt A Output" "$TEMPLATE"
check "template has Prompt B answer section" grep -Fq "## Answered Context For Prompt B" "$TEMPLATE"
check "template has research targets" grep -Fq "## Research Targets" "$TEMPLATE"
check "template has source rules" grep -Fq "## Source Rules" "$TEMPLATE"
check "template has response shape" grep -Fq "## Response Shape" "$TEMPLATE"
check "template has advisory boundary" grep -Fq "This sidecar output is advisory" "$TEMPLATE"
check "template avoids old paste wrapper" bash -c "! grep -Fq 'Paste this entire file' '$TEMPLATE'"
check "template avoids copy wrapper" bash -c "! grep -Fq 'Copy this template' '$TEMPLATE'"

check "README points to standalone contract" grep -Fq "standalone external-intelligence sidecar contract" "$REPO_ROOT/README.md"
check "README names v2 token" grep -Fq "STANDALONE_EXTERNAL_INTELLIGENCE_SIDECAR" "$REPO_ROOT/README.md"
check "AGENTS points to standalone contract" grep -Fq "standalone external-intelligence sidecar contract" "$REPO_ROOT/AGENTS.md"
check "AGENTS names v2 token" grep -Fq "STANDALONE_EXTERNAL_INTELLIGENCE_SIDECAR" "$REPO_ROOT/AGENTS.md"

bad_prompt="$TMP_DIR/bad-prompt.md"
cat > "$bad_prompt" <<'EOF_BAD_PROMPT'
Copy and paste this prompt into the sidecar.
Read the GitHub issue and the local file path for context.
EOF_BAD_PROMPT

if grep -Eiq '(copy and paste|paste this|read the GitHub issue|local file path)' "$bad_prompt"; then
    echo "  PASS: negative fixture catches wrapper/local-GitHub dependency language"
    PASS=$((PASS + 1))
else
    echo "  FAIL: negative fixture did not catch wrapper/local-GitHub dependency language"
    FAIL=$((FAIL + 1))
fi

if grep -Eiq '(^|[^[:alpha:]])(Copy this template|Paste this entire file|Read the GitHub issue|local file path)' "$CONTRACT" "$TEMPLATE"; then
    echo "  FAIL: contract/template contain forbidden wrapper or access dependency language"
    FAIL=$((FAIL + 1))
else
    echo "  PASS: contract/template avoid forbidden wrapper and access dependency language"
    PASS=$((PASS + 1))
fi

echo ""
echo "=== test-sidecar-prompt-ab-response-shaped-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
