# Repair Decision-Block Contract

This contract defines a portable copy-sync language for a **repair decision
block** — the assimilation step-8 gate that admits a selection-changing repair
only when it carries a complete six-field decision block, so non-trivial repairs
are justified before work begins. This is guidance for issue bodies, PR bodies,
docs, templates, and retained evaluation records. It is not a runtime package,
schema mandate, generated inventory, scheduler, queue, controller, watcher,
daemon, background sync, automatic updater, registry, or mutation authority.
GitHub issue/PR/check/merge truth remains task truth.

## Related Contracts

- `docs/repo-assimilation-method-contract.md` (the umbrella method this belongs to)
- `docs/benchmark-before-repair-contract.md`
- `docs/maturity-boundary-claim-contract.md`

Consumers may copy-sync or cite this contract and
`templates/repair-decision-block.md`. Do not turn either file into a runtime
dependency, import framework, generated registry, controller, queue, scheduler,
daemon, retry loop, watcher, background poller, automatic updater, or
task-closure authority.

## Required Record

| Field | Required meaning |
| --- | --- |
| `artifact` | Must be `REPAIR_DECISION_BLOCK_RECORD`. |
| `schema_version` | Contract version for the record shape. |
| `outcome` | The operator/repo outcome the repair serves. |
| `failing_observable` | The concrete thing failing today. |
| `rejected_alternatives` | Alternatives considered and rejected, with reasons. |
| `expected_metric` | The metric or observable expected to change. |
| `issue_branch_pr_check_path` | The owner-surface path: issue -> branch -> PR -> checks -> merge. |
| `bounded_non_claim` | What the repair does not prove or authorize. |
| `triggers_decision_block` | Boolean; true for first-in-family, domain, capability, or benchmark-changing work. |
| `record_bounded_non_claims` | Standard envelope non-claims array (the n=2 boundary, no GitHub query/mutation, no controller/scheduler/queue/registry/downstream), distinct from the per-repair `bounded_non_claim` field above. |
| `decision_state` | One of `adopt` / `defer` / `owner-route` / `no-op` / `needs-proof`. |

## Admission Rules

A repair decision-block record is admissible only when:

1. `outcome`, `failing_observable`, `rejected_alternatives`,
   `expected_metric`, `issue_branch_pr_check_path`, and `bounded_non_claim` are
   present for a selection-changing repair.
2. The decision block is required only when `triggers_decision_block` is true:
   first-in-family, domain, capability, or benchmark-changing work. Routine
   hygiene does not require it; avoid ceremony.
3. A repair that does not change selection records `decision_state: "no-op"`.
4. `decision_state` blocks adoption (`needs-proof` or `owner-route`) when any
   of the six decision-block fields is missing for a triggering repair.
5. `bounded_non_claim` separates operating-model progress from domain
   capability, and forbids treating a repair decision as outcome improvement.

## Maturity And Proof

The decision block is a **method** capability, not a controller or closure
surface. Its evidence is currently **n=2**: two by-hand campaigns
(portfolio_advisor and transcript_processor maturation repairs) have exercised
it. That is an n=2 observation, not proven cross-repo doctrine. The decision
block proves selection *justification* — it does **not** prove outcome
improvement. See `docs/maturity-boundary-claim-contract.md`.

## Owner Routing

- A triggering repair missing its decision block routes back to the proposing
  owner issue or PR before adoption.
- Detector or advisor gaps route to repo-auditor (a detector for a missing
  decision block) or repo-upgrade-advisor (a recommendation that packages the
  gap) through their owner issue/branch/PR/check/merge paths.

## Bounded Non-Claims

This contract does not query GitHub, mutate GitHub, create issues, create PRs,
merge PRs, close issues, run a scheduler, start a daemon, create a queue, create
a controller, create a hidden registry, mutate downstream repos, adopt repairs
automatically, or replace GitHub issue/PR/check/merge truth. n=2 is an
observation, not proven doctrine.
