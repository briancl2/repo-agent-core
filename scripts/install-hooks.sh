#!/usr/bin/env bash
# install-hooks.sh — Symlink pre-commit and pre-push hooks into a consumer repo.
#
# Usage: bash install-hooks.sh [target-repo-path]
#   target-repo-path: Path to the repo where hooks should be installed (default: pwd)
#
# This script symlinks hooks from repo-agent-core/hooks/ into the target repo's
# .git/hooks/ directory. Uses symlinks (not copies) per L106.
#
# Can be called from any fleet repo's Makefile: make install-hooks

set -euo pipefail

CORE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_REPO="${1:-.}"

# Resolve absolute path
TARGET_REPO="$(cd "$TARGET_REPO" && pwd)"

if [ ! -d "$TARGET_REPO/.git" ]; then
  echo "ERROR: $TARGET_REPO is not a git repository"
  exit 1
fi

HOOKS_DIR="$TARGET_REPO/.git/hooks"
mkdir -p "$HOOKS_DIR"

echo "Installing hooks from $CORE_DIR/hooks/ into $TARGET_REPO/.git/hooks/"

# Pre-commit hook
if [ -f "$CORE_DIR/hooks/pre-commit-hook.sh" ]; then
  ln -sf "$CORE_DIR/hooks/pre-commit-hook.sh" "$HOOKS_DIR/pre-commit"
  chmod +x "$HOOKS_DIR/pre-commit"
  echo "  ✓ pre-commit → $CORE_DIR/hooks/pre-commit-hook.sh"
else
  echo "  ✗ pre-commit-hook.sh not found in $CORE_DIR/hooks/"
  exit 1
fi

# Pre-push hook
if [ -f "$CORE_DIR/hooks/pre-push-hook.sh" ]; then
  ln -sf "$CORE_DIR/hooks/pre-push-hook.sh" "$HOOKS_DIR/pre-push"
  chmod +x "$HOOKS_DIR/pre-push"
  echo "  ✓ pre-push → $CORE_DIR/hooks/pre-push-hook.sh"
else
  echo "  ✗ pre-push-hook.sh not found in $CORE_DIR/hooks/"
  exit 1
fi

echo "Done. Hooks installed in $TARGET_REPO"
