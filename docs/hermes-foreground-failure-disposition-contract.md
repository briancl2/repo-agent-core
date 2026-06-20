# Hermes Foreground Failure Disposition Contract

> Version: 1.0
> Date: 2026-06-20
> Owner: repo-agent-core

## Purpose

This contract defines the portable `HERMES_FOREGROUND_FAILURE_DISPOSITION`
record for deciding whether a converted foreground Hermes failure issue may be
closed, must stay open, or needs a GitHub-visible blocker. It starts after a
failure has already been converted through foreground failure-to-issue truth.
It does not create issues, close issues, retry Hermes, repair code, or run in
the background.

It composes these existing repo-agent-core surfaces:

- `docs/foreground-failure-to-issue-conversion-contract.md`
- `docs/foreground-recovery-runtime-contract.md`
- `docs/hermes-foreground-launcher-contract.md`
- `docs/hermes-foreground-reliability-contract.md`

## Required Fields

| Field | Required meaning |
|---|---|
| failure issue | GitHub issue URL/number/state for the converted foreground failure. |
| primary object | The failed PR, issue, command, prompt, receipt, target, or check. Primary-object identity alone is not repair evidence. |
| related repair PRs | Candidate PR URLs/numbers/states/merge commits used as repair evidence. |
| command family | Stable command family, usually `hermes-foreground`. |
| failure code | Normalized failure code such as `foreground_output_invalid`, `missing_final_response`, or provider timeout code. |
| classification | One of `resolved_by_merged_repair`, `still_blocked`, `superseded_by_provider_policy`, or `invalid_for_closure`. |
| close allowance | Boolean close permission. Only `true` when the classification explicitly allows closure. |
| recommended action | Exact next owner action: close with evidence, keep open with blocker, or refuse closure from this receipt. |
| blocker evidence | Concrete blocker items that keep the failure open, including partial provider-policy residue. |
| provider-policy evidence | Current provider/model policy evidence plus explicit superseded-provider signal when policy supersession is claimed. |
| GitHub truth | Issue/PR/check/merge/comment URLs that carry the durable disposition. |
| promotion trigger | Evidence that makes the disposition reusable: clean live proof, merged repair, focused tests, and no unresolved high-severity critique. |
| demotion trigger | False-close path, ambiguous repair evidence, stale policy evidence, hidden retries, scheduler/controller behavior, or missing GitHub truth. |
| kill switch | Any false close, auto-close, or background retry behavior disables the disposition until repaired on the owner surface. |
| bounded non-claims | Explicit forbidden authority and non-promotion statements. |

## Closure Rules

A failure issue may close as `resolved_by_merged_repair` only when exactly one
related PR is merged and that PR references the failure issue itself. A merged
PR that only equals or mentions the primary object is not enough, because the
primary object may be the failed PR under review.

Missing PR evidence, unmerged PR evidence, ambiguous merged PR evidence, or
merged PR evidence that does not reference the failure issue must fail closed as
non-close evidence. Partial provider-policy residue is blocker evidence even if
a merged repair-looking PR is present. Provider-policy supersession may allow
closure only when both sides are present: an explicit superseded-provider signal
on the failure issue and current provider/model policy evidence from a cited
source.

## GitHub Truth Requirement

The disposition is durable only when recorded on the GitHub failure issue, the
repair PR, or another explicit owner-surface comment/check. Local receipts and
run roots are evidence, not closure truth. Ambiguous GitHub/API/check state must
become a GitHub-visible blocker rather than a local retained package.

## Forbidden Boundary

This contract forbids controller, scheduler, queue, daemon, registry, hidden
registry, retry loop, auto-close, auto-merge, automatic issue/PR creation,
background Hermes/GBrain behavior, Hermes-primary authority, `hermes -z`
adoption, upstream Hermes mutation, downstream mutation, target mutation, and
runtime dependency behavior.

## Copy-Sync Boundary

Consumers may copy this contract and
`templates/hermes-foreground-failure-disposition.md` or cite them from repo
docs. Copy drift is repo-quality debt handled by ordinary owner PRs. Do not
introduce a runtime dependency, generated registry, scheduler, queue, daemon,
controller, retry loop, auto-close path, auto-merge path, or background sync to
keep copies aligned.
