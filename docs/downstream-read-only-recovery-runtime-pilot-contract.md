# Downstream Read-Only Recovery Runtime Pilot Contract

## Foreground Failure Guidance / Recovery

- Failure signal: name the failed foreground command, exit status, and user-visible symptom.
- Recovery owner: link the owner issue, PR, or operator surface responsible for follow-up.
- Recovery action: state the next bounded foreground command or manual owner step; keep it one-shot and explicit.
- Evidence receipt: cite the stdout/stderr receipt path, CI run, or command transcript used to justify recovery.
- Bounded non-claims: This block does not authorize controllers, schedulers, queues, daemons, retry loops, retained reports, downstream mutation, or target mutation.

> Version: 1.0
> Date: 2026-06-02
> Owner: repo-agent-core

## Purpose

This compact contract defines a shared receipt shape for Issue #164 downstream
read-only recovery-runtime pilots. A pilot may replay or compose artifacts from
repo-auditor, repo-upgrade-advisor, and repo-optimizer against a downstream
repository identity, but it remains a bounded evidence-gathering artifact. It is
not runtime behavior.

Related contracts:

- `docs/foreground-recovery-runtime-contract.md`
- `docs/hermes-foreground-launcher-contract.md`
- `docs/interruption-recovery-and-batch-reconstitution-contract.md`
- `docs/foreground-learning-and-recovery-contract.md`

Consumers use this contract by copy-sync or citation only.

## Pilot Boundary

A downstream read-only recovery-runtime pilot can inspect a target repository and
produce artifacts only outside the target repo, usually /tmp or another explicit
operator-provided scratch directory outside the checkout. The pilot never writes
inside the target repo, never applies patches, and never opens downstream
PRs/issues.

Generated patches, patch metadata, blocker notes, and apply-check output are
receipts for operator review. They are not permission to mutate the downstream
checkout and are not a downstream automation path.

## Receipt Shape

A receipt artifact should use a compact JSON-compatible shape named
`DOWNSTREAM_READ_ONLY_RECOVERY_RUNTIME_PILOT_RECEIPT`. It is a documentation
contract rather than a committed JSON schema. Required fields preserve enough
identity, replay evidence, and no-mutation proof for a downstream pilot handoff:

| Field | Required meaning |
|---|---|
| artifact | Literal `DOWNSTREAM_READ_ONLY_RECOVERY_RUNTIME_PILOT_RECEIPT`. |
| schema_version | Receipt shape version; currently `1`. |
| generated_at | UTC timestamp for the receipt. |
| target_repo_identity | Stable target repo identity, preferably `owner/name` plus remote URL when available. |
| target_path_or_name | Target checkout path or repo name inspected by the pilot. |
| target_git_head_before | Git HEAD of the target repo before pilot inspection. |
| target_git_head_after | Git HEAD of the target repo after pilot inspection. Must match `target_git_head_before` for a read-only pilot. |
| target_dirty_count_before | Count of dirty target repo entries before pilot inspection. |
| target_dirty_count_after | Count of dirty target repo entries after pilot inspection. Must match `target_dirty_count_before` for a read-only pilot. |
| auditor_as_replay_artifact_path | Path to the retained repo-auditor-as replay artifact generated outside the target repo. |
| advisor_artifact_path | Path to the retained repo-upgrade-advisor artifact generated outside the target repo. |
| optimizer_replay_receipt_path | Path to the retained repo-optimizer replay receipt generated outside the target repo. |
| generated_patch_pack_path | Path to any generated patch pack for review, stored outside the target repo. |
| patch_metadata_path | Path to patch metadata explaining source artifacts, target identity, and intended operator review context. |
| blocker_path | Path to blocker evidence when the pilot cannot produce a complete patch pack or apply-check result. |
| apply_check_result_path | Path to read-only apply-check output produced outside the target repo without applying patches to the checkout. |
| bounded_non_claims | No-downstream-mutation claims that bound what the receipt does not prove or perform. |

## Validation Rules

A valid downstream read-only recovery-runtime pilot receipt:

1. Preserves target identity through `target_repo_identity` and
   `target_path_or_name`.
2. Preserves target git state by recording `target_git_head_before` and
   `target_git_head_after`; read-only success requires these values to match.
3. Preserves target dirtiness by recording `target_dirty_count_before` and
   `target_dirty_count_after`; read-only success requires these values to match.
4. Records the auditor, advisor, and optimizer evidence paths:
   `auditor_as_replay_artifact_path`, `advisor_artifact_path`, and
   `optimizer_replay_receipt_path`.
5. Records review artifacts outside the target repo:
   `generated_patch_pack_path`, `patch_metadata_path`, `blocker_path`, and
   `apply_check_result_path`.
6. Includes `bounded_non_claims` that state the pilot does not mutate the target
   repo and does not automate downstream follow-up.

## Bounded Non-Claims

Every receipt should include no-downstream-mutation bounded non-claims equivalent
to these clauses:

- This receipt does not apply patches.
- This receipt does not open downstream PRs or issues.
- This receipt does not mutate the target repo.
- This receipt does not install hooks or change target repo configuration.
- This receipt does not start a daemon, scheduler, queue, controller, retry loop,
  hidden registry, background sync, MCP server, watcher, cron job, service, or
  autopilot.
- This receipt does not perform automatic GitHub issue creation.
- This receipt does not claim the generated patch pack is safe to apply without
  explicit operator review and an explicit downstream write step outside this
  pilot.

## No-Regrowth Boundary

Do not implement this pilot through a runtime dependency: no daemon, no scheduler, no queue, no controller, no retry loop, no hidden registry, no background sync, no MCP server, no watcher, no cron job, no service, no autopilot, no automatic GitHub issue creation, and no other hidden control plane.

The pilot can write only outside the target repo, usually /tmp. It never applies
patches and never opens downstream PRs/issues. Any later downstream mutation,
patch application, pull request, issue, or repo configuration change requires an
explicit operator action outside this contract.

## Copy-Sync Boundary

Consumers may copy-sync this contract into downstream docs or cite it from local
pilot receipts. Copy drift is a normal repo-quality issue handled by review. Do
not add a daemon, scheduler, queue, controller, retry loop, hidden registry,
background sync, MCP server, automatic GitHub issue creation, or any runtime
synchronization mechanism to keep copies aligned.
