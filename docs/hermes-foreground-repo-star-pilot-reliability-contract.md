# Hermes Foreground Repo-Star Pilot Reliability Contract

> Version: 1.0
> Date: 2026-06-08
> Owner: repo-agent-core

## Purpose

This contract defines the shared receipt shape for measuring bounded Hermes
foreground reliability against repo-star downstream read-only pilot prompts. It
is a measurement and owner-routing contract, not a runner, scheduler,
controller, queue, daemon, retry loop, hidden registry, MCP server, background
sync mechanism, autonomous Hermes operating mode, or automatic GitHub workflow.

No-regrowth boundary: no daemon, no scheduler, no queue, no controller, no
retry loop, no hidden registry, no background sync, no MCP server, no watcher,
no cron job, no autopilot, and no automatic GitHub issue creation.

The first intended use is an Issue #164 reliability measurement episode after
repo-star downstream genericity has been proven across real read-only targets.
The receipt must preserve target identity, before/after git state, Hermes
launcher command and receipt paths, prompt scope, runtime outcome taxonomy,
repo-star evidence inputs, failure conversion status, owner routing, and
bounded non-claims.

Related contracts:

- `docs/hermes-foreground-launcher-contract.md`
- `docs/foreground-recovery-runtime-contract.md`
- `docs/downstream-read-only-recovery-runtime-pilot-contract.md`
- `docs/repo-star-downstream-genericity-proof-contract.md`

Consumers use this contract by copy-sync or citation only.

## Receipt Shape

A receipt artifact should validate as
`HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT`. Required fields
preserve enough information to measure foreground Hermes behavior without
mutating downstream targets:

| Field | Required meaning |
|---|---|
| artifact | Literal `HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT`. |
| schema_version | Receipt shape version; currently `1`. |
| generated_at | UTC timestamp for the receipt. |
| source_issue_or_pr | GitHub issue, PR, or comment that authorized or summarized the measurement. |
| measurement_root | Scratch measurement root outside target repositories, usually `/tmp/issue164-...`. |
| hermes_launcher | Bounded foreground launcher identity, including provider/model, prompt path, output root, receipt path, failure guidance path, and explicit `hermes -z` non-use. |
| target_identities | Target identity records with repo identity, path/name, remote URL when available, privacy note, and `target_is_non_bma=true`. |
| target_git_state_matrix | Before/after git state rows preserving head, dirty status, and status text before and after Hermes attempts. |
| reliability_trial_matrix | Trial rows with prompt id, target, command, timeout, exit status, receipt path, failure guidance path, outcome, duration, and target-mutation observation. |
| reliability_summary | Aggregate counts and verdict across the trial matrix. |
| repo_star_inputs | Auditor, advisor, optimizer, or prior genericity artifacts that informed prompt scope or owner routing. |
| output_roots | Output roots for prompts, Hermes receipts, failure guidance, generated patches, dry-run apply checks, blockers, and summaries, all outside targets. |
| failure_conversion | Whether route-changing Hermes failures were converted to GitHub issue/comment truth or intentionally left as non-route-changing measurement evidence. |
| owner_routing | Owner-surface fallback routes for launcher validation, recovery guidance, detector, recommendation, materialization, privacy, and downstream-read-only blockers. |
| bounded_non_claims | No-mutation, no-automation, no-Hermes-primary, no-`hermes -z`, and no-canonical-GBrain claims bounding what the receipt does not prove or perform. |

## Reliability Outcome Taxonomy

Each trial should use one of these outcome values:

- `clean_receipt`: Hermes exited normally, stdout validated, and a
  `HERMES_FOREGROUND_RUN_RECEIPT` exists.
- `empty_stdout`: process behavior produced no useful final response.
- `missing_receipt`: output existed but the launcher receipt was absent.
- `timeout`: outer timeout or bounded run budget expired.
- `warning_only`: output was only warnings or environment noise.
- `session_only`: output was only session metadata.
- `useful_analysis_with_failure`: Hermes produced useful analysis but failed the
  clean receipt contract.
- `target_mutation_attempt`: Hermes attempted or caused downstream mutation.
- `broad_rewrite_risk`: prompt/result attempted broad rewrite outside the
  bounded pilot scope.
- `launcher_failure`: wrapper or launcher command failed before a valid
  measurement could be made.
- `validation_failure`: receipt or stdout failed validator checks.
- `not_run`: trial was intentionally skipped with a recorded reason.

## Validation Rules

A valid reliability measurement:

1. Uses bounded foreground `hermes chat` through an approved launcher such as
   `scripts/run-hermes-foreground.py --provider copilot --model gpt-5.5`.
2. Records explicit provider/model flags unless the authorizing surface records
   same-episode proof for defaults.
3. Does not use or adopt `hermes -z`.
4. Writes prompts, receipts, failure guidance, summaries, generated patch text,
   and apply-check receipts only outside downstream targets.
5. Preserves each downstream target git head, dirty state, and status text
   before and after all Hermes attempts; read-only success requires exact
   before/after matches.
6. Separates clean receipts from empty stdout, missing receipts, timeouts,
   warning-only output, session-only output, useful analysis with failure,
   target mutation attempts, broad rewrite risk, launcher failure, validation
   failure, and intentional skips.
7. Records the repo-star evidence inputs that scoped the prompt or changed
   owner routing.
8. Converts route-changing Hermes failures to GitHub issue/comment truth before
   Codex fallback, or records a non-route-changing measurement reason.
9. Names the exact owner surface for every blocker: build-meta-analysis for the
   launcher or campaign coordinator, repo-agent-core for shared contracts,
   repo-auditor for detection/overclaim gaps, repo-upgrade-advisor for
   recommendation packaging, and repo-optimizer for patch-pack materialization.
10. Includes privacy redaction language suitable for downstream repositories
    whose content may include portfolio, account, newsletter, customer, or
    other proprietary details.

## Bounded Non-Claims

Every receipt should include clauses equivalent to:

- This receipt does not mutate downstream targets.
- This receipt does not apply patches.
- This receipt does not open downstream PRs or issues.
- This receipt does not make Hermes the campaign owner or primary autonomous
  operator.
- This receipt does not adopt or validate `hermes -z`.
- This receipt does not mutate Hermes internals or install Hermes-side
  background behavior.
- This receipt does not make GBrain canonical or start background GBrain
  behavior.
- This receipt does not start a daemon, scheduler, queue, controller, retry
  loop, hidden registry, background sync, MCP server, watcher, cron job,
  service, autopilot, or automatic GitHub issue creation.
- This receipt does not claim broad downstream adoption beyond the named
  targets and recorded reliability evidence.

## Copy-Sync Boundary

Consumers may copy-sync this contract, schema, or template into repo-star
surfaces or cite them from reliability receipts. Copy drift is repo quality
debt. Do not add a runtime dependency, generated registry, scheduler, queue,
controller, daemon, watcher, retry loop, automatic updater, or background sync
to keep copies aligned.
