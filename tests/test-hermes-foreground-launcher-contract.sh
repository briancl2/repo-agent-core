#!/usr/bin/env bash
# Verify the shared Hermes foreground launcher contract stays compact and bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/hermes-foreground-launcher-contract.md"
TEMPLATE="$REPO_ROOT/templates/hermes-foreground-run-receipt.md"
SCHEMA="$REPO_ROOT/schemas/HERMES_FOREGROUND_RUN_RECEIPT.schema.json"
SAMPLE="$REPO_ROOT/tests/samples/HERMES_FOREGROUND_RUN_RECEIPT.json"

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

echo "=== Hermes Foreground Launcher Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "schema exists" test -s "$SCHEMA"
check "sample exists" test -s "$SAMPLE"
check "sample validates against schema" bash "$REPO_ROOT/scripts/validate-artifacts.sh" "$SAMPLE" HERMES_FOREGROUND_RUN_RECEIPT
check "contract names one-shot command" grep -Fq "hermes chat -q -Q" "$CONTRACT"
check "contract names explicit provider flag" grep -Fq -- "--provider" "$CONTRACT"
check "template names explicit provider flag" grep -Fq -- "--provider" "$TEMPLATE"
check "contract names schema" grep -Fq "schemas/HERMES_FOREGROUND_RUN_RECEIPT.schema.json" "$CONTRACT"
check "template names schema" grep -Fq "schemas/HERMES_FOREGROUND_RUN_RECEIPT.schema.json" "$TEMPLATE"
check "contract is for core-five propagation" grep -Fq "core-five propagation" "$CONTRACT"
check "contract allows copy-sync/citation only" grep -Fq "copy-sync or citation only" "$CONTRACT"
check "contract forbids downstream mutation" grep -Fq "Do not mutate downstream repos" "$CONTRACT"
check "contract forbids Hermes internals mutation" grep -Fq "Do not mutate Hermes internals" "$CONTRACT"

for field in \
    "artifact" \
    "schema_version" \
    "generated_at" \
    "command.argv" \
    "command.cwd" \
    "command.provider" \
    "command.model" \
    "command.max_turns" \
    "command.timeout_seconds" \
    "stdout_path" \
    "stderr_path" \
    "prompt.retained_path" \
    "prompt.sha256" \
    "return_code" \
    "validation.passed" \
    "validation.error" \
    "validation.final_response_lines" \
    "status" \
    "reason" \
    "bounded_non_claims"; do
    check "contract includes receipt field $field" grep -Fq "$field" "$CONTRACT"
done

for schema_field in \
    '"artifact"' \
    '"schema_version"' \
    '"generated_at"' \
    '"command"' \
    '"prompt"' \
    '"stdout_path"' \
    '"stderr_path"' \
    '"return_code"' \
    '"validation"' \
    '"bounded_non_claims"'; do
    check "schema includes $schema_field" grep -Fq "$schema_field" "$SCHEMA"
    check "template includes $schema_field" grep -Fq "$schema_field" "$TEMPLATE"
done

for forbidden in \
    "runtime dependency" \
    "daemon" \
    "scheduler" \
    "queue" \
    "retry loop" \
    "controller" \
    "MCP server" \
    "autopilot" \
    "hidden registry" \
    "automatic GitHub issue creation"; do
    check "contract forbids $forbidden" grep -Fq "$forbidden" "$CONTRACT"
done

check "contract requires bounded non-claims" grep -Fq "Bounded non-claims" "$CONTRACT"
check "template includes bounded non-claims" grep -Fq "Bounded non-claims" "$TEMPLATE"
check "README points to contract" grep -Fq "hermes-foreground-launcher-contract.md" "$REPO_ROOT/README.md"
check "README points to schema" grep -Fq "HERMES_FOREGROUND_RUN_RECEIPT.schema.json" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "hermes-foreground-run-receipt.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/hermes-foreground-launcher-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to schema" grep -Fq "schemas/HERMES_FOREGROUND_RUN_RECEIPT.schema.json" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/hermes-foreground-run-receipt.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-hermes-foreground-launcher-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
