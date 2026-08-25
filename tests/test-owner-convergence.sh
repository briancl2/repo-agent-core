#!/usr/bin/env bash
# Focused cached-index, base-delta, and exact-consumer tests.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP_ROOT="$(mktemp -d "${TMPDIR:-/tmp}/repo-agent-core-owner-convergence.XXXXXX")"
trap 'rm -rf "$TMP_ROOT"' EXIT

REPO="$TMP_ROOT/repo"
INSTALLED="$TMP_ROOT/installed"
mkdir -p "$REPO/docs" "$REPO/compat" "$REPO/schemas" "$REPO/scripts" "$REPO/tests"
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
  'Floor test route.' \
  'docs/live-capability-inventory.md' \
  'schemas/*.schema.json' \
  > "$REPO/AGENTS.md"
printf '%s\n' '# Package' 'AGENTS.md' > "$REPO/README.md"
printf '%s\n' 'ACTIVE_TOKEN' > "$REPO/active.txt"
printf '%s\n' 'compatibility bytes' > "$REPO/compat/keep.md"
printf '%s\n' 'retired compatibility bytes' > "$REPO/compat/retired.md"
printf '%s\n' '{"type":"object"}' > "$REPO/schemas/FIXTURE.schema.json"
printf '%s\n' 'rollback source a' > "$REPO/removed-a.txt"
printf '%s\n' 'rollback source b' > "$REPO/removed-b.txt"
printf '%s\n' 'retained base path' > "$REPO/unclassified.txt"
printf '%s\n' 'canonical floor validator bytes' > "$REPO/scripts/validate-floor-receipt.sh"
printf '%s\n' 'read-only fleet floor audit bytes' > "$REPO/scripts/fleet-floor-conformance-audit.sh"
printf '%s\n' \
  'scripts/validate-floor-receipt.sh' \
  'scripts/fleet-floor-conformance-audit.sh' \
  > "$REPO/tests/test-floor-receipt-conformance.sh"
printf '%s\n' '# Historical inventory' > "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add .
git -C "$REPO" commit -qm "base"

BASE="$(git -C "$REPO" rev-parse HEAD)"
rm "$REPO/removed-a.txt" "$REPO/removed-b.txt" "$REPO/compat/retired.md"
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
  '| `scripts/validate-floor-receipt.sh` | floor validator | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` | `evidence.txt::FLOOR_TOKEN` | `evidence.txt::FLOOR_TOKEN` | `scripts/validate-owner-convergence.py::scripts/validate-floor-receipt.sh` |' \
  '| `scripts/fleet-floor-conformance-audit.sh` | fleet audit | `tests/test-floor-receipt-conformance.sh::scripts/fleet-floor-conformance-audit.sh` | - | - | - |' \
  '| `tests/test-floor-receipt-conformance.sh` | floor tests | `AGENTS.md::Floor test route.` | - | - | - |' \
  '' \
  '## Compatibility-only retained paths' \
  '' \
  '| Pattern | Classification |' \
  '|---|---|' \
  '| `compat/*.md` | retained contract |' \
  '| `schemas/*.schema.json` | unchanged schema |' \
  '| `unclassified.txt` | classified retained fixture |' \
  '' \
  '## Removed-name successor rules' \
  '' \
  '| Removed pattern | Successor |' \
  '|---|---|' \
  '| `removed-*.txt` | `active.txt` |' \
  '' \
  '## Exact terminal retirements' \
  '' \
  '| Exact path | Disposition |' \
  '|---|---|' \
  '| `compat/retired.md` | `retired-without-successor` |' \
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
  printf '%s\n' 'ACTIVE_TOKEN' 'FLOOR_TOKEN' > "$consumer/evidence.txt"
  if [ "$label" = "optimizer" ]; then
    mkdir -p "$consumer/scripts"
    printf '%s\n' 'scripts/validate-floor-receipt.sh' \
      > "$consumer/scripts/validate-owner-convergence.py"
  fi
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

if grep -Fq '| `scripts/validate-floor-receipt.sh` | canonical portable floor validator | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` | `scripts/validate-owner-convergence.py::scripts/validate-floor-receipt.sh` |' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md); then
  pass "floor validator inventory preserves unrelated evidence and names Optimizer owner validation"
else
  fail "floor validator inventory preserves unrelated evidence and names Optimizer owner validation"
fi

if grep -Fq 'Material progress uses' < <(git -C "$ROOT" show :AGENTS.md) \
  && grep -Fq '`Delta / Next`' < <(git -C "$ROOT" show :AGENTS.md) \
  && grep -Fq '`Outcome / Residual / Next`' < <(git -C "$ROOT" show :AGENTS.md) \
  && grep -Fq '`Zoom-out`' < <(git -C "$ROOT" show :AGENTS.md); then
  pass "active guidance carries compact proportional reporting forms"
else
  fail "active guidance carries compact proportional reporting forms"
fi

if grep -Fq 'reload the governing parent or owner outcome' \
  < <(git -C "$ROOT" show :AGENTS.md) \
  && grep -Fq 'select the largest unclosed' \
  < <(git -C "$ROOT" show :AGENTS.md) \
  && grep -Fq 'Do not default to the last local' \
  < <(git -C "$ROOT" show :AGENTS.md); then
  pass "sparse continuation reloads the governing outcome"
else
  fail "sparse continuation reloads the governing outcome"
fi

if grep -Fq 'Goal/Goal-null' < <(git -C "$ROOT" show :AGENTS.md) \
  || grep -Fq '/tmp' < <(git -C "$ROOT" show :AGENTS.md) \
  || grep -Fq 'batch count' < <(git -C "$ROOT" show :AGENTS.md) \
  || grep -Fq 'progress ledger' < <(git -C "$ROOT" show :AGENTS.md) \
  || grep -Fq 'heartbeat' < <(git -C "$ROOT" show :AGENTS.md) \
  || grep -Fq 'Issue-164 carrier' < <(git -C "$ROOT" show :AGENTS.md); then
  fail "legacy compatibility fields are absent from active reporting guidance"
else
  pass "legacy compatibility fields are absent from active reporting guidance"
fi

if grep -Fq '`docs/codex-native-runtime-readiness-contract.md`' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md) \
  && grep -Fq '`templates/codex-native-runtime-readiness.md`' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md) \
  && grep -Fq '`docs/goal-episode-evaluation-contract.md`' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md) \
  && grep -Fq '`templates/goal-episode-evaluation.md`' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md) \
  && grep -Fq 'are not ordinary reporting or execution defaults.' \
  < <(git -C "$ROOT" show :docs/live-capability-inventory.md); then
  pass "caller-bound Goal/runtime surfaces stay explicitly compatibility only"
else
  fail "caller-bound Goal/runtime surfaces stay explicitly compatibility only"
fi

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

expect_pass "cached index, declared compatibility retirement, schema identity, and three consumers pass" "${VALIDATE[@]}"
cp "$TMP_ROOT/stdout" "$TMP_ROOT/positive.json"
for expected in \
  '"consumer_count": 3' \
  '"caller_checks": 6' \
  '"deleted_paths": 3' \
  '"orphan_active_exports": 0' \
  '"removed_reference_files": 1' \
  '"terminal_retirements": 1' \
  '"unchanged_floor_export_blobs": 1' \
  '"unchanged_schema_blobs": 1' \
  '"unclassified_index_paths": 0'
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

printf '%s\n' 'compat/retired.md' >> "$TMP_ROOT/advisor/evidence.txt"
git -C "$TMP_ROOT/advisor" add evidence.txt
git -C "$TMP_ROOT/advisor" commit -qm "retain terminal retirement reference"
TERMINAL_ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
expect_fail \
  "exact terminal retirement with a live consumer reference fails closed" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$TERMINAL_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
if grep -Fq \
  'terminal-retirement path remains referenced by advisor@' \
  "$TMP_ROOT/stderr"
then
  pass "terminal-retirement rejection names the exact consumer ref"
else
  fail "terminal-retirement rejection names the exact consumer ref"
fi

git -C "$TMP_ROOT/advisor" restore --source="$ADVISOR_REF" -- evidence.txt
mkdir -p "$TMP_ROOT/advisor/compat"
printf '%s\n' 'retired contract bytes without a self-reference' \
  > "$TMP_ROOT/advisor/compat/retired.md"
git -C "$TMP_ROOT/advisor" add evidence.txt compat/retired.md
git -C "$TMP_ROOT/advisor" commit -qm "retain terminal retirement path"
TERMINAL_PATH_ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
expect_fail \
  "exact terminal retirement still vendored by a consumer fails closed" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$TERMINAL_PATH_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
if grep -Fq \
  'terminal-retirement path remains present in advisor@' \
  "$TMP_ROOT/stderr"
then
  pass "terminal-retirement path rejection names the exact consumer ref"
else
  fail "terminal-retirement path rejection names the exact consumer ref"
fi

git -C "$TMP_ROOT/advisor" rm -q compat/retired.md
git -C "$TMP_ROOT/advisor" update-index --add --cacheinfo \
  160000 "$ADVISOR_REF" compat/retired.md
git -C "$TMP_ROOT/advisor" commit -qm "retain terminal retirement gitlink"
TERMINAL_GITLINK_ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
expect_fail \
  "exact terminal retirement retained as a consumer gitlink fails closed" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$TERMINAL_GITLINK_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
if grep -Fq \
  'terminal-retirement path remains present in advisor@' \
  "$TMP_ROOT/stderr"
then
  pass "terminal-retirement gitlink rejection names the exact consumer ref"
else
  fail "terminal-retirement gitlink rejection names the exact consumer ref"
fi

git -C "$TMP_ROOT/advisor" rm -q compat/retired.md
mkdir -p "$TMP_ROOT/advisor/compat/retired.md"
printf '%s\n' 'retired path retained as a tree' \
  > "$TMP_ROOT/advisor/compat/retired.md/child.txt"
git -C "$TMP_ROOT/advisor" add compat/retired.md/child.txt
git -C "$TMP_ROOT/advisor" commit -qm "retain terminal retirement tree"
TERMINAL_TREE_ADVISOR_REF="$(git -C "$TMP_ROOT/advisor" rev-parse HEAD)"
expect_fail \
  "exact terminal retirement retained as a consumer tree fails closed" \
  python3 "$ROOT/scripts/validate_owner_convergence.py" \
    --repo "$REPO" \
    --base-ref "$BASE" \
    --installed-root "$INSTALLED" \
    --consumer "auditor=$TMP_ROOT/auditor@$AUDITOR_REF" \
    --consumer "advisor=$TMP_ROOT/advisor@$TERMINAL_TREE_ADVISOR_REF" \
    --consumer "optimizer=$TMP_ROOT/optimizer@$OPTIMIZER_REF"
if grep -Fq \
  'terminal-retirement path remains present in advisor@' \
  "$TMP_ROOT/stderr"
then
  pass "terminal-retirement tree rejection names the exact consumer ref"
else
  fail "terminal-retirement tree rejection names the exact consumer ref"
fi

sed 's#`compat/retired.md` | `retired-without-successor`#`compat/*.md` | `retired-without-successor`#' \
  "$TMP_ROOT/good-inventory.md" > "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add docs/live-capability-inventory.md
expect_fail "wildcard terminal retirement fails closed" "${VALIDATE[@]}"
cp "$TMP_ROOT/good-inventory.md" "$REPO/docs/live-capability-inventory.md"
git -C "$REPO" add docs/live-capability-inventory.md

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

git -C "$REPO" rm -q scripts/validate-floor-receipt.sh
expect_fail "deleted canonical floor validator fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree scripts/validate-floor-receipt.sh

printf '%s\n' 'drifted floor validator bytes' > "$REPO/scripts/validate-floor-receipt.sh"
git -C "$REPO" add scripts/validate-floor-receipt.sh
expect_fail "drifted canonical floor validator fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree scripts/validate-floor-receipt.sh

git -C "$REPO" rm -q scripts/fleet-floor-conformance-audit.sh
expect_fail "deleted fleet floor audit fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree scripts/fleet-floor-conformance-audit.sh

printf '%s\n' 'drifted fleet floor audit bytes' > "$REPO/scripts/fleet-floor-conformance-audit.sh"
git -C "$REPO" add scripts/fleet-floor-conformance-audit.sh
expect_pass "owner-local fleet floor audit may evolve under focused coverage" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree scripts/fleet-floor-conformance-audit.sh

printf '%s\n' 'new unclassified path' > "$REPO/new-unclassified.txt"
git -C "$REPO" add new-unclassified.txt
expect_fail "new unclassified tracked path fails closed" "${VALIDATE[@]}"
git -C "$REPO" rm -q -f new-unclassified.txt

git -C "$REPO" restore --source="$BASE" --staged --worktree removed-a.txt
expect_fail "partially retained removed-name family fails closed" "${VALIDATE[@]}"
git -C "$REPO" rm -q removed-a.txt

git -C "$REPO" rm -q unclassified.txt
expect_fail "undeclared base-to-index deletion fails closed" "${VALIDATE[@]}"
git -C "$REPO" restore --source="$BASE" --staged --worktree unclassified.txt

git -C "$REPO" commit -qm "converged package"
cp "$ROOT/scripts/validate_owner_convergence.py" \
  "$REPO/scripts/validate_owner_convergence.py"
MAKE_VALIDATE=(
  env -u OWNER_CONVERGENCE_BASE_REF
  make --no-print-directory -s
  -C "$REPO"
  -f "$ROOT/Makefile"
  validate-owner-convergence
)
expect_pass "clean committed index defaults to HEAD^" "${MAKE_VALIDATE[@]}"
if grep -Fq '"deleted_paths": 3' "$TMP_ROOT/stdout"; then
  pass "clean committed index validates the latest commit delta"
else
  fail "clean committed index validates the latest commit delta"
fi

printf '%s\n' 'head-only compatibility bytes' > "$REPO/compat/head-only.md"
git -C "$REPO" add compat/head-only.md
git -C "$REPO" commit -qm "add compatibility path"
git -C "$REPO" rm -q compat/head-only.md
expect_fail \
  "staged deletion of HEAD-only compatibility path defaults to HEAD" \
  "${MAKE_VALIDATE[@]}"
if grep -Fq \
  "deleted path must match exactly one removed-name rule: compat/head-only.md" \
  "$TMP_ROOT/stderr"
then
  pass "staged deletion is evaluated against HEAD"
else
  fail "staged deletion is evaluated against HEAD"
fi

echo ""
echo "=== test-owner-convergence.sh: $PASS pass, $FAIL fail ==="
[ "$FAIL" -eq 0 ] || exit 1
