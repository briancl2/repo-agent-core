# Benchmark-Before-Repair Contract

This contract defines a portable copy-sync language for
**benchmark-before-repair** — the assimilation step-4 discipline that defines
benchmark and scoring dimensions before selecting repairs, so repair selection
is benchmark-driven rather than warning-driven or byte-driven.

This is guidance for issue bodies, PR bodies, docs, templates, and retained
evaluation records. It is not a runtime package, schema mandate, generated
inventory, scheduler, queue, controller, watcher, daemon, background sync,
automatic updater, registry, or mutation authority. GitHub issue/PR/check/merge
truth remains task truth.

## Related Contracts

- `docs/repo-assimilation-method-contract.md` (the umbrella method this anchors)
- `docs/principle-alignment-anchor-contract.md`
- `docs/repair-decision-block-contract.md`

Consumers may copy-sync or cite this contract and
`templates/benchmark-before-repair.md`. Do not turn either file into a runtime
dependency, import framework, generated registry, controller, queue, scheduler,
daemon, retry loop, watcher, background poller, automatic updater, or
task-closure authority.

## Required Record

| Field | Required meaning |
| --- | --- |
| `artifact` | Must be `BENCHMARK_BEFORE_REPAIR_RECORD`. |
| `schema_version` | Contract version for the record shape. |
| `benchmark_dimensions` | The benchmark/scoring dimensions, defined before any repair was selected. |
| `defined_before_selection` | Boolean; true only when the dimensions predate repair selection. |
| `repair_candidates` | Candidate repairs compared against the benchmark dimensions. |
| `selected_repair` | The repair selected by the benchmark dimensions. |
| `rejected_repairs` | Repairs rejected or deferred because the benchmark dimensions ranked them lower or made them inadmissible. |
| `selection_changed` | Boolean; TRUE only when the benchmark changed which repair was selected or rejected — the portable test. |
| `before_after_delta` | The measured delta, or `pending` when report-only. |
| `decision_state` | One of `adopt` / `defer` / `owner-route` / `no-op` / `needs-proof`. |
| `bounded_non_claims` | What the benchmark did not prove, mutate, adopt, or authorize. |

## Admission Rules

A benchmark-before-repair record is admissible only when:

1. `benchmark_dimensions` are present and `defined_before_selection` is true.
2. The record is only useful when `selection_changed` is true. A benchmark that
   did not change selection is ceremony; record `no-op` or `needs-proof`.
3. Raw warning-count or byte-count reductions are not benchmark-driven repair
   selection and must not be claimed as such.
4. `before_after_delta` may be `pending` in a report-only sweep, but a capability
   claim requires a real measured delta.
5. `decision_state` blocks adoption (`needs-proof` or `owner-route`) when
   dimensions are missing or selection did not change.
6. `bounded_non_claims` forbid treating the benchmark as a controller, registry,
   closure-truth surface, or proof of domain-quality improvement.

## Maturity And Proof

Benchmark-before-repair is a **method** capability, not a controller or closure
surface. Its evidence is currently **n=2**: two by-hand campaigns
(portfolio_advisor and transcript_processor operating-model maturation) have
exercised it. That is an n=2 observation, not proven cross-repo doctrine. The
benchmark proves repair-selection discipline — it does **not** prove
domain-quality improvement, and a passing benchmark dimension is not proof the
domain output improved. See `docs/maturity-boundary-claim-contract.md`.

## Owner Routing

- A missing benchmark routes to the repo's own benchmark/spec owner issue before
  adoption.
- A missing or uncited benchmark dimension routes to the surface that owns the
  repo's assimilation/spec criteria.
- Detector or advisor propagation gaps route to repo-auditor (a detector for a
  missing benchmark) or repo-upgrade-advisor (a recommendation that packages the
  benchmark gap) through their owner issue/branch/PR/check/merge paths.

## Bounded Non-Claims

This contract does not query GitHub, mutate GitHub, create issues, create PRs,
merge PRs, close issues, run a scheduler, start a daemon, create a queue, create
a controller, create a hidden registry, mutate downstream repos, select repairs
automatically, prove domain-quality improvement, or replace GitHub
issue/PR/check/merge truth. n=2 is an observation, not proven doctrine.
