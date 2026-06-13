#!/usr/bin/env bash
# Verify the foreground failure-to-issue conversion contract stays portable and bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/foreground-failure-to-issue-conversion-contract.md"
TEMPLATE="$REPO_ROOT/templates/foreground-failure-to-issue-conversion.md"

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
        "daemon is allowed",
        "scheduler is allowed",
        "queue is allowed",
        "retry loop is allowed",
        "controller is allowed",
        "hidden registry is allowed",
        "background gbrain behavior is allowed",
        "automatic background issue creation is allowed",
        "auto-merge is allowed",
        "downstream mutation is allowed",
        "hermes internals mutation is allowed",
        "gbrain internals mutation is allowed",
        "runtime dependency behavior is allowed",
        "automatically retry",
        "automatically repair",
    ]
    for phrase in forbidden_phrases:
        assert phrase not in text, f"{path}: forbidden positive regrowth phrase: {phrase}"
PY
}

echo "=== Foreground Failure-To-Issue Conversion Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"

for composed in \
    "docs/foreground-recovery-runtime-contract.md" \
    "docs/hermes-foreground-launcher-contract.md" \
    "docs/interruption-recovery-and-batch-reconstitution-contract.md" \
    "docs/foreground-learning-and-recovery-contract.md"; do
    check "contract composes $composed" grep -Fq "$composed" "$CONTRACT"
done

check "contract accepts HERMES_FOREGROUND_FAILURE_GUIDANCE" grep -Fq "HERMES_FOREGROUND_FAILURE_GUIDANCE" "$CONTRACT"
check "template accepts HERMES_FOREGROUND_FAILURE_GUIDANCE" grep -Fq "HERMES_FOREGROUND_FAILURE_GUIDANCE" "$TEMPLATE"

for field in \
    "campaign issue URL" \
    "repo" \
    "command family" \
    "failure code" \
    "primary object" \
    "attempted command" \
    "status" \
    "evidence file" \
    "source receipt path" \
    "recommended owner" \
    "impact" \
    "dedupe key" \
    "owner action" \
    "bounded non-claims"; do
    check "contract requires field: $field" grep -Fq "$field" "$CONTRACT"
    check "template includes field: $field" grep -Fq "$field" "$TEMPLATE"
done

for dedupe_text in \
    "Exact marker search is authoritative" \
    "bounded fallback body scan" \
    "index-lag guard" \
    "broad fallback saturation is not a permanent blocker" \
    "clean exact marker search"; do
    check "contract states dedupe semantic: $dedupe_text" grep -Fiq "$dedupe_text" "$CONTRACT"
done

for output_text in \
    "GitHub issue or GitHub issue comment truth" \
    "dedupe key" \
    "evidence path" \
    "owner action" \
    "no automatic retry/repair"; do
    check "contract states conversion output: $output_text" grep -Fq "$output_text" "$CONTRACT"
    check "template states conversion output: $output_text" grep -Fq "$output_text" "$TEMPLATE"
done

check "contract routes GitHub ambiguity to visible blocker truth" grep -Fq "unresolved GitHub/API/check ambiguity becomes GitHub-visible blocker truth" "$CONTRACT"
check "contract rejects local retained package fallback" grep -Fq "not a local retained package" "$CONTRACT"
check "template includes GitHub blocker field" grep -Fq "GitHub-visible blocker" "$TEMPLATE"

for forbidden in \
    "daemon" \
    "scheduler" \
    "queue" \
    "retry loop" \
    "registry" \
    "controller" \
    "hidden registry" \
    "background GBrain behavior" \
    "automatic background issue creation" \
    "auto-merge" \
    "downstream mutation" \
    "Hermes/GBrain internals mutation" \
    "runtime dependency behavior"; do
    check "contract forbids $forbidden" grep -Fq "$forbidden" "$CONTRACT"
    check "template forbids $forbidden" grep -Fq "$forbidden" "$TEMPLATE"
done

check "contract and template avoid positive regrowth language" assert_no_positive_regrowth_language
check "README points to failure-to-issue contract" grep -Fq "foreground-failure-to-issue-conversion-contract.md" "$REPO_ROOT/README.md"
check "README points to failure-to-issue template" grep -Fq "foreground-failure-to-issue-conversion.md" "$REPO_ROOT/README.md"
check "AGENTS points to failure-to-issue contract" grep -Fq "docs/foreground-failure-to-issue-conversion-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to failure-to-issue template" grep -Fq "templates/foreground-failure-to-issue-conversion.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-foreground-failure-to-issue-conversion-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
