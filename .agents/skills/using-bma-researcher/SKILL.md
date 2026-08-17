---
name: using-bma-researcher
description: >
  Turn an ordinary research need into one cited owner result through BMA's
  stateless prepare, route-preflight, capture-materialization, package, and
  doctor primitives. Use when the operator asks a research question, when an
  agent detects a genuine need for external research, or when a prior admitted
  report needs answer-first reentry. Preserve question-only activation, route
  identity, privacy, source dispositions, uncertainty, counterevidence,
  NO_ACTION, and claim ceilings.
license: MIT
metadata:
  author: briancl2
  version: "1.0"
  category: research
---

# Using BMA Researcher

This skill is a provider-neutral foreground interface to the installed
`bma-researcher` command. It creates no authority, state service, queue,
registry, provider ladder, scheduler, retry loop, daemon, or background work.
The host agent owns the provider interaction and all asynchronous continuation.

## Activate from one genuine need

Use this skill when either:

- the operator asks an ordinary research question; or
- the agent encounters a real decision that needs research and records
  `agent_detected_need` before retrieving context or choosing a route.

The exact ordinary question is the only relevance input. Never add annotated
links, bookmark identifiers, corpus roots, retrieval queries, expected sources,
claims, conclusions, hidden labels, held-out hints, or backfill seeds. Do not
manufacture a question to exercise the route.

Before provider work, record the exact question, UTC timestamp, trigger,
authority, and one job family in a new owner-private run directory. Use one of:

- `answer_question`
- `analyze_decision`
- `compare_options`
- `investigate_claim`
- `monitor_change`
- `synthesize_dossier`

Composite work records every applicable family and one primary family. A prior
admission or dossier may be referenced only by its opaque owner-local handle;
it never replaces the exact current question.

## Use one immutable run directory

Choose an explicit absolute owner-private directory outside Git. Keep every
request, frozen context, route receipt, native capture, package, and custody
receipt for the attempt under that directory. Do not use a shared mutable
current-run path.

Run `bma-researcher prepare` once. It validates the request, freezes installed
context once, freezes trigger/job/state before any provider work, and emits the
exact provider input plus route requirements. If preparation fails, stop; do
not reconstruct an input by hand.

For a declared multi-case validation batch, materialize each immutable request
immediately before that case's one `prepare`; do not timestamp every request at
batch start and then reject later truthful installed snapshots as newer. Freeze
paired route controls from one exact snapshot and require their provider-input
bytes and SHA-256 to match. Case, attempt, and route labels are custody metadata,
not provider relevance input.

## Select one route

Prefer source-native evidence. Use a broader synthesis route only when the
question requires it:

- use authenticated Pro for private, context-rich, source-complete synthesis;
- use Deep Research for open-world currentness, breadth, contradiction, or
  primary-source discovery;
- use authenticated Grok only for bounded X-native deepening, not general
  synthesis.

Default to one initiation, at most one consequential clarification, zero retry,
one provider task, and no provider, account, or model switch. Never treat route
failure as permission to use cookies, scraping, another account, reconstructed
context, or an unapproved browser.

When the operator explicitly confirms the complete declared batch, that is the
action authority for every listed initial send. Do not ask for a redundant
per-attempt confirmation unless the send's content, route, account, provider,
or scope materially departs from that confirmed batch.

## Execute the emitted transport contract

After `prepare`, read the emitted `route-requirements.json` schema first and
branch only on its declared transport. Current foreground work requires
`bma_researcher_route_requirements.v5`; retained v3/v4 examples are historical
readback evidence and never authorize a new send. Re-read the exact run-local
`provider-input.md` immediately before transport. Require its SHA-256 and UTF-8
byte count to match both the invocation and route requirements. Unsupported
schemas, unknown representations, schema drift, or a changed file stop before
preflight or send.

For ChatGPT Pro or Deep Research, v5 always declares
`transport.representation: native_file_upload`. Never bulk-insert prepared
provider-input bytes into the ChatGPT composer and never split them across
multiple inline attempts. Follow
[the ChatGPT browser adapter](references/chatgpt-browser-transport.md): open
`Add files and more`, require the visible `Upload from computer` action,
pre-arm `tab.playwright.waitForEvent("filechooser", {timeoutMs: 10000})`, and
perform one trusted activation of the exact generic file input through the
tab's CDP `Runtime.evaluate` with `userGesture: true`. Await the chooser and call
`setFiles` once with the absolute exact prepared-file path. After exactly one
unambiguous attachment is visibly complete, put only the emitted fixed 59-byte
`submission_instruction` in the composer, require exact readback and enabled
Send. ChatGPT may add a positive-integer duplicate suffix such as
`provider-input(1).md` to the display label. The exact basename and that bounded
suffix both count as a visible filename match; other labels do not. ChatGPT's UI
does not expose a dependable attachment byte-size readback, so v5 binds the local file
hash/bytes, exact selected path, chooser completion, fixed composer instruction,
and absence of undeclared text or `[Truncated]` instead.

The initial ChatGPT `bma_researcher_route_observation.v5` transport object uses
exactly the following field set. An exact-label observation is:

```json
{
  "representation": "native_file_upload",
  "prepared_input_sha256_match": true,
  "prepared_input_bytes_match": true,
  "exact_composer_text_match": true,
  "trusted_file_input_activation_used": true,
  "supported_native_file_chooser_used": true,
  "chooser_selected_prepared_input_match": true,
  "upload_completed": true,
  "visible_file_name_match": true,
  "visible_attachment_names": ["provider-input.md"],
  "visible_attachment_count": 1,
  "undeclared_composer_text_absent": true,
  "truncation_marker_absent": true
}
```

Record the actual visible label in `visible_attachment_names`. When ChatGPT
displays its generated positive-integer duplicate suffix, such as
`provider-input(1).md`, the same exact field set still records
`"visible_file_name_match": true`. Preflight independently requires one name,
count `1`, and the bounded exact-or-suffix matcher. An unrelated label or any
second attachment fails even if the boolean was set true.

X/Grok retains the separate bounded `exact_inline_text` route: the whole
prepared file must match the empty-composer readback exactly, and all upload
booleans remain false. Its exact v5 transport object is:

```json
{
  "representation": "exact_inline_text",
  "prepared_input_sha256_match": true,
  "prepared_input_bytes_match": true,
  "exact_composer_text_match": true,
  "trusted_file_input_activation_used": false,
  "supported_native_file_chooser_used": false,
  "chooser_selected_prepared_input_match": false,
  "upload_completed": false,
  "visible_file_name_match": false,
  "visible_attachment_names": [],
  "visible_attachment_count": 0,
  "undeclared_composer_text_absent": true,
  "truncation_marker_absent": true
}
```

`source_native_exact_bytes` remains a separate terminal
acquisition path. After populating the exact representation-specific
observation, run v5 preflight immediately before the one initiation. A
clarification observation carries no transport object and
cannot redefine initial transport. Any false or missing required boolean,
representation drift, upload error, local-file drift, extra composer text, or
truncation stops before send and does not authorize compaction, retry, a second
send, or a route, account, provider, or model switch.

For no-send diagnosis, `bma-researcher transport-probe --output-dir <new-dir>`
emits one deterministic, non-sensitive 256 KiB fixture and receipt with
`send_authorized: false`. It needs no research question and must never be sent.
The v5 receipt proves browser control and prepared-artifact consistency only;
it does not prove provider attention, extraction, semantic use, or report
completeness.

## Prove the same attempt immediately before send

Obtain a fresh user-owned browser-tab inventory. Filter the exact origin, rank
the exact task or conversation URL first, then signed-in home, then observed
recency. Inspect at most three candidates and choose the first with the required
account, entitlement, and capability. If none qualifies, report inspected count
and remaining unknowns; do not claim global absence.

V5 identity evidence records portable booleans and a fresh random attempt alias;
initial native-upload transport/preflight additionally carries the exact prepared
hash/byte bindings, bounded attachment-basename inventory and small count, and
transport booleans allowed by the executable runtime.
It carries no account handle, cookie, credential, stable identity, DOM, or
screenshot and no other UI text. Capture-v4 additionally permits only the bounded,
route-allowlisted, non-identity `response_completion_marker` enum below; it
carries no handles, hashes, UI text, or stable identifiers. Cookies, credential
data, DOM, screenshots, and private account state remain host-local. Navigation,
reset, handoff, or restart invalidates the observation.

Immediately before send, run `bma-researcher preflight-check` with the explicit
same-attempt observation. This checks receipt consistency; it does not make
browser observation and send atomic. Recheck the same tab at capture. Package
must fail on origin, conversation, host-local identity, entitlement, capability,
attempt-alias, or required workflow drift.

For X Premium+ bookmark work, host-local evidence must establish the approved
operator account, Premium+, Bookmarks, and integrated Grok. For actual Deep
Research, literally select `+` then `Deep research`, preserve pre-send
selection, and require post-send plan/progress/completed-report evidence.

After two repeated page-control failures, stop. Resume a yielded tool call by
its exact cell identifier and a PTY by its exact session until terminal; never
settle an attempt while either is outstanding.

After the send and optional consequential clarification, resume the exact
yielded/browser handle and boundedly poll that same response before choosing a
capture branch. A generation-transition-stable marker requires the exact
response's route-specific generation/Stop control observed active then absent,
a response-specific post-generation action row/control, exact response-subtree
byte/hash stability across two bounded post-stop polls, and no navigation,
reset, or handoff. Pro records `chatgpt_pro_generation_transition_stable`, or
`response_specific_native_markdown_export_ready` only when that exact response's
native Markdown export control/result is available after generation, not from a
generic export/menu. Grok records `x_grok_generation_transition_stable`; Deep
Research records `deep_research_completed_report` and independently requires
plan/activity/completed-report evidence. If the active transition was missed
and no Pro native-export marker exists, or on timeout/handle/response drift,
stop with no capture and no retry. Generic menus, titles, feedback controls,
answer-like text, and citation counts are insufficient. Capture-v4 requires
`workflow.response_complete` true plus the exact route-bound
`workflow.response_completion_marker`; source-native records false/null after
its separate terminal acquisition. Preflight-v3 has neither field. This is
producer-declared same-attempt evidence, not browser attestation, UI-stability,
or semantic-completeness proof. The exact `RESPONSE_COMPLETION_MARKERS` allowlist
is `chatgpt_deep_research -> {deep_research_completed_report}`,
`chatgpt_pro -> {response_specific_native_markdown_export_ready,
chatgpt_pro_generation_transition_stable}`, `x_grok ->
{x_grok_generation_transition_stable}`, and `source_native -> {null}` with
`response_complete: false`. Missing, cross-route, or non-allowlisted markers
fail before materialization or package publication.

## Capture and package without rewriting

Capture the provider's exact native report when that route exposes one. The
browser-rendered fallback instead creates a distinctly labeled materialized
report whose exact provider response text is an unchanged prefix and whose URL
ledger is deterministic host-authored custody data. Capture citations,
route-specific workflow proof, elapsed state, and source/media dispositions. Preserve prompt-injection
handling, privacy/egress boundaries, advisory authority, uncertainty,
counterevidence, no-action analysis, and the narrowest defensible claim ceiling.

If a response-specific native Markdown export carries complete citation
evidence, preserve it in a `bma_researcher_capture.v4` JSON file and run
`bma-researcher package --run-dir <private-run> --capture
<native-capture.json>` once with that file directly; do not invoke
`materialize-capture` on the native branch.

When ChatGPT exposes no response-specific native export and its current
compound-citation carousel cannot satisfy the legacy all-members-at-once drawer
model, use `browser_rendered_markdown`. From the exact completed assistant
response subtree, save Playwright's response-specific browser `innerText` bytes
without clipboard or manual reconstruction and save its exact `outerHTML`.
Enumerate response-local citation controls in DOM order, traverse every current
compound carousel once in displayed order, and save a JSON array of first-seen
exact HTTPS URLs without normalization. Also retain the route-specific
response-local traversal used to produce that URL list: source-index rows for
Deep Research or direct source anchors for Pro. In one fixed browser evaluation, clone
the exact response root and set these five attributes on the clone before
serializing its `outerHTML` as the response-bound browser evidence DOM:

- `data-bma-researcher-browser-rendered-dom-evidence="bma_researcher_browser_rendered_dom_evidence.v1"`
- `data-bma-researcher-attempt-alias="<current attempt alias>"`
- `data-bma-response-inner-text-base64="<base64 exact staged innerText bytes>"`
- `data-bma-ordered-citation-urls-json-base64="<base64 exact staged URL-JSON bytes>"`
- `data-bma-original-response-outer-html-base64="<base64 exact original response outerHTML bytes>"`

Discard the clone after serialization. The runtime parses the retained response
root, requires its current attempt alias, and rejects separately staged text or
URL bytes that differ or duplicate evidence markers. This is producer-declared
response binding, not browser attestation or proof against deliberate
fabrication. Run once per capture-local
materialization attempt:

The traversal JSON is collected in that same fixed response-root evaluation and
has one of these two exact shapes; do not add fields or synthesize missing rows:

```json
[
  {"index": 1, "urls": ["https://example.com/source"], "text": "Displayed source row"},
  {"index": 2, "urls": [], "text": "Displayed attachment row"}
]
```

This indexed form is accepted only for Deep Research.
Rows are the completed response's displayed source-index rows in order;
`index` is contiguous from 1, `text` is the exact nonempty displayed row text,
and `urls` contains that row's unique exact HTTPS hrefs in displayed order.
Use an empty `urls` array only when the visible row is a nonportable attachment.
The first-seen portable URLs across all rows must equal the separately retained
ordered URL array.

```json
{
  "conversation_url": "https://chatgpt.com/c/example",
  "links": [
    {"href": "https://example.com/source", "text": "Example Source"}
  ],
  "portable_urls": ["https://example.com/source"]
}
```

This direct-link form is accepted only for Pro. `conversation_url` is the exact
claimed ChatGPT conversation URL; `links` contains every response-local source
anchor in DOM order with its exact href and nonempty displayed text; and
`portable_urls` is byte-for-byte the ordered URL-array value. Collection may
expose a raw anchor href whose only difference from its separately surfaced
portable locator is a terminal `utm_source=chatgpt.com` query component. The
materializer may regard that exact pair as equivalent for binding, but it does
not rewrite either retained value. In both forms, enumerate only descendants of
the exact completed response root and traverse each compound control once.
Direct-link `links` preserves duplicate anchor occurrences; indexed rows require
unique URLs within each row but preserve repeated URLs across different rows.
Build the portable array in first-seen order during collection and do not edit
either retained file afterward.

```text
bma-researcher materialize-browser-rendered-capture \
  --run-dir <private-run> \
  --capture <citation-free-draft> \
  --response-text <exact-inner-text> \
  --citation-urls <ordered-url-json> \
  --citation-traversal <response-local-traversal-json> \
  --assistant-dom <response-bound-browser-evidence-dom>
```

The command rejects duplicate or invalid URLs, preserves the exact provider
response text as an unchanged prefix, and appends one canonical host-authored
portable citation-occurrence map plus `## Response citation URLs` custody list,
derives portable citation rows from the retained response DOM and traversal, retains all four inputs and embedded
exact response `outerHTML` owner-privately, and
emits a hash-bound materialization receipt plus
`capture-browser-rendered.json`. Pass only that emitted capture directly
to `package`; its strict `rendered_dom_provenance` remains null and its separate
browser citation-occurrence map is portable. Deep Research maps exact numbered
marker-candidate spans to retained source-index rows; Pro maps exact line-bounded
marker candidates to response-local ChatGPT source anchors with matching
`href`/`alt`, `_blank` target, and `noopener` relation. Missing source indexes, nonportable
attachments, and visible `+N` members without retained locators remain explicit
partial evidence. The resulting report is a materialized browser capture, not an exact
provider-native report or native export; it must not be hand-edited and proves neither
citation entailment, compound-member completeness, nor UI completeness. Retained
`innerText` and HTML also do not attest an ambiguous candidate's exact UI role
or DOM-to-innerText position; route identity, completion, exact
report bytes, unique portable locators, and semantic usefulness still gate
admission. Packaging re-derives report and citation bytes from the retained
private inputs and rejects a direct caller-authored capture. A failed
materialization removes only its newly created report/private outputs before a
corrected capture proceeds. If local validation rejects the staged capture
before successful emission, correct only that capture-local staging and rerun
this command against the same completed provider response; this is not a
provider retry. Never rerun it after successful emission.

Otherwise, use rendered-DOM capture: stage the exact assistant-response DOM,
every response-local compound drawer, the visibility receipt, and a
citation-free capture draft in a separate owner-private staging directory
outside the run. Open every compound citation group in that same response and
save one drawer DOM for every group. The materializer creates the final
immutable run-local capture directory. Never put raw DOM, drawer, or receipt
bytes in the portable package or Research Brain.

At the same live-response capture, preserve the one
`bma_researcher_rendered_visibility.v4` browser receipt required by
`materialize-capture`. Use one bounded capture operation and one capture-local
opaque-token namespace. For the assistant artifact and each opened drawer
artifact in turn, inject a fresh `data-bma-visibility-node` token into every
exact retained pill wrapper, exposed assistant source anchor, displayed
compound-count marker, drawer-member `Element`, and exact non-primary descendant
`Element` whose direct text supplies an admitted label or count; retain that exact
element reference for token injection and visibility measurement, then
serialize the marked artifact in the same bounded operation. A pill that is
itself the exposed `<a>` is the sole allowed dual primary role: use one token
and retain both ordered pill and assistant-anchor receipt entries. The receipt
preserves global target order. Each retained pill has exactly one exposed
assistant source `<a>`—the pill itself or exactly one descendant—whose label
and locator supply that pill's citation. For each assistant pill in DOM order,
receipt order is its
wrapper, exposed source anchor, direct-text nested label elements in DOM
document order, displayed count marker and its direct-text nested count elements
in DOM document order when present, then its drawer members in displayed order
and each member's direct-text nested label elements in DOM document order before
the next pill. Direct text on a primary pill, anchor, count marker, or
drawer member is covered by that primary node's row, not a duplicate nested row.
The receipt binds case,
attempt, opaque aliases, private response-identity hash, assistant hash,
assistant-pill-ordered drawer hashes, and ordered domain-separated node-token
hashes. It exposes no raw token. Each retained element must have a true browser
`Element.checkVisibility({contentVisibilityAuto: true, opacityProperty: true,
visibilityProperty: true})` result using exactly those three modern options,
plus non-`none` computed display, visible visibility, positive opacity,
a connected node, a client rect, and a nonzero rendered box. Static HTML
attributes or class names alone do not prove visibility. A visible wrapper
cannot substitute for a computed-hidden exposed source anchor.

Before creating a v4 receipt, run and bind one private same-browser
`bma_researcher_check_visibility_capability_probe.v1`. Require a callable
method as `method_callable: true`, `options_object: getter_backed`, and
`option_getters_observed` with all three modern option keys exactly true.
Require `opacity_property_control` and `visibility_property_control` each to
record `zero_argument: true` and `explicit_option: false`. Record
`content_visibility_auto_behavior: getter_observed_behavior_not_claimed`; no
deterministic skipped-auto behavior is claimed. Missing, false, unread, or
drifted probe evidence stops capture. This receipt is evidence, not browser
attestation or proof of producer honesty.

For this rendered-DOM branch, invoke `bma-researcher materialize-capture`
exactly once with the citation-free capture draft, assistant DOM, drawer paths,
and the receipt through `--visibility-receipt`. Caller drawer order is not
evidence: the operation derives drawer custody and receipt order from
assistant-pill order. It applies the 10 MiB receipt bound before JSON decoding
and a 20 MiB bound to each assistant/drawer artifact before hashing or parsing.
It enforces the native report's fixed 20 MiB byte ceiling before materialization
or package read. Drawer inventory retains only path, hash, and byte-count
records; the operation verifies, parses, and copies one bounded drawer at a
time instead of retaining every raw drawer simultaneously. It
parses citation groups and sources, requires one private response identity
across every artifact, requires every admitted pill and drawer source to
descend from that artifact's exact response-identity element, preserves
entity-aware exact byte bindings, and emits the complete v4 capture plus
derived ordered citations and a
`bma_researcher_citation_source_map.v4` map with
`rendered-dom-extractor.v2`. That
map carries `visibility_verified: true`, receipt and element-identity schema
names, and the receipt hash for visibility proof; raw tokens, the receipt, and
stable response identity remain private. `package` emits the
citation ledger from that materialized capture. Never hand-author citation
groups, citations, drawer receipts, visibility evidence, byte offsets,
locators, hashes, or the source map. Missing, reordered, cross-response,
computed-hidden, hidden-only, extra, or unbound sources are terminal capture
failures; do not backfill URLs or rewrite the report.

Materialization refuses pre-existing run-local capture or output paths. If
publication fails after creating its private capture, it removes only that
attempt-owned directory and partial materialized output; it never overwrites or
deletes a pre-existing conflict.

The v4 bridge binds the producer's measured inventory to exact serialized
nodes. It is not browser attestation and does not prove producer honesty,
viewport intersection, unclipped pixels, z-order, or absence of occlusion.

For this rendered-DOM branch, run `bma-researcher package` only with the
`capture-materialized.json` emitted by that one invocation. It independently
re-derives the rendered-DOM map from the immutable private artifacts, validates
request/result/route consistency,
capture, citations, privacy, native-report identity, and answer-first reentry.
It writes:

- `report.md`, byte-identical to the native captured report;
- `owner-result.md`, beginning with the answer and owner decision;
- a structured outcome carrying adopt/reject/defer, evidence, source/product/
  report status, uncertainty, counterevidence, no-action, residual, next
  decision, and claim ceiling; and
- `reentry.md`, sufficient for a later owner decision without replaying the run.

Packaging stops at `PACKAGED`. Only the existing Research Brain custody route
may advance it to admitted custody. A useful report can remain owner-admitted
while product health is partial; report, product, and custody states are
separate claims.

For rendered-DOM custody, use Research Brain report-bundle manifest schema
version 2 and embed the exact packaged
`bma_researcher_citation_source_map.v4` object plus its package SHA-256. These
are distinct schema revisions: the report-bundle manifest is not the citation
source map. The report and manifest remain the exact two committed/read-back
files. Never copy raw assistant DOM, drawer, visibility-receipt, or private
response-identity bytes into that bundle. Report-bundle manifest version 1 and
citation-source-map v1/v2/v3 are historical verify-only; none authorizes a new
rendered admission. Exact known `bma_researcher_invocation.v2`,
`bma_researcher_result.v2`, and
`bma_researcher_subscription_route_receipt.v2` bytes remain readable through
BMA's retained validators/integrator. The retained integrator accepts generic
`bma_researcher_subscription_route_receipt.v1` only for an already settled case
retained solely for historical readback whose exact case and receipt hash are
allowlisted; it cannot authorize a new foreground packet. Extractor v2 and
`bma_researcher_rendered_visibility_node_token.v1` remain current because the
parsing and exact-element identity algorithms did not change.

If research shows no owner action is warranted, return `NO_ACTION` with the
evidence and decision boundary. Never turn an advisory result into an external
mutation without specific owner authority.

## Reenter or diagnose

For prior-report reentry, provide the prior-admission or dossier handle and the
current question. Render the prior answer first, followed by current residual,
next decision, and claim ceiling. Do not silently relaunch research.

Use `bma-researcher doctor` for read-only validation of installed skill,
runtime, source, route, and custody prerequisites. A healthy doctor result is
prerequisite evidence, not execution-portability or release proof.

Skill discovery and route preflight do not prove provider execution
portability, useful-report admission, natural-run reliability, or release
readiness.

See [the contract reference](references/researcher-contract.md) for the portable
request and route invariants and [the examples](examples/activation-cases.md)
for compliant activation boundaries.
