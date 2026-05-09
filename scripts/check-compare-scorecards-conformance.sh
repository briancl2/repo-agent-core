#!/usr/bin/env bash
# check-compare-scorecards-conformance.sh — detect consumer drift from core.
set -euo pipefail

CORE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CORE_SCRIPT="$CORE_DIR/scripts/compare-scorecards.sh"
TEST_ROOT="$CORE_DIR/work/compare-scorecards-conformance-$$"
FAIL=0
trap 'rm -rf "$TEST_ROOT"' EXIT
mkdir -p "$TEST_ROOT"
write_scorecard() {
  local path="$1" composite="$2" d1="$3" d2="$4" d3="$5" d4="$6" d5="$7" t1_pass="$8" t1_fail="$9" phase="${10}"
  {
    printf '{\n'
    printf '  "composite": %s,\n' "$composite"
    printf '  "dimensions": {\n'
    printf '    "D1_governance": {"score": %s},\n' "$d1"
    printf '    "D2_surface_health": {"score": %s},\n' "$d2"
    printf '    "D3_skill_maturity": {"score": %s},\n' "$d3"
    printf '    "D4_measurement": {"score": %s},\n' "$d4"
    printf '    "D5_self_improvement": {"score": %s}\n' "$d5"
    printf '  },\n'
    printf '  "tier1_checks": {"passed": %s, "failed": %s},\n' "$t1_pass" "$t1_fail"
    printf '  "meta": {"phase": "%s"}\n' "$phase"
    printf '}\n'
  } > "$path"
}
BEFORE="$TEST_ROOT/before.json"
STABLE_AFTER="$TEST_ROOT/stable-after.json"
PASS_AFTER="$TEST_ROOT/pass-after.json"
REGRESSION_AFTER="$TEST_ROOT/regression-after.json"
MISSING="$TEST_ROOT/missing.json"
write_scorecard "$BEFORE" 40 8 9 7 8 8 4 1 "phase-alpha"
write_scorecard "$STABLE_AFTER" 40 8 9 7 8 8 4 1 "phase-alpha"
write_scorecard "$PASS_AFTER" 45 9 9 8 9 10 5 0 "phase-beta"
write_scorecard "$REGRESSION_AFTER" 37 7 8 7 7 8 3 2 "phase-regression"

if [ "$#" -eq 0 ]; then
  set --
  for candidate in "$CORE_DIR/../repo-auditor" "$CORE_DIR/../repo-optimizer"; do
    [ -f "$candidate/scripts/compare-scorecards.sh" ] && set -- "$@" "$candidate"
  done
fi

if [ "$#" -eq 0 ]; then
  echo "ERROR: provide consumer repo roots or place repo-auditor/repo-optimizer next to repo-agent-core" >&2
  exit 2
fi

CORE_HASH="$(shasum -a 256 "$CORE_SCRIPT" | awk '{print $1}')"

run_case() {
  local name="$1"
  local before="$2"
  local after="$3"
  local core_out="$TEST_ROOT/core-$name.out"
  local core_err="$TEST_ROOT/core-$name.err"
  local consumer_out="$TEST_ROOT/consumer-$name.out"
  local consumer_err="$TEST_ROOT/consumer-$name.err"
  local core_rc consumer_rc case_fail=0
  set +e
  bash "$CORE_SCRIPT" "$before" "$after" > "$core_out" 2> "$core_err"
  core_rc=$?
  bash "$CONSUMER_SCRIPT" "$before" "$after" > "$consumer_out" 2> "$consumer_err"
  consumer_rc=$?
  set -e
  if [ "$core_rc" -ne "$consumer_rc" ]; then
    echo "  ✗ $name exit drift: core=$core_rc consumer=$consumer_rc"
    FAIL=$((FAIL + 1))
    case_fail=$((case_fail + 1))
  fi
  if ! cmp -s "$core_out" "$consumer_out"; then
    echo "  ✗ $name stdout drift"
    FAIL=$((FAIL + 1))
    case_fail=$((case_fail + 1))
  fi
  if ! cmp -s "$core_err" "$consumer_err"; then
    echo "  ✗ $name stderr drift"
    FAIL=$((FAIL + 1))
    case_fail=$((case_fail + 1))
  fi
  if [ "$case_fail" -eq 0 ]; then
    echo "  ✓ $name behavior match"
  fi
}

for consumer in "$@"; do
  CONSUMER_SCRIPT="$consumer/scripts/compare-scorecards.sh"
  echo "=== $(basename "$consumer") ==="
  if [ ! -f "$CONSUMER_SCRIPT" ]; then
    echo "  ✗ missing scripts/compare-scorecards.sh"
    FAIL=$((FAIL + 1))
    continue
  fi
  CONSUMER_HASH="$(shasum -a 256 "$CONSUMER_SCRIPT" | awk '{print $1}')"
  echo "  core_sha256:     $CORE_HASH"
  echo "  consumer_sha256: $CONSUMER_HASH"
  if [ "$CORE_HASH" != "$CONSUMER_HASH" ]; then
    echo "  ✗ hash drift"
    FAIL=$((FAIL + 1))
  else
    echo "  ✓ hash match"
  fi
  run_case stable "$BEFORE" "$STABLE_AFTER"
  run_case pass "$BEFORE" "$PASS_AFTER"
  run_case regression "$BEFORE" "$REGRESSION_AFTER"
  run_case missing-before "$MISSING" "$PASS_AFTER"
done

echo ""
if [ "$FAIL" -gt 0 ]; then
  echo "VERDICT: FAIL ($FAIL drift finding(s))"
  exit 1
fi
echo "VERDICT: PASS"
