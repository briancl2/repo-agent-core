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
- The pre-send observation is explicit, fresh, same-attempt, and invalidated by
  navigation, reset, handoff, or restart.
- Capture repeats origin, conversation, host-local identity-match, entitlement,
  capability, random attempt-alias, and route-specific workflow checks.
- Portable receipts contain booleans and random attempt aliases only.
- Deep Research needs launch-time selection and post-send native workflow proof.
- X Premium+ bookmark work needs private host-local account, Premium+,
  Bookmarks, and integrated-Grok proof.

## Result invariants

- The native report is preserved byte-for-byte.
- Citations and source/media dispositions remain inspectable.
- The owner result begins with the answer and decision.
- Structured and Markdown results agree on outcome, adopt/reject/defer,
  evidence, source/product/report status, uncertainty, counterevidence,
  no-action, residual, next decision, and claim ceiling.
- `NO_ACTION` is a valid owner outcome.
- Package state stops at `PACKAGED` until existing Research Brain custody
  succeeds.
- Prior request/result version 2 objects remain readable; migration never
  rewrites their historical bytes.

## Non-claims

Skill discovery and route preflight do not prove provider execution portability,
useful-report admission, natural-run reliability, or release readiness. A
comparator is an experiment, not a route adapter or a natural episode.
