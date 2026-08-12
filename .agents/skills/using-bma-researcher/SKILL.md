---
name: using-bma-researcher
description: >
  Turn an ordinary research need into one cited owner result through BMA's
  stateless prepare, route-preflight, package, and doctor primitives. Use when
  the operator asks a research question, when an agent detects a genuine need
  for external research, or when a prior admitted report needs answer-first
  reentry. Preserve question-only activation, route identity, privacy, source
  dispositions, uncertainty, counterevidence, NO_ACTION, and claim ceilings.
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

Record only portable booleans and a fresh random attempt alias. Stable account
handles, cookies, credential data, DOM, screenshots, and private account state
remain host-local. Navigation, reset, handoff, or restart invalidates the
observation.

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

## Capture and package without rewriting

Capture the provider's exact native report, citations, route-specific workflow
proof, elapsed state, and source/media dispositions. Preserve prompt-injection
handling, privacy/egress boundaries, advisory authority, uncertainty,
counterevidence, no-action analysis, and the narrowest defensible claim ceiling.

Run `bma-researcher package`. It validates request/result/route consistency,
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
