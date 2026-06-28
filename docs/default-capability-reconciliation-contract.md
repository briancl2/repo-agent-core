# Default Capability Reconciliation Contract

> Version: 1.0
> Date: 2026-05-31
> Owner: repo-agent-core

## Purpose

This contract defines the shared copy-sync language for reconciling upstream
tool capability changes across the repo-agent fleet. Use it when a default
platform capability in Codex App, Hermes, GBrain, GitHub, or another approved
operator surface may replace, relax, or obsolete custom repo-agent guidance.

It is guidance for issue bodies, PR bodies, docs, fixtures, and retained
evaluation records. It is not a runtime package, service, scheduler, queue,
controller, background job, watcher, hidden registry, or mandatory dependency.

Related contract: `docs/native-evidence-before-verdict-contract.md`.

## Required Record

| Field | Required meaning |
|---|---|
| Capability source | Upstream product, repo, commit, release, issue, PR, or local version that changed the decision. |
| Upstream-main proof | Upstream-main commit, release, or issue/PR closure that proves the capability has landed on the default source of truth. |
| Local proof | Exact bounded command, check, smoke test, fixture, or receipt proving the capability in the current environment. |
| Local same-version proof | Local proof from the same version or commit that would become the production default. |
| Native evidence before verdict | Current upstream docs/root instructions plus safe documented native attempt or concrete owner-surface blocker before adoption/default/substitution verdict. |
| Default/substitute decision | Adopt, keep existing default, substitute existing custom path, quarantine, or park. |
| Owner surface | Repository or upstream project that owns the next action. |
| First deliverable | Exact issue, PR, doc, detector, recommendation, or patch-pack shape. |
| Fallback if blocked | Concrete fallback path, issue-truth, or owner-surface repair if proof fails, CI fails, or a permission boundary appears. |
| Validation scope | Repo-native checks, validation receipt, and any read-only proving-ground sweep needed to trust the decision. |
| Regrowth boundary | Explicit statement that no controller, scheduler, queue, watcher, daemon, hidden registry, or local closeout stack was added. |

## Decision States

| State | Meaning |
|---|---|
| Adopt | The upstream/default capability is proved locally and becomes the preferred path for the named use. |
| Keep existing default | The current path remains correct because the new capability is irrelevant, lower quality, or not yet proved. |
| Substitute | A custom or older path is replaced by a default platform capability. |
| Quarantine | The capability exists but is unsafe, failing, ambiguous, or not decision-grade for the named use. |
| Park | The capability is interesting but outside the active permission boundary or owner-surface batch. |

## Proof Rules

Capability reconciliation requires current local proof when the decision changes
active guidance. A cited upstream commit or release is not enough by itself.
Production default adoption requires upstream-main proof and local same-version
proof for the capability being adopted.

For adoption, substitution, production-default, quarantine, or parking
verdicts about an external or upstream capability, upstream docs/root
instructions are necessary but not sufficient. The verdict-bearing surface
must carry native command/workflow output or a concrete owner-surface blocker.

The proof must be foreground and bounded. It may use read-only target repos as
fixtures, but generated patches, recommendations, or detector findings do not
authorize direct mutation of those targets.

If proof fails and the owner surface is known, convert the failure into issue
truth on that owner surface. Do not route the primary repair through a
retrospective, selector, queue, scheduler, or new control plane.

## Copy-Sync Boundary

Consumers may copy this contract or cite it from repository docs. Copy drift is
a repo-quality issue. Do not introduce a runtime import, generated registry,
watcher, scheduler, queue, controller, cron job, or background sync to keep
copies aligned.
