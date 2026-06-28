# Native Evidence Before Verdict Contract

> Version: 1.0
> Date: 2026-06-28
> Owner: repo-agent-core

## Purpose

This contract defines the shared repo-agent principle and mechanism for
external-system, upstream-tool, library, product, and native-capability
judgments: repo agents must collect native evidence before making a verdict.

The triggering failure is BMA Issue #164's GBrain adoption drift: agents
repeatedly claimed to research, evaluate, repair, or plan around GBrain without
first reliably reading and integrating the current upstream root docs and
native setup model. The repair landed in BMA #1144 / PR #1146 and produced the
advisory GBrain record `bma/issue164/native-evidence-before-verdict`.

Docs readback is necessary but not sufficient. A repo agent must not turn
upstream-doc reading, local doctor output, retained reports, model summaries,
or proof-shaped language into an adoption, readiness, fallback, production,
GA, cutover, or architecture verdict without a native attempt or a concrete
owner-surface blocker.

This contract is copy-sync/citation guidance for repo-local instructions,
issue/PR bodies, auditor detectors, advisor recommendations, optimizer
materialization checks, and verdict-bearing readouts. It is not a runtime
dependency, controller, scheduler, queue, daemon, registry, background memory
process, auto-updater, MCP server, automatic issue/PR creator, or downstream
mutation grant.

## Related Contracts And Evidence

- `docs/upstream-capability-intake-contract.md`
- `docs/default-capability-reconciliation-contract.md`
- `docs/gbrain-repo-local-instruction-distribution-contract.md`
- `docs/repo-star-closure-runtime-distribution-contract.md`
- BMA Issue #164: https://github.com/briancl2/build-meta-analysis/issues/164
- BMA repair issue: https://github.com/briancl2/build-meta-analysis/issues/1144
- BMA merged repair PR: https://github.com/briancl2/build-meta-analysis/pull/1146
- Advisory GBrain slug: `bma/issue164/native-evidence-before-verdict`

## Required Record

| Field | Required meaning |
|---|---|
| artifact | Literal `NATIVE_EVIDENCE_BEFORE_VERDICT`. |
| schema_version | Record shape version; currently `1`. |
| component_identity | External system, upstream repo, package, tool, model, platform, native capability, or product being judged. |
| intended_operator_outcome | The operator-valued outcome the component is supposed to help deliver. |
| verdict_class | Adoption, readiness, fallback, production, GA, cutover, architecture, repair, downgrade, or replacement judgment being considered. Negative claims such as not-production-ready or not-GA still count as verdicts. |
| current_upstream_docs_checked | README, root agent instructions such as AGENTS.md, install/setup guidance such as INSTALL_FOR_AGENTS, official docs, upstream issues/PRs, or release refs checked before the verdict. |
| native_model_mapped | Native architecture, setup/configuration model, trust boundaries, and validation path mapped to the intended operator outcome. |
| native_attempt_or_blocker | Safe documented native setup/use attempt, native command, native workflow, working native run, or concrete owner-surface blocker with source, permission, command, or safety-boundary detail. |
| verdict_bearing_evidence | Real command output, native result evidence, or the concrete blocker that appears on the issue/PR/comment/readout carrying the verdict. |
| owner_surface | GitHub issue/PR/repo or upstream project that owns the next repair, adoption, fallback, or blocker route. |
| validation_scope | Repo-native checks, smoke, replay, fixture, or owner proof needed before the verdict changes production guidance. |
| advisory_gbrain_ref | Optional advisory GBrain slug or explicit no-capture reason; GBrain remains advisory. |
| bounded_non_claims | Boundaries for what the record does not prove, automate, adopt, or mutate. |

## Verdict Rules

1. Read current upstream docs and root instructions before judging, repairing,
   replacing, or routing around the component.
2. Map the native architecture, setup/configuration model, trust boundaries,
   and validation path to the operator's actual desired outcome before
   drawing conclusions.
3. For adoption, readiness, fallback, production, GA, cutover, replacement, or
   architecture verdicts, require a safe documented native attempt or a
   concrete owner-surface blocker.
4. Carry the real command output, native result evidence, or concrete blocker
   on the verdict-bearing issue/PR/comment/readout.
5. If a native attempt is unsafe or blocked, route that blocker to the owner
   surface instead of turning docs readback into a verdict.
6. Treat local doctor output, local tests, retained reports, prompts, model
   summaries, and validation receipts as supporting evidence only; none can
   substitute for upstream operating instructions plus native attempt or
   blocker.
7. Treat negative claims as verdicts too. Phrases such as not production-ready,
   not GA, fallback required, hybrid fallback, or blocked adoption still need
   native evidence or a concrete blocker.

## Repo-Star Fleet Roles

- `repo-agent-core` owns this shared contract and template.
- `repo-auditor` should detect docs-readback-only verdicts, keyword-stuffed
  prompts, line-wrapped adoption/fallback claims, local-doctor-only judgments,
  and verdict-bearing readouts that lack native result evidence or an
  owner-surface blocker.
- `repo-upgrade-advisor` should package findings into exact owner-surface
  recommendations with first deliverable, validation scope, fallback,
  GitHub routing, source citation, and bounded non-claims.
- `repo-optimizer` should materialize only concrete patch/context-reduction
  changes that replace proof theater with native attempts or blocker routing;
  it should skip speculative optimization when no patchable owner surface
  exists.

## GBrain Policy

GBrain may carry this learning only as foreground advisory memory:

- Use the exact advisory slug `bma/issue164/native-evidence-before-verdict`
  only after exact `gbrain get` readback or an equivalent cited copy.
- Require GitHub/source provenance before copying GBrain guidance into
  repo-local instructions.
- Record GBrain misses, stale records, or runtime failures on the GitHub owner
  surface when they affect the route.
- GBrain does not override operator intent, GitHub issue/PR/check/merge truth,
  repo evidence, or repo-local instructions.

## Bounded Non-Claims

Every native-evidence-before-verdict record should include clauses equivalent
to:

- This record does not make GBrain canonical.
- This record does not let GBrain override operator intent, GitHub truth, repo
  evidence, or repo-local instructions.
- This record does not prove production readiness unless the native attempt
  and validation evidence support that exact verdict.
- This record does not authorize background GBrain sync/watch, cron,
  autopilot, dream, jobs worker, MCP serving, minions, queues, daemons,
  schedulers, hidden registries, automatic updates, automatic issue/PR
  creation, or downstream mutation.
- This record does not create a controller, scheduler, queue, registry,
  daemon, retry loop, hidden control plane, or retained proof ritual.

## Copy-Sync Boundary

Consumers may copy-sync this contract or template into repo-local instruction
surfaces, detector fixtures, advisor recommendation guidance, or optimizer
materialization checks. Copy drift is repo quality debt handled through review
and focused drift gates. Do not add a runtime dependency, generated registry,
scheduler, queue, controller, daemon, watcher, retry loop, automatic updater,
background sync, or canonical memory bridge to keep copies aligned.
