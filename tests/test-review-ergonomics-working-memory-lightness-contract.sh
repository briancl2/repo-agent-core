#!/usr/bin/env bash
# Verify the review ergonomics / working-memory lightness contract stays bounded.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/review-ergonomics-working-memory-lightness-contract.md"
TEMPLATE="$REPO_ROOT/templates/review-ergonomics-working-memory-lightness.md"

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
    "evidence_runs",
    "review_timeout_override_evidence",
    "working_memory_surface",
    "lightness_remedy",
    "distinct_repo_count",
    "graduation_disposition",
    "validation_scope",
    "owner_routing",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "as-55",
    "review timeout override",
    "current_state.md",
    "working-memory",
    "add lightness",
    "delete, compact, demote, split",
    "d1/d2/d3",
    "do not graduate the detector",
    "keep_candidate",
    "one-repo transcript_processor evidence",
    "copy-sync",
]:
    assert phrase in lower, phrase

for forbidden in [
    "may create a controller",
    "starts a scheduler",
    "runs a queue",
    "runs a daemon",
    "review bot assigns",
    "canonical memory is authoritative",
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

assert payload["artifact"] == "REVIEW_ERGONOMICS_WORKING_MEMORY_LIGHTNESS_RECEIPT"
assert payload["schema_version"] == 1
assert payload["source_issue_or_pr"].endswith("/99")
assert payload["candidate_id"] == "AS-55"
assert payload["candidate_disposition"] == "keep_candidate"
assert payload["distinct_repo_count"] == 1
assert payload["graduation_disposition"] == "not_graduated_transcript_processor_only_evidence"
runs = payload["evidence_runs"]
assert len(runs) == 3
assert all(run["review_timeout_override"] is True for run in runs)
assert all(run["working_memory_surface"] == "CURRENT_STATE.md" for run in runs)
assert payload["review_timeout_override_evidence"]["status"] == "present_in_all_runs"
surface = payload["working_memory_surface"]
assert surface["path"] == "CURRENT_STATE.md"
assert surface["status"] == "oversized_review_state"
remedy = payload["lightness_remedy"]
assert "delete stale state" in remedy["preferred_actions"]
assert "compact active state" in remedy["preferred_actions"]
assert "controller" in remedy["forbidden_remedy"]
assert "GitHub-visible blocker" in payload["owner_routing"]["fallback"]
claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not graduate as-55",
    "does not prescribe a global size cap",
    "does not make current_state.md",
    "does not mutate downstream repositories",
    "does not create a review bot",
    "does not replace github issue/pr/check/merge truth",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Review Ergonomics Working-Memory Lightness Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves lightness semantics" assert_contract_semantics
check "template preserves receipt shape" assert_template_semantics
check "README points to contract" grep -Fq "review-ergonomics-working-memory-lightness-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "review-ergonomics-working-memory-lightness.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/review-ergonomics-working-memory-lightness-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/review-ergonomics-working-memory-lightness.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-review-ergonomics-working-memory-lightness-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
