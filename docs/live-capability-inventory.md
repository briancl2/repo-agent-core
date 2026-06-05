# Live Capability Inventory

> Owner: repo-agent-core
> Scope: live capability tracking surface for calibrated capability-drift checks

This document tracks the live repo-agent-core capability surfaces that are
intentionally present on disk. It is documentation for the existing
repo-auditor capability-drift detector, not a runtime registry, generated
catalog, scheduler, controller, queue, daemon, watcher, or dependency.

The inventory records whether each surface is runtime-loaded by ordinary
repo-agent-core workflows, shared by copy-sync/citation, or retained as dormant
tooling that still needs a deliberate owner decision before deletion or archive.

## Shared Skill

| Path | Classification | Owner decision |
|---|---|---|
| `.agents/skills/reviewing-code-locally/SKILL.md` | runtime-loaded shared skill | Keep as the shared pre-commit review skill. |
| `.agents/skills/reviewing-code-locally/scripts/local_review.sh` | runtime-loaded skill helper | Keep as the executable helper for `make review`. |

## Scripts And Hooks

| Path | Classification | Owner decision |
|---|---|---|
| `scripts/check-compare-scorecards-conformance.sh` | runtime-loaded drift gate | Keep as the compare-scorecards copy-sync conformance gate. |
| `scripts/compare-scorecards.sh` | runtime-loaded shared primitive | Keep as the shared scorecard comparison primitive. |
| `scripts/install-hooks.sh` | runtime-loaded install helper | Keep as the hook installer used by consumer repos. |
| `scripts/pre-commit-hook.sh` | runtime-loaded hook source | Keep as the source pre-commit hook. |
| `scripts/pre-push-hook.sh` | runtime-loaded hook source | Keep as the source pre-push hook. |
| `scripts/record-closure-identity.sh` | runtime-loaded test receipt helper | Keep as the closure identity helper used by `make test`. |
| `scripts/validate-artifacts.sh` | runtime-loaded schema/artifact validator | Keep as the artifact validation entrypoint. |
| `hooks/pre-commit-hook.sh` | hook copy surface | Keep as the installable pre-commit hook surface. |
| `hooks/pre-push-hook.sh` | hook copy surface | Keep as the installable pre-push hook surface. |

## Speckit Agent Surfaces

These root GitHub agent files are intentionally tracked as live-on-disk
capabilities but are dormant unless a repo chooses to use Speckit flows. They
are not promoted to repo-agent-core runtime defaults by this inventory.

| Path | Classification | Owner decision |
|---|---|---|
| `.github/agents/speckit.analyze.agent.md` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.github/agents/speckit.checklist.agent.md` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.github/agents/speckit.clarify.agent.md` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.github/agents/speckit.constitution.agent.md` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.github/agents/speckit.implement.agent.md` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.github/agents/speckit.plan.agent.md` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.github/agents/speckit.specify.agent.md` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.github/agents/speckit.tasks.agent.md` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.github/agents/speckit.taskstoissues.agent.md` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |

## Speckit Script Surfaces

These `.specify` helpers are tracked because they are present live on disk and
may be used by Speckit workflows. Tracking them does not make Speckit the
default repo-agent-core workflow.

| Path | Classification | Owner decision |
|---|---|---|
| `.specify/scripts/bash/check-prerequisites.sh` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.specify/scripts/bash/common.sh` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.specify/scripts/bash/create-new-feature.sh` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.specify/scripts/bash/setup-plan.sh` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |
| `.specify/scripts/bash/update-agent-context.sh` | dormant Speckit helper | Keep tracked pending a later Speckit owner decision. |

## Non-Claims

- This inventory does not authorize deleting, archiving, or enabling dormant
  Speckit surfaces.
- This inventory does not add a schema, runtime dependency, generated registry,
  scheduler, controller, queue, watcher, daemon, retry loop, or background sync.
- This inventory is a human-readable tracking surface consumed by existing
  repo-auditor capability-drift semantics.
