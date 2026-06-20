# Scheduled Readback Owner Proof Contract

This contract defines a portable owner-proof shape for deciding whether a
read-only scheduled readback candidate has admissible scheduled evidence. It is
for foreground review, owner routing, and copy-sync/citation into BMA or
repo-star surfaces. It is not a runner, scheduler, queue, daemon, controller,
registry, workflow installer, issue creator, auto-merge path, or task-closure
authority.

The stable artifact token is `SCHEDULED_READBACK_OWNER_PROOF`.

## Related Contracts

- `docs/scheduled-runtime-learning-shadow-readback-contract.md`
- `docs/foreground-learning-and-recovery-contract.md`
- `docs/repo-star-closure-runtime-distribution-contract.md`

Consumers may copy-sync or cite this contract and
`templates/scheduled-readback-owner-proof.md`. Do not turn either file into a
runtime dependency, workflow runner, generated registry, scheduler, queue,
daemon, controller, retry loop, watcher, cron installer, background
GBrain/Hermes behavior, automatic GitHub issue/PR mutation, auto-merge path,
or task-closure authority.

## Required Fields

| Field | Requirement |
| --- | --- |
| `artifact` | Must be `SCHEDULED_READBACK_OWNER_PROOF`. |
| `schema_version` | Contract version for the owner-proof shape. |
| `source_issue_or_pr` | GitHub issue or PR that requested the proof. |
| `parent_campaign_url` | Parent campaign issue when applicable. |
| `owner_issue_url` | Owner issue governing the scheduled-readback candidate. |
| `candidate_id` | Stable candidate identifier, such as `runtime_shadow_schedule_readback`. |
| `schedule_source` | Workflow, cron, or other schedule source being read back. |
| `allowed_event` | Must be `schedule` for scheduled proof. |
| `event_filter` | Explicit accepted/rejected event policy. |
| `cadence` | Expected cadence, as-of time, latest scheduled age, and stale threshold. |
| `evidence_fields` | Required fields from the workflow/run/readback evidence. |
| `admission_disposition` | `admit_candidate`, `blocked_no_new_scheduled_run`, `blocked_already_admitted`, `blocked_stale`, or `blocked_failed_run`. |
| `blocker_rule` | Exact rule that turns missing or stale evidence into a GitHub-visible blocker. |
| `promotion_gate` | Evidence required before the candidate can move up the automation ladder. |
| `demotion_trigger` | Evidence that demotes or rejects the scheduled-readback candidate. |
| `kill_switch` | Operator or owner-surface action that stops promotion. |
| `github_truth` | Statement that GitHub issue/PR/check/merge truth remains closure truth. |
| `bounded_non_claims` | Non-claims for automation, mutation, closure, and background behavior. |

## Event Boundary

`workflow_dispatch` can be implementation or smoke evidence, but it must never
count as scheduled proof. Scheduled proof requires an actual `event=schedule`
run or a deterministic fixture that explicitly verifies only `schedule` is an
accepted scheduled event.

A proof that sees only `workflow_dispatch`, `push`, `pull_request`, or other
non-schedule events must produce a blocked or non-admission disposition and name
the next owner action.

## Admission Rules

A scheduled-readback owner proof is admissible only when:

1. `owner_issue_url`, `candidate_id`, `schedule_source`, `allowed_event`,
   `cadence`, `event_filter`, and `blocker_rule` are present.
2. `allowed_event` is exactly `schedule`.
3. `event_filter.workflow_dispatch_counts_as_scheduled` is false.
4. `evidence_fields` name the run id, event, status, conclusion, created time,
   run URL, and commit/head SHA expected from the readback source.
5. `admission_disposition` is one of the allowed values and explains the
   candidate or non-admission reason.
6. Stale cadence, missing scheduled evidence, failed scheduled runs, or
   already-admitted scheduled runs route to a concrete owner action.
7. `promotion_gate`, `demotion_trigger`, and `kill_switch` are explicit.
8. `github_truth` preserves GitHub issue/PR/check/merge truth as closure truth.
9. `bounded_non_claims` forbid private/raw capture, downstream mutation,
   background GBrain/Hermes behavior, schedulers, queues, daemons, controllers,
   registries, retry loops, auto-merge, and automatic issue/PR mutation.

## Owner Routing

- Missing owner issue, cadence, event filter, blocker rule, promotion gate, or
  bounded non-claims route to the contract owner.
- `workflow_dispatch`-as-proof, stale scheduled evidence, or failed scheduled
  readback evidence routes to the workflow or BMA owner issue.
- Detector gaps route to repo-auditor.
- Recommendation packaging gaps route to repo-upgrade-advisor.

## Bounded Non-Claims

This contract does not create a schedule, install a workflow, run a workflow,
post comments, upload artifacts, close issues, merge PRs, mutate downstream
repos, mutate Hermes/GBrain internals, make GBrain canonical, make Hermes the
campaign owner, authorize private/raw capture, authorize background behavior,
or replace GitHub issue/PR/check/merge truth.
