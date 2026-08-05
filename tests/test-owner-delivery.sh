#!/usr/bin/env bash
# Deterministic route, admission, settlement, and epoch fixtures.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_PATH=".agents/skills/owner-delivery/SKILL.md"
FIXTURE_PATH="tests/fixtures/owner-delivery-cases.tsv"

PASS=0
FAIL=0

pass() {
  PASS=$((PASS + 1))
  echo "  PASS: $1"
}

fail() {
  FAIL=$((FAIL + 1))
  echo "  FAIL: $1"
}

skill_has() {
  git -C "$ROOT" show ":$SKILL_PATH" | grep -Fq -- "$1"
}

for required in \
  'A held route blocks only work causally dependent on that route or effect.' \
  'ask exactly one question naming the decision and its tradeoff.' \
  'Transport success, green tests, a schema, plan, trace, reaction,' \
  'A complete native report remains admitted when a separate packaging or timing' \
  '| Read-only or no mutation |' \
  '| Ordinary reversible owner mutation |' \
  '| Consequential, private, destructive, or external mutation |' \
  'One task carries one owner outcome epoch.' \
  'do not create heartbeat comments' \
  'select its largest ready result inside current authority.'
do
  if skill_has "$required"; then
    pass "skill carries: $required"
  else
    fail "skill carries: $required"
  fi
done

header='case_id	stage	route_state	dependency	safe_alternate	effect	native_object	answers_need	packaging_slo	second_epoch	expected'
actual_header="$(git -C "$ROOT" show ":$FIXTURE_PATH" | sed -n '1p')"
if [ "$actual_header" = "$(printf '%b' "$header")" ]; then
  pass "fixture header is exact"
else
  fail "fixture header is exact"
fi

while IFS=$'\t' read -r case_id stage route_state dependency safe_alternate \
  effect native_object answers_need packaging_slo second_epoch expected
do
  [ "$case_id" = "case_id" ] && continue
  decision=""
  case "$stage" in
    route)
      if [ "$route_state" != "held" ] \
        || [ "$dependency" = "disjoint" ] \
        || [ "$safe_alternate" = "yes" ]; then
        decision="continue-outcome"
      else
        decision="ask-one-consequential-question"
      fi
      ;;
    admission)
      if [ "$native_object" = "complete" ] && [ "$answers_need" = "yes" ]; then
        decision="admit-native-object"
      else
        decision="reject-no-outcome"
      fi
      ;;
    settlement)
      case "$effect" in
        none) decision="native-terminal" ;;
        ordinary) decision="focused-owner-gates" ;;
        consequential) decision="full-authority-gates" ;;
        *) decision="invalid-effect" ;;
      esac
      ;;
    epoch)
      if [ "$second_epoch" = "yes" ]; then
        decision="return-before-next-epoch"
      else
        decision="continue-outcome"
      fi
      ;;
    *) decision="invalid-stage" ;;
  esac

  if [ "$decision" = "$expected" ]; then
    pass "$case_id -> $expected"
  else
    fail "$case_id expected $expected, got $decision"
  fi
done < <(git -C "$ROOT" show ":$FIXTURE_PATH")

echo ""
echo "=== test-owner-delivery.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
