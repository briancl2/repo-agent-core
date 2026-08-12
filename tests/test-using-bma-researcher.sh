#!/usr/bin/env bash
# Deterministic portable skill and install/drift behavior tests.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_PATH=".agents/skills/using-bma-researcher/SKILL.md"
INSTALLER="$ROOT/scripts/install-bma-researcher-skill.py"
SOURCE="$ROOT/.agents/skills/using-bma-researcher"
TEST_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEST_ROOT"' EXIT

if ! git -C "$ROOT" diff --quiet -- \
  .agents/skills/using-bma-researcher \
  scripts/install-bma-researcher-skill.py \
  tests/test-using-bma-researcher.sh; then
  echo "ERROR: relevant working-tree bytes differ from the tested Git index" >&2
  exit 1
fi
if [ -n "$(git -C "$ROOT" ls-files --others --exclude-standard -- \
  .agents/skills/using-bma-researcher \
  scripts/install-bma-researcher-skill.py \
  tests/test-using-bma-researcher.sh)" ]; then
  echo "ERROR: untracked bytes exist under a tested package path" >&2
  exit 1
fi

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
  'The exact ordinary question is the only relevance input.' \
  '`agent_detected_need` before retrieving context or choosing a route.' \
  '`answer_question`' \
  '`analyze_decision`' \
  '`compare_options`' \
  '`investigate_claim`' \
  '`monitor_change`' \
  '`synthesize_dossier`' \
  'at most one consequential clarification, zero retry,' \
  'no provider, account, or model switch.' \
  'Packaging stops at `PACKAGED`.' \
  'return `NO_ACTION`' \
  'Resume a yielded tool call by' \
  'report, product, and custody states are' \
  'Skill discovery and route preflight do not prove'
do
  if skill_has "$required"; then
    pass "skill carries: $required"
  else
    fail "skill carries: $required"
  fi
done

if python3 "$INSTALLER" install \
  --source "$SOURCE" \
  --target-root "$TEST_ROOT/skills" >"$TEST_ROOT/install.json"; then
  pass "fresh install succeeds"
else
  fail "fresh install succeeds"
fi

if python3 "$INSTALLER" check \
  --source "$SOURCE" \
  --target-root "$TEST_ROOT/skills" >"$TEST_ROOT/check.json"; then
  pass "exact install passes drift check"
else
  fail "exact install passes drift check"
fi

if python3 "$INSTALLER" install \
  --source "$SOURCE" \
  --target-root "$TEST_ROOT/skills" >"$TEST_ROOT/identical.json"; then
  pass "identical reinstall is a no-op"
else
  fail "identical reinstall is a no-op"
fi

printf '\nlocal drift\n' >>"$TEST_ROOT/skills/using-bma-researcher/SKILL.md"
if python3 "$INSTALLER" check \
  --source "$SOURCE" \
  --target-root "$TEST_ROOT/skills" >"$TEST_ROOT/drift.out" 2>"$TEST_ROOT/drift.err"; then
  fail "drift check fails closed"
else
  pass "drift check fails closed"
fi

if python3 "$INSTALLER" install \
  --source "$SOURCE" \
  --target-root "$TEST_ROOT/skills" >"$TEST_ROOT/block.out" 2>"$TEST_ROOT/block.err"; then
  fail "non-identical install blocks implicit replacement"
else
  pass "non-identical install blocks implicit replacement"
fi

if python3 "$INSTALLER" install \
  --source "$SOURCE" \
  --target-root "$TEST_ROOT/skills" \
  --replace-with-backup \
  --backup-root "$TEST_ROOT/backups" >"$TEST_ROOT/replace.json"; then
  pass "explicit replacement creates a verified backup"
else
  fail "explicit replacement creates a verified backup"
fi

if python3 "$INSTALLER" check \
  --source "$SOURCE" \
  --target-root "$TEST_ROOT/skills" >"$TEST_ROOT/recheck.json" \
  && [ "$(find "$TEST_ROOT/backups" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')" = "1" ] \
  && grep -RqF 'local drift' "$TEST_ROOT/backups"; then
  pass "replacement target is exact and one backup remains"
else
  fail "replacement target is exact and one backup remains"
fi

cp -R "$SOURCE" "$TEST_ROOT/overlap-source"
if python3 "$INSTALLER" install \
  --source "$TEST_ROOT/overlap-source" \
  --target-root "$TEST_ROOT/overlap-source/nested" \
  >"$TEST_ROOT/overlap.out" 2>"$TEST_ROOT/overlap.err"; then
  fail "source/target overlap fails before copying"
else
  pass "source/target overlap fails before copying"
fi

printf '\nsecond drift\n' >>"$TEST_ROOT/skills/using-bma-researcher/SKILL.md"
if python3 "$INSTALLER" install \
  --source "$SOURCE" \
  --target-root "$TEST_ROOT/skills" \
  --replace-with-backup \
  --backup-root "$TEST_ROOT/skills/using-bma-researcher/backups" \
  >"$TEST_ROOT/backup-overlap.out" 2>"$TEST_ROOT/backup-overlap.err"; then
  fail "backup/target overlap fails before copying"
else
  pass "backup/target overlap fails before copying"
fi

ln -s "$TEST_ROOT/missing-target-root" "$TEST_ROOT/broken-target-root"
if python3 "$INSTALLER" install \
  --source "$SOURCE" \
  --target-root "$TEST_ROOT/broken-target-root" \
  >"$TEST_ROOT/broken-root.out" 2>"$TEST_ROOT/broken-root.err"; then
  fail "broken target-root symlink fails closed"
else
  pass "broken target-root symlink fails closed"
fi

echo ""
echo "=== test-using-bma-researcher.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
