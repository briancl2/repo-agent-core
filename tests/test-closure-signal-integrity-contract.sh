#!/usr/bin/env bash
# Verify the closure-signal integrity contract stays bounded and evidence-backed.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/closure-signal-integrity-contract.md"
TEMPLATE="$REPO_ROOT/templates/closure-signal-integrity.md"

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

for section in [
    "## purpose",
    "## receipt/distribution shape",
    "## validation rules",
    "## bounded non-claims",
    "## owner routing",
    "## copy-sync boundary",
]:
    assert section in lower, section

for field in [
    "artifact",
    "schema_version",
    "source_issue_or_pr",
    "candidate_id",
    "candidate_disposition",
    "companion_signal_ids",
    "evidence_runs",
    "closure_dependency_surface",
    "external_closure_coupling",
    "work_close_result",
    "post_audit_signal",
    "scorer_signal",
    "unknown_metric_behavior",
    "divergence_summary",
    "distinct_repo_count",
    "graduation_disposition",
    "validation_scope",
    "owner_routing",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "as-54",
    "work-close",
    "post-audit",
    "scorer",
    "d1/d2",
    "d3 was clean",
    "keep-candidate",
    "as-56",
    "external closure coupling",
    "sibling repo local paths",
    "unknown metrics",
    "distinct_repo_count` counts repositories, not repeated runs",
    "transcript_processor-only one-repo evidence",
    "github issue/pr/check/merge truth remains task truth",
    "copy-sync",
]:
    assert phrase in lower, phrase

for forbidden in [
    "may create a controller",
    "starts a scheduler",
    "runs a queue",
    "runs a daemon",
    "automatically creates issues",
    "canonical closure truth is authoritative",
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

assert payload["artifact"] == "CLOSURE_SIGNAL_INTEGRITY_RECEIPT"
assert payload["schema_version"] == 1
assert payload["source_issue_or_pr"].endswith("/99")
assert payload["candidate_id"] == "AS-54"
assert payload["candidate_disposition"] == "keep_candidate"
assert payload["companion_signal_ids"] == ["AS-56 when external closure coupling is present"]
assert payload["distinct_repo_count"] == 1
assert payload["graduation_disposition"] == "not_graduated_transcript_processor_only_evidence"
deps = payload["closure_dependency_surface"]
assert deps["default_closure_entrypoint"] == "scripts/work-close.sh"
assert deps["external_repo_path_references"] == ["$HOME/repos/repo-auditor/scripts/repo-auditor.sh"]
assert "unknown post-audit metrics are not clean-result proof" in deps["absence_behavior"]
coupling = payload["external_closure_coupling"]
assert coupling["detector_id"] == "AS-56"
assert "sibling_repo_paths" in coupling["status"]
unknown = payload["unknown_metric_behavior"]
assert "PRE=?" in unknown["post_audit_delta"]
runs = payload["evidence_runs"]
assert len(runs) == 3
assert {run["run_id"] for run in runs} == {
    "transcript_processor-D1",
    "transcript_processor-D2",
    "transcript_processor-D3",
}
assert runs[0]["work_close_exit_code"] == 0
assert payload["work_close_result"]["exit_code"] == 0
assert payload["post_audit_signal"]["degraded_runs"] == ["transcript_processor-D1", "transcript_processor-D2"]
assert payload["scorer_signal"]["clean_runs"] == ["transcript_processor-D3"]
assert "keep-candidate" in payload["divergence_summary"]
assert "GitHub-visible blocker" in payload["owner_routing"]["fallback"]
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not graduate as-54",
    "does not treat as-56 external closure coupling as as-54 graduation evidence",
    "does not replace github issue/pr/check/merge truth",
    "does not require default closure to reach into sibling repo local paths",
    "does not mutate downstream repositories",
    "does not create a controller",
    "does not make local scorecards",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Closure Signal Integrity Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves closure signal semantics" assert_contract_semantics
check "template preserves receipt shape" assert_template_semantics
check "README points to contract" grep -Fq "closure-signal-integrity-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "closure-signal-integrity.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/closure-signal-integrity-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/closure-signal-integrity.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-closure-signal-integrity-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
