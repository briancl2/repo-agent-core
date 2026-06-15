# GitHub Parsed Closing Reference Contract

This contract defines a portable receipt shape for reviewing GitHub parsed
closing-reference semantics before a campaign PR is allowed to merge or close a
child issue. It is for copy-sync, citation, preflight design, and owner routing.
It is not a GitHub app, webhook, daemon, scheduler, queue, controller, retry
loop, hidden registry, retained closeout package, or automatic issue/PR
creator.

The primary consumer is an Issue #164 style carrier where non-final PRs may
reference a child issue but must not close it. The motivating hazard is
negated or narrative PR body text that humans read as non-closing, but GitHub
still parses as a closing reference. GitHub parsed truth outranks author
intent, local text interpretation, and retained local closeout evidence.

## Related Contracts

- `docs/foreground-failure-to-issue-conversion-contract.md`
- `docs/repo-star-closure-runtime-distribution-contract.md`
- `docs/scheduled-runtime-learning-shadow-readback-contract.md`

Consumers may copy-sync or cite this contract and
`templates/github-parsed-closing-reference.md`. Do not turn either file into a
runtime dependency, parser package, generated registry, scheduler, queue,
daemon, controller, retry loop, watcher, background behavior, automatic updater,
or task-closure authority.

## Required Fields

| Field | Requirement |
| --- | --- |
| `artifact` | Must be `GITHUB_PARSED_CLOSING_REFERENCE_REVIEW`. |
| `schema_version` | Contract version for the receipt shape. |
| `source_issue_or_pr` | GitHub issue or PR that requested the review. |
| `parent_campaign_url` | Parent campaign issue when applicable. |
| `child_issue_url` | Child issue whose closure state is protected. |
| `pr_url` | PR being reviewed. |
| `pr_intended_role` | One of `non_final_carrier_pr`, `final_child_closure_pr`, or `ordinary_pr`. |
| `github_parsed_closing_references` | Exact parsed closing references from GitHub API, check output, or manual readback. |
| `raw_reference_evidence` | URL, API payload path, check output path, or command transcript that produced the parsed readback. |
| `human_intent_summary` | Human-stated intent, such as `Refs #123 only` or `Closes #123`. |
| `parsed_vs_intent_disposition` | `match`, `hazard`, or `unknown`. |
| `non_final_child_closure_allowed` | Must be false for non-final carrier PRs. |
| `final_child_closure_required` | Must be true only for the final child-closing PR. |
| `closure_keyword_hazard_classes` | Closure-keyword classes the consumer must guard. |
| `required_action` | Exact owner action before merge or closure. |
| `owner_routing` | Owner surface for parser, PR text, check, or campaign-sync gaps. |
| `bounded_non_claims` | Non-claims for automation, mutation, closure, and background behavior. |

## Admission Rules

A PR closure preflight is admissible only when:

1. The review reads GitHub parsed closing references from GitHub/API/check truth
   or records a GitHub-visible blocker when that readback is unavailable.
2. For `pr_intended_role: non_final_carrier_pr`,
   `github_parsed_closing_references` must not include the protected
   `child_issue_url`, and `non_final_child_closure_allowed` must be false.
3. For `pr_intended_role: final_child_closure_pr`,
   `github_parsed_closing_references` must include the protected child issue,
   `final_child_closure_required` must be true, and the PR must be the intended
   final closure surface.
4. Negated closure-keyword text, quoted examples, markdown checklists,
   historical summaries, and "do not close" prose must be treated as hazards
   until GitHub parsed truth proves they are not closing references.
5. If GitHub parsed truth and human intent disagree, the disposition is
   `hazard`, and the owner action must repair PR text or check logic before
   merge.
6. If parsed-reference readback cannot be obtained, the disposition is
   `unknown`, and the owner action must record a GitHub-visible blocker instead
   of relying on local retained proof.
7. `bounded_non_claims` forbids downstream mutation, background Hermes/GBrain
   behavior, schedulers, queues, daemons, controllers, registries, retry loops,
   auto-merge, and automatic issue/PR creation.

## Closure Keyword Hazard Classes

Consumers should preserve at least these hazard classes:

- `negated_closure_keyword`: text such as "does not close #123" that may still
  contain a parsed closing reference.
- `quoted_or_example_closure_keyword`: examples, snippets, or quoted text that
  include a closure keyword and issue number.
- `checklist_closure_keyword`: markdown checklist or task-list wording that
  includes closure syntax before the PR is final.
- `historical_closure_summary`: retrospective or status text that mentions a
  past/future closing relationship without intending current PR closure.
- `cross_issue_crosstalk`: body text referencing a sibling child issue that
  should remain open.

## Owner Routing

- PR body wording hazards route to the PR author/owner before merge.
- Missing GitHub parsed-reference readback routes to the repo check or
  preflight owner.
- Child issue accidentally closed by a non-final PR routes to the campaign
  owner for immediate reopen plus parser/preflight repair.
- Detector or propagation gaps route to repo-auditor or repo-upgrade-advisor
  only after the BMA owner surface proves the class with GitHub evidence.

## Bounded Non-Claims

This contract does not parse GitHub itself, install checks, merge PRs, close or
reopen issues, replace GitHub issue/PR/check/merge truth, mutate downstream
repos, mutate Hermes/GBrain internals, make Hermes the campaign owner, create
automatic issue/PR creation behavior, or start any daemon, scheduler, queue,
controller, retry loop, hidden registry, watcher, service, or background sync.
