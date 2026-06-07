# Hermes Doer With GBrain-Distributed Repo-Local Instructions Contract

> Version: 1.0
> Date: 2026-06-07
> Owner: repo-agent-core

## Purpose

This contract defines how a repo may use Hermes as a bounded foreground
first-attempt doer while consuming repo-local instruction surfaces that cite or
copy-sync advisory GBrain distribution guidance.

The contract composes, but does not replace:

- `docs/hermes-foreground-launcher-contract.md`
- `docs/foreground-recovery-runtime-contract.md`
- `docs/gbrain-repo-local-instruction-distribution-contract.md`

Hermes remains a foreground implementation attempt. GBrain remains advisory memory.
GitHub issue/PR/check/merge truth, operator intent, repo evidence, and repo-local
instructions remain the owner truth.

Consumers use this contract by copy-sync or citation only. It is not a runtime
dependency, scheduler, controller, queue, daemon, retry loop, MCP server,
background sync, hidden registry, automatic updater, or autonomous campaign
operator.

## Episode Shape

A valid episode has seven foreground phases:

1. Confirm the GitHub issue or PR authorizes the work and names the repo-local
   instruction surfaces that govern the attempt.
2. Retrieve or cite only advisory GBrain-distributed guidance that has source,
   citation, provenance, or GitHub surface references.
3. Prepare a scoped Hermes prompt that points Hermes at the repo-local
   instruction surfaces and the concrete implementation target.
4. Run one bounded foreground Hermes attempt through the consuming repo's
   approved launcher path.
5. Validate Hermes output with launcher receipt checks before Codex or another
   coordinator consumes the diff.
6. Run repo-native validation for the touched owner surface.
7. Route timeout, empty output, missing receipt, broad rewrite, stale guidance,
   or ambiguous evidence to the owner GitHub surface before fallback work.

## Receipt Shape

A Hermes/GBrain doer receipt should include:

| Field | Required meaning |
|---|---|
| artifact | Literal `HERMES_DOER_WITH_GBRAIN_DISTRIBUTED_REPO_LOCAL_INSTRUCTIONS`. |
| schema_version | Receipt shape version; currently `1`. |
| generated_at | UTC timestamp for the receipt. |
| source_issue_or_pr | Work issue or PR authorizing the attempt. |
| consuming_repo | Repo where the foreground attempt ran. |
| instruction_surfaces | Repo-local instruction surfaces cited by the prompt. |
| gbrain_distribution_contract | Contract or template cited for advisory GBrain distribution. |
| gbrain_records_or_no_capture_reason | Advisory slugs used, or why no decision-changing GBrain record was captured. |
| hermes_launcher_contract | Contract or launcher path used for the foreground attempt. |
| hermes_receipt | Path or URL to the `HERMES_FOREGROUND_RUN_RECEIPT`. |
| failure_guidance | Path, URL, or not-applicable reason for failure guidance. |
| repo_native_validation | Commands and check results from the consuming repo. |
| owner_routing | Next owner-surface action for stale guidance, Hermes failure, or validation failure. |
| advisory_status | Must state that GBrain remains advisory. |
| hermes_campaign_owner | Must be `false`. |
| canonical_override_allowed | Must be `false`. |
| background_gbrain_behavior_used | Must be `false`. |
| bounded_non_claims | Statements bounding what the episode does not claim or automate. |

## Validation Rules

A valid episode:

1. Uses Hermes only as a bounded foreground first-attempt doer.
2. Keeps Codex, the operator, or the consuming repo owner responsible for
   selection, synthesis, validation, PR/CI/merge closure, and recovery.
3. Points Hermes at repo-local instruction surfaces rather than a hidden memory
   or controller surface.
4. Uses GBrain only as advisory distribution guidance backed by source, citation, provenance, or GitHub surface references.
5. Preserves advisory boundary language wherever GBrain is referenced.
6. Forbids claims that promote GBrain canonicality, source-of-truth status, or
   override power over local instructions.
7. Forbids background GBrain behavior, bulk import, sync/watch, cron, autopilot,
   dream, jobs worker, MCP serving, minions, daemons, schedulers, queues, hidden
   registries, and automatic updater behavior.
8. Forbids `hermes -z` as adoption proof unless a later owner-approved contract
   lifts the quarantine with upstream-main and same-version local proof.
9. Validates through the consuming repo's native checks, tests, review surface,
   or documented no-check reason.
10. Routes failed or ambiguous guidance to the semantic owner surface instead of
    creating a local proof hunt or hidden control plane.

## Bounded Non-Claims

Every episode should include clauses equivalent to:

- This episode does not make Hermes the campaign owner.
- This episode does not prove Hermes primary-doer autonomy.
- This episode does not make GBrain canonical.
- This episode does not let GBrain override operator intent, GitHub truth, repo
  evidence, or repo-local instructions.
- This episode does not bulk-import a corpus.
- This episode does not run `gbrain sync --watch`, cron, autopilot, dream, jobs
  worker, MCP serving, minions, daemons, schedulers, queues, hidden registries,
  or background memory behavior.
- This episode does not adopt `hermes -z` as production proof.
- This episode does not mutate downstream target repos.
- This episode does not add a runtime dependency, scheduler, controller, queue,
  daemon, retry loop, MCP server, generated registry, automatic updater, or
  background sync mechanism.

## Owner Routing

Use the semantic owner surface for failed or ambiguous lanes:

- Hermes launcher, receipt, or failure-guidance gap: consuming repo or BMA
  launcher owner surface.
- Stale, missing, uncited, or overclaiming advisory GBrain guidance: GBrain
  record owner or the GitHub issue/PR that needs to repair the source claim.
- Shared composition contract gap: repo-agent-core.
- Overclaim detection gap: repo-auditor.
- Adoption recommendation packaging gap: repo-upgrade-advisor.
- Patch/materialization or optimization proof gap: repo-optimizer.

## Copy-Sync Boundary

Consumers may copy this contract, copy the template, or cite either artifact in
their own instruction surfaces and receipts. Copy drift is repo quality debt.
Do not add a runtime dependency, generated registry, scheduler, queue,
controller, daemon, watcher, retry loop, automatic updater, background sync,
MCP server, or import framework to keep copies aligned.
