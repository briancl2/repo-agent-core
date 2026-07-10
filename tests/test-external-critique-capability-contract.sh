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
import re

text = open(sys.argv[1], encoding="utf-8").read()
lower = text.lower()

required_phrases = [
    "> Version: 1.2",
    "EXTERNAL_CRITIQUE_CAPABILITY",
    "external-critique-profile",
    "claude-opus-4.8|max",
    "gemini-3.1-pro-preview|high",
    "gpt-5.6-sol|max",
    "Configured-profile conformance",
    "observed runtime availability/receipt truth",
    "Historical receipts and archived outputs are immutable evidence",
    "not profile drift to rewrite",
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
    "Prefer repo-local skill or capability surfaces over prompt files",
    "prompt-only external critique is drift",
    "prompts may be request artifacts, sidecar artifacts, or provenance",
    "observed requested path/model",
    "actual responding path/model when known",
    "unavailable disposition",
    "No model probe is required or authorized",
]
for phrase in required_phrases:
    assert phrase.lower() in lower, phrase

assert not re.search(r"external-critique-profile(?:[-_](?:v?\d|20\d{2})|@)", lower), \
    "profile pointer must not carry a date or revision identity"

for slot in [
    "external_critique_profile_pointer",
    "configured_model_effort_slots",
    "authority_refs",
    "risk_vocabulary",
    "trigger_examples",
    "when_not_to_invoke",
    "privacy_redaction_boundaries",
    "receipt_runtime_expectations",
    "target_specific_anti_patterns",
    "capability_surface_expectations",
    "model_runtime_truth_fields",
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
    "`external_critique_profile_pointer`: `external-critique-profile`",
    "`default_single`: [`claude-opus-4.8|max`]",
    "`latest_panel`: [`claude-opus-4.8|max`, `gemini-3.1-pro-preview|high`, `gpt-5.6-sol|max`]",
    "configured-profile conformance",
    "runtime separation",
    "historical receipts and archived outputs are immutable evidence",
    "never revise a historical receipt or archived output",
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
    "capability surface",
    "repo-local skill or capability",
    "prompt artifact role",
    "requested path/model",
    "actual responding path/model",
    "unavailable disposition",
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

assert_summary_sync() {
    python3 - "$REPO_ROOT/README.md" "$REPO_ROOT/AGENTS.md" <<'PY'
import sys

for path in sys.argv[1:]:
    lower = open(path, encoding="utf-8").read().lower()
    for phrase in [
        "external-critique-profile",
        "claude-opus-4.8|max",
        "gemini-3.1-pro-preview|high",
        "gpt-5.6-sol|max",
        "configured-profile conformance",
        "historical receipts and archived outputs",
    ]:
        assert phrase in lower, f"{path}: {phrase}"
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
        "must add a model probe",
        "must introduce a probe program",
        "requires a model probe program",
        "prompt file is the primary capability surface",
        "prompts are the primary capability surface",
    ]:
        assert phrase not in lower, f"{path}: {phrase}"
PY
}

echo "=== External Critique Capability Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves bounded critique semantics" assert_contract_semantics
check "template preserves localizable slots" assert_template_semantics
check "README and AGENTS summarize the portable profile" assert_summary_sync
check "contract/template avoid positive regrowth language" assert_no_positive_regrowth_language
check "README points to critique capability contract" grep -Fq "external-critique-capability-contract.md" "$REPO_ROOT/README.md"
check "README points to critique capability template" grep -Fq "external-critique-capability.md" "$REPO_ROOT/README.md"
check "AGENTS points to critique capability contract" grep -Fq "docs/external-critique-capability-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to critique capability template" grep -Fq "templates/external-critique-capability.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-external-critique-capability-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
