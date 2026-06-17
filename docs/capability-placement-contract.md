# Capability Placement Contract

This contract defines a portable Autonomy Preview record for routing high-
priority owner-surface work before a carrier launches. It is for capability
placement, promotion/demotion evidence, and owner routing. It is not a
dashboard, registry, central ledger, scheduler, queue, daemon, controller,
runtime dependency, generated inventory, background memory process, automatic
GitHub issue/PR creator, auto-merge path, or Codex cloud/background write
authority.

The primary consumer is an Issue #164 style carrier where GitHub remains
canonical work truth, Codex/BMA is the foreground coordinator, Hermes may be a
bounded foreground doer when separately authorized, GBrain is advisory exact
readback memory, and repo-star repos own reusable contracts, detectors,
advisors, and compactness checks after proof.

The human-facing Autonomy Preview names best current owner, best future owner,
allowed reach now, native signal, promotion gate, demotion/rejection trigger,
kill switch, forbidden mode, GBrain slug/no-capture reason, and the routing
use before the carrier launches.

## Related Contracts

- `docs/core-five-owner-surface-contract.md`
- `docs/default-capability-reconciliation-contract.md`
- `docs/foreground-learning-and-recovery-contract.md`
- `docs/gbrain-retrieval-citation-lifecycle-contract.md`

Consumers may copy-sync or cite this contract and
`templates/capability-placement.md`. Do not turn either file into a runtime
dependency, schema mandate, generated registry, dashboard, scheduler, queue,
daemon, controller, retry loop, watcher, cron installer, background
GBrain/Hermes behavior, automatic updater, automatic issue/PR creator,
auto-merge path, or task-closure authority.

## Required Fields

| Field | Requirement |
| --- | --- |
| `artifact` | Must be `CAPABILITY_PLACEMENT_PREVIEW`. |
| `schema_version` | Contract version for the preview shape. |
| `source_issue_or_pr` | GitHub issue or PR requesting the placement decision. |
| `parent_campaign_url` | Parent campaign issue when applicable. |
| `carrier_child_url` | Child issue or owner issue governing the carrier. |
| `advisory_status` | Must be `advisory`. |
| `best_current_owner` | Best owner for the work now, such as Codex/BMA, repo-agent-core, repo-auditor, repo-upgrade-advisor, repo-optimizer, Hermes, GBrain, or GitHub-native truth. |
| `best_future_owner` | Desired owner after proof or adoption. |
| `local_remote` | Local, remote, or split placement, with the reason. |
| `foreground_scheduled` | Foreground, scheduled, or split placement, with the reason. |
| `allowed_reach_now` | Current permitted reach, including read-only, comments, branch/PR mutation, or no mutation. |
| `native_signal` | Native evidence source that proves or rejects value, such as an issue, PR, check, merge, comment, artifact, exact GBrain slug, or Hermes receipt. |
| `promotion_gate` | Evidence required before the capability can move up the autonomy ladder. |
| `demotion_rejection_trigger` | Condition that shrinks, parks, or rejects the capability. |
| `kill_switch` | Exact way to stop, remove, or demote the mechanism. |
| `why_not_alternatives` | Why labels, dashboards, registries, background automation, or other alternatives are not the right owner now. |
| `operator_value_hypothesis` | Concrete operator value expected if the placement is right. |
| `forbidden_mode` | Explicit forbidden expansion modes. |
| `gbrain_slug_or_no_capture_reason` | Exact advisory GBrain slug if memory changed the route, otherwise a no-capture reason. |
| `routing_use` | How the placement changed owner selection, reach, promotion, demotion, or launch shape. |
| `bounded_non_claims` | Non-claims for automation, authority, mutation, and closure truth. |

## Admission Rules

A capability-placement preview is useful only when it changes or materially
confirms a live route. It is admissible when:

1. `advisory_status` is exactly `advisory`.
2. Every required placement field is present.
3. `allowed_reach_now` is narrower than or equal to the approved owner issue or
   PR scope.
4. `native_signal` names GitHub issue/PR/check/merge truth, a bounded Hermes
   receipt, an exact GBrain readback, or an explicit no-capture reason.
5. `promotion_gate` and `demotion_rejection_trigger` are both concrete enough
   that a later owner can accept, reject, shrink, or park the mechanism.
6. `kill_switch` names the owner surface and action that can stop the mechanism.
7. `routing_use` says how the fields affected owner choice, current reach,
   foreground/scheduled placement, promotion, demotion, or rejection.
8. `bounded_non_claims` forbids controllers, schedulers, queues, daemons,
   registries, dashboards, central autonomy ledgers, hidden state stores,
   background Hermes/GBrain behavior, automatic issue/PR creation, auto-merge,
   Codex cloud/background write authority, downstream mutation, and replacement
   closure truth.

If the fields become boilerplate, do not create another validation surface.
Shrink the fields, reject the placement, or route the problem to the owner
surface that can delete or demote the noise.

## Owner Routing

- `repo-agent-core` owns this portable contract and template.
- `repo-auditor` may detect missing, vague, over-broad, or forbidden placement
  fields.
- `repo-upgrade-advisor` may recommend concrete owner, reach, promotion, and
  demotion fixes from detector findings.
- `repo-optimizer` may add compactness/noise checks only after detector or
  advisor output proves boilerplate risk.
- BMA or another owner repo uses the contract by citation or copy-sync on the
  GitHub issue/PR surface; it does not import this repo at runtime.

## Bounded Non-Claims

This contract does not select work, create issues, create PRs, post comments,
merge PRs, close issues, run Hermes, run GBrain, install a workflow, start a
schedule, start a daemon, authorize background behavior, mutate downstream
repos, make GBrain canonical, make Hermes the campaign owner, or replace GitHub
issue/PR/check/merge truth.
