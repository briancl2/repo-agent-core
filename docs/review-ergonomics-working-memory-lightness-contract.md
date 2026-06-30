# Review Ergonomics Working-Memory Lightness Contract

> Version: 1.0
> Date: 2026-06-30
> Owner: repo-agent-core

## Purpose

This contract defines the copy-sync/citation shape for the AS-55
review-ergonomics-working-memory-lightness keep-candidate. transcript_processor
D1/D2/D3 all hit review timeout override and oversized `CURRENT_STATE.md`
friction, making this the strongest recurring signal in the lane. The evidence
is still one-repo evidence, so it remains a keep-candidate rather than a
graduated detector.

The contract preserves the "add lightness" remedy: reduce working-memory load,
split or delete oversized review state, and keep review inputs compact enough to
fit human and automated review. It does not authorize new governance machinery
to manage bloated state.

This contract is not a runtime dependency, controller, scheduler, queue, daemon,
registry, review bot, retry loop, background sync, automatic issue/PR creator,
auto-merge path, downstream mutation grant, or canonical memory surface.

## Receipt/Distribution Shape

Review-ergonomics receipts should include:

| Field | Required meaning |
|---|---|
| `artifact` | Literal `REVIEW_ERGONOMICS_WORKING_MEMORY_LIGHTNESS_RECEIPT`. |
| `schema_version` | Receipt shape version; currently `1`. |
| `source_issue_or_pr` | GitHub issue, PR, or campaign surface that requested the readback. |
| `candidate_id` | `AS-55`. |
| `candidate_disposition` | `keep_candidate`, unless later distinct-repo evidence changes it. |
| `evidence_runs` | D1/D2/D3 or equivalent run identifiers, with per-run repo identity. |
| `review_timeout_override_evidence` | Timeout override command, env, log, or run evidence. |
| `working_memory_surface` | Oversized state file, review prompt, handoff, or equivalent surface. |
| `lightness_remedy` | Concrete deletion, compaction, split, demotion, or review-scope reduction. |
| `distinct_repo_count` | Count of distinct repositories represented by the evidence. |
| `graduation_disposition` | Detector graduation, keep-candidate, or insufficient-evidence reason. |
| `validation_scope` | Focused checks that prove the review surface got lighter and stayed useful. |
| `owner_routing` | Exact issue, PR, detector, advisor, or maintainer surface responsible for follow-up. |
| `bounded_non_claims` | Explicit limits on automation, mutation, canonical memory, and control-plane behavior. |

## Validation Rules

1. A positive AS-55 receipt requires concrete timeout override evidence and a
   concrete working-memory surface. Either one alone is insufficient.
2. `CURRENT_STATE.md` or equivalent state-file evidence must identify why the
   surface is oversized, stale, duplicative, or too costly to review.
3. Remedies should add lightness: delete, compact, demote, split by owner
   surface, reduce review scope, or replace verbose state with a focused
   GitHub-visible pointer. Adding a supervisor, dashboard, controller, queue, or
   scheduler is not a remedy.
4. The receipt must record a validation path that checks the new review surface
   is smaller or more focused while preserving necessary owner context.
5. `distinct_repo_count` counts repositories, not repeated runs. D1/D2/D3 on one
   repo do not graduate the detector.
6. One-repo transcript_processor evidence stays `keep_candidate` even when the
   recurring signal is strong.
7. Owner action must name a concrete GitHub surface or first deliverable; a
   category such as "improve ergonomics" is not admissible.
8. Any implementation that creates a controller, scheduler, queue, daemon,
   registry, watcher, retry loop, background sync, automatic issue/PR path, or
   canonical memory ledger violates this contract.

## Bounded Non-Claims

This contract does not:

- graduate AS-55 from one-repo transcript_processor evidence;
- prescribe a global size cap without repo-local review evidence;
- make `CURRENT_STATE.md` or any review state file canonical memory;
- create a review bot, reviewer assignment system, controller, scheduler, queue,
  daemon, registry, retry loop, watcher, hidden control plane, automatic updater,
  background sync, or retained state package;
- create issues, create PRs, post comments, merge PRs, or close issues;
- mutate downstream repositories;
- replace GitHub issue/PR/check/merge truth.

## Owner Routing

- Missing timeout override evidence routes to the run owner before admission.
- Missing oversized state evidence routes to the repo owner that maintains the
  review or handoff surface.
- Remedies that add governance instead of lightness route back to deletion,
  compaction, demotion, or a GitHub-visible blocker.
- One-repo-only evidence routes to a keep-candidate issue or recommendation,
  not to graduation.
- If a future detector/advisor is approved, it must include positive oversized
  review fixtures and negative compact-review fixtures.

## Copy-Sync Boundary

Consumers may copy-sync this contract or
`templates/review-ergonomics-working-memory-lightness.md`, or cite them from
detector, advisor, optimizer, or campaign surfaces. Copy drift is review debt
handled by focused tests and owner review. Do not add a runtime dependency,
generated registry, controller, scheduler, queue, daemon, watcher, retry loop,
background sync, automatic updater, auto-merge path, or downstream mutation path
to keep copies aligned.
