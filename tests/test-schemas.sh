#!/usr/bin/env bash
# test-schemas.sh — Validate all JSON schemas are syntactically correct
# and can be loaded. Also validates sample artifacts if present in tests/samples/.

set -euo pipefail

CORE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCHEMAS_DIR="$CORE_DIR/schemas"
SAMPLES_DIR="$CORE_DIR/tests/samples"
PASS=0
FAIL=0

echo "=== Schema Syntax Validation ==="
for schema in "$SCHEMAS_DIR"/*.schema.json; do
  NAME="$(basename "$schema")"
  if python3 -c "import json; json.load(open('$schema'))" 2>/dev/null; then
    echo "  ✓ $NAME — valid JSON"
    PASS=$((PASS + 1))
  else
    echo "  ✗ $NAME — INVALID JSON"
    FAIL=$((FAIL + 1))
  fi
done

echo ""
echo "=== Schema Structure Validation ==="
for schema in "$SCHEMAS_DIR"/*.schema.json; do
  NAME="$(basename "$schema")"
  # Check it has $schema and type fields
  HAS_SCHEMA=$(python3 -c "import json; d=json.load(open('$schema')); print('yes' if '\$schema' in d else 'no')" 2>/dev/null || echo "error")
  if [ "$HAS_SCHEMA" = "yes" ]; then
    echo "  ✓ $NAME — has \$schema field"
    PASS=$((PASS + 1))
  else
    echo "  ✗ $NAME — missing \$schema field"
    FAIL=$((FAIL + 1))
  fi
done

# Validate sample artifacts against schemas if samples/ dir exists
if [ -d "$SAMPLES_DIR" ]; then
  echo ""
  echo "=== Sample Artifact Validation ==="
  for sample in "$SAMPLES_DIR"/*.json; do
    [ -f "$sample" ] || continue
    NAME="$(basename "$sample")"
    # Try to validate
    bash "$CORE_DIR/scripts/validate-artifacts.sh" "$sample" 2>/dev/null
    if [ $? -eq 0 ]; then
      PASS=$((PASS + 1))
    else
      FAIL=$((FAIL + 1))
    fi
  done
fi

echo ""
echo "=== Results ==="
echo "  PASS: $PASS  FAIL: $FAIL"

if [ "$FAIL" -gt 0 ]; then
  echo "  VERDICT: FAIL"
  exit 1
else
  echo "  VERDICT: PASS"
  exit 0
fi
