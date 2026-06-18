# Codex Native Runtime Readiness Contract

> Version: 1.0
> Date: 2026-06-17
> Owner: repo-agent-core

## Purpose

This contract defines the portable Issue #164 record shape for assessing Codex
native local, worktree, cloud, remote, automation, and subagent readiness before
moving a foreground owner-surface lane to a different runtime placement.

It is copy-sync guidance for GitHub issues, PR bodies, repo-local docs, and
fleet-local checks. It is not a runtime package, controller, scheduler, queue,
daemon, retry loop, registry, background sync, automatic issue/PR creator,
auto-merge path, retained closeout package, downstream mutation grant, or live
Codex Cloud/remote execution proof.

Use it when a campaign wants to promote Codex from local/worktree foreground
coordination into a better-assessed native runtime harness, or when an owner
repo needs to reject that promotion because the raw evidence is missing.

Related contracts:

- `docs/capability-placement-contract.md`
- `docs/goal-episode-evaluation-contract.md`
- `docs/repo-star-closure-runtime-distribution-contract.md`
- `docs/scheduled-runtime-learning-shadow-readback-contract.md`
- `docs/github-parsed-closure-semantics-contract.md`

Consumers use this contract by copy-sync or citation only.

## Readiness Record Shape

| Field | Required meaning |
|---|---|
| artifact | Literal `CODEX_NATIVE_RUNTIME_READINESS`. |
| schema_version | Record shape version; currently `1`. |
| source_issue_or_pr | GitHub issue, PR, or campaign surface that authorized the assessment. |
| capability | Capability under assessment, usually `Codex Native Runtime / Cloud / Remote Readiness`. |
| transfer_mode | One of `fresh_thread`, `same_thread_continuation`, or `forked_thread`; manual fallback belongs in `launch_fallback`, not as a new transfer enum. |
| runtime_surfaces_checked | Official Codex surfaces considered, including local environments, worktrees, cloud environments, automations, remote connections, and subagents when relevant. |
| official_codex_context | Official Codex manual or docs references used for capability context. |
| raw_evidence_basis | Session log, Goal receipt, command transcript, CI/check run, run root, or issue/PR truth that supports any runtime-readiness claim. |
| goal_state | Active, completed, blocked, or Goal-null fallback with source. |
| run_root | `/tmp/issue164-*` run root used for the episode, outside target repos. |
| progress_ledger | Path to `progress-ledger.jsonl` under the run root. |
| runtime_context_payload | Runtime-context JSON path, preflight command, and summary result when the assessing repo has such a checker. |
| heartbeat_lifecycle | Heartbeat id/name, created-after prerequisites, prompt authority, capture/disposition, and deletion or unavailable fallback. |
| local_worktree_dogfood | Local/worktree evidence from the actual run, separated from official docs context. |
| cloud_remote_disposition | Whether cloud/remote execution was `not_run_context_only`, `raw_evidence_proven`, `blocked`, or `not_applicable`. |
| automation_subagent_disposition | Whether automations/subagents were context only, explicitly user-triggered, blocked, or not applicable; no background controller claim. |
| github_truth | Linked issue, PR, check, merge, and closure truth for what landed. |
| ci_polling_terminal_condition | Green-clean merge, GitHub-visible blocker, approval boundary, or rejected evidence. |
| promotion_gate | Exact evidence required before repeating, broadening, or placing future work on the assessed runtime surface. |
| demotion_rejection_trigger | Conditions that demote or reject the readiness claim. |
| kill_switch | Concrete owner action when evidence is missing or the route crosses a forbidden boundary. |
| bounded_non_claims | Explicit no-live-cloud/remote, no-controller, no-scheduler, no-queue, no-daemon, no-registry, no-auto-merge, no-automatic-issue/PR, no-downstream-mutation, and no-retained-closeout claims. |
| next_owner_action | Exact next owner-surface issue/PR shape, not a category. |

## Official Context Boundary

Official Codex documentation can establish that a capability surface exists, but
it does not prove that a given Issue #164 episode actually used that surface.
Cloud environments, remote connections, automations, and subagents remain
`context_only` until raw task evidence proves a live run on that surface.

Local/worktree dogfood evidence may support local/worktree readiness when it is
backed by the run's command transcripts, worktree path, branch, checks, PR, and
merge or blocker state. A same-thread continuation can be valid for an in-flight
episode when it is recorded explicitly and does not masquerade as a fresh launch.

## Promotion And Demotion

Promote a Codex native runtime placement only when the record contains:

1. Official Codex context for the claimed surface.
2. GitHub issue/PR/check/merge truth for the owner work.
3. Raw runtime evidence for any runtime-health or execution claim.
4. Goal state or Goal-null fallback.
5. `/tmp` run root and `progress-ledger.jsonl`.
6. Heartbeat lifecycle or explicit unavailable fallback.
7. Runtime-context payload/preflight when the assessing repo provides one.
8. Local/worktree dogfood evidence, or raw cloud/remote execution evidence when
   claiming cloud/remote readiness beyond context.
9. Bounded non-claims and a demotion trigger.
10. Next exact owner-surface action.

Demote or reject the readiness claim when raw evidence is missing, the worktree
is stale, cloud/remote execution is overclaimed, automations or subagents are
treated as background controllers, a scheduler/queue/daemon/registry appears,
GitHub issue/PR/check/merge truth is absent, a retained closeout package is
promoted as task truth, auto issue/PR creation or auto-merge is claimed, or
downstream/core-five mutation exceeds the approved owner boundary.

## Bounded Non-Claims

Every record should include clauses equivalent to:

- This record does not prove live Codex Cloud or remote execution unless
  `cloud_remote_disposition` is `raw_evidence_proven` and cites raw evidence.
- This record does not make official Codex documentation a substitute for raw
  runtime evidence.
- This record does not claim runtime improvement from Goal mode without raw
  runtime evidence.
- This record does not make automations or subagents background controllers.
- This record does not create a controller, scheduler, queue, daemon, retry
  loop, registry, hidden control plane, automatic issue/PR creator, auto-merge
  path, retained closeout package, or downstream mutation grant.
- This record does not mutate sibling repos or downstream targets without their
  own owner issue, PR, checks, and merge truth.

## Copy-Sync Boundary

Consumers may copy-sync this contract or template into owner surfaces, or cite
them from detector/advisor/optimizer evidence. Copy drift is repo quality debt
handled through review and focused gates. Do not add a runtime dependency,
generated registry, scheduler, queue, controller, daemon, watcher, retry loop,
automatic updater, or background sync to keep copies aligned.
