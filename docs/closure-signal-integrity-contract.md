# Closure Signal Integrity Contract

> Version: 1.0
> Date: 2026-06-30
> Owner: repo-agent-core

## Purpose

This contract defines the copy-sync/citation shape for the AS-54
closure-signal-integrity keep-candidate. transcript_processor D1/D2 evidence
showed a `work-close` path exiting `0` while downstream post-audit and scorer
signal degraded. D3 was clean, so the candidate remains evidence-backed but not
graduated.

The signal is a repo-star operating-friction candidate, not a closure authority.
It records when a green work-close exit and later audit/scorer degradation
diverge so the owning repo can route the mismatch to an explicit owner action.

This contract is not a runtime dependency, controller, scheduler, queue, daemon,
registry, retry loop, hidden control plane, automatic issue/PR creator,
auto-merge path, retained closeout package, downstream mutation grant, or
canonical closure truth.

## Receipt/Distribution Shape

Closure-signal integrity receipts should include:

| Field | Required meaning |
|---|---|
| `artifact` | Literal `CLOSURE_SIGNAL_INTEGRITY_RECEIPT`. |
| `schema_version` | Receipt shape version; currently `1`. |
| `source_issue_or_pr` | GitHub issue, PR, or campaign surface that requested the readback. |
| `candidate_id` | `AS-54`. |
| `candidate_disposition` | `keep_candidate`, unless later distinct-repo evidence changes it. |
| `evidence_runs` | D1/D2/D3 or equivalent run identifiers, with per-run repo identity. |
| `work_close_result` | Exit code, command, and surface that claimed closure. |
| `post_audit_signal` | Post-audit status, degraded fields, or clean result. |
| `scorer_signal` | Scorer status, degraded fields, or clean result. |
| `divergence_summary` | Why the closure signal and downstream signal diverged. |
| `distinct_repo_count` | Count of distinct repositories represented by the evidence. |
| `graduation_disposition` | Detector graduation, keep-candidate, true-negative, or insufficient-evidence reason. |
| `validation_scope` | Focused tests/checks that prove the owner repair preserves the signal. |
| `owner_routing` | Exact issue, PR, detector, advisor, or maintainer surface responsible for follow-up. |
| `bounded_non_claims` | Explicit limits on automation, mutation, closure authority, and canonical truth. |

## Validation Rules

1. A positive closure-signal-integrity receipt requires both the closure-side
   result and downstream post-audit or scorer evidence. A `work-close` exit code
   alone is not sufficient.
2. A clean D3-style run does not erase D1/D2 divergence. It records the
   candidate as still bounded by observed evidence.
3. `distinct_repo_count` counts repositories, not repeated runs. Multiple
   transcript_processor runs against one repo do not graduate the detector.
4. `candidate_disposition` must remain `keep_candidate` when evidence is only
   transcript_processor-only one-repo evidence.
5. Receipts must identify the degraded signal fields or explicitly record a
   clean result. Vague "post-audit degraded" claims are insufficient.
6. Owner action must name a concrete GitHub surface or first deliverable; a
   category such as "improve closure" is not admissible.
7. GitHub issue/PR/check/merge truth remains task truth. Local closeout reports,
   work packages, or scorer artifacts are evidence only.
8. Any implementation that creates a controller, scheduler, queue, daemon,
   registry, watcher, retry loop, background sync, automatic issue/PR path, or
   canonical closure ledger violates this contract.

## Bounded Non-Claims

This contract does not:

- graduate AS-54 from one-repo transcript_processor evidence;
- claim D3 clean evidence proves the candidate false;
- replace GitHub issue/PR/check/merge truth;
- make `work-close` output the sole closure signal;
- create issues, create PRs, post comments, merge PRs, or close issues;
- mutate downstream repositories;
- create a controller, scheduler, queue, daemon, registry, retry loop, watcher,
  hidden control plane, automatic updater, background sync, or retained closeout
  package;
- make any local scorecard, report, ledger, or memory surface canonical closure
  truth.

## Owner Routing

- Missing closure-side command evidence routes to the repo that produced the
  work-close or closeout surface.
- Missing post-audit or scorer evidence routes to the scorer/auditor owner
  surface before any detector claim is accepted.
- One-repo-only evidence routes to a keep-candidate issue or recommendation,
  not to graduation.
- If a future detector/advisor is added, its owner surface must carry fixture
  evidence for both the positive divergence and a clean negative case.
- If the owner repair is not patchable, record a GitHub-visible blocker instead
  of generating a speculative patch.

## Copy-Sync Boundary

Consumers may copy-sync this contract or
`templates/closure-signal-integrity.md`, or cite them from detector, advisor,
optimizer, or campaign surfaces. Copy drift is review debt handled by focused
tests and owner review. Do not add a runtime dependency, generated registry,
controller, scheduler, queue, daemon, watcher, retry loop, background sync,
automatic updater, auto-merge path, or downstream mutation path to keep copies
aligned.
