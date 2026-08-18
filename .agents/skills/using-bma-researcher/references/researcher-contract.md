# Portable Researcher Contract

The installed BMA runtime owns executable JSON validation. This reference keeps
the harness-facing invariants compact and provider neutral.

## Request invariants

- One mode-0700 owner-private episode directory outside Git and one immutable
  run directory per attempt.
- Source-owner refresh and exact-object binding finish before the one prepare.
  Field Theory and YouTube retain their existing refresh contracts; the binding
  records their exact observed identities/cutoffs. Research Brain is an
  explicit fresh clean checkout at the episode-recorded full commit, never a
  mutable default. `prepare` performs no refresh.
- `materialize-request --mode ordinary` is the sole ordinary constructor. Its
  otherwise complete v3 draft leaves `recorded_at` and `currentness.cutoff`
  null; the BMA-owned materializer derives one current UTC value for both and
  securely publishes the existing request-file contract. Replay/test-fixture
  values remain explicit and strict.
- In a multi-case batch, bind exact sources and materialize each request
  immediately before its one `prepare`; paired route controls share one exact
  binding. Case, attempt, and route labels remain host-local custody metadata
  rather than relevance input.
- Exact ordinary question is the only relevance input.
- Trigger is `operator_question` or `agent_detected_need`.
- Authority and job family are frozen before context or routing.
- A composite request lists all applicable job families and one primary family.
- Prior-admission and dossier references are opaque owner-local handles.
- Task-required capabilities describe needs, not a preferred provider.
- Prohibited relevance inputs include source identifiers, corpus roots,
  retrieval queries, expected sources, expected claims, expected conclusions,
  hidden labels, held-out hints, and backfill seeds.
- A `ForegroundError` retains its safe verbatim message, exception class, and
  stable operation stage only in the owner-private failure receipt. Public CLI
  and stderr remain bounded and generic.

## Route invariants

- One initiation, zero retry, one provider task, and no provider/account/model
  switch by default.
- One explicit confirmation of a fully declared batch authorizes its listed
  initial sends; no per-attempt reconfirmation is required absent material
  content, route, account, provider, or scope drift.
- At most one clarification, and only when it is consequential to the answer.
- The host reads the emitted route-requirements schema first. Current foreground
  work requires v5. Retained v3/v4 examples are historical readback evidence
  only and never authorize a new send. The host never selects transport from
  input size, provider UI, or earlier attempts.
- `bma_researcher_route_requirements.v3` is retained only for exact historical
  readback validation. Its hash remains bound to both route requirements and
  invocation, while its UTF-8 byte count comes from the invocation because v3
  route requirements have no `provider_input_bytes`. It cannot authorize a
  current preflight or send.
- `bma_researcher_route_requirements.v5` requires the prepared hash and byte
  count to match both route requirements and invocation immediately before
  transport. ChatGPT always declares `native_file_upload`; X/Grok alone retains
  bounded `exact_inline_text`.
- Immediately before every supported upload or exact-inline fill capable of
  disclosing prepared bytes, the host invokes `bma-researcher egress-possible`
  and requires success. The immutable owner-private event binds episode, route,
  prepared hash/bytes, and timestamp. Repetition revalidates the same event; it
  grants no send, retry, or attempt authority.
- ChatGPT native upload opens `Add files and more`, requires visible `Upload
  from computer`, pre-arms the `filechooser` wait, and performs one trusted CDP
  `Runtime.evaluate` activation of the exact generic file input with
  `userGesture: true`. The chooser calls `setFiles` once with the absolute exact
  prepared path and records the chooser-selection match only when that path's
  current hash/bytes match the prepared artifact. Exactly one unambiguous
  completed attachment must be visible before the fixed submission instruction
  is placed in the composer and read back exactly. A ChatGPT-generated
  positive-integer duplicate suffix counts as a filename match; unrelated labels
  fail. The chooser-selected exact path and prepared hash/bytes remain the
  independent transport identity.
- V5 deliberately does not require visible attachment byte-size UI. It binds
  the exact local file hash/bytes and path, trusted activation, chooser and
  upload completion, the complete visible attachment-name inventory and count,
  exactly one bounded matching filename, exact composer instruction, absence of
  undeclared text, and absence of `[Truncated]`.
- X/Grok v5 `exact_inline_text` invokes `egress-possible` immediately before
  the exact composer fill, then requires complete composer readback to match
  exact prepared bytes while upload fields are false. Clarification carries no
  transport object and cannot redefine initial transport.
- The v5 transport receipt establishes browser control and host-side
  prepared-artifact consistency only. It does not prove provider attention,
  extraction, semantic use, or report completeness.
- `transport-probe` is a deterministic, non-sensitive, no-send 256 KiB browser
  diagnostic with `send_authorized: false`; it needs no research question and
  must never be sent.
- The pre-send observation is explicit, fresh, same-attempt, and invalidated by
  navigation, reset, handoff, or restart.
- Current preflight is v7 and requires the conservative event to predate the
  initial observation. The event is possible-disclosure evidence, not completed
  transfer, provider work, send, attempt consumption, or retry authority. A
  bypassed or interrupted upload/fill remains `egress_possible`; positive
  evidence may refine only later state. This applies only to browser routes;
  source-native acquisition creates no event, browser observation, preflight,
  or send and binds its exact acquisition directly in capture/package.
- Provider work starts at initial Send activation. One confirmed sleep/wake or
  connectivity break before that point permits one same-route recovery: discard stale handles, enumerate fresh user-owned
  tabs, and revalidate the same account, entitlement, capability, attempt, and
  route. It adds no send or provider retry. Known enabled extension file-URL
  permission remains valid absent a fresh explicit permission-denied error.
  After Send activation, a confirmed break may reacquire the exact already-sent
  conversation and response with fresh user-owned handles after route,
  conversation, and response identity revalidation; that recovery adds no send.
  Capture-v5 alone permits one same-route retry when ChatGPT explicitly reports
  a connectivity interruption, the response cannot resume after recovery, and
  the newest operator authority explicitly requests completion. It binds the
  same prepared bytes/instruction/provider/account/model/route, discloses two
  sends and the fresh-tab/conversation boundary, permits no clarification, and
  requires a completed captured response. Connectivity recovery does not erase
  counted page-control failures.
- Capture repeats origin, conversation, host-local identity-match, entitlement,
  capability, random attempt-alias, and route-specific workflow checks.
- V5 identity evidence contains portable booleans and a fresh random attempt
  alias. Initial native-upload transport additionally carries exact prepared
  hash/byte bindings, the bounded attachment-basename inventory and small
  count, and transport booleans allowed by the executable runtime; v7 preflight
  cross-binds that transport plus the owner-private egress event. Identity evidence
  contains no account handle, cookie, credential, stable identity, DOM,
  screenshot, or other UI text. Capture-v4/v5 additionally permit their bounded,
  route-allowlisted, non-identity `response_completion_marker` enum; it carries
  no handles, hashes, UI text, or stable identifiers.
- Deep Research needs launch-time selection and post-send native workflow proof.
- X Premium+ bookmark work needs private host-local account, Premium+,
  Bookmarks, and integrated-Grok proof.
- After send and any consequential clarification, the producer resumes the
  exact yielded/browser handle and boundedly polls that same response before
  either capture branch. The sole exception is the confirmed post-Send
  connectivity recovery above: once route, conversation, and response identity
  are revalidated, its fresh browser handle becomes the exact continuation
  handle for that already-sent response and is not handle drift.
  Generation-transition-stable requires its exact
  route-specific generation/Stop control observed active then absent, a
  response-specific post-generation action row/control, exact response-subtree
  byte/hash stability across two bounded post-stop polls, and no navigation,
  reset, or handoff. Missing the active transition without the Pro native-export
  marker, timeout, or drift permits no capture or retry; generic UI is
  ineligible.
- Capture-v4/v5 require `workflow.response_complete` true plus an exact route-bound
  `workflow.response_completion_marker`: Deep Research accepts only
  `deep_research_completed_report`; Pro accepts
  `response_specific_native_markdown_export_ready` or
  `chatgpt_pro_generation_transition_stable`; Grok accepts only
  `x_grok_generation_transition_stable`. The Pro native marker requires that
  exact response's post-generation native Markdown export control/result, not a
  generic export/menu. Source-native requires false/null after its separate
  terminal acquisition. Preflight receipts reject both fields. Deep Research
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

- A provider-native report is preserved byte-for-byte when available. A
  `browser_rendered_markdown` artifact is distinctly materialized: exact provider
  response text remains an unchanged prefix and a canonical host-authored URL
  custody ledger follows it. The complete materialized artifact is then
  preserved byte-for-byte and must not be called a provider-native report.
- Native Markdown export is preferred when its response-specific citation
  evidence is complete.
- ChatGPT also permits `browser_rendered_markdown` when native export is absent
  and the current citation carousel cannot satisfy the legacy all-members drawer
  model. Capture exact response-subtree browser `innerText` bytes and exact
  `outerHTML`;
  traverse response-local citation controls and every compound carousel once in
  displayed order; and preserve first-seen exact HTTPS URLs without
  normalization plus the route-specific response-local traversal used to
  produce that list: source-index rows for Deep Research or direct source
  anchors for Pro. In one fixed browser evaluation, clone the response root and
  add the v2 schema marker, current attempt alias, and base64 encodings of the
  exact text, original HTML, ordered URL-list, and route-traversal bytes before
  serializing the response-bound evidence DOM. The materializer derives its
  private component files from that sole current browser artifact. Historical
  v1 evidence DOMs retain exact separately staged text, URL, and traversal files
  for readback compatibility.
  The traversal has only the exact Deep indexed-row array or Pro direct-link
  object defined in `SKILL.md`; the shapes are route-exclusive, indexed rows
  are contiguous from 1 through at most 999, the separately bounded portable
  URL ledger remains at most 100, and direct links are
  in response DOM order. The portable array must equal the first-seen bound
  locators. A raw href may bind to a separately retained portable locator when
  their sole difference is ChatGPT's terminal `utm_source=chatgpt.com` query
  component; neither retained value is rewritten.
  `materialize-browser-rendered-capture` parses that root, rejects a wrong
  attempt or duplicate evidence marker, validates the v2 embedded components,
  retains staged/evidence mismatch rejection for historical v1 inputs, and
  rejects duplicate or invalid URLs, uses a canonical separator plus citation-occurrence and
  `## Response citation URLs` ledgers, derives citations and the portable
  browser occurrence map, keeps all raw inputs owner-private, emits
  a canonical hash-bound materialization receipt and
  `capture-browser-rendered.json`, carries null strict rendered-DOM provenance,
  and makes no native-export, entailment, compound-member-completeness, or
  UI-completeness claim. Its exact text spans are marker candidates; retained
  `innerText` plus HTML does not attest an ambiguous candidate's exact UI role
  or DOM-to-innerText position. Missing source indexes, nonportable attachments, and
  visible `+N` members without retained locators remain explicit partial map
  evidence.
  Current maps use
  `bma_researcher_browser_rendered_citation_occurrence_map.v2`; their
  `unresolved_additional_compound_member_count_lower_bound` counts additional
  source members disclosed by visible `+N` markers. Historical v1 maps preserve
  `unresolved_compound_member_occurrence_lower_bound` and their rendered wording
  during exact readback; v2 evidence cannot downgrade to a v1 map.
  This is producer-declared binding, not browser attestation or proof against
  deliberate fabrication or same-response origin.
  Package re-derives the exact report, citations, and receipt from retained
  inputs, rejects unmaterialized caller captures, and materialization failure
  rolls back only its newly created report/private outputs.
  A pre-emission local validation failure may be corrected in capture-local
  staging and rematerialized against the same completed provider response; this
  does not authorize another provider send. Successful emission remains
  terminal for that materialization path.
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
- A complete native export is preserved in a `bma_researcher_capture.v5` JSON
  file and passed directly to `bma-researcher package --run-dir <private-run>
  --capture <native-capture.json>`; the native branch never calls
  `materialize-capture`.
- A complete `browser_rendered_markdown` capture is likewise passed directly
  to `package` with null strict rendered-DOM provenance fields, but only after
  `materialize-browser-rendered-capture` emits it. It never calls the strict
  `materialize-capture` command and retains exact raw inputs owner-privately.
- Only the strict `rendered_dom_markdown` branch calls `materialize-capture` exactly once
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
