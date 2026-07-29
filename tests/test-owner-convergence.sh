#!/usr/bin/env bash
# Focused cached-index and fail-closed tests for owner convergence.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/repo-agent-core-owner-convergence.XXXXXX")"
trap 'rm -rf "$TMP_ROOT"' EXIT

REPO="$TMP_ROOT/repo"
INSTALLED="$TMP_ROOT/installed"
mkdir -p "$REPO/docs" "$INSTALLED/private-name/skills/example"
mkdir -p "$INSTALLED/private-name/agents" "$INSTALLED/private-name/prompts"

git -C "$REPO" init -q
git -C "$REPO" config user.email "owner-convergence@example.invalid"
git -C "$REPO" config user.name "Owner Convergence Test"

printf '%s\n' '# Constitution' 'Exact fixture bytes.' > "$REPO/CONSTITUTION.md"
printf '%s\n' '# Bootloader' 'Active owner route.' > "$REPO/AGENTS.md"
printf '%s\n' '# Package' 'Active package.' > "$REPO/README.md"
printf '%s\n' 'active export' > "$REPO/active.txt"
printf '%s\n' 'rollback source' > "$REPO/removed.txt"
printf '%s\n' '# Historical inventory' > "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add .
git -C "$REPO" commit -qm "base"

BASE="$(git -C "$REPO" rev-parse HEAD)"
rm "$REPO/removed.txt"
printf '%s\n' \
  '# Owner package inventory' \
  '' \
  '## Active exports' \
  '' \
  '| Path | Class | Callers |' \
  '|---|---|---|' \
  '| `CONSTITUTION.md` | shared semantic floor | owner |' \
  '| `AGENTS.md` | compact bootloader | owner |' \
  '| `README.md` | package entrypoint | owner |' \
  '| `docs/live-capability-inventory.md` | owner-manifest | owner |' \
  '| `active.txt` | fixture export | owner |' \
  '' \
  '## Removed-name successors' \
  '' \
  '| Removed path | Successor |' \
  '|---|---|' \
  '| `removed.txt` | `active.txt` |' \
  > "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add -A

printf '%s\n' 'name: private-name' > "$INSTALLED/private-name/skills/example/SKILL.md"
printf '%s\n' 'private agent' > "$INSTALLED/private-name/agents/private-name.agent.md"
printf '%s\n' 'private prompt' > "$INSTALLED/private-name/prompts/private-name.prompt.md"
printf '%s\n' 'private instructions' > "$INSTALLED/private-name/AGENTS.md"

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

VALIDATE=(python3 "$ROOT/scripts/validate_owner_convergence.py" --repo "$REPO" --base-ref "$BASE" --installed-root "$INSTALLED")

expect_pass "valid cached index, rollback, and count-only discovery pass" "${VALIDATE[@]}"
if grep -Fq "private-name" "$TMP_ROOT/stdout" "$TMP_ROOT/stderr"; then
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

sed 's/`removed\.txt` | `active\.txt`/`removed.txt` | `missing.txt`/' \
  "$REPO/docs/live-capability-inventory.md" > "$TMP_ROOT/inventory-missing-successor.md"
mv "$TMP_ROOT/inventory-missing-successor.md" "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add docs/live-capability-inventory.md
expect_fail "missing removed-name successor fails closed" "${VALIDATE[@]}"

echo ""
echo "=== test-owner-convergence.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
