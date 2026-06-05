#!/usr/bin/env bash
# Emit closure-run identity for local gates and GitHub Actions runs.

set -euo pipefail

closure_phase="${CLOSURE_PHASE:-${1:-closure}}"
closure_trigger="${CLOSURE_TRIGGER:-manual}"
utc_now="$(date -u +%Y%m%dT%H%M%SZ)"
closure_run_id="${CLOSURE_RUN_ID:-local-${utc_now}-$$}"
parent_command="${PARENT_COMMAND:-make ${closure_phase}}"
evidence_reuse_key="${EVIDENCE_REUSE_KEY:-${closure_phase}:${parent_command}}"
github_run_id="${GITHUB_RUN_ID:-local}"
github_run_attempt="${GITHUB_RUN_ATTEMPT:-0}"

json="$(
  python3 - "$closure_run_id" "$closure_phase" "$closure_trigger" \
    "$evidence_reuse_key" "$parent_command" "$github_run_id" "$github_run_attempt" <<'PY'
import json
import sys

fields = {
    "closure_run_id": sys.argv[1],
    "closure_phase": sys.argv[2],
    "closure_trigger": sys.argv[3],
    "evidence_reuse_key": sys.argv[4],
    "parent_command": sys.argv[5],
    "github_run_id": sys.argv[6],
    "github_run_attempt": sys.argv[7],
}
print(json.dumps(fields, sort_keys=True))
PY
)"

printf '%s\n' "$json"

if [ -n "${CLOSURE_IDENTITY_RECEIPT:-}" ]; then
  mkdir -p "$(dirname "$CLOSURE_IDENTITY_RECEIPT")"
  printf '%s\n' "$json" > "$CLOSURE_IDENTITY_RECEIPT"
fi
