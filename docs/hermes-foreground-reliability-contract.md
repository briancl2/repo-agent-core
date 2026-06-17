# Hermes Foreground Reliability Contract

> Version: 1.0
> Date: 2026-06-17
> Owner: repo-agent-core

## Purpose

This contract defines the portable Issue #164 reliability evidence shape for
using Hermes as a bounded foreground doer or advisory checker on owner-surface
work. It sits above the low-level launcher receipt and below any repo-specific
PR closure contract: the launcher proves one foreground Hermes run happened;
this contract records whether that run was eligible, useful, reviewed, and
bounded enough to influence future placement decisions.

Consumers may copy-sync this contract and
`templates/hermes-foreground-reliability.md`, or cite them from an issue, PR, or
operator-facing work contract. The contract is advisory and foreground-only. It
does not create a schema mandate, runtime dependency, control plane, or durable
autonomy service.

Related contracts:

- `docs/capability-placement-contract.md`
- `docs/hermes-foreground-launcher-contract.md`
- `docs/foreground-recovery-runtime-contract.md`
- `docs/foreground-failure-to-issue-conversion-contract.md`
- `docs/hermes-foreground-repo-star-pilot-reliability-contract.md`

## Required Reliability Fields

Each Hermes doer/checker reliability record should include these fields:

| Field | Required meaning |
|---|---|
| source_issue_or_pr | GitHub issue, PR, or comment that authorized the Hermes attempt and names the owner surface. |
| campaign_link | Parent campaign or adoption-wave surface, when the work is part of Issue #164. |
| capability_placement | Compact Autonomy Preview placement: current owner, future owner, allowed reach, native signal, promotion gate, demotion trigger, kill switch, why-not alternatives, operator-value hypothesis, and forbidden mode. |
| hermes_eligibility | Why the leaf is eligible for Hermes foreground doer or checker treatment; include scope, expected output, and why broad validation or campaign control is excluded. |
| attempt_role | One of `doer`, `checker_shadow`, `checker_advisory`, or `not_eligible`. |
| launcher_receipt | Path or URL to the `HERMES_FOREGROUND_RUN_RECEIPT`, or an explicit `not_run_reason`. |
| final_output_validation | Validator, command, or review result proving the Hermes final output is non-empty, non-session-only, and useful, or the failure class if not useful. |
| failure_guidance | Path or URL to `HERMES_FOREGROUND_FAILURE_GUIDANCE`, conversion issue/comment, or `not_needed_reason` for clean success. |
| coordinator_review | Codex/BMA, repo maintainer, or operator-visible review that accepted, edited, rejected, or demoted the Hermes output. |
| validation_owner | Human/agent owner that ran local gates, CI, merge-readiness checks, and recovery; this must not be Hermes. |
| github_work_truth | Issue/PR/check/merge/comment links proving what actually landed or blocked. |
| promotion_gate | Evidence needed before repeating or broadening the same Hermes role. |
| demotion_rejection_trigger | Conditions that demote Hermes to no-run, advisory-only, or Codex-only for this class. |
| checker_shadow_disposition | If Hermes acted as checker, record whether the signal was used, ignored, noisy, duplicative, or blocker-converting. |
| bounded_non_claims | Explicit non-claims preventing this record from becoming background authority or closure truth. |

## Eligibility Rules

A Hermes foreground attempt is eligible only when:

1. The leaf is scoped enough for one bounded prompt and one retained final
   response.
2. The issue/PR already names the owner surface, allowed reach, forbidden mode,
   and fallback route.
3. The run uses an approved foreground launcher such as
   `scripts/run-hermes-foreground.py --provider copilot --model gpt-5.5`.
4. The attempt records explicit provider/model flags unless the same episode
   records direct proof for defaults.
5. The coordinator remains responsible for route selection, prompt scoping,
   output review, local validation, PR/check/merge truth, campaign sync, and
   recovery.
6. Failure guidance exists for route-changing failures, or the clean-success
   record explains why failure conversion was not needed.

## Doer Evidence

A doer proof is clean only when Hermes produces a useful implementation or
artifact candidate and the coordinator performs all closure work after the
attempt:

- Validate the launcher receipt and final output.
- Review and edit the diff or artifact before commit.
- Run repo-native focused validation plus required owner gates.
- Publish issue/PR/check/merge truth through the owner repo.
- Record whether the result changes future Hermes placement.

Doer proof does not transfer validation, recovery, PR creation, CI polling,
merge, campaign selection, or Campaign Sync to Hermes.

## Checker Evidence

A checker proof is clean only when Hermes runs as an advisory foreground review
or shadow check after the primary work is already reviewable. Checker evidence
should classify the signal as:

- `route_changing`: found a blocker or better owner route that changed the PR or
  issue path.
- `confirming`: materially increased confidence without changing the route.
- `duplicative`: matched existing Codex/CI/review findings.
- `noisy`: produced vague, stale, or over-broad advice.
- `invalid`: claimed forbidden authority, ignored evidence, or contradicted
  GitHub truth.

Route-changing checker failures or findings must be recorded on GitHub issue or
PR truth. Routine confirming, duplicative, or noisy results may use a compact
no-capture reason instead of creating a retained package.

## Promotion And Demotion

Promotion requires repeated clean owner-surface proofs with:

- Valid launcher receipts and final output validation.
- Explicit coordinator review.
- Local validation and required GitHub checks.
- No over-broad authority claims.
- Lower operator burden or higher reliability than a Codex-only path.
- Clear owner value for repeating the same role.

Demote or reject Hermes for the class when the attempt times out, misses a
receipt, emits empty/session-only/warning-only output, needs substantial
coordinator salvage, attempts forbidden authority, increases operator burden,
or produces useful output but fails the required failure-to-issue conversion.

## Forbidden Authority

This contract must not become, and must not authorize, a runtime dependency,
schema mandate, daemon, scheduler, queue, retry loop, controller, hidden registry,
MCP server, watcher, cron job, background sync, automatic GitHub issue creation,
automatic GitHub PR creation, auto-merge, downstream mutation,
Hermes repo mutation, background Hermes behavior, background GBrain behavior,
`hermes -z` adoption, Codex cloud write authority, Hermes-primary campaign control,
broad validation ownership, Campaign Sync ownership, merge ownership,
or recovery ownership.

## Copy-Sync Boundary

Consumers may copy-sync or cite this contract and its template. Copy drift is
repo quality debt. Keep alignment by normal PR review and owner-surface tests;
do not add a registry, updater, dependency, scheduler, queue, controller,
daemon, retry loop, watcher, or background sync to keep copies aligned.
