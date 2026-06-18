#!/usr/bin/env bash
# Verify the Codex native runtime readiness contract stays bounded and evidence-first.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/codex-native-runtime-readiness-contract.md"
TEMPLATE="$REPO_ROOT/templates/codex-native-runtime-readiness.md"

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
    "CODEX_NATIVE_RUNTIME_READINESS",
    "transfer_mode",
    "launch_fallback",
    "runtime_surfaces_checked",
    "official_codex_context",
    "raw_evidence_basis",
    "goal_state",
    "run_root",
    "progress_ledger",
    "runtime_context_payload",
    "heartbeat_lifecycle",
    "local_worktree_dogfood",
    "cloud_remote_disposition",
    "automation_subagent_disposition",
    "github_truth",
    "ci_polling_terminal_condition",
    "promotion_gate",
    "demotion_rejection_trigger",
    "kill_switch",
    "bounded_non_claims",
    "next_owner_action",
]:
    assert field in text, field

for phrase in [
    "local environments",
    "worktrees",
    "cloud environments",
    "automations",
    "remote connections",
    "subagents",
    "context_only",
    "raw task evidence proves a live run",
    "same-thread continuation",
    "/tmp` run root",
    "progress-ledger.jsonl",
    "github issue/pr/check/merge truth",
    "official codex documentation a substitute for raw",
    "runtime improvement from goal",
    "background controllers",
    "next exact owner-surface action",
    "copy-sync or citation only",
]:
    assert phrase in lower, phrase

for forbidden in [
    "may create automatic issues",
    "may auto-merge",
    "starts a controller",
    "starts a scheduler",
    "starts a queue",
    "starts a daemon",
    "hidden registry tracks",
    "cloud execution is proven by docs",
    "remote execution is proven by docs",
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

assert payload["artifact"] == "CODEX_NATIVE_RUNTIME_READINESS"
assert payload["schema_version"] == 1
assert payload["capability"] == "Codex Native Runtime / Cloud / Remote Readiness"
assert payload["cloud_remote_disposition"] == "not_run_context_only"
assert payload["automation_subagent_disposition"] == "context_only_no_background_controller"
assert payload["official_codex_context"]["used_as"] == "capability context only unless raw runtime evidence proves live execution"
assert set(payload["runtime_surfaces_checked"]) >= {
    "local_environments",
    "worktrees",
    "cloud_environments",
    "automations",
    "remote_connections",
    "subagents",
}
for field in [
    "source_issue_or_pr",
    "transfer_mode",
    "raw_evidence_basis",
    "goal_state",
    "run_root",
    "progress_ledger",
    "runtime_context_payload",
    "heartbeat_lifecycle",
    "local_worktree_dogfood",
    "github_truth",
    "ci_polling_terminal_condition",
    "promotion_gate",
    "demotion_rejection_trigger",
    "kill_switch",
    "bounded_non_claims",
    "next_owner_action",
]:
    assert field in payload, field
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not prove live codex cloud or remote execution",
    "raw runtime evidence",
    "does not claim goal-mode runtime improvement",
    "does not make automations or subagents background controllers",
    "does not create a controller",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Codex Native Runtime Readiness Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves required semantics" assert_contract_semantics
check "template preserves evidence-first receipt semantics" assert_template_semantics
check "README points to contract" grep -Fq "codex-native-runtime-readiness-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "codex-native-runtime-readiness.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/codex-native-runtime-readiness-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/codex-native-runtime-readiness.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-codex-native-runtime-readiness-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
