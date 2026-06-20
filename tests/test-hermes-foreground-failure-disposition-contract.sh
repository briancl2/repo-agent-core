#!/usr/bin/env bash
# Verify the Hermes foreground failure disposition contract stays portable and bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/hermes-foreground-failure-disposition-contract.md"
TEMPLATE="$REPO_ROOT/templates/hermes-foreground-failure-disposition.md"

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

assert_no_positive_regrowth_language() {
    python3 - "$CONTRACT" "$TEMPLATE" <<'PY'
import sys

for path in sys.argv[1:]:
    text = open(path, encoding="utf-8").read().lower()
    forbidden_phrases = [
        "controller is allowed",
        "scheduler is allowed",
        "queue is allowed",
        "daemon is allowed",
        "registry is allowed",
        "retry loop is allowed",
        "auto-close is allowed",
        "auto-merge is allowed",
        "automatically close",
        "automatically retry",
        "automatically repair",
        "downstream mutation is allowed",
    ]
    for phrase in forbidden_phrases:
        assert phrase not in text, f"{path}: forbidden positive regrowth phrase: {phrase}"
PY
}

echo "=== Hermes Foreground Failure Disposition Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"

for token in \
    "HERMES_FOREGROUND_FAILURE_DISPOSITION" \
    "failure issue" \
    "primary object" \
    "related repair PRs" \
    "command family" \
    "failure code" \
    "classification" \
    "close allowance" \
    "recommended action" \
    "blocker evidence" \
    "provider-policy evidence" \
    "GitHub truth" \
    "promotion trigger" \
    "demotion trigger" \
    "kill switch" \
    "bounded non-claims"; do
    check "contract includes $token" grep -Fq "$token" "$CONTRACT"
done

for classification in \
    "resolved_by_merged_repair" \
    "still_blocked" \
    "superseded_by_provider_policy" \
    "invalid_for_closure"; do
    check "contract includes classification $classification" grep -Fq "$classification" "$CONTRACT"
    check "template includes classification $classification" grep -Fq "$classification" "$TEMPLATE"
done

for rule in \
    "references the failure issue itself" \
    "Primary-object URL equality alone is not repair evidence" \
    "Missing PR evidence" \
    "unmerged PR evidence" \
    "ambiguous merged PR evidence" \
    "Partial provider-policy residue remains blocker evidence" \
    "explicit superseded-provider signal" \
    "current provider/model policy evidence"; do
    check "template states closure rule: $rule" grep -Fq "$rule" "$TEMPLATE"
done

for forbidden in \
    "controller" \
    "scheduler" \
    "queue" \
    "daemon" \
    "registry" \
    "retry loop" \
    "auto-close" \
    "auto-merge" \
    "automatic issue/PR creation" \
    "background Hermes/GBrain behavior" \
    "Hermes-primary authority" \
    "hermes -z" \
    "upstream Hermes mutation" \
    "downstream mutation" \
    "target mutation" \
    "runtime dependency behavior"; do
    check "contract forbids $forbidden" grep -Fq "$forbidden" "$CONTRACT"
    check "template forbids $forbidden" grep -Fq "$forbidden" "$TEMPLATE"
done

check "contract and template avoid positive regrowth language" assert_no_positive_regrowth_language
check "README points to failure disposition contract" grep -Fq "hermes-foreground-failure-disposition-contract.md" "$REPO_ROOT/README.md"
check "README points to failure disposition template" grep -Fq "hermes-foreground-failure-disposition.md" "$REPO_ROOT/README.md"
check "AGENTS points to failure disposition contract" grep -Fq "docs/hermes-foreground-failure-disposition-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to failure disposition template" grep -Fq "templates/hermes-foreground-failure-disposition.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-hermes-foreground-failure-disposition-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
