# Repo-Star Downstream Genericity Proof Contract

> Version: 1.0
> Date: 2026-06-08
> Owner: repo-agent-core

## Purpose

This contract defines the shared two-target receipt shape for proving that
repo-star capabilities can inspect real non-BMA downstream repositories without
mutating them or exporting BMA campaign ceremony. It is a proof artifact
contract, not a runner, scheduler, controller, queue, daemon, retry loop,
registry, MCP server, background sync mechanism, or automatic GitHub workflow.

No-regrowth boundary: no daemon, no scheduler, no queue, no controller, no
retry loop, no hidden registry, no background sync, no MCP server, no watcher,
no cron job, no autopilot, and no automatic GitHub issue creation.

The first intended use is an Issue #164 downstream genericity proof across two
real read-only targets, such as `portfolio_advisor` and `CustomerNewsletter`.
The receipt must preserve target identity, before/after git state, target-native
gate classification, repo-star command/output roots, privacy posture, BMA
ceremony leakage checks, owner routing, and bounded non-claims.

Related contracts:

- `docs/repo-star-genericity-proof-contract.md`
- `docs/downstream-read-only-recovery-runtime-pilot-contract.md`
- `docs/core-five-owner-surface-contract.md`

Consumers use this contract by copy-sync or citation only.

## Receipt Shape

A receipt artifact should validate as
`REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT`. Required fields preserve enough
information to prove two-target genericity without target mutation:

| Field | Required meaning |
|---|---|
| artifact | Literal `REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT`. |
| schema_version | Receipt shape version; currently `1`. |
| generated_at | UTC timestamp for the receipt. |
| source_issue_or_pr | GitHub issue, PR, or comment that authorized or summarized the proof. |
| proof_root | Scratch proof root outside target repos, usually `/tmp/issue164-...`. |
| target_identities | Two target identity records, each with repo identity, path/name, remote URL when available, privacy note, and `target_is_non_bma=true`. |
| target_git_state_matrix | Two before/after git state rows, each preserving head, dirty status, and status text before and after replay. |
| target_native_gate_matrix | Two target-native gate rows, each classified as `no_retained_gate`, `parseable_pass`, `parseable_warning`, `parseable_fail`, `partial_run`, `stale_fleet_metric`, `true_target_risk`, or `amendment_required_unknown`. |
| repo_star_command_list | Repo-star commands run or skipped, with target, tool, status, receipt path, and skip reason when applicable. |
| output_roots | Output roots for repo-auditor, repo-upgrade-advisor, repo-optimizer, generated patch artifacts, blocker evidence, and apply-check receipts, all outside targets. |
| privacy_redaction_note | Statement bounding file-level evidence and excluding secrets, portfolio values, account-level details, and proprietary content unless minimally required. |
| bma_ceremony_leakage_checklist | Checklist proving BMA labels, Issue #164 task-closure semantics, retained report packages, completion manifests, local closeout receipts, campaign sync, and BMA-only receipt paths were not exported into targets. |
| github_summary_surface | Issue, PR, or comment where the compact proof outcome is recorded. |
| owner_routing | Owner-surface fallback routes for contract, detector, recommendation, materialization, target-native gate, privacy, and downstream-read-only blockers. |
| genericity_verdict | `pass`, `partial`, `fail`, `blocked`, or `not_run`. |
| bounded_non_claims | No-mutation, no-automation, no-canonical-GBrain, and no-Hermes-primary claims bounding what the receipt does not prove or perform. |

## Validation Rules

A valid repo-star downstream genericity proof:

1. Records exactly two real non-BMA targets unless the authorizing GitHub
   surface names a different count.
2. Writes generated evidence only outside target repositories.
3. Preserves each target git head, dirty state, and status text before and after
   replay; read-only success requires exact before/after matches.
4. Records a target-native gate classification for each target using the
   allowed matrix states instead of flattening ambiguity into a generic
   `unknown`.
5. Separates no retained gate, parseable pass/fail/warning, partial run, stale
   fleet metric, true target risk, and amendment-required unknown.
6. Records repo-auditor, repo-upgrade-advisor, and repo-optimizer commands or
   intentional skip rows. Do not force repo-upgrade-advisor without auditor evidence,
   and do not force repo-optimizer without a patch-ready owner row.
7. Stores generated patches and apply-check receipts outside targets and uses
   `git apply --check` or equivalent dry-run only. It never applies patches.
8. Includes a BMA ceremony leakage checklist proving BMA labels, Issue #164 task-closure semantics,
   retained report packages, completion manifests,
   local closeout receipts, campaign-sync machinery, and BMA-only receipt paths
   were not exported into either target.
9. Includes privacy redaction language suitable for downstream repositories
   whose content may include portfolio, account, newsletter, customer, or other
   proprietary details.
10. Names the exact owner surface for every blocker: repo-agent-core for shared
    receipt-contract gaps, repo-auditor for detection/gate classification,
    repo-upgrade-advisor for recommendation packaging, repo-optimizer for
    patch-pack materialization, and the coordinator GitHub issue/PR for
    downstream read-only or privacy stop rules.

## Bounded Non-Claims

Every receipt should include clauses equivalent to:

- This receipt does not mutate downstream targets.
- This receipt does not apply patches.
- This receipt does not open downstream PRs or issues.
- This receipt does not add BMA labels, Issue #164 task-closure semantics, retained
  report packages, completion manifests, local closeout receipts, campaign-sync
  machinery, or BMA-only receipt paths to target repositories.
- This receipt does not install hooks or change target repo configuration.
- This receipt does not make GBrain canonical or start background GBrain
  behavior.
- This receipt does not adopt `hermes -z`, make Hermes the campaign owner, or
  claim Hermes primary-doer autonomy.
- This receipt does not start a daemon, scheduler, queue, controller, retry
  loop, hidden registry, background sync, MCP server, watcher, cron job,
  service, autopilot, or automatic GitHub issue creation.
- This receipt does not claim broad downstream adoption beyond the named targets
  and recorded owner-surface evidence.

## Copy-Sync Boundary

Consumers may copy-sync this contract, schema, or template into repo-star
surfaces or cite them from proof receipts. Copy drift is repo quality debt. Do
not add a runtime dependency, generated registry, scheduler, queue, controller,
daemon, watcher, retry loop, automatic updater, or background sync to keep
copies aligned.
