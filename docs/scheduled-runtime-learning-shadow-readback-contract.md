# Scheduled Runtime Learning Shadow Readback Contract

This contract defines a portable receipt shape for admitting a scheduled
Runtime Learning Shadow run after the run exists. It is for readback,
comparison, review, and owner routing. It is not a runner, scheduler, queue,
daemon, controller, registry, workflow installer, retained closeout package, or
automatic GitHub issue/PR creator.

The primary consumer is an Issue #164 style scheduled workflow candidate where
`workflow_dispatch` preflight is useful evidence but only an actual
`event=schedule` run can satisfy schedule proof. Comments and artifacts remain
evidence only, not task closure truth; GitHub issue/PR/check/merge truth
remains closure truth.

## Related Contracts

- `docs/foreground-learning-and-recovery-contract.md`
- `docs/foreground-recovery-runtime-contract.md`
- `docs/gbrain-retrieval-citation-lifecycle-contract.md`

Consumers may copy-sync or cite this contract and
`templates/scheduled-runtime-learning-shadow-readback.md`. Do not turn either
file into a runtime dependency, import framework, generated registry, scheduler,
queue, daemon, controller, retry loop, watcher, cron installer, background
GBrain/Hermes behavior, automatic updater, or task-closure authority.

## Required Fields

| Field | Requirement |
| --- | --- |
| `artifact` | Must be `SCHEDULED_RUNTIME_LEARNING_SHADOW_READBACK`. |
| `schema_version` | Contract version for the receipt shape. |
| `source_issue_or_pr` | GitHub issue or PR that requested the readback. |
| `parent_campaign_url` | Parent campaign issue when applicable. |
| `target_issue_url` | Issue receiving the generated evidence comment. |
| `child_issue_url` | Child issue governing the scheduled carrier. |
| `event_name` | Must be `schedule` for schedule proof. |
| `workflow_name` | Workflow display name. |
| `run_id` | GitHub Actions run id. |
| `run_number` | GitHub Actions run number. |
| `run_attempt` | GitHub Actions run attempt. |
| `run_url` | GitHub Actions run URL. |
| `commit_sha` | Commit SHA used by the run. |
| `node24_opt_in` | Boolean proof that JavaScript actions were opted into Node 24 when required. |
| `artifact_name` | Uploaded artifact name; must include Runtime Learning Shadow plus run identity. |
| `artifact_source` | Must identify runner-temp or another non-checkout artifact location. |
| `generated_issue_comment_count` | Must be exactly `1`. |
| `generated_issue_comment_path` | Path or artifact member for the one generated issue comment. |
| `posted_comment_url` | GitHub URL for the posted evidence comment, when available. |
| `git_before` | Object containing head and status before readback generation. |
| `git_after` | Object containing head and status after readback generation. |
| `git_state_preserved` | Must be true for read-only success. |
| `hermes_capture` | Hermes receipt path or no-capture reason. |
| `gbrain_readback` | GBrain slug/evidence path or no-capture reason. |
| `actionability_classification` | One of `actionable`, `blocker`, `clean no-op`, `noisy`, or `failed`. |
| `closure_truth` | Must state that generated comments/artifacts are not closure truth. |
| `promotion_disposition` | The current rung or disposition under review. |
| `four_run_review` | Four-run review criteria and current state. |
| `owner_routing` | Exact owner surface and next action for blockers or follow-up. |
| `bounded_non_claims` | Non-claims for automation, mutation, closure, and background behavior. |

## Admission Rules

A scheduled Runtime Learning Shadow readback is admissible only when:

1. `event_name` is exactly `schedule`.
2. `generated_issue_comment_count` is exactly `1`.
3. `artifact_source` records runner temp or another explicit location outside
   the repository checkout.
4. `artifact_name` includes `Runtime Learning Shadow`, `run_id`,
   `run_number`, and `run_attempt` evidence.
5. `target_issue_url`, `child_issue_url`, `run_id`, `run_number`,
   `run_attempt`, `run_url`, and `commit_sha` are present.
6. `git_before.head == git_after.head`,
   `git_before.status == git_after.status`, and `git_state_preserved` is true.
7. Hermes and GBrain fields each provide a receipt/evidence path or a concrete
   no-capture reason.
8. `closure_truth` explicitly says the comment and artifacts are evidence only, not task closure truth.
9. `bounded_non_claims` forbids downstream mutation, background GBrain/Hermes
   behavior, `hermes -z` adoption, schedulers, queues, daemons, controllers,
   registries, retry loops, auto-merge, and automatic issue/PR creation.

`workflow_dispatch` receipts are useful implementation or smoke evidence, but
they must not satisfy schedule proof.

## Four-Run Review

After four scheduled runs, the review must end in exactly one disposition:

- `keep_with_named_value`
- `reduce_frequency`
- `demote_to_manual_only`
- `repair_specific_failure`

Clean no-op results do not justify retention by themselves. A keep decision
must name the retained value, the evidence supporting it, and the owner surface
that accepts the ongoing burden. A repair decision must name the specific
failure and owner action instead of creating another local proof hunt.

## Owner Routing

- Workflow evidence-path drift or scheduled readback admission gaps route to the
  workflow owner.
- Foreground Hermes failures route through the foreground failure-to-issue
  conversion surface before Codex fallback when they change the route.
- Stale, missing, uncited, or contradictory GBrain evidence routes to the
  GBrain advisory owner surface or a repo-local instruction/citation repair.
- Closure-overclaim, local closeout regrowth, or detector/advisor propagation
  gaps route to repo-auditor, repo-upgrade-advisor, or BMA according to the
  exact failing surface.

## Bounded Non-Claims

This contract does not create a schedule, install a workflow, run a workflow,
post comments, upload artifacts, close issues, merge PRs, mutate downstream
repos, mutate Hermes/GBrain internals, make GBrain canonical, adopt
`hermes -z`, make Hermes the campaign owner, authorize background behavior, or
replace GitHub issue/PR/check/merge truth.
