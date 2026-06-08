# Sidecar Prompt A/B Response-Shaped Contract

> Version: 1.0
> Date: 2026-06-08
> Owner: repo-agent-core

## Purpose

This contract defines the shared Prompt A/B shape for manual sidecar review
with ChatGPT Pro, Deep Research, or comparable external advisor surfaces. Use it
when one prompt gathers external or assumption-gap evidence and a later prompt
asks for repo-specific planning, migration advice, or next-track guidance.

The contract prevents a known failure mode: Prompt B is generated before Prompt
A's answer exists, then later treated as if it reconciled actual Prompt A
evidence. Prompt B must be response-shaped unless it is explicitly marked as a
hypothetical draft.

It also prevents the companion operator-burden failure mode: a "prompt kit"
becomes a human-assembled file checklist. Each sidecar turn
should be one complete paste artifact. The repo-side coordinator or tooling owns
evidence assembly, answers sidecar questions from repo/GitHub truth, and
regenerates the next paste-ready bundle.

This is a copy-sync/citation contract and template. It is not a runtime
package, retained report requirement, scheduler, queue, controller, daemon,
hidden registry, watcher, memory import framework, background sync, or
automatic sidecar runner.

## Required Protocol

| Field | Required meaning |
|---|---|
| Sidecar surface | The external advisor surface, model/tool mode, and any source-access mode used. |
| Single-paste invariant | One complete paste artifact per sidecar turn. The prompt must say no additional files are required, and the repo-side coordinator/tooling owns evidence assembly. |
| Prompt A objective | The first prompt asks for assumption gaps, missing evidence, risks, stale claims, and questions the repo-side operator must answer before planning. |
| Prompt A response evidence | The actual Prompt A answer or a durable reference to it. Required before Prompt B can claim reconciliation. |
| Prompt A acceptance check | Why the Prompt A answer is specific enough to feed Prompt B, or why it is rejected and Prompt B is blocked. |
| Prompt B mode | `response-shaped` or `hypothetical-draft`. |
| Prompt B inputs | Exact Prompt A response sections, live GitHub/repo truth, boundaries, and operator corrections used to shape Prompt B. |
| Prompt B reconciliation task | Prompt B must reconcile Prompt A's actual answer against current repo and GitHub truth before recommending owner action. |
| Current-truth check | Prompt B must distinguish live GitHub/repo truth from sidecar advice and stale retained material. |
| Output shape | Prompt B must return one exact owner-surface action, first deliverable/PR shape, validation scope, stop rules, and bounded non-claims. |
| Regrowth boundary | Explicit statement that the protocol did not create automation, retained closure packages, controllers, queues, schedulers, registries, daemons, retry loops, or background memory behavior. |

## Prompt A Rules

Prompt A is assumption-gap first. It should ask the sidecar to find missing
facts, stale assumptions, contradictions, risks, decision blockers, and source
questions. It may ask for candidate directions, but it should not ask the
sidecar to become campaign authority.

Prompt A should request:

- claims that need current repo or GitHub verification;
- assumptions the local coordinator appears to be making;
- missing source or provenance questions;
- where the operator's stated intent conflicts with proposed work;
- what evidence would be needed before Prompt B can safely plan.

Prompt A must be paste-ready for the current sidecar turn:

- it should tell the operator to paste the entire file into the sidecar;
- it should state that no additional files are required;
- it should state that repo-side tooling or the coordinator assembled the
  evidence;
- if the sidecar needs more evidence, it should ask the repo-side coordinator
  or tooling to regenerate a better bundle;
- it must keep report, ledger, transcript, excerpt, and evidence-file assembly
  on the repo-side coordinator/tooling path.

## Prompt B Rules

Prompt B is response-shaped. It may be written only after Prompt A's actual
answer is available unless the prompt is clearly labeled `hypothetical-draft`.
When Prompt B is eventually used in response-shaped mode, the repo-side
coordinator/tooling should embed the actual Prompt A response and any needed
repo/GitHub evidence into one paste-ready Prompt B artifact.

A response-shaped Prompt B must:

1. Quote or summarize the actual Prompt A claims it is reconciling.
2. Separate Prompt A advice from current GitHub/repo truth.
3. Identify which Prompt A claims are accepted, rejected, stale, unsupported, or
   blocked pending owner-surface proof.
4. Choose one exact owner-surface action instead of a category handback.
5. Name the first deliverable or PR shape.
6. Include validation scope and stop rules.
7. Include bounded non-claims.

A hypothetical Prompt B draft must state that it cannot claim reconciliation,
must not be used as campaign direction, and must be regenerated after the
actual Prompt A response exists.

## Output Shape

The sidecar response or repo-side reconciliation should preserve this shape:

- Executive verdict.
- Prompt A claims accepted/rejected/stale/unsupported/blocked.
- Current GitHub/repo truth used.
- One exact owner-surface action.
- First deliverable or PR shape.
- Validation scope.
- Stop rules.
- Bounded non-claims.

## Owner Routing

- Shared protocol gap: repo-agent-core.
- BMA campaign consumption gap: build-meta-analysis.
- Detector gap for repeated sidecar overclaim or Prompt B-before-response
  patterns: repo-auditor, only after the foreground protocol proves the pattern
  is detectable.
- Recommendation packaging gap: repo-upgrade-advisor, only when future advisor
  output needs to recommend sidecar protocol repair.
- Patch/materialization gap: repo-optimizer, only if sidecar protocol output
  becomes patch-pack input.

## Copy-Sync Boundary

Consumers may copy this contract, copy the template, or cite either artifact in
local prompt bundles, issue bodies, PR bodies, or docs. Copy drift is normal
repo-quality debt handled through review. Do not add a runtime dependency,
generated inventory, scheduler, queue, controller, watcher, daemon, hidden
registry, sidecar runner, retry loop, or background sync to keep copies aligned.
