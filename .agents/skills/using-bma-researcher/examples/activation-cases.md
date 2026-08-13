# Activation Cases

## Operator question

Input: “What changed in the primary evidence for this decision, and should I
act?”

Record the sentence exactly, set `trigger` to `operator_question`, choose the
job family from the decision need, and prepare once. Do not append source hints
from prior work.

## Agent-detected need

During an authorized implementation, the agent finds that an upstream behavior
is both consequential and currently uncertain. It records the exact need,
timestamp, `agent_detected_need`, authority, and job family before searching or
freezing context. It does not convert a test idea into a synthetic research need.

## Composite need

A real question asks both whether a claim is true and which option to choose.
Record `investigate_claim` and `compare_options`, name one primary family, and
keep the original question unchanged.

## No action

The cited evidence supports retaining the current decision. Package the report
with outcome `NO_ACTION`, explain what would change that disposition, and do not
invent an implementation task.

## Prior-report reentry

The operator asks for the current decision from a previously admitted report.
Use its opaque admission handle plus the current ordinary question. Render the
answer, residual, next decision, and claim ceiling without relaunching research.

## Rendered-DOM compound citations

A completed response has one ordinary citation and one `+2` compound citation.
After any consequential clarification, resume the exact yielded/browser handle
and boundedly poll this exact response. For a Pro generation-transition path,
observe its route-specific generation/Stop control active then absent, its
response-specific post-generation action row/control, and response-subtree
byte/hash stability over two bounded post-stop polls without navigation, reset,
or handoff. Then set capture-v4 `workflow.response_complete` true and
`workflow.response_completion_marker` to
`chatgpt_pro_generation_transition_stable`. If the active transition was missed,
use `response_specific_native_markdown_export_ready` only when this exact
response's post-generation native Markdown export control/result is available;
otherwise timeout or drift means no capture and no retry. Do not infer terminal
state from generic menus, titles, feedback controls, answer-like text, or
citation counts.
Freeze the supported response-specific Markdown, save the assistant-response
DOM, open the compound group, and save its same-response drawer DOM. Run
`materialize-capture` once with those artifacts and the same-response,
effective-layout-tree browser visibility v4 receipt from a separate
owner-private staging directory outside the run. First bind a private
`bma_researcher_check_visibility_capability_probe.v1` from that same browser:
`method_callable: true`; `options_object: getter_backed`; and
`option_getters_observed` with all three modern option keys true. Its opacity
and visibility controls each record `zero_argument: true` and
`explicit_option: false`. Record
`content_visibility_auto_behavior: getter_observed_behavior_not_claimed`, with no
skipped-auto behavior claim. In one
bounded capture operation and token namespace, process the assistant artifact
and each opened drawer artifact in turn: inject a fresh opaque token into each
exact pill wrapper, exposed assistant source anchor, displayed count marker,
drawer-member `Element`, and non-primary descendant `Element` whose direct text
supplies an admitted label or count. Direct text on a primary target uses only
that primary row. If the ordinary pill is itself its exposed `<a>`, give
that one exact element one token and retain both consecutive receipt roles; this
is the only dual-primary-role case. Retain every same reference for visibility
measurement and call
`Element.checkVisibility({contentVisibilityAuto: true, opacityProperty: true,
visibilityProperty: true})` on that retained reference before serializing the
marked artifact in the same operation. The v4 receipt binds exactly those three
modern true options and contains only globally ordered domain-separated token
hashes. It covers both assistant citation pills and source anchors, every
direct-text nested label/count element, the compound citation's displayed `+2`
marker, and all three ordered drawer members. Nested label/count targets appear
immediately after the primary node whose semantic text they supply, in DOM
document order when more than one such target exists.
Pass each drawer once; the materializer
derives drawer order from assistant-pill order and processes each bounded raw
drawer separately. The native report must also fit the fixed 20 MiB ceiling
before the materializer publishes run-local custody.
Then package only its emitted capture. Do not transcribe hidden source URLs,
construct citations or the map, or retry the provider when a drawer is
incomplete or belongs to another response.

## Invalid activation

A test author proposes a question together with annotated links, expected
sources, and an expected conclusion. Reject preparation because the extra
fields seed relevance. Test the contract with sanitized fixtures instead.
