#!/usr/bin/env bash
# Verify the repo-health retrospective method contract stays bounded, evidence-first, and falsifiable.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTRACT="$REPO_ROOT/docs/repo-health-retrospective-method-contract.md"
TEMPLATE="$REPO_ROOT/templates/repo-health-retrospective-method.md"

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
    "repo_identity",
    "operator_intent",
    "thesis",
    "evidence_hierarchy",
    "operating_surfaces",
    "candidate_register",
    "add_lightness_ranking",
    "outcome_proxy_rerank",
    "thesis_verdict",
    "cut_simplify_add_tally",
    "owner_surface",
    "bounded_non_claims",
]:
    assert field in text, field

for phrase in [
    "repo_health_retrospective_method",
    "five operating surfaces",
    "three passes",
    "known anti-pattern",
    "emerging",
    "detection",
    "add-lightness",
    "falsifiable thesis",
    "independent outcome-proxy re-rank",
    "friction frequency",
    "refute",
    "primary-evidence-first",
    "canonical repo/github truth",
    "secondary evidence alone",
    "candidate-detector register",
    "handed back unbuilt",
    "ties broken toward deletion",
    "cut/simplify",
    "copy-sync/citation guidance",
    "repo-auditor",
    "repo-upgrade-advisor",
    "repo-optimizer",
    "#1270",
]:
    assert phrase in lower, phrase

# register verdict vocabulary
for verdict in ["`cut`", "`simplify`", "`add`", "`bounded-helper`", "`do-not-build`", "`conditional`"]:
    assert verdict in lower, verdict

for forbidden in [
    "starts a controller",
    "starts a scheduler",
    "auto-creates issues",
    "may mutate downstream",
    "ranking is a measured return",
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

VERDICTS = {"CUT", "SIMPLIFY", "ADD", "BOUNDED-HELPER", "DO-NOT-BUILD", "CONDITIONAL"}

assert payload["artifact"] == "REPO_HEALTH_RETROSPECTIVE_METHOD"
assert payload["schema_version"] == 1
for field in [
    "repo_identity",
    "operator_intent",
    "thesis",
    "evidence_hierarchy",
    "operating_surfaces",
    "candidate_register",
    "add_lightness_ranking",
    "outcome_proxy_rerank",
    "thesis_verdict",
    "cut_simplify_add_tally",
    "owner_surface",
    "bounded_non_claims",
]:
    assert payload.get(field), field

# 5 operating surfaces x 3 passes
assert len(payload["operating_surfaces"]) >= 5, "operating_surfaces >= 5"
for surface in payload["operating_surfaces"]:
    for pass_field in ["pass_a_known", "pass_b_emerging", "pass_c_verdict"]:
        assert surface.get(pass_field), pass_field

# candidate-detector register with valid verdicts
assert len(payload["candidate_register"]) >= 1, "candidate_register >= 1"
for row in payload["candidate_register"]:
    for row_field in ["id", "verdict", "anti_pattern", "evidence", "owner_surface", "acceptance_sketch"]:
        assert row_field in row, row_field
    assert row["verdict"] in VERDICTS, row["verdict"]

# evidence hierarchy: primary vs secondary + no-secondary-alone rule
eh = payload["evidence_hierarchy"]
assert eh.get("primary") and eh.get("secondary"), "primary/secondary evidence"
assert "secondary evidence alone" in eh.get("rule", "").lower(), "no-secondary-alone rule"

# add-lightness ranking is an explicit preference
assert payload["add_lightness_ranking"]["is_preference_not_measurement"] is True

# independent outcome-proxy re-rank can disagree and refute
opr = payload["outcome_proxy_rerank"]
assert opr["disagrees_with_add_lightness_ranking"] is True
assert opr["can_refute_thesis"] is True

# tally covers the full verdict vocabulary
assert set(payload["cut_simplify_add_tally"].keys()) == VERDICTS, "tally keys"

assert payload["thesis_verdict"].get("verdict"), "thesis_verdict verdict"

claims = " ".join(payload["bounded_non_claims"]).lower()
for phrase in [
    "does not turn its add-lightness ranking into a measured return",
    "does not rest any verdict on secondary session-log or runtime evidence alone",
    "does not implement detectors, open new issues, or mutate sibling repos",
    "does not authorize background sync/watch",
    "does not create a controller",
]:
    assert phrase in claims, phrase
PY
}

echo "=== Repo-Health Retrospective Method Contract Test ==="

check "contract exists" test -s "$CONTRACT"
check "template exists" test -s "$TEMPLATE"
check "contract preserves retrospective-method semantics" assert_contract_semantics
check "template preserves retrospective-method record semantics" assert_template_semantics
check "README points to contract" grep -Fq "repo-health-retrospective-method-contract.md" "$REPO_ROOT/README.md"
check "README points to template" grep -Fq "repo-health-retrospective-method.md" "$REPO_ROOT/README.md"
check "AGENTS points to contract" grep -Fq "docs/repo-health-retrospective-method-contract.md" "$REPO_ROOT/AGENTS.md"
check "AGENTS points to template" grep -Fq "templates/repo-health-retrospective-method.md" "$REPO_ROOT/AGENTS.md"

echo ""
echo "=== test-repo-health-retrospective-method-contract.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
