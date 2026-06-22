#!/usr/bin/env bash
# Verify the external critique capability contract stays localizable and bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/external-critique-capability-contract.md"
TEMPLATE="$REPO_ROOT/templates/external-critique-capability.md"

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

assert_contract_semantics() {
    python3 - "$CONTRACT" <<'PY'
import sys

text = open(sys.argv[1], encoding="utf-8").read()
lower = text.lower()

required_phrases = [
    "EXTERNAL_CRITIQUE_CAPABILITY",
    "bounded risk sensor",
    "not authority",
    "default path is one critic",
    "panel/latest-panel requires named high-stakes context",
    "No forced finding quota",
    "blocker or advisory",
    "One initial pass plus one follow-up pass",
    "independent owner evidence",
    "Target repo principles outrank imported BMA phrasing",
    "literal BMA wording is not canonical",
    "BMA prompt text may be seed evidence only",
    "CRITIQUE_RESULT",
]
for phrase in required_phrases:
    assert phrase.lower() in lower, phrase

for slot in [
    "authority_refs",
    "risk_vocabulary",
    "trigger_examples",
    "when_not_to_invoke",
    "privacy_redaction_boundaries",
    "receipt_runtime_expectations",
    "target_specific_anti_patterns",
]:
    assert slot in text, slot

for forbidden in [
    "controller",
    "scheduler",
    "queue",
    "daemon",
    "registry",
    "dashboard",
    "retry loop",
    "background memory",
    "automatic issue/pr system",
    "standing paired-probe program",
    "central service",
    "auto-merge",
    "downstream repos",
]:
    assert forbidden in lower, forbidden
PY
}

assert_template_semantics() {
    python3 - "$TEMPLATE" <<'PY'
import sys

text = open(sys.argv[1], encoding="utf-8").read()
lower = text.lower()

for phrase in [
    "artifact: EXTERNAL_CRITIQUE_CAPABILITY",
    "BMA seed evidence, if any",
    "authority refs",
    "target principles precedence",
    "independent owner evidence",
    "risk vocabulary",
    "trigger examples",
    "when-not-to-invoke rule",
    "privacy/redaction boundaries",
    "receipt/runtime expectations",
    "target-specific anti-patterns",
    "critic mode",
    "one_critic_default",
    "named_high_stakes_panel",
    "latest_panel",
    "finding quota: none",
    "blocker/advisory rule",
    "non-authority statement",
]:
    assert phrase.lower() in lower, phrase

for phrase in [
    "controller",
    "scheduler",
    "queue",
    "daemon",
    "registry",
    "dashboard",
    "retry loop",
    "background memory",
    "automatic issue/pr system",
    "standing paired-probe program",
    "central service",
    "auto-merge",
    "live external probe authorization",
    "downstream mutation path",
    "bma canonical wording",
]:
    assert phrase in lower, phrase
PY
}

assert_no_positive_regrowth_language() {
    python3 - "$CONTRACT" "$TEMPLATE" <<'PY'
import sys

for path in sys.argv[1:]:
    lower = open(path, encoding="utf-8").read().lower()
    for phrase in [
        "controller is allowed",
        "scheduler is allowed",
        "queue is allowed",
        "daemon is allowed",
        "registry is allowed",
        "dashboard is allowed",
        "automatically create issues",
        "automatically create prs",
        "auto-merge is allowed",
        "forced finding quota is required",
        "forced finding quota is allowed",
        "bma wording is canonical",
        "critic output is authority",
        "panel by default",
        "standing paired-probe program is allowed",
    ]:
        assert phrase not in lower, f"{path}: {phrase}"
PY
}

echo "=== External Critique Capability Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves bounded critique semantics" assert_contract_semantics
check "template preserves localizable slots" assert_template_semantics
check "contract/template avoid positive regrowth language" assert_no_positive_regrowth_language
check "README points to critique capability contract" grep -Fq "external-critique-capability-contract.md" "$REPO_ROOT/README.md"
check "README points to critique capability template" grep -Fq "external-critique-capability.md" "$REPO_ROOT/README.md"
check "AGENTS points to critique capability contract" grep -Fq "docs/external-critique-capability-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to critique capability template" grep -Fq "templates/external-critique-capability.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-external-critique-capability-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
