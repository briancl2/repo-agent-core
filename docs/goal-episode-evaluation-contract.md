# Goal Episode Evaluation Contract

> Version: 1.0
> Date: 2026-05-30
> Owner: repo-agent-core

## Purpose

This contract defines the shared language for evaluating Codex Goal-mode
episodes across the repo-agent fleet. It is copy-sync guidance for reports,
issue comments, PR bodies, and fleet-local checks. It is not a runtime package,
service, scheduler, queue, controller, background job, or mandatory dependency.

Use it when a repo claims that Goal mode improved autonomy, delivery throughput,
self-healing, operator steering burden, or foreground coordinator autonomy
acceptance. The evaluation record must separate what actually landed from
local/session-only evidence.

## Required Record

| Field | Required meaning |
|---|---|
| Goal objective | Exact objective passed to Goal mode or the closest retained issue text when the Goal text is unavailable. |
| Coordinator autonomy acceptance verdict | One of `accepted`, `partial`, `rejected`, or `not_applicable`. |
| PRs merged | Count and links for merged PRs in the episode. |
| Repos touched | Repositories with owner-surface mutation, separated from read-only validation targets. |
| Owner PR count | Count of non-BMA owner-surface PRs merged. |
| BMA PR count | Count of BMA PRs merged for orchestration, doctrine, evidence, or campaign sync. |
| Elapsed time | Human-readable elapsed runtime when available. |
| Raw runtime evidence | Session log, Goal receipt, CI run, or command transcript reference when runtime behavior is claimed. |
| Failure issues | GitHub issues created or updated for concrete blockers. |
| Operator interventions | Operator turns that changed scope, route, priority, or permission boundary. |
| Next blocker | One concrete blocker, or `none` when the episode is complete. |
| Next exact owner-surface action | The next issue/PR shape, not a category or request for the operator to choose. |

## Evidence Classes

Evaluation records must classify evidence as one of these classes:

| Evidence class | Use |
|---|---|
| GitHub truth | Issue, PR, commit, check, merge, and closure state. This is canonical for what landed. |
| Repo-native validation | Local or CI checks from the owner repo. This proves gate health, not campaign progress by itself. |
| Raw runtime evidence | Session logs, Goal metadata, command receipts, or replay logs. Required for runtime-health claims. |
| Operator intent | Operator turns or retained issue text that changed priority, scope, or permission boundaries. |
| Local/session-only | Useful diagnostic evidence that does not prove owner-surface delivery. |

## Runtime Health Dimensions

Goal episode evaluation should grade at least these dimensions:

| Dimension | Pass signal |
|---|---|
| Delivery throughput | The episode merged the intended PR sequence or converted a concrete blocker to issue truth. |
| Batch size | The episode delivered a meaningful multi-PR or owner-surface batch, not micro-work. |
| Owner-surface reach | Work landed in the repo that owns the mechanism or repair. |
| Operator steering reduction | The agent selected concrete next actions without handing category choices back to the operator. |
| Self-healing quality | Failures became direct owner-surface repairs or issue truth instead of retrospective-only loops. |
| Runtime health | Raw runtime evidence supports claims about Goal continuity, hangs, recovery, or tool behavior. |
| Ceremony resistance | No new controller, queue, scheduler, local closeout stack, or hidden registry was added. |
| Architecture adoption | The batch increased use of GitHub truth, Codex Goal mode, Hermes foreground attempts when practical, and bounded GBrain memory only when decision-changing. |

## Coordinator Autonomy Acceptance

Coordinator autonomy acceptance is a foreground evidence verdict for a real
episode. It does not promote the coordinator into a background controller or
make any helper tool the primary operator.

Verdict values:

- `accepted`: the episode closed the intended owner-surface route through
  GitHub issue/PR/check/merge truth, and the non-`not_applicable` evidence set
  below is present.
- `partial`: the episode produced useful foreground autonomy evidence, but one
  or more intended owner-surface outcomes, recovery paths, or evidence fields
  stayed incomplete.
- `rejected`: the autonomy claim exceeded the evidence, crossed a forbidden
  control-plane boundary, or lacked an owner action after a blocker.
- `not_applicable`: no coordinator autonomy acceptance claim is being graded.

Any `accepted`, `partial`, or `rejected` verdict must record:

1. GitHub issue/PR/check/merge truth for the work surfaced as accepted,
   partial, or rejected.
2. Raw runtime evidence such as Goal metadata, session logs, command
   transcripts, CI/check runs, replay logs, or the run-root progress ledger.
3. Goal state or Goal-null fallback.
4. `/tmp` run root plus `progress-ledger.jsonl` when the episode used the large
   carrier/runtime harness.
5. Heartbeat capture/disposition, or an explicit unavailable-state fallback
   when heartbeat creation was not available.
6. Bounded non-claims for no background controller, scheduler, queue, daemon,
   registry, auto-merge, automatic issue/PR creation, downstream mutation,
   Hermes-primary ownership, or canonical GBrain memory.
7. Demotion trigger that would downgrade or reject the autonomy claim.
8. Next exact owner-surface action.

Hermes and GBrain evidence may support the verdict only as bounded foreground
doer/advisory memory evidence. GitHub truth, operator intent, and repo evidence
remain higher authority.

## Self-Healing Rule

If the failing owner surface is known, the next repair is that owner surface. Do
not make a retrospective, selector, or doctrine update the primary repair unless
the failure class is unknown, cross-cutting, or already fixed and being evaluated.

When a blocker changes the route, record it as GitHub issue truth with the first
deliverable and validation scope. A retrospective may follow as evaluation, not
as a substitute for the known owner-surface repair.

## Copy-Sync Boundary

Consumers may copy this contract or cite it from repository docs. Drift is a
repo-quality issue. Do not introduce a runtime import, generated registry,
watcher, scheduler, queue, controller, cron job, or background sync to keep
copies aligned.
