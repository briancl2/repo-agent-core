# Repo Anthropology Contract

This contract defines a portable copy-sync language for **repo anthropology** —
the assimilation step-3 surface capturing a repo-agent's purpose, use cases,
deliverables, operator interaction model, defined principles, and revealed
principles before any repair is selected.

This is guidance for issue bodies, PR bodies, docs, templates, and retained
evaluation records. It is not a runtime package, schema mandate, generated
inventory, controller, scheduler, queue, daemon, registry, or mutation
authority. GitHub issue/PR/check/merge truth remains task truth.

## Related Contracts

- `docs/repo-assimilation-method-contract.md` (the umbrella method)
- `docs/principle-alignment-anchor-contract.md`
- `docs/benchmark-before-repair-contract.md`

Consumers may copy-sync or cite this contract and
`templates/repo-anthropology.md`. Do not turn either file into a runtime
dependency, import framework, generated registry, controller, queue, scheduler,
daemon, retry loop, watcher, background poller, automatic updater, or
task-closure authority.

## Required Record

| Field | Required meaning |
| --- | --- |
| `artifact` | Must be `REPO_ANTHROPOLOGY_RECORD`. |
| `schema_version` | Contract version for the record shape. |
| `purpose` | What the repo-agent is for, in operator-facing terms. |
| `use_cases` | The repo-agent jobs the operator actually asks it to perform. |
| `deliverables` | The concrete outputs the repo-agent is expected to produce. |
| `operator_interaction_model` | How the operator interacts with the repo-agent: foreground/background shape, issue/PR flow, and review/merge boundary. |
| `defined_principles` | Principles already codified, with the native surface reference. |
| `revealed_principles` | Principles practiced but never codified, with evidence refs. |
| `evidence_refs` | Commits, repairs, docs, issues, PRs, or other cited evidence backing the anthropology. |
| `decision_state` | One of `adopt` / `defer` / `owner-route` / `no-op` / `needs-proof`. |
| `bounded_non_claims` | What the anthropology did not prove, mutate, adopt, or authorize. |

## Admission Rules

A repo anthropology record is admissible only when:

1. `purpose`, `use_cases`, and `deliverables` are present.
2. `revealed_principles` cite evidence refs (commits, repairs, or docs) rather
   than aspirational claims.
3. Anthropology is a **descriptive** surface. It records what the repo-agent is;
   it is not repair-selection authority by itself.
4. `decision_state` blocks adoption (`needs-proof` or `owner-route`) when
   `purpose` or `deliverables` are missing.
5. `bounded_non_claims` forbid treating anthropology as a controller, registry,
   closure-truth surface, or proof of repo-agent capability.

## Maturity And Proof

The anthropology step is a **method** capability, not a controller or closure
surface. Its evidence is currently **n=2**: two by-hand campaigns
(portfolio_advisor and transcript_processor) have exercised it. That proves
operating-model readiness (knowing what the repo is) — it does **not** prove
repo-agent capability (improved domain outputs). See
`docs/maturity-boundary-claim-contract.md`.

## Owner Routing

- A repo with no anthropology surface routes to the repo's own owner issue
  before adoption.
- Detector gaps route to repo-auditor through its owner issue/branch/PR/check/
  merge path.
- Advisor gaps route to repo-upgrade-advisor through its owner issue/branch/PR/
  check/merge path.

## Bounded Non-Claims

This contract does not query GitHub, mutate GitHub, create issues, create PRs,
merge PRs, close issues, run a scheduler, start a daemon, create a queue, create
a controller, create a hidden registry, mutate downstream repos, prove
repo-agent capability, or replace GitHub issue/PR/check/merge truth. n=2 is an
observation, not proven doctrine.
