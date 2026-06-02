#!/usr/bin/env bash
# Verify the compact foreground recovery runtime contract and guidance artifact stay bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/foreground-recovery-runtime-contract.md"
GUIDANCE_SCHEMA="$REPO_ROOT/schemas/HERMES_FOREGROUND_FAILURE_GUIDANCE.schema.json"
GUIDANCE_TEMPLATE="$REPO_ROOT/templates/hermes-foreground-failure-guidance.md"
GUIDANCE_SAMPLE="$REPO_ROOT/tests/samples/HERMES_FOREGROUND_FAILURE_GUIDANCE.json"
FAILED_RECEIPT_SAMPLE="$REPO_ROOT/tests/samples/HERMES_FOREGROUND_RUN_RECEIPT_FAILED.json"

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

check_json_semantics() {
    python3 - "$GUIDANCE_SCHEMA" "$GUIDANCE_SAMPLE" "$FAILED_RECEIPT_SAMPLE" <<'PY'
import json
import sys

schema = json.load(open(sys.argv[1], encoding="utf-8"))
sample = json.load(open(sys.argv[2], encoding="utf-8"))
receipt = json.load(open(sys.argv[3], encoding="utf-8"))

try:
    import jsonschema  # type: ignore
except ImportError:
    jsonschema = None

if jsonschema is not None:
    jsonschema.validate(sample, schema)
else:
    for field in schema["required"]:
        assert field in sample, field

assert sample["artifact"] == "HERMES_FOREGROUND_FAILURE_GUIDANCE"
assert sample["schema_version"] == 1
assert sample["command_family"] == "hermes-foreground"
assert sample["evidence_file"] == sample["source_receipt_path"]
assert sample["evidence_file"].endswith("HERMES_FOREGROUND_RUN_RECEIPT_FAILED.json")
assert receipt["artifact"] == "HERMES_FOREGROUND_RUN_RECEIPT"
assert receipt["status"] in {"failed", "timeout", "not_run"}
assert receipt["return_code"] != 0
assert receipt["validation"]["passed"] is False
argv = sample["suggested_failure_to_issue_argv"]
assert argv[:2] == ["python3", "scripts/github-failure-to-issue.py"]
assert "--live" in argv or "--dry-run" in argv
expected = {
    "--campaign-issue-url": sample["campaign_issue_url"],
    "--repo": sample["repo"],
    "--command-family": sample["command_family"],
    "--failure-code": sample["failure_code"],
    "--primary-object": sample["primary_object"],
    "--command": sample["attempted_command"],
    "--status": sample["status"],
    "--evidence-file": sample["evidence_file"],
    "--recommended-owner": sample["recommended_owner"],
    "--impact": sample["impact"],
}
for flag, value in expected.items():
    matches = [i for i, part in enumerate(argv) if part == flag]
    assert len(matches) == 1, flag
    assert argv[matches[0] + 1] == value, flag
joined_claims = " | ".join(sample["bounded_non_claims"]).lower()
for needle in (
    "does not invoke gh",
    "does not retry",
    "does not authorize a daemon",
    "does not mutate target repos",
    "operator must explicitly run",
):
    assert needle in joined_claims, needle
PY
}

assert_no_regrowth_terms() {
    python3 - "$CONTRACT" "$GUIDANCE_TEMPLATE" <<'PY'
import sys

for path in sys.argv[1:]:
    text = open(path, encoding="utf-8").read().lower()
    forbidden_phrases = [
        "introduce a runtime dependency",
        "add a daemon",
        "add a scheduler",
        "add a queue",
        "add a controller",
        "add a retry loop",
        "add an mcp server",
        "automatic github issue creation is allowed",
        "mutate downstream repos",
    ]
    for phrase in forbidden_phrases:
        assert phrase not in text, f"{path}: forbidden regrowth phrase: {phrase}"
PY
}

echo "=== Foreground Recovery Runtime Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "guidance schema exists" test -s "$GUIDANCE_SCHEMA"
check "guidance template exists" test -s "$GUIDANCE_TEMPLATE"
check "guidance sample exists" test -s "$GUIDANCE_SAMPLE"
check "failed receipt sample exists" test -s "$FAILED_RECEIPT_SAMPLE"
check "guidance sample validates against schema" bash "$REPO_ROOT/scripts/validate-artifacts.sh" "$GUIDANCE_SAMPLE" HERMES_FOREGROUND_FAILURE_GUIDANCE
check "failed receipt sample validates against schema" bash "$REPO_ROOT/scripts/validate-artifacts.sh" "$FAILED_RECEIPT_SAMPLE" HERMES_FOREGROUND_RUN_RECEIPT
check "guidance sample preserves BMA helper semantics" check_json_semantics

for composed in \
    "docs/hermes-foreground-launcher-contract.md" \
    "docs/interruption-recovery-and-batch-reconstitution-contract.md" \
    "docs/foreground-learning-and-recovery-contract.md"; do
    check "contract composes $composed" grep -Fq "$composed" "$CONTRACT"
done

for field in \
    "artifact" \
    "schema_version" \
    "campaign_issue_url" \
    "repo" \
    "command_family" \
    "failure_code" \
    "primary_object" \
    "status" \
    "attempted_command" \
    "evidence_file" \
    "recommended_owner" \
    "impact" \
    "source_receipt_path" \
    "suggested_failure_to_issue_argv" \
    "suggested_failure_to_issue_command" \
    "bounded_non_claims"; do
    check "contract includes guidance field $field" grep -Fq "$field" "$CONTRACT"
    check "schema includes guidance field $field" grep -Fq "\"$field\"" "$GUIDANCE_SCHEMA"
    check "template includes guidance field $field" grep -Fq "\"$field\"" "$GUIDANCE_TEMPLATE"
done

for required_text in \
    "HERMES_FOREGROUND_FAILURE_GUIDANCE" \
    "HERMES_FOREGROUND_RUN_RECEIPT" \
    "hermes-foreground" \
    "copy-sync or citation" \
    "does not invoke gh" \
    "does not retry" \
    "does not authorize a daemon" \
    "does not mutate target repos" \
    "operator must explicitly run"; do
    check "contract includes boundary text: $required_text" grep -Fq "$required_text" "$CONTRACT"
    check "template includes boundary text: $required_text" grep -Fq "$required_text" "$GUIDANCE_TEMPLATE"
done

for forbidden in \
    "runtime dependency" \
    "daemon" \
    "scheduler" \
    "queue" \
    "retry loop" \
    "controller" \
    "MCP server" \
    "background sync" \
    "automatic GitHub issue creation" \
    "downstream mutation"; do
    check "contract forbids $forbidden" grep -Fq "$forbidden" "$CONTRACT"
done

check "contract and template avoid positive regrowth language" assert_no_regrowth_terms
check "README points to runtime contract" grep -Fq "foreground-recovery-runtime-contract.md" "$REPO_ROOT/README.md"
check "README points to guidance schema" grep -Fq "HERMES_FOREGROUND_FAILURE_GUIDANCE.schema.json" "$REPO_ROOT/README.md"
check "README points to guidance template" grep -Fq "hermes-foreground-failure-guidance.md" "$REPO_ROOT/README.md"
check "AGENTS points to runtime contract" grep -Fq "docs/foreground-recovery-runtime-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to guidance schema" grep -Fq "schemas/HERMES_FOREGROUND_FAILURE_GUIDANCE.schema.json" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to guidance template" grep -Fq "templates/hermes-foreground-failure-guidance.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-foreground-recovery-runtime-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
