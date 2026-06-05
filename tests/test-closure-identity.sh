#!/usr/bin/env bash
# Verify local and CI closure-run identity surfaces stay comparable.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SCRIPT="$REPO_ROOT/scripts/record-closure-identity.sh"
WORKFLOW="$REPO_ROOT/.github/workflows/ci.yml"
TMPDIR="$(mktemp -d "${TMPDIR:-/tmp}/repo-agent-core-closure-identity.XXXXXX")"
trap 'rm -rf "$TMPDIR"' EXIT

echo "=== Closure Identity Test ==="

before_status="$(git -C "$REPO_ROOT" status --short)"
default_json="$(
  env -u CLOSURE_RUN_ID \
    -u CLOSURE_PHASE \
    -u CLOSURE_TRIGGER \
    -u EVIDENCE_REUSE_KEY \
    -u PARENT_COMMAND \
    -u GITHUB_RUN_ID \
    -u GITHUB_RUN_ATTEMPT \
    -u CLOSURE_IDENTITY_RECEIPT \
    bash "$SCRIPT" test
)"
after_status="$(git -C "$REPO_ROOT" status --short)"

python3 - "$default_json" <<'PY'
import json
import re
import sys

payload = json.loads(sys.argv[1])
required = {
    "closure_run_id",
    "closure_phase",
    "closure_trigger",
    "evidence_reuse_key",
    "parent_command",
    "github_run_id",
    "github_run_attempt",
}
assert set(payload) == required, payload
assert re.match(r"^local-\d{8}T\d{6}Z-\d+$", payload["closure_run_id"]), payload
assert payload["closure_phase"] == "test", payload
assert payload["closure_trigger"] == "manual", payload
assert payload["evidence_reuse_key"] == "test:make test", payload
assert payload["parent_command"] == "make test", payload
assert payload["github_run_id"] == "local", payload
assert payload["github_run_attempt"] == "0", payload
PY

if [ "$before_status" != "$after_status" ]; then
  echo "  FAIL: closure identity emission dirtied the repo"
  exit 1
fi
echo "  PASS: local defaults emit required fields without dirtying repo"

receipt="$TMPDIR/identity/receipt.json"
CLOSURE_RUN_ID="12345-2" \
CLOSURE_PHASE="ci-test" \
CLOSURE_TRIGGER="pull_request" \
EVIDENCE_REUSE_KEY="ci-test:make test" \
PARENT_COMMAND="make test" \
GITHUB_RUN_ID="12345" \
GITHUB_RUN_ATTEMPT="2" \
CLOSURE_IDENTITY_RECEIPT="$receipt" \
  bash "$SCRIPT" ci-test >/dev/null

python3 - "$receipt" <<'PY'
import json
import sys

payload = json.load(open(sys.argv[1], encoding="utf-8"))
assert payload["closure_run_id"] == "12345-2", payload
assert payload["closure_phase"] == "ci-test", payload
assert payload["closure_trigger"] == "pull_request", payload
assert payload["evidence_reuse_key"] == "ci-test:make test", payload
assert payload["parent_command"] == "make test", payload
assert payload["github_run_id"] == "12345", payload
assert payload["github_run_attempt"] == "2", payload
PY
echo "  PASS: explicit receipt path writes JSON with CI identity fields"

grep -Fq 'CLOSURE_RUN_ID: ${{ github.run_id }}-${{ github.run_attempt }}' "$WORKFLOW"
grep -Fq 'GITHUB_RUN_ID: ${{ github.run_id }}' "$WORKFLOW"
grep -Fq 'GITHUB_RUN_ATTEMPT: ${{ github.run_attempt }}' "$WORKFLOW"
grep -Fq 'PARENT_COMMAND: make test' "$WORKFLOW"
echo "  PASS: GitHub Actions wiring exposes run id and attempt"
