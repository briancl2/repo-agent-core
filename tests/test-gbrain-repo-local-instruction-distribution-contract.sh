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
    "consuming_repo",
    "instruction_surfaces",
    "gbrain_records_used",
    "source_refs_checked",
    "advisory_status",
    "canonical_override_allowed",
    "background_gbrain_behavior_used",
    "repo_native_validation",
    "native_evidence_before_verdict",
    "owner_routing",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "gbrain remains advisory",
    "copy-sync or citation only",
    "repo-local instruction surfaces",
    "source, citation, provenance, or github surface references",
    "must be `false`",
    "validates through the consuming repo's native checks",
    "docs readback is necessary but not sufficient",
    "documented native attempt or concrete owner-surface blocker",
    "native-evidence-before-verdict-contract.md",
    "operator intent",
    "github issue/pr/check/merge truth",
    "repo-agent-core",
    "repo-auditor",
    "repo-upgrade-advisor",
    "repo-optimizer",
]:
    assert phrase in lower, phrase

for forbidden in [
    "promotes gbrain as canonical",
    "treats gbrain as source of truth",
    "allows gbrain to override local instructions",
    "background gbrain behavior is allowed",
    "bulk import is allowed",
    "starts a daemon",
    "starts a scheduler",
    "mcp server keeps copies aligned",
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
assert payload["canonical_override_allowed"] is False
assert payload["background_gbrain_behavior_used"] is False
assert payload["instruction_surfaces"]
assert payload["gbrain_records_used"]
assert payload["source_refs_checked"][0]["citation_ok"] is True
assert payload["repo_native_validation"]
assert payload["native_evidence_before_verdict"]["contract_ref"].endswith("native-evidence-before-verdict-contract.md")
assert payload["native_evidence_before_verdict"]["advisory_gbrain_slug"] == "bma/issue164/native-evidence-before-verdict"

owners = {row["owner_surface"] for row in payload["owner_routing"]}
assert "repo-agent-core" in owners

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not make gbrain canonical",
    "does not let gbrain override operator intent",
    "does not bulk-import",
    "does not mutate downstream target repos",
    "does not add a runtime dependency",
    "does not let docs readback",
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
