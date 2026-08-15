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

SKILL_TEXT="$(git -C "$ROOT" show ":$SKILL_PATH" | tr '\n' ' ' | tr -s ' ')"
CONTRACT_TEXT="$(git -C "$ROOT" show \
  ":.agents/skills/using-bma-researcher/references/researcher-contract.md" | \
  tr '\n' ' ' | tr -s ' ')"
EXAMPLE_TEXT="$(git -C "$ROOT" show ":.agents/skills/using-bma-researcher/examples/activation-cases.md" | tr '\n' ' ' | tr -s ' ')"

skill_has() {
  grep -Fq -- "$1" <<< "$SKILL_TEXT"
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
  'After the send and optional consequential clarification, resume the exact' \
  'boundedly poll that same response before choosing a' \
  "response's route-specific generation/Stop control observed active then absent," \
  'byte/hash stability across two bounded post-stop polls' \
  '`response_specific_native_markdown_export_ready` only when that exact response' \
  '`chatgpt_pro_generation_transition_stable`' \
  '`x_grok_generation_transition_stable`' \
  '`deep_research_completed_report`' \
  'stop with no capture and no retry.' \
  '`workflow.response_completion_marker`' \
  'source-native records false/null after' \
  'Preflight-v3 has neither field.' \
  'V3 route-identity/preflight artifacts record only portable booleans' \
  'route-allowlisted, non-identity `response_completion_marker` enum below;' \
  'it carries no handles, hashes, UI text, or stable identifiers.' \
  'The exact `RESPONSE_COMPLETION_MARKERS` allowlist' \
  '`chatgpt_deep_research -> {deep_research_completed_report}`' \
  '`chatgpt_pro -> {response_specific_native_markdown_export_ready,' \
  '`x_grok -> {x_grok_generation_transition_stable}`' \
  '`source_native -> {null}` with' \
  '`response_complete: false`.' \
  'Missing, cross-route, or non-allowlisted markers' \
  'fail before materialization or package publication.' \
  'producer-declared same-attempt evidence, not browser attestation, UI-stability,' \
  'report, product, and custody states are' \
  'If a response-specific native Markdown export carries complete citation evidence,' \
  'preserve it in a `bma_researcher_capture.v4` JSON file and run' \
  '`bma-researcher package --run-dir <private-run> --capture <native-capture.json>` once with that file directly;' \
  'do not invoke `materialize-capture` on the native branch.' \
  'Otherwise, use rendered-DOM capture: stage the exact assistant-response DOM,' \
  'every response-local compound drawer, the visibility receipt, and a citation-free capture draft' \
  '`bma-researcher materialize-capture`' \
  'For this rendered-DOM branch, invoke `bma-researcher materialize-capture` exactly once' \
  'For this rendered-DOM branch, run `bma-researcher package` only with the' \
  '`capture-materialized.json` emitted by that one invocation.' \
  'Never hand-author citation groups, citations, drawer receipts, visibility evidence,' \
  'separate owner-private staging directory outside the run' \
  '`package` emits the citation ledger from that materialized capture.' \
  'requires one private response identity across every artifact' \
  "requires every admitted pill and drawer source to descend from that artifact's exact response-identity element" \
  'entity-aware exact byte bindings' \
  '`--visibility-receipt`' \
  '`bma_researcher_rendered_visibility.v4` browser receipt required by' \
  'Use one bounded capture operation and one capture-local' \
  'For the assistant artifact and each opened drawer' \
  'retain that exact element reference for token injection and visibility measurement, then serialize the' \
  'exact non-primary descendant' \
  '`Element` whose direct text supplies an admitted label or count;' \
  'is the sole allowed dual primary role: use one token' \
  'both ordered pill and assistant-anchor receipt entries.' \
  'preserves global target order.' \
  'Each retained pill has exactly one exposed' \
  'assistant source `<a>`—the pill itself or exactly one descendant—whose label' \
  'direct-text nested label elements in DOM' \
  "each member's direct-text nested label elements in DOM document order" \
  "Direct text on a primary pill, anchor, count marker, or drawer member is covered by that primary node's row, not a duplicate nested row." \
  'direct-text nested label elements in DOM document order' \
  "each member's direct-text nested label elements in DOM document order" \
  'ordered domain-separated node-token hashes. It exposes no raw token.' \
  'Each retained element must have a true browser `Element.checkVisibility({contentVisibilityAuto: true, opacityProperty: true,' \
  'visibilityProperty: true})` result using exactly those three modern options,' \
  'exact retained pill wrapper, exposed assistant source anchor, displayed' \
  'A visible wrapper cannot substitute for a computed-hidden exposed source anchor.' \
  'Caller drawer order is not evidence:' \
  'a 20 MiB bound to each assistant/drawer artifact before hashing or parsing.' \
  "the native report's fixed 20 MiB byte ceiling before materialization or package read." \
  'Drawer inventory retains only path, hash, and byte-count records;' \
  'one bounded drawer at a time instead of retaining every raw drawer simultaneously.' \
  'it removes only that attempt-owned directory and partial materialized output;' \
  "The v4 bridge binds the producer's measured inventory to exact serialized" \
  'It is not browser attestation and does not prove producer honesty,' \
  'It applies the 10 MiB receipt bound before JSON decoding' \
  'Static HTML attributes or class names alone do not prove visibility.' \
  '`bma_researcher_citation_source_map.v4` map with' \
  '`rendered-dom-extractor.v2`.' \
  'Missing, reordered, cross-response, computed-hidden, hidden-only, extra, or unbound sources are terminal capture failures;' \
  'These are distinct schema revisions: the report-bundle manifest is not the citation source map.' \
  'embed the exact packaged `bma_researcher_citation_source_map.v4` object plus its package SHA-256.' \
  'Report-bundle manifest version 1 and citation-source-map v1/v2/v3 are historical verify-only; none authorizes a new' \
  '`bma_researcher_check_visibility_capability_probe.v1`.' \
  '`method_callable: true`, `options_object: getter_backed`, and' \
  '`option_getters_observed` with all three modern option keys exactly true.' \
  '`opacity_property_control` and `visibility_property_control` each to' \
  '`zero_argument: true` and `explicit_option: false`.' \
  '`content_visibility_auto_behavior: getter_observed_behavior_not_claimed`;' \
  'This receipt is evidence, not browser' \
  'Extractor v2 and' \
  '`bma_researcher_rendered_visibility_node_token.v1` remain current because the' \
  'Exact known `bma_researcher_invocation.v2`,' \
  '`bma_researcher_result.v2`, and' \
  '`bma_researcher_subscription_route_receipt.v2` bytes remain readable through' \
  "BMA's retained validators/integrator." \
  'The retained integrator accepts generic' \
  '`bma_researcher_subscription_route_receipt.v1` only for an already settled case' \
  'retained solely for historical readback whose exact case and receipt hash are' \
  'allowlisted; it cannot authorize a new foreground packet.' \
  'Skill discovery and route preflight do not prove'
do
  if skill_has "$required"; then
    pass "skill carries: $required"
  else
    fail "skill carries: $required"
  fi
done

NATIVE_LINE="$(git -C "$ROOT" show ":$SKILL_PATH" | grep -nF -m1 \
  'If a response-specific native Markdown export carries complete citation' | cut -d: -f1)"
TERMINAL_LINE="$(git -C "$ROOT" show ":$SKILL_PATH" | grep -nF -m1 \
  'After the send and optional consequential clarification' | cut -d: -f1)"
OTHERWISE_LINE="$(git -C "$ROOT" show ":$SKILL_PATH" | grep -nF -m1 \
  'Otherwise, use rendered-DOM capture:' | cut -d: -f1)"
MATERIALIZE_LINE="$(git -C "$ROOT" show ":$SKILL_PATH" | grep -nF -m1 \
  'For this rendered-DOM branch, invoke `bma-researcher materialize-capture`' | cut -d: -f1)"
PACKAGE_LINE="$(git -C "$ROOT" show ":$SKILL_PATH" | grep -nF -m1 \
  'For this rendered-DOM branch, run `bma-researcher package` only with the' | cut -d: -f1)"
NATIVE_BRANCH_TEXT="$(git -C "$ROOT" show ":$SKILL_PATH" | \
  sed -n "${NATIVE_LINE},$((OTHERWISE_LINE - 1))p" | tr '\n' ' ' | tr -s ' ')"
if [ -n "$TERMINAL_LINE" ] && [ -n "$NATIVE_LINE" ] && [ -n "$OTHERWISE_LINE" ] && \
  [ -n "$MATERIALIZE_LINE" ] && [ -n "$PACKAGE_LINE" ] && \
  [ "$TERMINAL_LINE" -lt "$NATIVE_LINE" ] && \
  [ "$NATIVE_LINE" -lt "$OTHERWISE_LINE" ] && \
  [ "$OTHERWISE_LINE" -lt "$MATERIALIZE_LINE" ] && \
  [ "$MATERIALIZE_LINE" -lt "$PACKAGE_LINE" ] && \
  [ "$(grep -Fc -- 'materialize-capture' <<< "$NATIVE_BRANCH_TEXT")" -eq 1 ] && \
  grep -Fq -- 'do not invoke `materialize-capture` on the native branch.' \
    <<< "$NATIVE_BRANCH_TEXT"; then
  pass "native direct-package and rendered materialize/package branches are mutually exclusive and ordered"
else
  fail "native direct-package and rendered materialize/package branches are mutually exclusive and ordered"
fi

if grep -Fq -- \
  'After send and any consequential clarification, the producer resumes the exact yielded/browser handle and boundedly polls that same response before either capture branch.' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  'Generation-transition-stable requires its exact route-specific generation/Stop control observed active then absent, a response-specific post-generation action row/control, exact response-subtree byte/hash stability across two bounded post-stop polls, and no navigation, reset, or handoff.' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  'Capture-v4 requires `workflow.response_complete` true plus an exact route-bound `workflow.response_completion_marker`:' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  '`response_specific_native_markdown_export_ready` or `chatgpt_pro_generation_transition_stable`;' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  'Preflight-v3 rejects both fields.' <<< "$CONTRACT_TEXT" && grep -Fq -- \
  'producer-declared same-attempt evidence, not attestation or proof of UI stability or semantic completeness.' \
  <<< "$CONTRACT_TEXT"; then
  pass "researcher contract carries the capture-v4 terminal-response gate and claim ceiling"
else
  fail "researcher contract carries the capture-v4 terminal-response gate and claim ceiling"
fi

if grep -Fq -- \
  'V3 route-identity/preflight receipts contain booleans and fresh random attempt aliases only.' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  'Capture-v4 additionally permits only its bounded, route-allowlisted, non-identity `response_completion_marker` enum;' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  '`chatgpt_deep_research -> {deep_research_completed_report}`' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  '`chatgpt_pro -> {response_specific_native_markdown_export_ready, chatgpt_pro_generation_transition_stable}`' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  '`x_grok -> {x_grok_generation_transition_stable}`' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  '`source_native -> {null}` with `response_complete: false`.' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  'Missing, cross-route, or non-allowlisted markers fail before materialization or package publication.' \
  <<< "$CONTRACT_TEXT"; then
  pass "researcher contract binds the exact four-route marker matrix and failure semantics"
else
  fail "researcher contract binds the exact four-route marker matrix and failure semantics"
fi

if grep -Eq -- \
  'Portable receipts contain booleans and random attempt aliases only|Record only portable booleans and a fresh random attempt alias' \
  <<< "$SKILL_TEXT $CONTRACT_TEXT"; then
  fail "portable booleans-only wording is scoped away from capture-v4"
else
  pass "portable booleans-only wording is scoped away from capture-v4"
fi

if grep -Fq -- '`rendered-dom-extractor.v2`' <<< "$SKILL_TEXT" && \
  grep -Fq -- '`rendered-dom-extractor.v2`' <<< "$CONTRACT_TEXT"; then
  pass "skill and contract bind the literal rendered-DOM extractor enum"
else
  fail "skill and contract bind the literal rendered-DOM extractor enum"
fi

if grep -Fq -- \
  'Exact known `bma_researcher_invocation.v2`, `bma_researcher_result.v2`, and `bma_researcher_subscription_route_receipt.v2` bytes remain readable through' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  'The retained integrator accepts generic `bma_researcher_subscription_route_receipt.v1` only for an already settled case retained solely for historical readback whose exact case and receipt hash are allowlisted; it cannot authorize a new foreground packet.' \
  <<< "$CONTRACT_TEXT"; then
  pass "researcher contract preserves exact v2 and bounded v1 historical route readback"
else
  fail "researcher contract preserves exact v2 and bounded v1 historical route readback"
fi

if grep -Fq -- \
  'A complete native export is preserved in a `bma_researcher_capture.v4` JSON file and passed directly to `bma-researcher package --run-dir <private-run> --capture <native-capture.json>`; the native branch never calls `materialize-capture`.' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  'Otherwise, the rendered-DOM branch calls `materialize-capture` exactly once' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  'only the emitted `capture-materialized.json` to `package`' \
  <<< "$CONTRACT_TEXT"; then
  pass "researcher contract preserves the native/rendered branch split"
else
  fail "researcher contract preserves the native/rendered branch split"
fi

if grep -Fq -- \
  'After any consequential clarification, resume the exact yielded/browser handle and boundedly poll this exact response.' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  '`workflow.response_completion_marker` to `chatgpt_pro_generation_transition_stable`.' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  'use `response_specific_native_markdown_export_ready` only when this exact response' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  'otherwise timeout or drift means no capture and no retry.' <<< "$EXAMPLE_TEXT"; then
  pass "compound example gates capture on the same-response terminal observation"
else
  fail "compound example gates capture on the same-response terminal observation"
fi

for exact_visibility_text in \
  '`bma_researcher_rendered_visibility.v4` receipt covering every assistant' \
  '`Element.checkVisibility({contentVisibilityAuto: true, opacityProperty: true, visibilityProperty: true})` effective layout-tree result using exactly those three modern options' \
  'New rendered capture emits `bma_researcher_citation_source_map.v4` with' \
  'citation-source-map v1/v2/v3 are distinct historical verify-only schemas' \
  '`bma_researcher_check_visibility_capability_probe.v1`' \
  '`method_callable: true`, `options_object: getter_backed`' \
  '`option_getters_observed` with all three modern option keys exactly true' \
  '`opacity_property_control` and `visibility_property_control` each bind' \
  '`content_visibility_auto_behavior: getter_observed_behavior_not_claimed`' \
  'The receipt does not attest browser or producer honesty' \
  'exact non-primary descendant `Element` whose direct text supplies an admitted label or count' \
  "Direct text on a primary pill, anchor, count marker, or drawer member is covered by that primary node's row, not a duplicate nested row." \
  'exposed assistant source anchor is the pill itself or exactly one source `<a>` descendant' \
  'is the sole allowed dual primary role: its one token produces both ordered pill and assistant-anchor' \
  'no other primary roles may share one token.' \
  'Extractor v2 and `bma_researcher_rendered_visibility_node_token.v1` remain current'
do
  if grep -Fq -- "$exact_visibility_text" <<< "$CONTRACT_TEXT"; then
    pass "researcher contract carries: $exact_visibility_text"
  else
    fail "researcher contract carries: $exact_visibility_text"
  fi
done

if grep -Fq -- \
  'non-primary descendant `Element` whose direct text supplies an admitted label or count.' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  'Direct text on a primary target uses only that primary row.' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  'that one exact element one token and retain both consecutive receipt roles; this is the only dual-primary-role case.' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  'every direct-text nested label/count element' <<< "$EXAMPLE_TEXT" && \
  grep -Fq -- 'in DOM document order when more than one such target exists.' \
    <<< "$EXAMPLE_TEXT"; then
  pass "compound example covers nested text visibility and the sole pill-anchor dual role"
else
  fail "compound example covers nested text visibility and the sole pill-anchor dual role"
fi

if grep -Fq -- \
  '`Element.checkVisibility({contentVisibilityAuto: true, opacityProperty: true, visibilityProperty: true})` on that retained reference' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  'The v4 receipt binds exactly those three modern true options' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  '`bma_researcher_check_visibility_capability_probe.v1` from that same browser' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  '`method_callable: true`; `options_object: getter_backed`' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  '`option_getters_observed` with all three modern option keys true' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  '`zero_argument: true` and `explicit_option: false`' \
  <<< "$EXAMPLE_TEXT" && grep -Fq -- \
  '`content_visibility_auto_behavior: getter_observed_behavior_not_claimed`' \
  <<< "$EXAMPLE_TEXT"; then
  pass "compound example binds exact modern checkVisibility options to retained elements"
else
  fail "compound example binds exact modern checkVisibility options to retained elements"
fi

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
