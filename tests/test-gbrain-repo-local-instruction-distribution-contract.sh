#!/usr/bin/env bash
# Verify the GBrain repo-local instruction distribution contract stays advisory and bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/gbrain-repo-local-instruction-distribution-contract.md"
TEMPLATE="$REPO_ROOT/templates/gbrain-repo-local-instruction-distribution.md"

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
    "artifact",
    "schema_version",
    "source_issue_or_contract",
    "contract_url",
    "repos_updated",
    "instruction_surfaces_updated",
    "gbrain_records_referenced",
    "citation_expectation",
    "advisory_status",
    "canonical_records_written",
    "background_behavior_used",
    "validation",
    "owner_routing",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "gbrain remains advisory",
    "operator intent",
    "github issue/pr/check/merge truth",
    "source/citation expectation",
    "draft",
    "shadow_canonical",
    "canonical records written must remain `0`",
    "existing `.github/copilot-instructions.md`",
    "do not create a broad new instruction system only for symmetry",
    "repo-auditor",
    "repo-upgrade-advisor",
    "copy-sync or citation only",
]:
    assert phrase in lower, phrase

for forbidden in [
    "makes gbrain canonical",
    "background gbrain behavior is allowed",
    "creates a scheduler",
    "creates a queue",
    "starts a daemon",
    "mcp server keeps copies aligned",
    "automatic updater keeps copies aligned",
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

assert payload["artifact"] == "GBRAIN_REPO_LOCAL_INSTRUCTION_DISTRIBUTION"
assert payload["schema_version"] == 1
assert payload["advisory_status"].lower() == "gbrain remains advisory"
assert payload["canonical_records_written"] == 0
assert payload["background_behavior_used"] is False
assert payload["repos_updated"], "repos_updated"
assert payload["instruction_surfaces_updated"], "instruction_surfaces_updated"
assert "slug" in payload["citation_expectation"].lower()
assert "source refs" in payload["citation_expectation"].lower()

owners = {row["owner_surface"] for row in payload["owner_routing"]}
for owner in ["repo-agent-core", "repo-auditor", "repo-upgrade-advisor"]:
    assert owner in owners, owner

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not make gbrain canonical",
    "does not write canonical records",
    "does not bulk-import",
    "does not mutate downstream target repos",
]:
    assert phrase in claims, phrase
for forbidden in ["autopilot", "dream", "jobs worker", "mcp serving"]:
    assert forbidden in claims, forbidden
PY
}

echo "=== GBrain Repo-Local Instruction Distribution Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves advisory distribution semantics" assert_contract_semantics
check "template preserves advisory distribution receipt semantics" assert_template_semantics
check "README points to contract" grep -Fq "gbrain-repo-local-instruction-distribution-contract.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/gbrain-repo-local-instruction-distribution-contract.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-gbrain-repo-local-instruction-distribution-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
