#!/usr/bin/env bash
# Focused cached-index, base-delta, and exact-consumer tests.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/repo-agent-core-owner-convergence.XXXXXX")"
trap 'rm -rf "$TMP_ROOT"' EXIT

REPO="$TMP_ROOT/repo"
INSTALLED="$TMP_ROOT/installed"
mkdir -p "$REPO/docs" "$REPO/compat" "$REPO/schemas"
mkdir -p "$INSTALLED/private-name/skills/example"
mkdir -p "$INSTALLED/private-name/agents" "$INSTALLED/private-name/prompts"

git -C "$REPO" init -q
git -C "$REPO" config user.email "owner-convergence@example.invalid"
git -C "$REPO" config user.name "Owner Convergence Test"

printf '%s\n' '# Constitution' 'Exact fixture bytes.' > "$REPO/CONSTITUTION.md"
printf '%s\n' \
  '# Bootloader' \
  'Package owner route.' \
  'Active owner route.' \
  'docs/live-capability-inventory.md' \
  'schemas/*.schema.json' \
  > "$REPO/AGENTS.md"
printf '%s\n' '# Package' 'AGENTS.md' > "$REPO/README.md"
printf '%s\n' 'ACTIVE_TOKEN' > "$REPO/active.txt"
printf '%s\n' 'compatibility bytes' > "$REPO/compat/keep.md"
printf '%s\n' '{"type":"object"}' > "$REPO/schemas/FIXTURE.schema.json"
printf '%s\n' 'rollback source a' > "$REPO/removed-a.txt"
printf '%s\n' 'rollback source b' > "$REPO/removed-b.txt"
printf '%s\n' 'retained base path' > "$REPO/unclassified.txt"
printf '%s\n' '# Historical inventory' > "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add .
git -C "$REPO" commit -qm "base"

BASE="$(git -C "$REPO" rev-parse HEAD)"
rm "$REPO/removed-a.txt" "$REPO/removed-b.txt"
printf '%s\n' \
  '# Owner package inventory' \
  '' \
  '## Active exports' \
  '' \
  '| Path | Class | Owner evidence | Auditor evidence | Advisor evidence | Optimizer evidence |' \
  '|---|---|---|---|---|---|' \
  '| `CONSTITUTION.md` | floor | `AGENTS.md::Package owner route.` | - | - | - |' \
  '| `AGENTS.md` | bootloader | `README.md::AGENTS.md` | - | - | - |' \
  '| `README.md` | entrypoint | `AGENTS.md::Package owner route.` | - | - | - |' \
  '| `docs/live-capability-inventory.md` | owner-manifest | `AGENTS.md::docs/live-capability-inventory.md` | - | - | - |' \
  '| `active.txt` | fixture export | `AGENTS.md::Active owner route.` | `evidence.txt::ACTIVE_TOKEN` | `evidence.txt::ACTIVE_TOKEN` | `evidence.txt::ACTIVE_TOKEN` |' \
  '| `schemas/FIXTURE.schema.json` | schema export | `AGENTS.md::schemas/*.schema.json` | - | - | - |' \
  '' \
  '## Compatibility-only retained paths' \
  '' \
  '| Pattern | Classification |' \
  '|---|---|' \
  '| `compat/*.md` | retained contract |' \
  '| `schemas/*.schema.json` | unchanged schema |' \
  '' \
  '## Removed-name successor rules' \
  '' \
  '| Removed pattern | Successor |' \
  '|---|---|' \
  '| `removed-*.txt` | `active.txt` |' \
  > "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add -A
cp "$REPO/docs/live-capability-inventory.md" "$TMP_ROOT/good-inventory.md"

printf '%s\n' 'name: private-name' > "$INSTALLED/private-name/skills/example/SKILL.md"
printf '%s\n' 'private agent' > "$INSTALLED/private-name/agents/private-name.agent.md"
printf '%s\n' 'private prompt' > "$INSTALLED/private-name/prompts/private-name.prompt.md"
printf '%s\n' 'private instructions' > "$INSTALLED/private-name/AGENTS.md"

make_consumer() {
  local label="$1"
  local consumer="$TMP_ROOT/$label"
  mkdir -p "$consumer"
  git -C "$consumer" init -q
  git -C "$consumer" config user.email "owner-convergence@example.invalid"
  git -C "$consumer" config user.name "Owner Convergence Test"
  printf '%s\n' 'ACTIVE_TOKEN' > "$consumer/evidence.txt"
  if [ "$label" = "auditor" ]; then
    local newline_path
    newline_path="$consumer/"$'line\nbreak.txt'
    printf '%s\n' 'removed-a.txt' > "$newline_path"
  fi
  git -C "$consumer" add .
  git -C "$consumer" commit -qm "consumer fixture"
}

make_consumer auditor
make_consumer advisor
make_consumer optimizer
AUDITOR_REF="$(git -C "$TMP_ROOT/auditor" rev-parse HEAD)"
ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
OPTIMIZER_REF="$(git -C "$TMP_ROOT/optimizer" rev-parse HEAD)"

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

expect_pass() {
  local label="$1"
  shift
  if "$@" > "$TMP_ROOT/stdout" 2> "$TMP_ROOT/stderr"; then
    pass "$label"
  else
    fail "$label"
    sed -n '1,20p' "$TMP_ROOT/stderr"
  fi
}

expect_fail() {
  local label="$1"
  shift
  if "$@" > "$TMP_ROOT/stdout" 2> "$TMP_ROOT/stderr"; then
    fail "$label"
  else
    pass "$label"
  fi
}

VALIDATE=(
  python3 "$ROOT/scripts/validate_owner_convergence.py"
  --repo "$REPO"
  --base-ref "$BASE"
  --installed-root "$INSTALLED"
  --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF"
  --consumer "advisor=$TMP_ROOT/advisor@$ADVISOR_REF"
  --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
)

expect_pass "cached index, rollback delta, schema identity, and three consumers pass" "${VALIDATE[@]}"
cp "$TMP_ROOT/stdout" "$TMP_ROOT/positive.json"
for expected in \
  '"consumer_count": 3' \
  '"caller_checks": 3' \
  '"deleted_paths": 2' \
  '"orphan_active_exports": 0' \
  '"removed_reference_files": 1' \
  '"unchanged_schema_blobs": 1'
do
  if grep -Fq "$expected" "$TMP_ROOT/positive.json"; then
    pass "positive receipt contains $expected"
  else
    fail "positive receipt contains $expected"
  fi
done
echo "  synthetic receipt: $(cat "$TMP_ROOT/positive.json")"

if grep -Fq "private-name" "$TMP_ROOT/positive.json" "$TMP_ROOT/stderr"; then
  fail "installed discovery exposes no private names"
else
  pass "installed discovery exposes no private names"
fi

printf '%s\n' '# Bootloader' 'Issue #164 is active.' > "$REPO/AGENTS.md"
expect_pass "unstaged bad prose cannot override the clean cached index" "${VALIDATE[@]}"

git -C "$REPO" add AGENTS.md
expect_fail "staged retired authority fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree AGENTS.md

printf '\377\n' > "$REPO/README.md"
git -C "$REPO" add README.md
expect_fail "staged non-UTF-8 active prose fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree README.md

sed 's/evidence.txt::ACTIVE_TOKEN/evidence.txt::MISSING_TOKEN/' \
  "$TMP_ROOT/good-inventory.md" > "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add docs/live-capability-inventory.md
expect_fail "false per-export consumer caller evidence fails closed" "${VALIDATE[@]}"
cp "$TMP_ROOT/good-inventory.md" "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add docs/live-capability-inventory.md

git -C "$REPO" rm -q active.txt
expect_fail "missing active export fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree active.txt

git -C "$REPO" rm -q compat/keep.md
expect_fail "one deleted retained compatibility contract fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree compat/keep.md

printf '%s\n' '{"type":"string"}' > "$REPO/schemas/FIXTURE.schema.json"
git -C "$REPO" add schemas/FIXTURE.schema.json
expect_fail "changed exported schema bytes fail closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree schemas/FIXTURE.schema.json

git -C "$REPO" restore --source="$BASE" --staged --worktree removed-a.txt
expect_fail "partially retained removed-name family fails closed" "${VALIDATE[@]}"
git -C "$REPO" rm -q removed-a.txt

git -C "$REPO" rm -q unclassified.txt
expect_fail "undeclared base-to-index deletion fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree unclassified.txt

echo ""
echo "=== test-owner-convergence.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
