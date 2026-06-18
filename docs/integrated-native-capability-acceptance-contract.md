# Integrated Native Capability Acceptance Contract

> Version: 1.0
> Date: 2026-06-18
> Owner: repo-agent-core

## Purpose

This contract defines the portable Issue #164 Arc 5 record shape for
`INTEGRATED_NATIVE_CAPABILITY_ACCEPTANCE`: a GitHub-native acceptance record
that can promote proven native capability evidence without overclaiming
unproven surfaces.

It composes the earlier Issue #164 primitives for advisory GBrain, bounded
Hermes, Codex native runtime readiness, source-intelligence intake, scheduled
shadow readback, and GitHub issue/PR/check/merge truth. Consumers may copy-sync
or cite this contract and template. Do not turn either file into a runtime
dependency, controller, scheduler, queue, daemon, retry loop, registry,
automatic issue/PR creator, auto-merge path, retained closeout package,
background Hermes/GBrain process, Codex remote proof substitute, sidecar runner,
or downstream mutation grant.

## Carrier 1 Input And Carrier 2 Owner Evidence

The first accepted input is build-meta-analysis Arc 5 Carrier 1 correction;
this repo-agent-core owner propagation is Arc 5 Carrier 2:

- BMA parent campaign: `https://github.com/briancl2/build-meta-analysis/issues/164`
- BMA Carrier 1 child: `https://github.com/briancl2/build-meta-analysis/issues/909`
- BMA Carrier 1 correction PR: `https://github.com/briancl2/build-meta-analysis/pull/911`
- BMA Carrier 1 correction merge: `ae87e1fb6a646be0575a0b3330f288c9a41bf6b7`
- repo-agent-core owner issue: `https://github.com/briancl2/repo-agent-core/issues/76`

Carrier 1 correction accepted Codex Cloud proof from
`task_e_6a34120847c4832b94a1a08423530556`: hosted
`briancl2/build-meta-analysis`, commit
`5d5bc96609e8b059b327c2309da7d07171c99f0c`, repo path
`/workspace/build-meta-analysis`, branch `work`, `AGENTS.md` present,
`python3 scripts/issue164-native-preflight.py --help` available and exited 0,
clean `git status --short` before and after, and no files changed. The Cloud
CLI readback reported READY/no diff with zero changed files.

Carrier 1 correction did not accept Codex remote proof. Remote remains
`codex_remote_proof_disposition=deferred_not_validated`. It also did not accept
Deep Research or external-intelligence sidecar output. sidecar prompting is a
failed prompt generation case:
`external_intelligence_sidecar_disposition=failed_prompt_generation_deferred_outside_arc5`
because the generated prompt assumed local/private repo context that external
intelligence does not have.

## Required Fields

| Field | Requirement |
| --- | --- |
| `artifact` | Literal `INTEGRATED_NATIVE_CAPABILITY_ACCEPTANCE`. |
| `schema_version` | Contract version for this wrapper shape. |
| `source_issue_or_pr` | GitHub issue, PR, or campaign surface authorizing the acceptance. |
| `parent_campaign_url` | Parent Issue #164 campaign URL when applicable. |
| `carrier_child_url` | BMA child or owner issue governing the accepted carrier. |
| `owner_issue_url` | Owner repo issue when propagation happens outside BMA. |
| `cloud_proof` | Raw Cloud task identity, hosted repo, commit, git status before/after, validation command, and no-diff result. |
| `codex_cloud_proof_disposition` | Must be `accepted_ready_no_diff` for the BMA Carrier 1 correction input. |
| `codex_remote_proof_disposition` | Must be `deferred_not_validated` until raw remote task/session evidence exists. |
| `external_intelligence_sidecar_disposition` | Must be `failed_prompt_generation_deferred_outside_arc5` for this Arc 5 propagation. |
| `github_truth` | Linked issues, PRs, required checks, merge commit, closure truth, and Campaign Sync. |
| `arc_gate_matrix` | Arc 1 advisory GBrain, Arc 2 bounded Hermes, Arc 3 Codex runtime, Arc 4 source-intelligence, and Arc 5 integrated acceptance dispositions. |
| `promotion_gate` | Evidence required before repeating or broadening the acceptance claim. |
| `demotion_rejection_trigger` | Exact conditions that demote or reject the claim. |
| `kill_switch` | Owner action when proof is missing or a forbidden boundary is crossed. |
| `bounded_non_claims` | Explicit no-remote-acceptance, no-sidecar-acceptance, no-docs-as-proof, no-controller, no-scheduler, no-queue, no-daemon, no-registry, no-auto-merge, no-automatic-issue/PR, no-retained-closeout, and no-downstream-mutation claims. |
| `next_owner_action` | Next carrier or repair owner action after accepted, partial, blocked, or rejected disposition. |

## Promotion And Demotion

Promote an integrated native capability acceptance record only when it contains:

1. GitHub issue/PR/check/merge truth for the accepted work.
2. Raw task or session evidence for every runtime surface being accepted.
3. `codex_cloud_proof_disposition=accepted_ready_no_diff` only when the Cloud
   task is cited with task id, hosted repo, commit, validation, git status
   before/after, and no diff.
4. `codex_remote_proof_disposition=deferred_not_validated` unless a separate
   remote task/session proof exists.
5. `external_intelligence_sidecar_disposition=failed_prompt_generation_deferred_outside_arc5`
   until a replacement sidecar protocol lands through a separate owner route.
6. Arc gate dispositions that preserve advisory GBrain, bounded Hermes, source
   intake, scheduled-shadow, and GitHub truth boundaries.
7. Promotion gate, demotion/rejection trigger, kill switch, bounded non-claims,
   and next exact owner action.

Demote or reject the record when it treats official docs as live proof, claims
remote acceptance without raw remote evidence, treats the failed sidecar prompt
as accepted, claims GBrain canonicality, gives Hermes primary ownership,
introduces controller/scheduler/queue/daemon/registry behavior, creates
automatic GitHub mutation, auto-merges, stores retained closeout truth as task
truth, mutates downstream repos, or exceeds the approved owner issue/PR surface.

## Arc Gate Matrix

- Arc 1 GBrain Operational Semantic Spine: advisory-only; no canonical memory
  claim.
- Arc 2 Hermes Maker/Checker Expansion: bounded foreground doer/checker-shadow;
  no Hermes primary ownership.
- Arc 3 Codex Native Runtime / Cloud / Remote Readiness: local/worktree
  readiness plus Cloud task proof accepted; remote remains deferred.
- Arc 4 Deep Research And External Intelligence Native Corpus: source corpus
  and intake contract accepted; sidecar prompt generation failed and is outside
  Arc 5.
- Arc 5 Integrated Native Capability Acceptance: Cloud-backed propagation may
  proceed only with remote and sidecar as bounded non-claims.

## Consumer Routing

- `repo-agent-core` owns this contract and template.
- `repo-auditor` may detect missing integrated acceptance fields and false
  acceptance overclaims after a separate owner issue admits that carrier.
- `repo-upgrade-advisor` may recommend owner action from those detector
  findings after a separate owner issue admits that carrier.
- `repo-optimizer` is not part of this accepted propagation route unless a
  later approved owner issue proves a distinct optimizer need.

## Copy-Sync Boundary

Consumers may copy-sync this contract or template into issue bodies, PR bodies,
repo-local docs, detector fixtures, advisor examples, or local validation
guards. Copy drift is repo quality debt handled by focused review and tests. Do
not add a runtime dependency, generated registry, watcher, scheduler, queue,
controller, daemon, retry loop, automatic updater, or background sync to keep
copies aligned.

## Bounded Non-Claims

This contract does not prove live Codex remote execution, accept sidecar output,
run Deep Research, call the Deep Research API, use official documentation as
live proof, create issues, create PRs, post comments, merge PRs, close issues,
schedule jobs, run Hermes, run GBrain, create a controller, scheduler, queue,
daemon, registry, retry loop, sidecar runner, retained closeout package, or
downstream mutation path.
