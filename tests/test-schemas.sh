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
echo "=== Command Output ROI Receipt Semantics ==="
if python3 - "$SAMPLES_DIR/COMMAND_OUTPUT_ROI_RECEIPT.json" "$SAMPLES_DIR/COMMAND_OUTPUT_ROI_RECEIPT_REJECTED.json" <<'PY'
import copy
import json
import sys

passing = json.load(open(sys.argv[1], encoding="utf-8"))
failing = json.load(open(sys.argv[2], encoding="utf-8"))


def receipt_semantics_are_valid(payload):
    if payload["verdict"] == "fail":
        return payload["raw_transcript_detected"] is True and len(payload["violations"]) >= 1
    if payload["verdict"] == "pass":
        return payload["raw_transcript_detected"] is False and payload["violations"] == []
    return False


assert passing["verdict"] == "pass"
assert passing["raw_transcript_detected"] is False
assert passing["violations"] == []
assert failing["verdict"] == "fail"
assert failing["raw_transcript_detected"] is True
assert len(failing["violations"]) >= 1
assert receipt_semantics_are_valid(passing)
assert receipt_semantics_are_valid(failing)

bad = copy.deepcopy(failing)
bad["violations"] = []
assert not receipt_semantics_are_valid(bad)
PY
then
  echo "  ✓ COMMAND_OUTPUT_ROI_RECEIPT pass/fail samples preserve verdict semantics"
  PASS=$((PASS + 1))
else
  echo "  ✗ COMMAND_OUTPUT_ROI_RECEIPT pass/fail samples violate verdict semantics"
  FAIL=$((FAIL + 1))
fi

BAD_RECEIPT="$(mktemp "${TMPDIR:-/tmp}/command-output-roi-bad.XXXXXX.json")"
python3 - "$SAMPLES_DIR/COMMAND_OUTPUT_ROI_RECEIPT_REJECTED.json" "$BAD_RECEIPT" <<'PY'
import copy
import json
import sys

payload = json.load(open(sys.argv[1], encoding="utf-8"))
bad = copy.deepcopy(payload)
bad["violations"] = []
with open(sys.argv[2], "w", encoding="utf-8") as handle:
    json.dump(bad, handle)
PY
set +e
bash "$CORE_DIR/scripts/validate-artifacts.sh" "$BAD_RECEIPT" COMMAND_OUTPUT_ROI_RECEIPT >/dev/null 2>&1
BAD_RC=$?
set -e
rm -f "$BAD_RECEIPT"
if [ "$BAD_RC" -ne 0 ]; then
  echo "  ✓ COMMAND_OUTPUT_ROI_RECEIPT validator rejects fail-without-violations"
  PASS=$((PASS + 1))
else
  echo "  ✗ COMMAND_OUTPUT_ROI_RECEIPT validator accepted fail-without-violations"
  FAIL=$((FAIL + 1))
fi

echo ""
echo "=== Source Insight Packet Semantics ==="
if python3 - "$SCHEMAS_DIR/SOURCE_INSIGHT_PACKET.schema.json" "$SAMPLES_DIR/SOURCE_INSIGHT_PACKET.json" <<'PY'
import copy
import json
import sys

schema = json.load(open(sys.argv[1], encoding="utf-8"))
sample = json.load(open(sys.argv[2], encoding="utf-8"))

try:
    import jsonschema  # type: ignore
except ImportError:
    jsonschema = None


def validate(payload):
    if jsonschema is not None:
        jsonschema.validate(payload, schema)
        return
    for field in schema["required"]:
        assert field in payload
    assert payload["artifact"] == "SOURCE_INSIGHT_PACKET"


validate(sample)
source_ids = {source["source_id"] for source in sample["sources"]}
assert all(source["insight_disposition"] in {"insight", "no_insight", "contradiction", "inaccessible"} for source in sample["sources"])
for claim in sample["claims"]:
    assert set(claim["source_ids"]).issubset(source_ids)
for finding in sample["high_signal_findings"]:
    assert set(finding["source_ids"]).issubset(source_ids)
    assert finding["disposition"] in {
        "owner_surface_candidate",
        "github_issue_candidate",
        "roadmap_disposition",
        "explicit_no_action",
        "rejected_or_inaccessible",
    }

bad = copy.deepcopy(sample)
del bad["sources"][0]["insight_disposition"]
failed = False
try:
    validate(bad)
except Exception:
    failed = True
if jsonschema is not None:
    assert failed
PY
then
  echo "  ✓ SOURCE_INSIGHT_PACKET sample preserves source-to-claim and owner-routing semantics"
  PASS=$((PASS + 1))
else
  echo "  ✗ SOURCE_INSIGHT_PACKET sample violates source-intelligence semantics"
  FAIL=$((FAIL + 1))
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
