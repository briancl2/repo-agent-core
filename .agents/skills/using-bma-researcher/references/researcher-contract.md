# Portable Researcher Contract

The installed BMA runtime owns executable JSON validation. This reference keeps
the harness-facing invariants compact and provider neutral.

## Request invariants

- One immutable owner-private run directory outside Git.
- Exact ordinary question is the only relevance input.
- Trigger is `operator_question` or `agent_detected_need`.
- Authority and job family are frozen before context or routing.
- A composite request lists all applicable job families and one primary family.
- Prior-admission and dossier references are opaque owner-local handles.
- Task-required capabilities describe needs, not a preferred provider.
- Prohibited relevance inputs include source identifiers, corpus roots,
  retrieval queries, expected sources, expected claims, expected conclusions,
  hidden labels, held-out hints, and backfill seeds.

## Route invariants

- One initiation, zero retry, one provider task, and no provider/account/model
  switch by default.
- At most one clarification, and only when it is consequential to the answer.
- The host reads the emitted route-requirements schema first. V3 has no v4
  transport field; only v4 requires reading `transport.representation`. The
  host never selects transport from input size, provider UI, or earlier attempts.
- `bma_researcher_route_requirements.v3` retains exact inline transport only. The host re-reads
  `provider-input.md`, matches its hash against both route requirements and the
  invocation, and matches its UTF-8 byte count against the invocation only;
  v3 route requirements have no `provider_input_bytes`. The host puts only
  those bytes in an empty composer, rejects undeclared text or `[Truncated]`,
  writes no v4 transport object, and runs v3 preflight before the one send.
- `bma_researcher_route_requirements.v4` requires the prepared hash and byte count to match
  both route requirements and invocation immediately before transport. Browser representations are exactly
  `exact_inline_text` or `native_file_upload`; an unknown representation or
  schema/representation drift fails before preflight or send.
- V4 `exact_inline_text` requires the complete composer readback to match the
  exact prepared hash and UTF-8 byte count, native-upload booleans false, no
  undeclared text, and no truncation marker before preflight.
- V4 `native_file_upload` requires the emitted supported-chooser requirements,
  an empty composer, a `filechooser` wait armed before clicking the actual
  visible file input or its visible opener, one `chooser.setFiles` call with
  the absolute prepared-file path, completed visible upload state, matching
  visible filename and byte size, and a post-upload local hash/byte recheck.
  `locator.setInputFiles`, native-picker fallback, reconstructed files, extra
  composer text, and `[Truncated]` are forbidden.
- The initial v4 transport object records the emitted representation; prepared
  hash/byte matches; exact-inline match; supported chooser use; upload
  completion; visible name/size matches; undeclared-composer-text absence; and
  truncation-marker absence. Exact-inline makes only its applicable booleans
  true; upload makes only its applicable booleans true. Clarification carries
  no transport object and cannot redefine the initial transport.
- For either v4 browser representation, the initial observation's outbound
  hash and byte count remain bound to the exact prepared artifact; the
  transport object records whether those bytes are inline or the native file.
- The v4 transport receipt establishes host-side prepared-artifact and visible
  transport-state consistency only. It does not prove provider attention,
  extraction, semantic use, or report completeness.
- The pre-send observation is explicit, fresh, same-attempt, and invalidated by
  navigation, reset, handoff, or restart.
- Capture repeats origin, conversation, host-local identity-match, entitlement,
  capability, random attempt-alias, and route-specific workflow checks.
- V3 route-identity/preflight receipts contain booleans and fresh random
  attempt aliases only. V4 route-identity/preflight additionally carries the
  prepared artifact bindings allowed by the runtime contract and otherwise
  retains only booleans and fresh random aliases. Capture-v4 additionally permits only its bounded,
  route-allowlisted, non-identity `response_completion_marker` enum; it carries
  no handles, hashes, UI text, or stable identifiers.
- Deep Research needs launch-time selection and post-send native workflow proof.
- X Premium+ bookmark work needs private host-local account, Premium+,
  Bookmarks, and integrated-Grok proof.
- After send and any consequential clarification, the producer resumes the
  exact yielded/browser handle and boundedly polls that same response before
  either capture branch. Generation-transition-stable requires its exact
  route-specific generation/Stop control observed active then absent, a
  response-specific post-generation action row/control, exact response-subtree
  byte/hash stability across two bounded post-stop polls, and no navigation,
  reset, or handoff. Missing the active transition without the Pro native-export
  marker, timeout, or drift permits no capture or retry; generic UI is
  ineligible.
- Capture-v4 requires `workflow.response_complete` true plus an exact route-bound
  `workflow.response_completion_marker`: Deep Research accepts only
  `deep_research_completed_report`; Pro accepts
  `response_specific_native_markdown_export_ready` or
  `chatgpt_pro_generation_transition_stable`; Grok accepts only
  `x_grok_generation_transition_stable`. The Pro native marker requires that
  exact response's post-generation native Markdown export control/result, not a
  generic export/menu. Source-native requires false/null after its separate
  terminal acquisition. Preflight-v3 rejects both fields. Deep Research
  independently retains its plan/activity/completed-report bits. This is
  producer-declared same-attempt evidence, not attestation or proof of UI
  stability or semantic completeness.
- The exact `RESPONSE_COMPLETION_MARKERS` allowlist is
  `chatgpt_deep_research -> {deep_research_completed_report}`,
  `chatgpt_pro -> {response_specific_native_markdown_export_ready,
  chatgpt_pro_generation_transition_stable}`, `x_grok ->
  {x_grok_generation_transition_stable}`, and `source_native -> {null}` with
  `response_complete: false`. Missing, cross-route, or non-allowlisted markers
  fail before materialization or package publication.

## Result invariants

- The native report is preserved byte-for-byte.
- Native Markdown export is preferred when its response-specific citation
  evidence is complete.
- Rendered-DOM capture uses one immutable assistant-response DOM plus one
  same-response source-drawer DOM for every compound citation group, staged in
  a separate owner-private directory outside the run. The materializer creates
  the final immutable run-local capture directory.
- The live browser also supplies one response/hash/element-bound
  `bma_researcher_rendered_visibility.v4` receipt covering every assistant
  citation-pill wrapper, exposed assistant source anchor, displayed
  compound-count marker, drawer member, and exact non-primary descendant
  `Element` whose direct text supplies an admitted label or count. One bounded capture operation uses
  one capture-local token namespace. For the assistant artifact and each opened
  drawer artifact in turn, the producer adds a fresh opaque node token to each
  exact retained target, retains that same `Element` reference for visibility
  measurement, and serializes that marked artifact in the same operation while
  preserving global target order. The
  exposed assistant source anchor is the pill itself or exactly one source
  `<a>` descendant of its retained wrapper; its label and locator supply that
  pill's citation. A pill that is itself that exposed `<a>` is the sole allowed dual
  primary role: its one token produces both ordered pill and assistant-anchor
  receipt entries; no other primary roles may share one token. For each
  assistant pill in DOM order, exact receipt order is the pill wrapper, exposed
  source anchor, direct-text nested label elements in DOM document order,
  displayed count marker and its direct-text nested count elements in DOM
  document order when present, then that pill's drawer members in displayed
  order and each member's direct-text nested label elements in DOM document
  order before the next pill. Direct text on a primary pill, anchor, count marker, or drawer
  member is covered by that primary node's row, not a duplicate nested row. The
  receipt contains only ordered domain-separated token hashes. Each entry
  carries a true browser
  `Element.checkVisibility({contentVisibilityAuto: true, opacityProperty: true,
  visibilityProperty: true})` effective layout-tree result using exactly those
  three modern options, plus its computed style, connection, client rect, and
  nonzero box. Static class/style inference
  is insufficient, and a visible pill wrapper cannot substitute for its hidden
  exposed source anchor.
- Before v4 capture, the producer runs one private same-browser
  `bma_researcher_check_visibility_capability_probe.v1`. It binds a callable
  method as `method_callable: true`, `options_object: getter_backed`, and
  `option_getters_observed` with all three modern option keys exactly true. Its
  `opacity_property_control` and `visibility_property_control` each bind
  `zero_argument: true` and `explicit_option: false`. It records
  `content_visibility_auto_behavior: getter_observed_behavior_not_claimed`; no
  deterministic skipped-auto behavior is claimed. Missing, false, unread, or
  drifted probe evidence fails closed. The receipt does not attest browser or
  producer honesty.
- Materialize and package apply the 10 MiB visibility-receipt bound before JSON
  decoding, the 20 MiB-per-artifact assistant/drawer bound before hash or
  parse, and the native report's fixed 20 MiB ceiling before materialization or
  package read. Drawer inventory retains only path/hash/byte-count records;
  each bounded drawer is verified, parsed, and copied separately rather than
  retaining all raw drawer bytes simultaneously. The bridge binds producer
  inventory to exact serialized nodes; it is not browser attestation and does
  not prove producer honesty, viewport intersection, clipping freedom, z-order,
  or absence of occlusion.
- A complete native export is preserved in a `bma_researcher_capture.v4` JSON
  file and passed directly to `bma-researcher package --run-dir <private-run>
  --capture <native-capture.json>`; the native branch never calls
  `materialize-capture`.
- Otherwise, the rendered-DOM branch calls `materialize-capture` exactly once
  to derive citation groups, ordered citations, entity-aware byte occurrences,
  receipts, and source map; agents never hand-author them. That branch passes
  only the emitted `capture-materialized.json` to `package`, which emits the
  citation ledger.
- One private response identity must match across every rendered-DOM artifact,
  and every admitted pill and drawer source must descend from its artifact's
  exact identity element. Only a fresh opaque alias and hash-bound receipts
  travel portably.
- Assistant-pill order determines drawer custody and receipt order; caller
  drawer argument order is not evidence.
- Materialization never overwrites pre-existing output. Publication failure
  removes only the attempt-owned partial output and private capture directory.
- Package independently re-derives the rendered-DOM map and rejects missing,
  reordered, cross-response, computed-hidden, hidden-only, extra, or unbound
  sources.
- New rendered capture emits `bma_researcher_citation_source_map.v4` with
  `rendered-dom-extractor.v2`, true visibility verification, receipt and
  element-identity schema names, and the private receipt hash. Raw authenticated
  DOM, node tokens, drawer, visibility-receipt, and stable response-identity
  bytes remain local.
  Citations, the derived map/ledger, and source/media dispositions remain
  inspectable.
- The owner result begins with the answer and decision.
- Structured and Markdown results agree on outcome, adopt/reject/defer,
  evidence, source/product/report status, uncertainty, counterevidence,
  no-action, residual, next decision, and claim ceiling.
- `NO_ACTION` is a valid owner outcome.
- Package state stops at `PACKAGED` until existing Research Brain custody
  succeeds.
- New rendered-DOM custody uses Research Brain report-bundle manifest schema
  version 2. It embeds and hash-binds the exact packaged citation-source-map v4
  object. Manifest version 1 and citation-source-map v1/v2/v3 are distinct
  historical verify-only schemas and cannot authorize new rendered admission.
  Extractor v2 and `bma_researcher_rendered_visibility_node_token.v1` remain
  current because parsing and exact element identity are unchanged.
- Prior request/result version 2 objects remain readable; migration never
  rewrites their historical bytes.
- Exact known `bma_researcher_invocation.v2`, `bma_researcher_result.v2`, and
  `bma_researcher_subscription_route_receipt.v2` bytes remain readable through
  BMA's retained validators/integrator. The retained integrator accepts generic
  `bma_researcher_subscription_route_receipt.v1` only for an already settled
  case retained solely for historical readback whose exact case and receipt
  hash are allowlisted; it cannot authorize a new foreground packet.

## Non-claims

Skill discovery and route preflight do not prove provider execution portability,
useful-report admission, natural-run reliability, or release readiness. A
comparator is an experiment, not a route adapter or a natural episode.
