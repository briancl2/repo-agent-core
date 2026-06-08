#!/usr/bin/env bash
# Verify the Hermes repo-star reliability contract stays bounded and read-only.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/hermes-foreground-repo-star-pilot-reliability-contract.md"
TEMPLATE="$REPO_ROOT/templates/hermes-foreground-repo-star-pilot-reliability.md"
SAMPLE="$REPO_ROOT/tests/samples/HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT.json"

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

for field in [
    "hermes_launcher",
    "target_identities",
    "target_git_state_matrix",
    "reliability_trial_matrix",
    "reliability_summary",
    "repo_star_inputs",
    "output_roots",
    "failure_conversion",
    "owner_routing",
    "bounded_non_claims",
]:
    assert field in text, field

for state in [
    "clean_receipt",
    "empty_stdout",
    "missing_receipt",
    "timeout",
    "warning_only",
    "session_only",
    "useful_analysis_with_failure",
    "target_mutation_attempt",
    "broad_rewrite_risk",
    "launcher_failure",
    "validation_failure",
    "not_run",
]:
    assert state in text, state

for phrase in [
    "scripts/run-hermes-foreground.py --provider copilot --model gpt-5.5",
    "does not use or adopt `hermes -z`",
    "writes prompts, receipts, failure guidance, summaries, generated patch text",
    "read-only success requires exact",
    "converts route-changing hermes failures to github issue/comment truth",
    "build-meta-analysis for",
    "repo-agent-core for shared contracts",
    "repo-auditor for detection",
    "repo-upgrade-advisor for",
    "repo-optimizer for",
    "does not make hermes the campaign owner",
    "does not make gbrain canonical",
    "no daemon",
    "no scheduler",
    "no queue",
    "no controller",
    "no background sync",
    "no automatic github",
]:
    assert phrase in lower, phrase

for forbidden in [
    "may mutate downstream",
    "can mutate downstream",
    "may use hermes -z",
    "starts a daemon",
    "starts a scheduler",
    "hidden registry tracks",
    "background sync keeps",
]:
    assert forbidden not in lower, forbidden
PY
}

assert_template_semantics() {
    python3 - "$TEMPLATE" <<'PY'
import json
import re
import sys

text = open(sys.argv[1], encoding="utf-8").read()
match = re.search(r"```json\n(.*?)\n```", text, re.S)
assert match, "template JSON fence"
payload = json.loads(match.group(1))

assert payload["artifact"] == "HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT"
assert payload["hermes_launcher"]["provider"] == "copilot"
assert payload["hermes_launcher"]["model"] == "gpt-5.5"
assert payload["hermes_launcher"]["hermes_z_used"] is False
assert len(payload["target_identities"]) == 2
assert all(row["target_is_non_bma"] is True for row in payload["target_identities"])
assert all(row["read_only_state_preserved"] is True for row in payload["target_git_state_matrix"])
outcomes = {row["outcome"] for row in payload["reliability_trial_matrix"]}
assert "clean_receipt" in outcomes
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in ["does not mutate downstream targets", "does not adopt or validate hermes -z", "does not make gbrain canonical"]:
    assert phrase in claims, phrase
PY
}

assert_sample_semantics() {
    python3 - "$SAMPLE" <<'PY'
import json
import sys

payload = json.load(open(sys.argv[1], encoding="utf-8"))
assert payload["artifact"] == "HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT"
assert payload["source_issue_or_pr"].endswith("/528")
assert payload["hermes_launcher"]["provider"] == "copilot"
assert payload["hermes_launcher"]["model"] == "gpt-5.5"
assert payload["hermes_launcher"]["hermes_z_used"] is False
assert {row["target_key"] for row in payload["target_identities"]} == {"portfolio_advisor", "customer-newsletter"}
for row in payload["target_git_state_matrix"]:
    assert row["git_head_before"] == row["git_head_after"]
    assert row["git_status_before"] == row["git_status_after"]
    assert row["read_only_state_preserved"] is True
assert payload["reliability_summary"]["read_only_targets_preserved"] is True
assert payload["reliability_summary"]["clean_receipt_count"] == 1
outcomes = {row["outcome"] for row in payload["reliability_trial_matrix"]}
assert {"clean_receipt", "not_run"}.issubset(outcomes)
owners = {row["owner_surface"] for row in payload["owner_routing"]}
assert {"build-meta-analysis", "repo-agent-core", "repo-auditor", "repo-upgrade-advisor", "repo-optimizer"}.issubset(owners)
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not mutate downstream targets",
    "does not apply patches",
    "does not open downstream prs or issues",
    "does not make hermes the campaign owner",
    "does not adopt or validate hermes -z",
    "does not make gbrain canonical",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Hermes Foreground Repo-Star Pilot Reliability Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "sample exists" test -s "$SAMPLE"
check "contract preserves required semantics" assert_contract_semantics
check "template preserves required semantics" assert_template_semantics
check "sample preserves read-only reliability semantics" assert_sample_semantics
check "sample validates against schema" bash "$REPO_ROOT/scripts/validate-artifacts.sh" "$SAMPLE" HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT
check "README points to contract" grep -Fq "hermes-foreground-repo-star-pilot-reliability-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "hermes-foreground-repo-star-pilot-reliability.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/hermes-foreground-repo-star-pilot-reliability-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to schema" grep -Fq "schemas/HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT.schema.json" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-hermes-foreground-repo-star-pilot-reliability-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
