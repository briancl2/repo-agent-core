# Route-Changing Learning Failure Contract

This contract defines a portable receipt shape for Issue #164-style events where
a foreground failure, GitHub readback, GBrain lookup, CI/check result, or owner
issue changes the route. It composes foreground Hermes failure routing, GitHub
owner-surface evidence, advisory GBrain exact-handle replay, fallback without
memory, `Learning / Recovery` fields, and literal-safe GitHub status-comment
readback.

The contract is for preflight, review, repair, and owner routing, including
literal-safe GitHub status-comment/readback evidence. It is not a
runtime dependency, GitHub client, memory daemon, controller, scheduler, queue,
registry, retry loop, retained closeout package, automatic issue/PR creator, or
closure authority. GitHub issue/PR/check/merge truth remains task truth, and
GBrain remains advisory memory.

## Related Contracts

- `docs/foreground-learning-and-recovery-contract.md`
- `docs/foreground-recovery-runtime-contract.md`
- `docs/foreground-failure-to-issue-conversion-contract.md`
- `docs/gbrain-advisory-pilot-outcome-learning-loop-contract.md`
- `docs/github-parsed-closure-semantics-contract.md`

Consumers may copy-sync or cite this contract and
`templates/route-changing-learning-failure.md`. Do not turn either file into a
runtime dependency, import framework, generated registry, controller, queue,
scheduler, daemon, retry loop, watcher, background GitHub poller, background
GBrain process, automatic updater, or task-closure authority.

## Required Fields

| Field | Requirement |
| --- | --- |
| `artifact` | Must be `ROUTE_CHANGING_LEARNING_FAILURE_RECEIPT`. |
| `schema_version` | Contract version for the receipt shape. |
| `source_issue_or_pr` | Owner issue, PR, check, or comment that requested the routing readback. |
| `parent_campaign_url` | Parent campaign issue when applicable. |
| `route_changed` | Boolean; true only when the event changed the owner action, fallback, or admission decision. |
| `route_change_reason` | Concrete reason the route changed, or `none` when the receipt records a no-capture disposition. |
| `github_surface` | GitHub issue, PR, comment, check, or review thread that owns the durable truth. |
| `raw_evidence` | Paths or URLs for command receipts, failure guidance, check output, detector receipts, or run-root evidence. |
| `hermes_failure_routing` | Foreground Hermes receipt/failure-guidance status when Hermes participated; may be `not_applicable`. |
| `gbrain_search_disposition` | Broad search/query command status and whether it found the route-changing record. |
| `gbrain_exact_handle_replay` | Exact `gbrain get` readback rows for admitted slugs, or an explicit empty list. |
| `gbrain_slug_or_no_capture_reason` | Decision-changing advisory slug, or a no-capture reason such as `routine`, `duplicate`, `local_only`, `not_reusable`, or `github_evidence_sufficient`. |
| `fallback_without_memory` | The owner route that would have been chosen without GBrain memory; this is the fallback without memory. |
| `owner_action` | Exact owner surface issue, PR, branch, or patch route created or changed by the event. |
| `literal_safe_github_readback` | Evidence that GitHub status comments carrying code, backticks, shell snippets, issue numbers, or JSON were posted/read back literally. |
| `learning_recovery_block` | `Learning / Recovery` fields: decision changed, GitHub surface, raw evidence, optional GBrain slug, no-capture reason, reusable learning text, owner action, and bounded non-claims. |
| `admission_disposition` | One of `admit`, `block_missing_github_surface`, `block_missing_raw_evidence`, `block_missing_memory_disposition`, `block_missing_fallback`, `block_literal_readback`, or `insufficient_evidence`. |
| `bounded_non_claims` | Non-claims for automation, mutation, GBrain authority, Hermes authority, scheduling, controllers, and local closeout packages. |

## Admission Rules

A route-changing learning/failure receipt is admissible only when:

1. `github_surface`, `raw_evidence`, `owner_action`, and
   `learning_recovery_block` are present.
2. The receipt names either a decision-changing `gbrain_slug_or_no_capture_reason`
   slug with exact-handle readback, or a no-capture reason. Broad GBrain search miss is not proof that memory was absent when exact handles are available.
3. `fallback_without_memory` names the owner action that would have been chosen
   without advisory GBrain evidence.
4. Foreground Hermes failures cite a `HERMES_FOREGROUND_RUN_RECEIPT`,
   `HERMES_FOREGROUND_FAILURE_GUIDANCE`, or an explicit `not_applicable`
   disposition; a route-changing failed foreground run must become GitHub issue
   or issue-comment truth before Codex fallback.
5. Literal-bearing GitHub comments are posted through a literal-safe path and
   read back before admission. Shell backticks, fenced code, JSON, and issue
   numbers must survive GitHub readback when they are part of the evidence.
6. `admission_disposition` blocks when GitHub surface, raw evidence, memory
   disposition, fallback, or literal readback evidence is missing.
7. `bounded_non_claims` forbids canonical GBrain authority, background GBrain,
   background Hermes, Hermes-primary campaign control, downstream mutation,
   schedulers, queues, daemons, controllers, retry loops, auto-merge, automatic
   issue/PR creation, and retained local closeout packages.

## Literal-Safe GitHub Readback

When a route-changing status comment carries shell snippets, backticks, issue
numbers, JSON, paths, or code fences, the producer must avoid shell
interpolation hazards and read the posted GitHub body back. A corrected comment
that repairs stripped literal values should cite the superseded comment and
become the authoritative GitHub surface for the receipt.

The readback evidence should record:

- posting method or safe body source;
- GitHub comment URL;
- literal fields expected to survive;
- readback status for each literal field;
- superseded comment URL when applicable;
- owner repair action if readback fails.

## Owner Routing

- Missing GitHub owner-surface truth routes to the repo coordinating the
  campaign or PR.
- Missing Hermes failure routing routes to the foreground launcher or
  failure-to-issue owner surface.
- Missing advisory GBrain slug/no-capture, fallback, exact-handle replay, or
  broad-search disposition routes to the GBrain learning-loop consumer.
- Literal-unsafe GitHub comments route to the producer surface that posted the
  comment, plus a corrected readback comment.
- Detector or advisor propagation gaps route to repo-auditor or
  repo-upgrade-advisor through their owner issue/branch/PR/check/merge paths.

## Bounded Non-Claims

This contract does not query GitHub, mutate GitHub, create issues, create PRs,
post comments, merge PRs, close issues, repair issue state, run Hermes, run
GBrain, create a retained local closeout package, start a daemon, schedule a
poller, create a queue, create a controller, create a hidden registry, mutate
downstream repos, make GBrain canonical, make Hermes the campaign owner, or
replace GitHub issue/PR/check/merge truth.
