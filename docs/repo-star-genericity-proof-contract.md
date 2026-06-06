# Repo-Star Genericity Proof Contract

> Version: 1.0
> Date: 2026-06-06
> Owner: repo-agent-core

## Purpose

This contract defines the shared receipt shape for proving that repo-star
capabilities are generic beyond BMA without mutating a target repository. It is
a proof artifact contract, not a runner, scheduler, controller, queue, daemon,
or background sync mechanism.

No-regrowth boundary: no daemon, no scheduler, no queue, no controller, no
retry loop, no hidden registry, no background sync, no MCP server, and no
automatic GitHub issue creation.

The first proof target should be a controlled non-BMA git repository under
`/tmp` or another explicit scratch root outside every checked-out target repo.
The receipt must preserve target identity, before/after git state, owner-surface
artifact paths, and bounded non-claims.

Related contracts:

- `docs/core-five-owner-surface-contract.md`
- `docs/downstream-read-only-recovery-runtime-pilot-contract.md`

Consumers use this contract by copy-sync or citation only.

## Receipt Shape

A receipt artifact should validate as
`REPO_STAR_GENERICITY_PROOF_RECEIPT`. Required fields preserve enough
information to prove genericity without target mutation:

| Field | Required meaning |
|---|---|
| artifact | Literal `REPO_STAR_GENERICITY_PROOF_RECEIPT`. |
| schema_version | Receipt shape version; currently `1`. |
| generated_at | UTC timestamp for the receipt. |
| proof_root | Scratch proof root outside target repos, usually `/tmp/repo-star-genericity-<timestamp>`. |
| target_repo_identity | Stable non-BMA target identity, preferably repo name plus remote URL when available. |
| target_path_or_name | Target checkout path or repo name inspected by the proof. |
| target_is_non_bma | Boolean proving the target is not BMA. |
| target_git_head_before | Git HEAD of the target repo before proof inspection. |
| target_git_head_after | Git HEAD of the target repo after proof inspection. Must match before for read-only success. |
| target_dirty_count_before | Count of dirty target repo entries before proof inspection. |
| target_dirty_count_after | Count of dirty target repo entries after proof inspection. Must match before for read-only success. |
| evidence_written_outside_target | Boolean proving generated evidence stayed outside the target repo. |
| target_mutation_performed | Must be `false`. |
| auditor_artifact_path | Path to repo-auditor evidence generated outside the target repo. |
| advisor_artifact_path | Path to repo-upgrade-advisor recommendation packaging outside the target repo. |
| optimizer_artifact_path | Path to repo-optimizer report, patch pack, blocker, or apply-check receipt outside the target repo. |
| apply_check_result_path | Path to read-only apply-check output when a patch pack exists; otherwise null with blocker evidence. |
| blocker_path | Path to blocker evidence when any owner surface cannot produce its proof artifact. |
| owner_routing | Owner-surface fallback routes for auditor, advisor, optimizer, and shared-contract blockers. |
| genericity_verdict | `pass`, `fail`, `blocked`, or `not_run`. |
| bounded_non_claims | No-mutation and no-automation claims bounding what the receipt does not prove or perform. |

## Validation Rules

A valid repo-star genericity proof:

1. Uses a non-BMA target repo under `/tmp` or another explicit scratch root.
2. Writes generated evidence outside the target repo.
3. Preserves target git head and dirty count before and after proof execution.
4. Records repo-auditor, repo-upgrade-advisor, and repo-optimizer artifact
   paths or records a blocker path with owner routing.
5. Validates generated patch packs with `git apply --check` only; it never applies patches.
6. Names the exact owner surface for every blocker:
   repo-auditor for detection, repo-upgrade-advisor for recommendation
   packaging, repo-optimizer for patch-pack materialization, and repo-agent-core for shared receipt-contract gaps.
7. Includes bounded non-claims that reject downstream mutation and hidden
   control planes.

## Bounded Non-Claims

Every receipt should include clauses equivalent to:

- This receipt does not mutate the target repo.
- This receipt does not apply patches.
- This receipt does not open downstream PRs or issues.
- This receipt does not install hooks or change target repo configuration.
- This receipt does not start a daemon, scheduler, queue, controller, retry
  loop, hidden registry, background sync, MCP server, watcher, cron job,
  service, or autopilot.
- This receipt does not claim repo-star genericity unless target state is
  preserved and all required owner-surface artifacts or blockers are recorded.

## Copy-Sync Boundary

Consumers may copy-sync this contract, schema, or template into repo-star
surfaces or cite them from proof receipts. Copy drift is repo quality debt. Do
not add a runtime dependency, generated registry, scheduler, queue, controller,
daemon, watcher, retry loop, automatic updater, or background sync to keep
copies aligned.
