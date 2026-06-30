# Validation Integrity Format Tracking Contract

> Version: 1.0
> Date: 2026-06-30
> Owner: repo-agent-core

## Purpose

This contract defines the copy-sync/citation shape for validation-integrity
format tracking after the D3 correction. validation-integrity had no live drift
in this round: `briancl2/transcript_processor-private#56` already bound the
Phase-3 producer format, and `briancl2/transcript_processor-private#58` added
the residual fail-closed drift-protection regression with a saved-run fixture and
unique-ID, ledger-text, and compact-mismatch checks.

The remedy is contract-backed format tracking, not an AS-56 detector this round.
It keeps producer format and validator expectations tied to a saved-run
regression that breaks when they drift.

This contract is not a runtime dependency, schema mandate, controller,
scheduler, queue, daemon, registry, retry loop, watcher, background sync,
automatic issue/PR creator, auto-merge path, downstream mutation grant, or
canonical validation ledger.

## Receipt/Distribution Shape

Validation-integrity format tracking receipts should include:

| Field | Required meaning |
|---|---|
| `artifact` | Literal `VALIDATION_INTEGRITY_FORMAT_TRACKING_RECEIPT`. |
| `schema_version` | Receipt shape version; currently `1`. |
| `source_issue_or_pr` | GitHub issue, PR, or campaign surface that requested the readback. |
| `format_binding_ref` | `briancl2/transcript_processor-private#56` or successor producer-format binding. |
| `drift_regression_ref` | `briancl2/transcript_processor-private#58` or successor fail-closed regression. |
| `format_drift_status` | `no_live_drift_observed`, `drift_blocked_by_regression`, or owner-visible blocker. |
| `detector_disposition` | `not_as_56_detector_backed_this_round` unless a later detector is approved. |
| `saved_run_fixture` | Saved-run fixture path or GitHub evidence that exercises the producer format. |
| `fail_closed_checks` | Unique-ID, ledger-text, compact-mismatch, and any additional validator expectation checks. |
| `producer_validator_coupling` | Statement of which producer fields must stay aligned with validator expectations. |
| `validation_command` | Focused test/gate command that fails closed on drift. |
| `owner_routing` | Exact owner issue, PR, or blocker route when format binding or regression evidence is missing. |
| `bounded_non_claims` | Explicit limits on detector graduation, automation, mutation, schema mandates, and canonical truth. |

## Validation Rules

1. A validation-integrity receipt must cite a producer-format binding and a
   drift-protection regression. For this lane those are
   `briancl2/transcript_processor-private#56` and
   `briancl2/transcript_processor-private#58`.
2. The receipt must state that no live validation-integrity drift was observed in
   D3 unless later evidence proves otherwise.
3. The remedy must be fail-closed: the regression fails when producer format and
   validator expectations drift.
4. The saved-run fixture must exercise the producer output shape used by the
   validator. Synthetic examples are not enough unless they are explicitly
   accepted as a saved-run replacement by the owner surface.
5. `fail_closed_checks` must include unique-ID, ledger-text, and
   compact-mismatch checks. Missing any of those checks blocks admission.
6. `detector_disposition` must remain `not_as_56_detector_backed_this_round`.
   Do not present this as AS-56 detector evidence.
7. Owner action must name a concrete GitHub surface or first deliverable; a
   category such as "improve validation" is not admissible.
8. Any implementation that creates a controller, scheduler, queue, daemon,
   registry, watcher, retry loop, background sync, automatic issue/PR path, or
   canonical validation ledger violates this contract.

## Bounded Non-Claims

This contract does not:

- claim validation-integrity had live D3 drift;
- claim AS-56 exists or graduated this round;
- replace `briancl2/transcript_processor-private#56` producer-format binding or
  `briancl2/transcript_processor-private#58` drift-protection regression;
- mandate a shared runtime schema beyond the copied receipt/template shape;
- create issues, create PRs, post comments, merge PRs, or close issues;
- mutate downstream repositories;
- create a controller, scheduler, queue, daemon, registry, retry loop, watcher,
  hidden control plane, automatic updater, background sync, or retained
  validation package;
- make any local fixture, ledger, or memory surface canonical validation truth.

## Owner Routing

- Missing producer-format binding routes to the producer owner surface before
  admission.
- Missing fail-closed regression evidence routes to the validator owner surface.
- Missing saved-run fixture evidence routes to the owner surface that owns the
  validation fixture.
- Missing unique-ID, ledger-text, or compact-mismatch checks route to
  regression repair, not detector graduation.
- Any future AS-56 detector proposal must be opened as a separate owner issue
  with distinct-repo evidence; it cannot inherit this round's contract-backed
  validation-integrity disposition as detector proof.

## Copy-Sync Boundary

Consumers may copy-sync this contract or
`templates/validation-integrity-format-tracking.md`, or cite them from detector,
advisor, optimizer, or campaign surfaces. Copy drift is review debt handled by
focused tests and owner review. Do not add a runtime dependency, generated
registry, controller, scheduler, queue, daemon, watcher, retry loop, background
sync, automatic updater, auto-merge path, or downstream mutation path to keep
copies aligned.
