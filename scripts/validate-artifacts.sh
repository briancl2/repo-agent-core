#!/usr/bin/env bash
# validate-artifacts.sh — Schema validation wrapper for fleet artifacts.
#
# Usage: bash validate-artifacts.sh <artifact-path> [schema-name]
#   artifact-path: Path to the JSON artifact to validate
#   schema-name:   Schema to validate against (auto-detected if omitted)
#
# Supported artifacts: SCORECARD.json, OPPORTUNITIES.json, OPTIMIZATION_SCORECARD.json
# Requires: python3 with jsonschema (pip install jsonschema)

set -euo pipefail

CORE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCHEMAS_DIR="$CORE_DIR/schemas"

ARTIFACT_PATH="${1:-}"
SCHEMA_NAME="${2:-}"

if [ -z "$ARTIFACT_PATH" ]; then
  echo "Usage: validate-artifacts.sh <artifact-path> [schema-name]"
  echo ""
  echo "Examples:"
  echo "  validate-artifacts.sh output/SCORECARD.json"
  echo "  validate-artifacts.sh output/OPPORTUNITIES.json OPPORTUNITIES"
  exit 1
fi

if [ ! -f "$ARTIFACT_PATH" ]; then
  echo "ERROR: Artifact not found: $ARTIFACT_PATH"
  exit 1
fi

# Auto-detect schema from filename
if [ -z "$SCHEMA_NAME" ]; then
  BASENAME="$(basename "$ARTIFACT_PATH" .json)"
  case "$BASENAME" in
    SCORECARD) SCHEMA_NAME="SCORECARD" ;;
    OPPORTUNITIES) SCHEMA_NAME="OPPORTUNITIES" ;;
    OPTIMIZATION_SCORECARD) SCHEMA_NAME="OPTIMIZATION_SCORECARD" ;;
    FINDINGS|findings) SCHEMA_NAME="FINDINGS" ;;
    *)
      echo "ERROR: Cannot auto-detect schema for '$BASENAME'. Specify schema name."
      echo "Available: SCORECARD, OPPORTUNITIES, OPTIMIZATION_SCORECARD, FINDINGS"
      exit 1
      ;;
  esac
fi

SCHEMA_FILE="$SCHEMAS_DIR/${SCHEMA_NAME}.schema.json"

if [ ! -f "$SCHEMA_FILE" ]; then
  echo "ERROR: Schema not found: $SCHEMA_FILE"
  exit 1
fi

# Check if python3 is available
if ! command -v python3 >/dev/null 2>&1; then
  echo "WARN: python3 not available. Falling back to basic JSON syntax check."
  if python3 -c "import json; json.load(open('$ARTIFACT_PATH'))" 2>/dev/null; then
    echo "PASS: Valid JSON syntax (schema validation skipped — install python3)"
    exit 0
  else
    echo "FAIL: Invalid JSON syntax in $ARTIFACT_PATH"
    exit 1
  fi
fi

# Try jsonschema validation
if python3 -c "import jsonschema" 2>/dev/null; then
  python3 -c "
import json, jsonschema, sys

with open('$SCHEMA_FILE') as f:
    schema = json.load(f)
with open('$ARTIFACT_PATH') as f:
    artifact = json.load(f)

try:
    jsonschema.validate(artifact, schema)
    print('PASS: $ARTIFACT_PATH validates against $SCHEMA_NAME schema')
    sys.exit(0)
except jsonschema.ValidationError as e:
    print(f'FAIL: {e.message}')
    print(f'  Path: {\"/\".join(str(p) for p in e.absolute_path)}')
    sys.exit(1)
except jsonschema.SchemaError as e:
    print(f'SCHEMA ERROR: {e.message}')
    sys.exit(2)
"
else
  # Fallback: basic JSON validity + required keys check
  echo "WARN: jsonschema not installed. Running basic validation."
  python3 -c "
import json, sys

with open('$ARTIFACT_PATH') as f:
    data = json.load(f)

with open('$SCHEMA_FILE') as f:
    schema = json.load(f)

# Check required top-level keys
required = schema.get('required', [])
missing = [k for k in required if k not in data]
if missing:
    print(f'FAIL: Missing required keys: {missing}')
    sys.exit(1)
print(f'PASS: $ARTIFACT_PATH has all required keys for $SCHEMA_NAME (install jsonschema for full validation)')
"
fi
