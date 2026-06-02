# repo-agent-core

Shared primitives for the **repo-agent fleet** — schemas, templates, hooks, and scoring infrastructure used by [repo-auditor](https://github.com/briancl2/repo-auditor), [repo-upgrade-advisor](https://github.com/briancl2/repo-upgrade-advisor), and [repo-optimizer](https://github.com/briancl2/repo-optimizer).

## Quick Start

```bash
# Review staged changes before committing
make review

# Validate schemas
make test

# Validate compare-scorecards copy-sync drift gate
make validate-compare-scorecards CONSUMERS="../repo-auditor ../repo-optimizer"
```

## Structure

```
schemas/                    # Machine-readable inter-agent contracts
  SCORECARD.schema.json     # Audit health scorecard (5 dimensions, 0-100)
  OPPORTUNITIES.schema.json # Advisor recommendation format
  OPTIMIZATION_SCORECARD.schema.json # Optimization result format
  COMMAND_OUTPUT_ROI_RECEIPT.schema.json # Command-output summarization receipt
  HERMES_FOREGROUND_RUN_RECEIPT.schema.json # One-shot Hermes foreground launcher receipt
  HERMES_FOREGROUND_FAILURE_GUIDANCE.schema.json # Advisory Hermes foreground failure guidance
  TOKEN_MEASUREMENT_SUMMARY.schema.json # Additive token-efficiency summary
  HOTSPOT_EVIDENCE_PACKETS.schema.json  # Additive hotspot evidence packets
  AGENTIC_ROOT_CAUSE_BRIEFS.schema.json # Additive bounded brief handoff
  TRANSFER_ORACLE_RECEIPT.schema.json # Shared transfer-readiness receipt + calibration metadata
  CRITIQUE_RESULT.schema.json # Shared critique result + calibration metadata
  PLAYBOOK_MANIFEST_AUTHORITY.schema.json # Shared playbook/manifest authority
  ADAPTER_AUDIT_SUMMARY.schema.json # Shared adapter audit summary
  SOURCE_INSIGHT_PACKET.schema.json # Shared source-intelligence intake packet
templates/                  # Shared templates
  v3.1-markdown-handoff.md  # Subagent handoff template
  optimizer_policy.yaml     # Token budget ratchet policy
  findings-table.md         # Findings table format (renamed from findings.schema.md in the historical BMA planning corpus)
  transfer-readiness.md     # Transfer oracle receipt template
  playbook-manifest-authority.md # Authority declaration template
  adapter-audit-summary.md  # Adapter audit summary template
  bounded-non-claims.md     # Bounded non-claims template
  goal-episode-evaluation.md # Goal-mode episode evaluation template
  interruption-recovery-and-batch-reconstitution.md # Blocker recovery template
  foreground-learning-and-recovery-block.md # Foreground learning/recovery block
  default-capability-reconciliation.md # Upstream/default capability decision template
  hermes-foreground-run-receipt.md # One-shot Hermes foreground launcher receipt
  hermes-foreground-failure-guidance.md # Advisory Hermes foreground failure guidance
scripts/                    # Hook scripts
  pre-commit-hook.sh        # v2 hard-default review (blocks by default)
  pre-push-hook.sh          # Push review warning
  compare-scorecards.sh     # Shared scorecard comparison primitive
  check-compare-scorecards-conformance.sh # Fixture + hash drift gate for consumer copies
docs/
  core-five-owner-surface-contract.md # Issue #164 core-five owner-surface contract
  goal-episode-evaluation-contract.md # Shared Goal-mode runtime evaluation language
  interruption-recovery-and-batch-reconstitution-contract.md # Goal blocker recovery contract
  foreground-learning-and-recovery-contract.md # Foreground learning/recovery contract
  default-capability-reconciliation-contract.md # Default-first capability reconciliation language
  hermes-foreground-launcher-contract.md # One-shot Hermes foreground launcher contract
  foreground-recovery-runtime-contract.md # Compact foreground recovery runtime composition
  compare-scorecards-distribution.md # Supported copy-sync distribution model
.agents/skills/             # Shared skills
  reviewing-code-locally/   # Pre-commit code review skill
detection-signatures/       # DS-1 through DS-21
```

## Dependency Graph

```
                 repo-agent-core  ← you are here
                /       |        \
               v        v         v
       repo-auditor  repo-upgrade-advisor  repo-optimizer
```

Each agent depends only on `repo-agent-core`. Agents copy primitives (not symlink) — each is independently runnable. The supported `compare-scorecards` distribution model is [copy-sync with a drift gate](docs/compare-scorecards-distribution.md).

## Core-Five Owner-Surface Contract

Issue #164 core-five decomposition is governed by the
[core-five owner-surface contract](docs/core-five-owner-surface-contract.md).
It defines the reciprocal read-only proving-ground rule and the capability-home
table for build-meta-analysis, repo-agent-core, repo-auditor,
repo-upgrade-advisor, and repo-optimizer. It is shared guidance for copy-sync
distribution, not a runtime dependency or controller.

## Goal Episode Evaluation Contract

The [Goal episode evaluation contract](docs/goal-episode-evaluation-contract.md)
defines the shared runtime-health and self-healing evaluation language for
multi-PR Goal-mode episodes. Consumers may copy the
[template](templates/goal-episode-evaluation.md) or cite the contract, but must
not turn it into a controller, scheduler, queue, or background sync mechanism.

## Default Capability Reconciliation Contract

The [default capability reconciliation contract](docs/default-capability-reconciliation-contract.md)
defines the shared record shape for adopting, substituting, quarantining, or
parking upstream/default tool capabilities after bounded local proof. Consumers
may copy the [template](templates/default-capability-reconciliation.md) or cite
the contract, but must not turn it into a controller, scheduler, queue, watcher,
hidden registry, or background sync mechanism.
Production default adoption requires upstream-main proof, local same-version
proof, owner surface, fallback path, and validation receipt before a capability
changes the default path.

## Interruption Recovery Contract

The [interruption recovery and batch reconstitution contract](docs/interruption-recovery-and-batch-reconstitution-contract.md)
defines the shared record shape for preserving a Goal-mode or multi-PR episode
when an upstream, tool, CI, permission, or owner-surface blocker interrupts the
original route. Consumers may copy the
[template](templates/interruption-recovery-and-batch-reconstitution.md) or cite
the contract, but must not turn it into a controller, scheduler, queue, retry
loop, daemon, registry, or background sync mechanism.

## Foreground Learning And Recovery Contract

The [foreground learning and recovery contract](docs/foreground-learning-and-recovery-contract.md)
defines the compact record shape for self-learning and self-healing claims that
change a decision during foreground work. Consumers may copy the
[template](templates/foreground-learning-and-recovery-block.md) or cite the
contract, but must not turn it into a memory daemon, controller, scheduler,
queue, registry, or background sync mechanism. Routine no-op learning should
record an explicit no-capture reason rather than inventing a GBrain note.

## Hermes Foreground Launcher Contract

The [Hermes foreground launcher contract](docs/hermes-foreground-launcher-contract.md)
defines the compact JSON receipt shape for bounded one-shot `hermes chat -q -Q`
attempts during Issue #164 core-five propagation. Consumers may copy the
[schema](schemas/HERMES_FOREGROUND_RUN_RECEIPT.schema.json), copy the
[receipt template](templates/hermes-foreground-run-receipt.md), or cite the
contract, but must not turn it into a runtime dependency, daemon, scheduler,
queue, retry loop, controller, MCP server, autopilot, hidden registry, automatic
GitHub issue creation, or background sync mechanism. It does not authorize
mutating downstream repos or Hermes internals.

## Foreground Recovery Runtime Contract

The [foreground recovery runtime contract](docs/foreground-recovery-runtime-contract.md)
composes the Hermes launcher, interruption recovery, and foreground learning
contracts for Issue #164 core-five propagation. It defines the advisory
[HERMES_FOREGROUND_FAILURE_GUIDANCE schema](schemas/HERMES_FOREGROUND_FAILURE_GUIDANCE.schema.json)
and [failure guidance template](templates/hermes-foreground-failure-guidance.md)
for a failed BMA Hermes launcher path. Consumers may copy-sync or cite these
artifacts, but must not turn them into a runtime dependency, daemon, scheduler,
queue, retry loop, controller, MCP server, background sync, automatic GitHub
issue creation, or downstream mutation path.

## Source Insight Contract

`SOURCE_INSIGHT_PACKET` is the shared primitive for source-intelligence work.
It gives operator-provided links, field reports, official docs, local artifacts,
session logs, and historical commits equal first-pass insight treatment before
claims are ranked by proof strength. It is intentionally a foreground artifact
contract, not a crawler, scheduler, queue, memory daemon, or controller.

The first consumers are:

- `repo-auditor`: detect source bundles that omit insight/no-insight coverage
  or owner/no-action routing.
- `repo-upgrade-advisor`: render source-driven recommendations while preserving
  source IDs, claim IDs, evidence tiers, and bounded non-claims.

## License

MIT
