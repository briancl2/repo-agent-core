# Principle-Alignment Anchor Contract

This contract defines a portable copy-sync language for a **principle-alignment
anchor** — the foundational step-0 of repo-agent operating-model assimilation.
The anchor starts with root `CONSTITUTION.md` as the shared semantic floor, then
reconciles subordinate owner policy, revealed practice, and any cited external
canon used as advisory assessment criteria. An imported canon can inform
owner-policy reasoning; it cannot extend, amend, or outrank the shared root.
The result is a principle gap matrix that anchors downstream repair selection.

Read root `CONSTITUTION.md` before using this method. Apply only articles that
change the forward decision, finding, scope, or conclusion, and state that
effect when it occurs. Do not duplicate the nine articles or convert them into
a universal checklist. Owner-local specialization may strengthen or specialize
the floor, but unresolved conflict with shared meaning stops for explicit
resolution.

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
| `repo_identity` | The repo-agent being anchored, root `CONSTITUTION.md`, and the subordinate owner-policy surfaces being assessed. |
| `imported_canon` | A cited external canon used only as advisory owner-policy assessment criteria; it carries no shared constitutional authority. |
| `reconciliation_table` | Each imported criterion mapped to the relevant shared article and/or nearest owner policy, with a verdict: `present` / `partial` / `gap` / `present-but-scattered`. |
| `revealed_principles` | Principles the repo already practices as scattered point-repairs but has never codified, with evidence refs. |
| `principle_gap_matrix` | Ranked owner-policy or practice gaps (severity × autonomy-merge-safety), each mapped to an imported criterion and an owner route. |
| `codification_target` | The subordinate owner-policy, contract, or spec surface where a local gap would land. Shared meaning changes only through explicit ratification of exact, hash-identified root bytes. |
| `selection_gate` | The rule that the first repair is chosen by gap severity, not issue order, plus the benchmark vector used. For a domain enhancement it also names the **true outcome lever** the repair targets — not a convenient proxy — per the Domain-Outcome Eval Gate in `docs/repo-assimilation-method-contract.md`. |
| `right_sizing_basis` | Codebase complexity + repo-agent use case + revealed usage, justifying depth (avoid both half-adoption and over-speccing). |
| `validation` | Repo-native checks expected before the anchor changes production guidance. |
| `decision_state` | One of `adopt` / `defer` / `owner-route` / `no-op` / `needs-proof`. |
| `bounded_non_claims` | What the anchor did not prove, mutate, adopt, or authorize. |

## Admission Rules

A principle-alignment anchor record is admissible only when:

1. `repo_identity`, `imported_canon`, `reconciliation_table`, and
   `principle_gap_matrix` are present, and the imported canon carries a
   source/citation.
2. `codification_target` prefers an existing native owner-policy, contract, or
   spec surface over a new custom doc (native-before-custom). It must not extend
   root `CONSTITUTION.md`; a shared-meaning change instead requires explicit
   ratification of exact, hash-identified root bytes.
3. `selection_gate` names a severity-ranked first repair and the benchmark
   vector; the first repair is not chosen by issue order. For a domain
   enhancement, the selection gate names the true outcome lever rather than an
   adjacent proxy and defers to the Domain-Outcome Eval Gate before the
   enhancement is marked done.
4. `right_sizing_basis` is justified from complexity + use-case +
   revealed-usage. A bounded non-claim is required when revealed-usage is
   reconstructed rather than measured.
5. `revealed_principles` cite evidence refs (commits, repairs, or docs) rather
   than aspirational claims.
6. `decision_state` blocks adoption (`needs-proof` or `owner-route`) when the
   gap matrix, codification target, validation, or resolution of a shared-root
   conflict is missing.
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

The n=2 observation is **detector-confirmed**: repo-auditor **AS-51** fired HIGH
on transcript_processor `main` (`2e80638`) — constitution + spec present, but no
imported-canon + reconciliation/gap-matrix anchor artifact — a verified true-gap,
not a false positive. The gap class transfers; the detector is graduated to n=2.

## Owner Routing

- A repo missing the ratified root constitution, or holding different root
  bytes, routes to its own exact-byte ratification owner surface before
  adoption.
- Owner-policy gaps route to the target repo's existing instruction, contract,
  or spec owner surface; they do not become shared constitutional amendments.
- A missing or uncited imported canon routes to the canon source surface.
- Detector or advisor propagation gaps route to repo-auditor (a detector for a
  missing anchor) or repo-upgrade-advisor (a recommendation that packages the
  gap) through their owner issue/branch/PR/check/merge paths.

## Bounded Non-Claims

This contract does not query GitHub, mutate GitHub, create issues, create PRs,
merge PRs, close issues, run a scheduler, start a daemon, create a queue, create
a controller, create a hidden registry, mutate downstream repos, adopt principles
automatically, or replace GitHub issue/PR/check/merge truth. Anchoring proves
operating-model readiness (purpose, principles, selection gate); it is not a
validated domain outcome, which requires the Domain-Outcome Eval Gate's confirmed
delta on the target's own eval. It does not amend or extend root
`CONSTITUTION.md`. n=2 is an observation, not proven doctrine.
