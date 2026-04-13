#!/usr/bin/env bash
# scripts/pre-commit-hook.sh — Pre-commit hook for repo-upgrade-advisor
#
# Runs make check before every commit. Install with: make install-hooks
# Adapted per spec 056.

set -euo pipefail

echo "=== Pre-commit: Running make check ==="
make check

if [ $? -eq 0 ]; then
    echo "=== Check passed ==="
else
    echo "=== Check FAILED — commit blocked ==="
    exit 1
fi
