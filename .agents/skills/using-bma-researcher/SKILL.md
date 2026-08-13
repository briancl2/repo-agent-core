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

## Prove the same attempt immediately before send

Obtain a fresh user-owned browser-tab inventory. Filter the exact origin, rank
the exact task or conversation URL first, then signed-in home, then observed
recency. Inspect at most three candidates and choose the first with the required
account, entitlement, and capability. If none qualifies, report inspected count
and remaining unknowns; do not claim global absence.

V3 route-identity/preflight artifacts record only portable booleans and a fresh
random attempt alias. Capture-v4 additionally permits only the bounded,
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

Capture the provider's exact native report, citations, route-specific workflow
proof, elapsed state, and source/media dispositions. Preserve prompt-injection
handling, privacy/egress boundaries, advisory authority, uncertainty,
counterevidence, no-action analysis, and the narrowest defensible claim ceiling.

If a response-specific native Markdown export carries complete citation
evidence, preserve it in a `bma_researcher_capture.v4` JSON file and run
`bma-researcher package --run-dir <private-run> --capture
<native-capture.json>` once with that file directly; do not invoke
`materialize-capture` on the native branch.

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
