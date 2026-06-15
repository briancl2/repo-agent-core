# GitHub Parsed Closure Semantics Contract

This contract defines a portable receipt shape for checking GitHub's parsed
issue-closing semantics on Issue #164-style carrier PRs. It exists because a PR
body can accidentally produce a parsed closing reference even when the author
uses negated wording such as "does not close #798". The parsed GitHub surface,
not local author intent, is the evidence that matters.

The contract is for preflight, review, repair, and owner routing. It is not a
GitHub client, validator service, controller, scheduler, queue, daemon,
registry, retained closeout package, automatic issue/PR creator, or local
closure authority. GitHub issue/PR/check/merge truth remains task-closure truth.

## Related Contracts

- `docs/foreground-failure-to-issue-conversion-contract.md`
- `docs/foreground-learning-and-recovery-contract.md`
- `docs/scheduled-runtime-learning-shadow-readback-contract.md`

Consumers may copy-sync or cite this contract and
`templates/github-parsed-closure-semantics.md`. Do not turn either file into a
runtime dependency, import framework, generated registry, controller, queue,
scheduler, daemon, retry loop, watcher, background GitHub poller, automatic
updater, or task-closure authority.

## Required Fields

| Field | Requirement |
| --- | --- |
| `artifact` | Must be `GITHUB_PARSED_CLOSURE_SEMANTICS_RECEIPT`. |
| `schema_version` | Contract version for the receipt shape. |
| `source_issue_or_pr` | Owner issue or PR that requested the check. |
| `parent_campaign_url` | Parent campaign issue when applicable. |
| `pr_url` | Pull request being checked. |
| `pr_state` | Pull request state at readback time. |
| `pr_merged` | Boolean merged state at readback time. |
| `campaign_sync_status` | One of `non_final`, `final_for_own_child`, or `not_campaign_sync`. |
| `target_child_issue_url` | The child issue this PR is allowed to govern. |
| `active_child_issue_url` | The current active child issue that must remain active unless it is the final target. |
| `pr_body_closure_keyword_scan` | Local body scan evidence for closure-keyword hazards, including negated wording. |
| `closing_issues_references` | GitHub parsed `closingIssuesReferences` or equivalent readback. |
| `allowed_closing_issue_urls` | Exact issue URLs this PR may affect through closing semantics. |
| `unexpected_closing_issue_urls` | Parsed closing references outside the allowed list. |
| `issue_state_before` | Before-state map for target, active, and parsed referenced issues. |
| `issue_state_after` | After-state map for target, active, and parsed referenced issues when available. |
| `state_drift_detected` | Boolean for unexpected before/after issue-state change. |
| `repair_action` | Required owner action if unexpected parsed closure or issue-state drift appears. |
| `admission_disposition` | One of `admit`, `block_non_final_parsed_closure`, `block_unexpected_child_closure`, `repair_issue_state`, or `insufficient_evidence`. |
| `closure_truth` | Must state that this receipt is evidence only; GitHub issue/PR/check/merge truth remains closure truth. |
| `bounded_non_claims` | Non-claims for automation, mutation, closure, scheduling, controllers, and local closeout packages. |

## Admission Rules

A parsed-closure receipt is admissible only when:

1. `pr_url`, `target_child_issue_url`, `active_child_issue_url`,
   `campaign_sync_status`, `pr_body_closure_keyword_scan`, and
   `closing_issues_references` are present.
2. Non-final Issue #164 carrier PRs have no parsed closing references for any
   child issue. A local body scan is not enough when GitHub parsed references
   exist.
3. Final Campaign Sync PRs may have parsed closing references only for their own target child issue; they must not affect unrelated active children.
4. `unexpected_closing_issue_urls` is empty for `admit`.
5. Before/after issue state is present for the target child, active child, and
   any parsed referenced child when the receipt is used after publication or
   merge.
6. `repair_action` is present when parsed references or before/after state
   evidence show unexpected child issue impact.
7. `closure_truth` explicitly says the receipt is evidence only and does not replace GitHub issue/PR/check/merge truth.
8. `bounded_non_claims` forbids local closeout packages, downstream mutation,
   background GitHub polling, schedulers, queues, daemons, controllers,
   registries, retry loops, auto-merge, and automatic issue/PR creation.

## Closure-Keyword Hazard

GitHub may parse issue-closing keywords from ordinary prose, including negated
phrases. A body sentence such as `This does not close #798` is unsafe in an
Issue #164 carrier PR because the parsed `closingIssuesReferences` surface can
still treat the issue as a closing reference. Consumers should avoid closure
keywords near issue numbers except when intentionally closing the PR's own
child issue on a final Campaign Sync PR.

The local body scan is only an early warning. The authoritative readback is the
parsed GitHub PR surface (`closingIssuesReferences` or an equivalent GraphQL/API
result) plus the before/after issue state.

## Owner Routing

- Parsed closure references outside the allowed child issue list route to the
  PR owner before merge.
- Unintended issue-state changes route to the owner repo for state repair and a
  GitHub-visible note on the affected child issue.
- Missing parsed-reference evidence routes to the repo implementing the
  preflight/readback helper.
- Detector or advisor propagation gaps route to repo-auditor or
  repo-upgrade-advisor through their owner issue/branch/PR/check/merge paths.

## Bounded Non-Claims

This contract does not query GitHub, mutate GitHub, create issues, create PRs,
post comments, merge PRs, close issues, repair issue state, install a checker,
start a daemon, schedule a poller, create a queue, create a controller, create
a hidden registry, mutate downstream repos, create a retained closeout package,
or replace GitHub issue/PR/check/merge truth.
