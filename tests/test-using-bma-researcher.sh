#!/usr/bin/env bash
# Deterministic portable skill and install/drift behavior tests.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_PATH=".agents/skills/using-bma-researcher/SKILL.md"
INSTALLER="$ROOT/scripts/install-bma-researcher-skill.py"
SOURCE="$ROOT/.agents/skills/using-bma-researcher"
V3_ROUTE_FIXTURE="$ROOT/.agents/skills/using-bma-researcher/examples/v3-route-requirements.json"
V3_INVOCATION_FIXTURE="$ROOT/.agents/skills/using-bma-researcher/examples/v3-invocation.json"
V5_ROUTE_FIXTURE="$ROOT/.agents/skills/using-bma-researcher/examples/v5-route-requirements.json"
V5_PROBE_FIXTURE="$ROOT/.agents/skills/using-bma-researcher/examples/v5-transport-probe.json"
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

# Exact outputs from BMA candidate e7af37bd96ed3318620fd4eb665579b1d9ad2b86.
# The route fixture comes from route_requirements() for the exact probe bytes;
# the manifest is the byte-identical transport-probe output.
if [ "$(shasum -a 256 "$V5_ROUTE_FIXTURE" | awk '{print $1}')" = \
  "a883383c8ff8cf8dc5744dd22ba5e2d394e0e5aebc3666f12a4c8bbed3f7aad9" ] && \
  [ "$(shasum -a 256 "$V5_PROBE_FIXTURE" | awk '{print $1}')" = \
  "4e05c8088528e990a565def6ed0452f83dc6c150e3cf75f2936613f9d326b78e" ] && \
  python3 -c 'import json,sys; route=json.load(open(sys.argv[1])); probe=json.load(open(sys.argv[2])); artifact=probe["artifacts"][0]; transport=route["transport"]; upload=transport["native_file_upload"]; assert route["schema_version"] == "bma_researcher_route_requirements.v5"; assert route["selected_route"] == "chatgpt_pro"; assert route["provider_input_sha256"] == artifact["sha256"]; assert route["provider_input_bytes"] == artifact["bytes"] == 262144; assert transport["representation"] == artifact["representation"] == "native_file_upload"; assert transport["submission_instruction"] == artifact["submission_instruction"]; assert upload["trusted_file_input_activation_method"] == artifact["file_input_activation_method"]; assert upload["supported_native_file_chooser_required"] is True; assert upload["trusted_file_input_activation_required"] is True; assert upload["upload_completion_required"] is True; assert upload["prepared_file_selection_match_required"] is True; assert upload["visible_file_name_match_required"] is True; assert "visible_file_size_match_required" not in upload; assert probe["schema_version"] == "bma_researcher_chatgpt_transport_probe.v1"; assert probe["send_authorized"] is False; assert artifact["submission_instruction_bytes"] == 59' \
    "$V5_ROUTE_FIXTURE" "$V5_PROBE_FIXTURE"; then
  pass "hash-pinned BMA v5 route and transport-probe fixtures match the canonical skill"
else
  fail "hash-pinned BMA v5 route and transport-probe fixtures match the canonical skill"
fi

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
  'read the emitted `route-requirements.json` schema first and' \
  'Current foreground work requires' \
  '`bma_researcher_route_requirements.v5`; retained v3/v4 examples are historical' \
  'readback evidence and never authorize a new send.' \
  'For ChatGPT Pro or Deep Research, v5 always declares' \
  '`transport.representation: native_file_upload`.' \
  'Never bulk-insert prepared' \
  'provider-input bytes into the ChatGPT composer and never split them across' \
  'multiple inline attempts.' \
  'open' \
  '`Add files and more`, require the visible `Upload from computer` action,' \
  'pre-arm `tab.playwright.waitForEvent("filechooser", {timeoutMs: 10000})`' \
  '`Runtime.evaluate` with `userGesture: true`.' \
  '`setFiles` once with the absolute exact prepared-file path.' \
  'fixed 59-byte' \
  '`submission_instruction` in the composer' \
  'ChatGPT' \
  'does not expose a dependable attachment byte-size readback' \
  'ChatGPT `bma_researcher_route_observation.v5` transport object uses' \
  '"representation": "native_file_upload",' \
  '"prepared_input_sha256_match": true,' \
  '"prepared_input_bytes_match": true,' \
  '"exact_composer_text_match": true,' \
  '"trusted_file_input_activation_used": true,' \
  '"supported_native_file_chooser_used": true,' \
  '"chooser_selected_prepared_input_match": true,' \
  '"upload_completed": true,' \
  '"visible_file_name_match": true,' \
  '"visible_attachment_names": ["provider-input.md"],' \
  '"visible_attachment_count": 1,' \
  '"undeclared_composer_text_absent": true,' \
  '"truncation_marker_absent": true' \
  'X/Grok retains the separate bounded `exact_inline_text` route' \
  '"representation": "exact_inline_text",' \
  '"trusted_file_input_activation_used": false,' \
  '"supported_native_file_chooser_used": false,' \
  '"chooser_selected_prepared_input_match": false,' \
  '"upload_completed": false,' \
  '"visible_file_name_match": false,' \
  '"visible_attachment_names": [],' \
  '"visible_attachment_count": 0,' \
  'A clarification observation carries no transport' \
  'does not authorize compaction, retry, a second send, or a route,' \
  '`bma-researcher transport-probe --output-dir <new-dir>`' \
  '`send_authorized: false`' \
  'The v5 receipt proves browser control and prepared-artifact consistency only;' \
  'it does not prove provider' \
  'attention, extraction, semantic use, or report completeness.' \
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
  'V5 identity evidence records portable booleans and a fresh random attempt alias;' \
  'initial native-upload transport/preflight additionally carries the exact prepared' \
  'hash/byte bindings, bounded attachment-basename inventory and small count, and' \
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
  'materialize-browser-rendered-capture' \
  '`capture-browser-rendered.json`' \
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

transport_skill_valid() {
  local candidate="$1"
  local guard
  for guard in \
    'read the emitted `route-requirements.json` schema first and' \
    '`bma_researcher_route_requirements.v5`; retained v3/v4 examples are historical readback evidence' \
    'For ChatGPT Pro or Deep Research, v5 always declares' \
    '`transport.representation: native_file_upload`.' \
    'Never bulk-insert prepared provider-input bytes into the ChatGPT composer and never split them across' \
    '`Add files and more`, require the visible `Upload from computer` action,' \
    'pre-arm `tab.playwright.waitForEvent("filechooser", {timeoutMs: 10000})`' \
    '`Runtime.evaluate` with `userGesture: true`.' \
    '`setFiles` once with the absolute exact prepared-file path.' \
    '`submission_instruction` in the composer' \
    'does not expose a dependable attachment byte-size readback' \
    'ChatGPT `bma_researcher_route_observation.v5` transport object uses exactly the following field set. An exact-label observation is:' \
    '"representation": "native_file_upload", "prepared_input_sha256_match": true, "prepared_input_bytes_match": true, "exact_composer_text_match": true, "trusted_file_input_activation_used": true, "supported_native_file_chooser_used": true, "chooser_selected_prepared_input_match": true, "upload_completed": true, "visible_file_name_match": true, "visible_attachment_names": ["provider-input.md"], "visible_attachment_count": 1, "undeclared_composer_text_absent": true, "truncation_marker_absent": true' \
    'Preflight independently requires one name, count `1`, and the bounded exact-or-suffix matcher.' \
    '"representation": "exact_inline_text", "prepared_input_sha256_match": true, "prepared_input_bytes_match": true, "exact_composer_text_match": true, "trusted_file_input_activation_used": false, "supported_native_file_chooser_used": false, "chooser_selected_prepared_input_match": false, "upload_completed": false, "visible_file_name_match": false, "visible_attachment_names": [], "visible_attachment_count": 0, "undeclared_composer_text_absent": true, "truncation_marker_absent": true' \
    '`bma-researcher transport-probe --output-dir <new-dir>`' \
    '`send_authorized: false`' \
    'does not authorize compaction, retry, a second send, or a route,'
  do
    grep -Fq -- "$guard" <<< "$candidate" || return 1
  done
}

if transport_skill_valid "$SKILL_TEXT"; then
  pass "canonical transport contract passes exact branch validator"
else
  fail "canonical transport contract passes exact branch validator"
fi

for mutation_target in \
  'bma_researcher_route_requirements.v5' \
  '"representation": "native_file_upload"' \
  '"representation": "exact_inline_text"' \
  'prepared_input_sha256_match' \
  'prepared_input_bytes_match' \
  'exact_composer_text_match' \
  'trusted_file_input_activation_used' \
  'supported_native_file_chooser_used' \
  'chooser_selected_prepared_input_match' \
  'upload_completed' \
  'visible_file_name_match' \
  'visible_attachment_names' \
  'visible_attachment_count' \
  'undeclared_composer_text_absent' \
  'truncation_marker_absent' \
  'tab.playwright.waitForEvent("filechooser", {timeoutMs: 10000})' \
  'Runtime.evaluate' \
  'submission_instruction' \
  'transport-probe' \
  'a second send'
do
  MUTATED_SKILL_TEXT="$(python3 -c \
    'import sys; print(sys.stdin.read().replace(sys.argv[1], "__drifted_transport_guard__"), end="")' \
    "$mutation_target" <<< "$SKILL_TEXT")"
  if transport_skill_valid "$MUTATED_SKILL_TEXT"; then
    fail "transport validator rejects drift: $mutation_target"
  else
    pass "transport validator rejects drift: $mutation_target"
  fi
done

# Byte-identical copies of the historical prepared-v3 fixture generated by BMA
# commit 973e635447e747a18d9362e5e16a3ce80559b04c.
if [ "$(shasum -a 256 "$V3_ROUTE_FIXTURE" | awk '{print $1}')" = \
  "da7d4fcf68aababf6b7b5740ea86cd42e68933566850f57dfcb8827e54c6962f" ] && \
  [ "$(shasum -a 256 "$V3_INVOCATION_FIXTURE" | awk '{print $1}')" = \
  "c2a71594ccc9a226f72b1f09b6c85f2bf3f795c46b5882bd1773c672e3ecc20c" ] && \
  python3 -c 'import json,sys; route=json.load(open(sys.argv[1])); invocation=json.load(open(sys.argv[2])); assert route["schema_version"] == "bma_researcher_route_requirements.v3"; assert "provider_input_sha256" in route; assert "provider_input_bytes" not in route; assert route["provider_input_sha256"] == invocation["provider_input"]["sha256"]; assert isinstance(invocation["provider_input"]["bytes"], int); assert invocation["route_requirements"]["sha256"] == sys.argv[3]' \
    "$V3_ROUTE_FIXTURE" "$V3_INVOCATION_FIXTURE" \
    "da7d4fcf68aababf6b7b5740ea86cd42e68933566850f57dfcb8827e54c6962f"; then
  pass "authoritative BMA v3 fixture keeps bytes in invocation, not route requirements"
else
  fail "authoritative BMA v3 fixture keeps bytes in invocation, not route requirements"
fi

if grep -Fq -- \
  'SHA-256 and UTF-8 byte count to match the prepared invocation and route requirements.' \
  <<< "$EXAMPLE_TEXT"; then
  fail "v3 guidance does not depend on route_requirements.provider_input_bytes"
elif grep -Fq -- \
  'match its UTF-8 byte count only against `invocation.json`' \
  <<< "$EXAMPLE_TEXT"; then
  pass "v3 guidance does not depend on route_requirements.provider_input_bytes"
else
  fail "v3 guidance does not depend on route_requirements.provider_input_bytes"
fi

V5_SCHEMA_LINE="$(git -C "$ROOT" show ":$SKILL_PATH" | grep -nF -m1 \
  'Current foreground work requires' | cut -d: -f1)"
V5_UPLOAD_LINE="$(git -C "$ROOT" show ":$SKILL_PATH" | grep -nF -m1 \
  'For ChatGPT Pro or Deep Research, v5 always declares' | cut -d: -f1)"
V5_OBSERVATION_LINE="$(git -C "$ROOT" show ":$SKILL_PATH" | grep -nF -m1 \
  'The initial ChatGPT `bma_researcher_route_observation.v5` transport object uses' | cut -d: -f1)"
PREFLIGHT_TRANSPORT_LINE="$(git -C "$ROOT" show ":$SKILL_PATH" | grep -nF -m1 \
  'observation, run v5 preflight immediately before the one initiation.' | cut -d: -f1)"
if [ -n "$V5_SCHEMA_LINE" ] && [ -n "$V5_UPLOAD_LINE" ] && \
  [ -n "$V5_OBSERVATION_LINE" ] && \
  [ -n "$PREFLIGHT_TRANSPORT_LINE" ] && \
  [ "$V5_SCHEMA_LINE" -lt "$V5_UPLOAD_LINE" ] && \
  [ "$V5_UPLOAD_LINE" -lt "$V5_OBSERVATION_LINE" ] && \
  [ "$V5_OBSERVATION_LINE" -lt "$PREFLIGHT_TRANSPORT_LINE" ]; then
  pass "v5 ChatGPT upload and preflight operations are mutually ordered"
else
  fail "v5 ChatGPT upload and preflight operations are mutually ordered"
fi

for transport_contract in \
  'The host reads the emitted route-requirements schema first.' \
  'Current foreground work requires v5.' \
  'Retained v3/v4 examples are historical readback evidence' \
  '`bma_researcher_route_requirements.v3` is retained only for exact historical' \
  'Its hash remains bound to both route requirements and' \
  'its UTF-8 byte count comes from the invocation because v3' \
  'v3 route requirements have no `provider_input_bytes`.' \
  'It cannot authorize a current preflight or send.' \
  '`bma_researcher_route_requirements.v5` requires the prepared hash and byte' \
  'ChatGPT always declares `native_file_upload`; X/Grok alone retains' \
  'opens `Add files and more`, requires visible `Upload' \
  'pre-arms the `filechooser` wait' \
  '`Runtime.evaluate` activation of the exact generic file input with' \
  '`userGesture: true`.' \
  'does not require visible attachment byte-size UI.' \
  '`transport-probe` is a deterministic, non-sensitive, no-send 256 KiB browser' \
  'V5 identity evidence contains portable booleans and a fresh random attempt' \
  'bounded attachment-basename inventory and' \
  'It does not prove provider attention, extraction, semantic use, or report completeness.'
do
  if grep -Fq -- "$transport_contract" <<< "$CONTRACT_TEXT"; then
    pass "researcher contract carries transport invariant: $transport_contract"
  else
    fail "researcher contract carries transport invariant: $transport_contract"
  fi
done

for transport_example in \
  '## Historical v3 transport readback' \
  'match its UTF-8 byte count only against `invocation.json`' \
  'the v3 route-requirements object has no `provider_input_bytes`.' \
  'Do not create a composer observation, run preflight, upload, or send from a v3 artifact.' \
  '## Current v5 ChatGPT native-file transport' \
  '`prepare` emits `bma_researcher_route_requirements.v5`' \
  'pre-arm `waitForEvent("filechooser")`' \
  'Never bulk-insert the prepared file into ChatGPT' \
  '## Current v5 X/Grok exact-inline transport' \
  '## Questionless transport certification' \
  '`send_authorized: false`' \
  'stop before send. Do not compact, rebuild, retry, or switch route.'
do
  if grep -Fq -- "$transport_example" <<< "$EXAMPLE_TEXT"; then
    pass "researcher example carries transport case: $transport_example"
  else
    fail "researcher example carries transport case: $transport_example"
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

browser_rendered_skill_valid() {
  local candidate="$1"
  local guard
  for guard in \
    'data-bma-researcher-browser-rendered-dom-evidence="bma_researcher_browser_rendered_dom_evidence.v1"' \
    'data-bma-researcher-attempt-alias' \
    'data-bma-response-inner-text-base64' \
    'data-bma-ordered-citation-urls-json-base64' \
    'data-bma-original-response-outer-html-base64' \
    '--citation-traversal <response-local-traversal-json>' \
    'This indexed form is required for Deep Research and is also accepted for Pro.' \
    'This direct-link form is accepted only for Pro.' \
    '"conversation_url": "https://chatgpt.com/c/example"' \
    '"portable_urls": ["https://example.com/source"]' \
    'does not rewrite either retained value.' \
    'Direct-link `links` preserves duplicate anchor occurrences' \
    'portable citation-occurrence map' \
    'Missing source indexes, nonportable attachments, and visible `+N` members without retained locators remain explicit partial evidence.' \
    'requires its current attempt alias' \
    'rejects separately staged text or URL bytes that differ or duplicate evidence markers' \
    'not browser attestation or proof against deliberate fabrication.'
  do
    grep -Fq -- "$guard" <<< "$candidate" || return 1
  done
}

if browser_rendered_skill_valid "$SKILL_TEXT"; then
  pass "browser-rendered response-root binding contract is complete"
else
  fail "browser-rendered response-root binding contract is complete"
fi

for mutation_target in \
  'data-bma-researcher-browser-rendered-dom-evidence="bma_researcher_browser_rendered_dom_evidence.v1"' \
  'data-bma-researcher-attempt-alias' \
  'data-bma-response-inner-text-base64' \
  'data-bma-ordered-citation-urls-json-base64' \
  'data-bma-original-response-outer-html-base64' \
  '--citation-traversal <response-local-traversal-json>'
do
  mutated_browser_text="${SKILL_TEXT/"$mutation_target"/__removed_browser_guard__}"
  if browser_rendered_skill_valid "$mutated_browser_text"; then
    fail "browser-rendered validator rejects drift: $mutation_target"
  else
    pass "browser-rendered validator rejects drift: $mutation_target"
  fi
done

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
  'V5 identity evidence contains portable booleans and a fresh random attempt alias.' \
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
  'A complete `browser_rendered_markdown` capture is likewise passed directly to `package` with null strict rendered-DOM provenance fields, but only after `materialize-browser-rendered-capture` emits it.' \
  <<< "$CONTRACT_TEXT" && grep -Fq -- \
  'Only the strict `rendered_dom_markdown` branch calls `materialize-capture` exactly once' \
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
