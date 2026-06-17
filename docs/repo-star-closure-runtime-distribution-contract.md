# Repo-Star Closure Runtime Distribution Contract

> Version: 1.0
> Date: 2026-06-09
> Owner: repo-agent-core

## Purpose

This contract defines the shared repo-star distribution shape for Issue #164
closure-ceremony and runtime-drift lessons. It is the portable owner-surface
contract that repo-auditor detectors, repo-upgrade-advisor recommendations, and
repo-optimizer materialization checks can cite or copy-sync after BMA proves a
pattern should generalize.

The contract is not a runner, runtime dependency, controller, scheduler, queue,
daemon, retry loop, registry, background memory process, auto-merge path,
target-repo mutation grant, or retained report-package truth.

Related contracts:

- `docs/core-five-owner-surface-contract.md`
- `docs/foreground-recovery-runtime-contract.md`
- `docs/downstream-read-only-recovery-runtime-pilot-contract.md`
- `docs/repo-star-downstream-genericity-proof-contract.md`
- `docs/gbrain-repo-local-instruction-distribution-contract.md`

Consumers use this contract by copy-sync or citation only.

## Distribution Record Shape

A closure/runtime distribution record should include:

| Field | Required meaning |
|---|---|
| artifact | Literal `REPO_STAR_CLOSURE_RUNTIME_DISTRIBUTION`. |
| schema_version | Record shape version; currently `1`. |
| source_issue_or_pr | GitHub issue, PR, or campaign surface that authorized distribution. |
| source_contract_refs | repo-agent-core contracts, BMA docs, or PRs used as source evidence. |
| closure_ceremony_regrowth_classes | Closure duplication classes detected, recommended, or ruled out. |
| runtime_drift_classes | Runtime launch, Goal, run-root, heartbeat, CI, and next-action drift classes detected, recommended, or ruled out. |
| coordinator_autonomy_acceptance_classes | Foreground autonomy acceptance overclaim classes detected, recommended, or ruled out. |
| owner_surface_recommendations | Exact owner-surface recommendation rows. |
| validation_scope | Focused native checks required by each owner repo before publication. |
| fallback_routes | GitHub issue/PR owner routes if a detector, recommendation, or materialization path blocks. |
| gbrain_policy | Foreground advisory GBrain lookup/capture policy and canonical-record count. |
| downstream_mutation_policy | Statement that downstream targets stay unmodified unless separately approved. |
| bounded_non_claims | No-regrowth claims that bound what the distribution does not automate or prove. |

## Closure-Ceremony Regrowth Classes

Repo-star detectors and advisors should recognize these closure ceremony
regrowth classes on GitHub-native campaign, instruction, PR-body, and helper
surfaces:

1. Local work packages required for qualifying GitHub-native campaign closure.
2. Completion manifests required where GitHub issue/PR/check/merge truth is
   sufficient.
3. SER or session-end report scorecards treated as task closure proof.
4. Handoff-sync facts used as duplicate task-closure evidence.
5. Retained report packages promoted as durable closure truth.
6. Local duplicate closure receipts next to a qualifying GitHub child issue.
7. Pointer-file compatibility preserved after direct URL validation owns
   campaign closure.
8. Stale direct-closure self-heal artifacts or local receipt writers kept after
   GitHub issue/PR sections and direct validators absorb the safety role.

Positive findings should require a GitHub-native qualifying context or an
instruction/helper surface that would make that context regress. Negative cases
must preserve normal non-qualifying fallback closeout, neutral historical docs,
and explicit diagnostics that are not default task-closure truth.

## Runtime Drift Classes

Repo-star detectors and advisors should recognize these runtime drift classes in
Issue #164 large-arc launch, handoff, and PR-disposition surfaces:

1. Fresh coordinator launch missing explicit transfer mode.
2. Live Issue #164/child/PR/check truth not rechecked before mutation.
3. Goal state omitted without a Goal-null fallback.
4. Canonical `/tmp/issue164-*` run root missing or located inside a target repo.
5. `progress-ledger.jsonl` missing or not used for compact progress evidence.
6. Heartbeat created before the child issue or run root exists.
7. Heartbeat prompt allowed to mutate repos, merge PRs, or create hidden
   control machinery.
8. CI polling and green-clean merge-or-blocker discipline omitted from the
   runtime contract.
9. Next action stated as a category, such as "do real delivery", instead of an
   exact owner surface plus first deliverable.

Negative cases must allow same-thread continuation for active in-flight work,
normal non-Issue-164 delivery, read-only downstream pilots with target state
preserved, and GitHub-visible blockers that intentionally stop at an approval
boundary.

## Coordinator Autonomy Acceptance Classes

Repo-star detectors and advisors should recognize these foreground autonomy
acceptance overclaim classes in Goal episode reports, runtime digests,
Autonomy Preview blocks, Learning / Recovery blocks, PR bodies, and campaign
sync surfaces:

1. Acceptance verdict missing or outside `accepted`, `partial`, `rejected`, or
   `not_applicable`.
2. Non-`not_applicable` verdict missing GitHub issue/PR/check/merge truth.
3. Non-`not_applicable` verdict missing raw runtime evidence, Goal or Goal-null
   state, `/tmp` run root plus `progress-ledger.jsonl`, or heartbeat
   capture/disposition.
4. Verdict lacks a demotion trigger or next exact owner-surface action.
5. Promotion gate is vague, category-only, or detached from owner-surface
   validation.
6. Acceptance claim treats doctrine, retained reports, comments, or local
   ledgers as closure truth without GitHub merge/check/closure evidence.
7. Acceptance claim implies background autonomy, Codex Cloud/remote execution,
   Hermes-primary ownership, canonical GBrain memory, automatic issue/PR
   creation, auto-merge, downstream mutation, controller, scheduler, queue,
   daemon, registry, retry loop, or hidden control plane without separate
   approval and evidence.

Negative cases must allow `not_applicable` verdicts, doctrine-only non-claims,
null GBrain lookups with a concrete no-capture reason, and foreground
coordinator episodes that stop at a GitHub-visible blocker.

## Owner-Surface Recommendation Fields

Every repo-upgrade-advisor recommendation produced from these detectors should
include:

| Field | Required meaning |
|---|---|
| exact_owner_surface | One of BMA, repo-agent-core, repo-auditor, repo-upgrade-advisor, repo-optimizer, or a named GitHub owner issue. |
| first_deliverable | Exact first PR, detector, recommendation package, materialization check, or owner issue. |
| validation_scope | Focused tests and repo-native checks needed before publication. |
| fallback | GitHub-visible owner route if the deliverable blocks or evidence is insufficient. |
| github_issue_routing | Issue or PR surface that should carry closure, blocker, or learning truth. |
| bounded_non_claims | Explicit no-controller, no-scheduler, no-queue, no-daemon, no-registry, no-retained-package, no-downstream-mutation, and no-background-memory claims. |
| source_citation | repo-agent-core/BMA contract citation or source evidence when guidance is copied. |

Recommendations must be owner-actionable. They should not hand back a category,
create a readiness packet as the deliverable, or require retained local
closeout truth where GitHub issue/PR/check/merge truth is sufficient.

## Optimizer Materialization Boundary

repo-optimizer may materialize context-reduction or patch-pack guidance only
when repo-auditor findings and repo-upgrade-advisor recommendations identify a
specific owner surface, patchable file set, and validation path. A safe
materialization record should keep generated patches outside downstream targets
unless the target repo is itself an approved owner surface, run `git apply
--check` or an equivalent dry-run only, and route blockers to GitHub owner
truth.

If no concrete patch/context-reduction gap exists, repo-optimizer should be
skipped on the GitHub issue/PR surface with evidence. The skip is not a failed
arc when the child issue records why optimizer materialization would be
speculative.

## GBrain Policy

GBrain may influence this distribution only as foreground advisory memory:

- Use bounded sequential reads when they can affect selection, launch, or
  reusable learning.
- Record a no-capture reason for null, routine, duplicate, or non-decision
  results.
- Capture draft or shadow advisory learning only when a reusable
  decision-changing lesson is produced by the owner work.
- `canonical_records_written` must remain `0`.

GBrain does not override operator intent, GitHub issue/PR/check/merge truth,
repo evidence, or repo-local instructions.

## Bounded Non-Claims

Every distribution should include clauses equivalent to:

- This distribution does not make retained local reports, work packages,
  completion manifests, SER, handoff-sync facts, pointer files, or local
  receipts task-closure truth for qualifying GitHub-native campaign work.
- This distribution does not mutate downstream target repositories.
- This distribution does not open downstream PRs or issues without fresh
  approval.
- This distribution does not make GBrain canonical.
- This distribution does not start persistent memory automation.
- This distribution does not adopt `hermes -z`, make Hermes the campaign owner,
  or claim Hermes primary-doer autonomy.
- This distribution does not create a controller, scheduler, queue, registry,
  daemon, retry loop, auto-updater, auto-merge path, hidden control plane, MCP
  server, minion, cron job, service, or retained report-package closure path.

## Copy-Sync Boundary

Consumers may copy-sync this contract or template into repo-star surfaces, or
cite them from detector/advisor/optimizer evidence. Copy drift is repo quality
debt handled through review and focused drift gates. Do not add a runtime
dependency, generated registry, scheduler, queue, controller, daemon, watcher,
retry loop, automatic updater, or background sync to keep copies aligned.
