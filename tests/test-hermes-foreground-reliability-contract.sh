#!/usr/bin/env bash
# Verify the Hermes foreground reliability contract stays bounded and portable.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/hermes-foreground-reliability-contract.md"
TEMPLATE="$REPO_ROOT/templates/hermes-foreground-reliability.md"

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
    "source_issue_or_pr",
    "campaign_link",
    "capability_placement",
    "hermes_eligibility",
    "attempt_role",
    "launcher_receipt",
    "final_output_validation",
    "failure_guidance",
    "coordinator_review",
    "validation_owner",
    "github_work_truth",
    "promotion_gate",
    "demotion_rejection_trigger",
    "checker_shadow_disposition",
    "bounded_non_claims",
]:
    assert field in text, field

for role in [
    "doer",
    "checker_shadow",
    "checker_advisory",
    "not_eligible",
]:
    assert role in text, role

for disposition in [
    "route_changing",
    "confirming",
    "duplicative",
    "noisy",
    "invalid",
]:
    assert disposition in text, disposition

for phrase in [
    "scripts/run-hermes-foreground.py --provider copilot --model gpt-5.5",
    "coordinator remains responsible",
    "failure guidance exists for route-changing failures",
    "doer proof does not transfer validation",
    "checker proof is clean only when hermes runs as an advisory foreground review",
    "route-changing checker failures or findings must be recorded on github",
    "demote or reject hermes",
    "`hermes -z` adoption",
    "copy-sync or cite",
]:
    assert phrase in lower, phrase

for forbidden in [
    "runtime dependency",
    "schema mandate",
    "daemon",
    "scheduler",
    "queue",
    "retry loop",
    "controller",
    "hidden registry",
    "MCP server",
    "watcher",
    "cron job",
    "background sync",
    "automatic GitHub issue creation",
    "automatic GitHub PR creation",
    "auto-merge",
    "downstream mutation",
    "Hermes repo mutation",
    "background Hermes behavior",
    "background GBrain behavior",
    "Codex cloud write authority",
    "Hermes-primary campaign control",
    "broad validation ownership",
    "Campaign Sync ownership",
    "merge ownership",
    "recovery ownership",
]:
    assert forbidden.lower() in lower, forbidden

for forbidden_claim in [
    "hermes owns validation",
    "hermes owns recovery",
    "hermes owns campaign sync",
    "auto-merge is allowed",
    "background hermes is allowed",
    "may mutate downstream",
]:
    assert forbidden_claim not in lower, forbidden_claim
PY
}

assert_template_semantics() {
    python3 - "$TEMPLATE" <<'PY'
import sys

text = open(sys.argv[1], encoding="utf-8").read()
lower = text.lower()

for heading in [
    "## Source",
    "## Capability Placement",
    "## Hermes Eligibility",
    "## Launcher Evidence",
    "## Coordinator Review",
    "## GitHub Work Truth",
    "## Checker Shadow Disposition",
    "## Promotion / Demotion",
    "## Bounded Non-Claims",
]:
    assert heading in text, heading

for phrase in [
    "Attempt role: `doer` / `checker_shadow` / `checker_advisory` / `not_eligible`",
    "Receipt path or URL",
    "Failure guidance path, URL, or not-needed reason",
    "Validation owner",
    "Disposition: `route_changing` / `confirming` / `duplicative` / `noisy` / `invalid` / `not_run`",
    "does not make Hermes the campaign owner",
    "does not adopt `hermes -z`",
    "does not mutate downstream repos or Hermes internals",
    "does not create or update GitHub issues or PRs automatically",
    "does not start a daemon",
]:
    assert phrase.lower() in lower, phrase
PY
}

echo "=== Hermes Foreground Reliability Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves required semantics" assert_contract_semantics
check "template preserves required semantics" assert_template_semantics
check "README points to contract" grep -Fq "hermes-foreground-reliability-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "hermes-foreground-reliability.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/hermes-foreground-reliability-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/hermes-foreground-reliability.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-hermes-foreground-reliability-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
