# Assimilation GitHub Work Management V1 Contract

> Version: 1.0
> Date: 2026-07-09
> Owner: repo-agent-core
> Source issue: briancl2/repo-agent-core#117
> Coordination issue: briancl2/build-meta-analysis#1318

## Purpose

This contract defines the copy-sync/citation shape for
`ASSIMILATION_GITHUB_WORK_MANAGEMENT_V1`, a small GitHub work-management
readback for BMA-assimilated repo-agent repos.

It is grounded in transcript_processor assimilation-health evidence recorded on
repo-agent-core#117: local staged-diff review missed cross-PR consistency,
multiple artifacts copied one regime fact and drifted, local closure hid open
review signal, the authoritative PR reviewer was not repo-discoverable, and a
later autonomous merge pass showed a candidate maturity signal after repo-native
gates, review findings, and conflicts were handled through GitHub truth.

The V1 shape intentionally has only four work-management fields:

- `github_closure_reconciliation`
- `required_ci_and_reviewer_model`
- `shared_fact_control`
- `autonomous_merge_eligibility_candidate`

`permission_insufficient` is an evidence state, not a repo-quality gap and not
a fifth V1 work-management field. If a repo cannot read PRs, checks, reviews,
branch/ruleset evidence, or parsed closing references, the receipt must record
`permission_insufficient` and route one exact owner action instead of grading the
repo as deficient.

This contract is not a runtime dependency, schema mandate, GitHub client,
review bot, controller, scheduler, queue, daemon, registry, dashboard, watcher,
automatic issue/PR creator, auto-merge path, retained closeout package, or
downstream mutation grant. GitHub issue/PR/check/review/merge truth is
authoritative.

## Related Contracts

- `docs/github-parsed-closure-semantics-contract.md`
- `docs/repo-agent-fleet-consistency-floor-contract.md`
- `docs/repo-assimilation-method-contract.md`
- `docs/closure-signal-integrity-contract.md`

Consumers may copy-sync or cite this contract and
`templates/assimilation-github-work-management-v1.md`. Do not turn either file
into a runtime dependency, generated inventory, controller, scheduler, queue,
daemon, retry loop, background poller, review bot, automatic updater,
automatic issue/PR loop, auto-merge mechanism, retained closeout truth, or
downstream mutation path.

## Receipt/Distribution Shape

An assimilation GitHub work-management receipt includes these fields:

| Field | Required meaning |
| --- | --- |
| `artifact` | Literal `ASSIMILATION_GITHUB_WORK_MANAGEMENT_V1`. |
| `schema_version` | Receipt shape version; currently `1`. |
| `source_issue_or_pr` | Owner issue or PR that requested the readback. |
| `parent_campaign_url` | Parent BMA campaign issue when applicable. |
| `consuming_repo` | The `briancl2/<repo>` being assessed or updated. |
| `generated_at` | UTC timestamp for the readback. |
| `evidence_refs` | Current GitHub, repo, validation, and review evidence used for the receipt. |
| `permission_insufficient` | Explicit access blocker for PR/check/review/branch/ruleset/parsed-closure evidence; this is not a repo-quality gap. |
| `github_closure_reconciliation` | GitHub-truth closure and cross-session reconciliation readback. |
| `required_ci_and_reviewer_model` | Required checks and authoritative reviewer model, with local review classified as pre-check only. |
| `shared_fact_control` | One-source-of-truth declaration for regime values copied across artifacts. |
| `autonomous_merge_eligibility_candidate` | Candidate-only maturity readback for repo-agent autonomous merge eligibility. |
| `validation_scope` | Focused commands/checks that validate the receipt or consuming change. |
| `owner_routing` | Exact owner surfaces for gaps, permission blockers, or follow-up arcs. |
| `next_owner_action` | One exact next owner action, not a category. |
| `bounded_non_claims` | Explicit limits on automation, mutation, merge authority, and closure truth. |

### github_closure_reconciliation

This field records the GitHub-truth closure and cross-session view before a
repo-agent assimilation item is treated as closed.

Required sub-fields:

- `github_pr_list_readback`: `gh pr list --state all` or equivalent current
  PR truth, including sibling PRs that may implement the same source issue.
- `cross_pr_consistency_checked`: whether related PRs sharing a source issue,
  constant, or regime value were compared.
- `superset_subset_disposition`: when concurrent PRs overlap, which one is
  kept, closed, merged, or blocker-routed.
- `open_review_threads`: unresolved required review findings, especially P2+
  or medium-and-above findings.
- `closing_issue_references`: parsed or equivalent closure references when the
  PR could affect issue state.
- `issue_state_reconciliation`: before/after or current issue-state readback
  for the owner issue and any issue the PR may close.
- `closure_disposition`: `admit`, `blocked_open_reviews`,
  `blocked_cross_pr_inconsistency`, `blocked_unexpected_closure_reference`,
  `permission_insufficient`, or a repo-local equivalent.

Validation rule: local `make review`, `make test`, or work-close output is not
enough for this field. The authoritative evidence is current GitHub issue,
PR, review, check, parsed-closing, and merge truth.

### required_ci_and_reviewer_model

This field records the repo-native gate and review model expected before an
assimilation PR can merge.

Required sub-fields:

- `repo_native_gate`: exact command(s) and expected pass/fail signal.
- `required_checks`: exact GitHub check names or explicit no-protection
  evidence.
- `required_reviewer_model`: the authoritative PR reviewer identity or rule,
  such as the GitHub app/bot or repo policy that owns review truth.
- `local_review_role`: must classify local staged-diff review as a pre-check,
  not a substitute for GitHub-truth PR review.
- `required_review_threshold`: the severity threshold that blocks merge, such
  as P2+/medium-and-above findings when that is the repo policy.
- `review_truth_source`: GitHub PR review threads, review decision, or explicit
  permission blocker.

Validation rule: a repo-local review script may be valuable, but it cannot
prove cross-PR consistency or that authoritative GitHub review threads are
resolved.

### shared_fact_control

This field records one source of truth for regime values shared by more than
one artifact.

Required sub-fields:

- `fact_name`: the shared fact or regime value, such as a CLI version pin.
- `owning_source`: the file, constant, issue, or policy that owns the value.
- `consuming_artifacts`: every artifact that reads or copies the value.
- `drift_check`: test, lint, review rule, or explicit blocker that prevents
  per-artifact copies from drifting.
- `duplicate_copy_disposition`: `single_source`, `copy_sync_with_drift_gate`,
  `blocked_duplicate_without_gate`, or `not_applicable`.

Validation rule: three copies of the same regime value are a drift generator
unless a named source and drift gate make the copies intentional and checked.

### autonomous_merge_eligibility_candidate

This field is a candidate-only maturity readback. It may record that a repo is
a candidate for agent-owned merge follow-through after evidence shows the
repo-native gate is green, commit discipline is wired, required review findings
are resolved, and merge conflicts are verified.

Required sub-fields:

- `candidate_state`: `candidate`, `not_candidate`, `blocked`, or `unknown`.
- `repo_native_gate_green`: boolean or explicit blocker.
- `spec_id_or_spec_exempt_commit_discipline`: whether commit discipline exists
  and was followed.
- `required_review_findings_resolved`: whether P2+/medium-and-above required
  findings are resolved or explicitly blocker-routed.
- `merge_conflicts_resolved_and_verified`: whether conflicts were resolved and
  verified with target-native checks.
- `human_approval_role`: product/directional approval posture, or repo-local
  policy if stronger approval is still required.
- `autonomous_merge_authority`: must be `candidate_only` unless a separate
  repo-local policy, owner issue, PR, checks, and merge evidence authorize a
  more permissive behavior.

Validation rule: this field does not authorize auto-merge, background merge
loops, or broad human-review waivers. It only records whether a repo has enough
evidence to propose or evaluate a repo-local autonomous-merge policy.

## Validation Rules

1. Receipts must cite current GitHub issue/PR/check/review/merge evidence or
   record `permission_insufficient`; memory, local review, and stale issue text
   are not enough.
2. The only V1 work-management fields are
   `github_closure_reconciliation`, `required_ci_and_reviewer_model`,
   `shared_fact_control`, and `autonomous_merge_eligibility_candidate`.
3. `permission_insufficient` must be explicit when PRs, checks, reviews,
   branch/ruleset settings, or parsed-closing evidence cannot be read. It routes
   to access or owner-surface repair and must not be scored as repo-quality
   failure.
4. `github_closure_reconciliation` must include cross-session/cross-PR readback
   when sibling PRs can implement the same source issue or share a regime fact.
5. `required_ci_and_reviewer_model` must name exact checks and the
   authoritative reviewer model. Local staged-diff review must be labeled a
   pre-check.
6. `shared_fact_control` must name the owning source for shared regime values or
   mark duplicate copies blocked until a drift gate exists.
7. `autonomous_merge_eligibility_candidate` is candidate-only and cannot be
   used as merge authority without separate repo-local owner issue/PR/check/
   merge evidence.
8. `next_owner_action` must be exact: a specific issue, PR, contract, detector,
   recommendation, patch bundle, access repair, or repo-local adoption action.
9. Later repo-auditor, repo-upgrade-advisor, repo-optimizer, or BMA acceptance
   propagation requires separate owner issues, branches, PRs, checks, and merge
   truth. This repo-agent-core contract does not implement those arcs.
10. Any implementation that creates a controller, scheduler, queue, daemon,
   registry, dashboard, watcher, retry loop, background poller, automatic
   issue/PR loop, auto-merge path, retained closeout truth, or downstream
   mutation path violates this contract.

## Owner Routing

| Gap | Owner surface |
| --- | --- |
| Shared V1 contract/template gap | repo-agent-core |
| Detector coverage gap for V1 fields | repo-auditor, through a separate owner issue/PR |
| Recommendation packaging gap | repo-upgrade-advisor, through a separate owner issue/PR |
| Optimizer remediation bundle gap | repo-optimizer, through a separate owner issue/PR |
| Repo-local adoption or merge-policy gap | the consuming repo, through its own issue -> branch -> PR -> checks -> merge path |
| Permission/readback gap | the repo or organization surface that controls PR/check/review/branch/ruleset visibility |
| BMA campaign routing gap | build-meta-analysis coordination issue, without changing the primary GBrain lane unless explicitly approved |

If evidence is missing because access is insufficient, route a
`permission_insufficient` owner action before detector/advisor/optimizer claims.
If a gap is not patchable, record a GitHub-visible blocker instead of producing
a speculative patch.

## Bounded Non-Claims

This contract does not:

- close repo-agent-core#117 by itself without a PR, checks, and merge truth;
- implement repo-auditor, repo-upgrade-advisor, repo-optimizer, or BMA
  acceptance arcs;
- score a repo as deficient when GitHub evidence is unreadable because of
  permission limits;
- replace GitHub issue/PR/check/review/merge truth;
- make local staged-diff review authoritative for cross-PR consistency;
- make local work-close output closure truth when GitHub review threads or issue
  state disagree;
- require identical CI or reviewer implementation across repos;
- authorize autonomous merge, auto-merge, background merge loops, or a broad
  waiver of human review;
- mutate downstream or target repositories;
- create issues, create PRs, post comments, merge PRs, or close issues;
- create a controller, scheduler, queue, daemon, registry, dashboard, watcher,
  retry loop, hidden control plane, background poller, automatic updater,
  automatic issue/PR loop, retained closeout package, or background sync.

## Copy-Sync Boundary

Consumers may copy-sync this contract or
`templates/assimilation-github-work-management-v1.md`, or cite them from
detector, advisor, optimizer, campaign, or repo-local adoption surfaces. Copy
drift is review debt handled by focused tests and owner review. Do not add a
runtime dependency, generated registry, controller, scheduler, queue, daemon,
watcher, retry loop, background sync, automatic updater, auto-merge path, or
downstream mutation path to keep copies aligned.
