# Principle-Alignment Anchor Contract

This contract defines a portable copy-sync language for a **principle-alignment
anchor** — the foundational step-0 of repo-agent operating-model assimilation. A
repo-agent gains an operating-model layer by importing an operating-model
principle canon as *assessment criteria*, reconciling it against the repo's
existing engineering constitution, deriving revealed principles, and producing a
principle gap matrix that anchors all downstream repair selection.

This is guidance for issue bodies, PR bodies, docs, templates, and retained
evaluation records. It is not a runtime package, schema mandate, generated
inventory, scheduler, queue, controller, watcher, daemon, background sync,
automatic updater, registry, or mutation authority. GitHub issue/PR/check/merge
truth remains task truth.

## Related Contracts

- `docs/repo-assimilation-method-contract.md` (the umbrella method this anchors)
- `docs/maturity-boundary-claim-contract.md`
- `docs/capability-placement-contract.md`
- `docs/upstream-capability-intake-contract.md`

Consumers may copy-sync or cite this contract and
`templates/principle-alignment-anchor.md`. Do not turn either file into a runtime
dependency, import framework, generated registry, controller, queue, scheduler,
daemon, retry loop, watcher, background poller, automatic updater, or
task-closure authority.

## Required Record

| Field | Required meaning |
| --- | --- |
| `artifact` | Must be `PRINCIPLE_ALIGNMENT_ANCHOR_RECORD`. |
| `schema_version` | Contract version for the record shape. |
| `repo_identity` | The repo-agent being anchored, and its existing engineering constitution surface (e.g. `.specify/memory/constitution.md`). |
| `imported_canon` | The operating-model principle canon imported as assessment criteria, with source/citation. |
| `reconciliation_table` | Each imported criterion mapped to the nearest existing principle, with a verdict: `present` / `partial` / `gap` / `present-but-scattered`. |
| `revealed_principles` | Principles the repo already practices as scattered point-repairs but has never codified, with evidence refs. |
| `principle_gap_matrix` | Ranked gaps (severity × autonomy-merge-safety), each mapped to an imported criterion and an owner route. |
| `codification_target` | Where the new operating-model principles land; a **native** constitution/spec extension is preferred over a custom side-doc. |
| `selection_gate` | The rule that the first repair is chosen by gap severity, not issue order, plus the benchmark vector used. |
| `right_sizing_basis` | Codebase complexity + repo-agent use case + revealed usage, justifying depth (avoid both half-adoption and over-speccing). |
| `validation` | Repo-native checks expected before the anchor changes production guidance. |
| `decision_state` | One of `adopt` / `defer` / `owner-route` / `no-op` / `needs-proof`. |
| `bounded_non_claims` | What the anchor did not prove, mutate, adopt, or authorize. |

## Admission Rules

A principle-alignment anchor record is admissible only when:

1. `repo_identity`, `imported_canon`, `reconciliation_table`, and
   `principle_gap_matrix` are present, and the imported canon carries a
   source/citation.
2. `codification_target` prefers a **native** constitution/spec extension over a
   new custom doc (native-before-custom). A custom side-doc requires a stated
   reason why the native surface could not host the principles.
3. `selection_gate` names a severity-ranked first repair and the benchmark
   vector; the first repair is not chosen by issue order.
4. `right_sizing_basis` is justified from complexity + use-case +
   revealed-usage. A bounded non-claim is required when revealed-usage is
   reconstructed rather than measured.
5. `revealed_principles` cite evidence refs (commits, repairs, or docs) rather
   than aspirational claims.
6. `decision_state` blocks adoption (`needs-proof` or `owner-route`) when the
   gap matrix, codification target, or validation is missing.
7. `bounded_non_claims` forbid treating the anchor as a controller, registry,
   closure-truth surface, or proof of repo-agent capability.

## Maturity And Proof

The anchor is a **method** capability, not a controller or closure surface. Its
evidence is currently **n=2**: two by-hand campaigns (portfolio_advisor and
transcript_processor operating-model charters) have exercised it. That is an n=2
observation, not proven cross-repo doctrine. The anchor proves operating-model
*readiness* (purpose, principles, selection gate) — it does **not** prove
repo-agent *capability* (improved domain outputs). See
`docs/maturity-boundary-claim-contract.md`.

## Owner Routing

- A repo with no operating-model constitution surface routes to its own
  constitution/spec owner issue before adoption.
- A missing or uncited imported canon routes to the canon source surface.
- Detector or advisor propagation gaps route to repo-auditor (a detector for a
  missing anchor) or repo-upgrade-advisor (a recommendation that packages the
  gap) through their owner issue/branch/PR/check/merge paths.

## Bounded Non-Claims

This contract does not query GitHub, mutate GitHub, create issues, create PRs,
merge PRs, close issues, run a scheduler, start a daemon, create a queue, create
a controller, create a hidden registry, mutate downstream repos, adopt principles
automatically, or replace GitHub issue/PR/check/merge truth. n=2 is an
observation, not proven doctrine.
