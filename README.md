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
  HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT.schema.json # Bounded Hermes repo-star pilot reliability receipt
  GBRAIN_ADVISORY_PILOT_OUTCOME_LEARNING_LOOP_RECEIPT.schema.json # Advisory GBrain pilot outcome learning-loop receipt
  TOKEN_MEASUREMENT_SUMMARY.schema.json # Additive token-efficiency summary
  HOTSPOT_EVIDENCE_PACKETS.schema.json  # Additive hotspot evidence packets
  AGENTIC_ROOT_CAUSE_BRIEFS.schema.json # Additive bounded brief handoff
  TRANSFER_ORACLE_RECEIPT.schema.json # Shared transfer-readiness receipt + calibration metadata
  CRITIQUE_RESULT.schema.json # Shared critique result + calibration metadata
  PLAYBOOK_MANIFEST_AUTHORITY.schema.json # Shared playbook/manifest authority
  ADAPTER_AUDIT_SUMMARY.schema.json # Shared adapter audit summary
  SOURCE_INSIGHT_PACKET.schema.json # Shared source-intelligence intake packet
  REPO_STAR_GENERICITY_PROOF_RECEIPT.schema.json # Shared non-BMA repo-star genericity proof receipt
  REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT.schema.json # Two-target downstream genericity proof receipt
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
  upstream-capability-intake.md # Compact upstream capability intake template
  hermes-foreground-run-receipt.md # One-shot Hermes foreground launcher receipt
  hermes-foreground-failure-guidance.md # Advisory Hermes foreground failure guidance
  hermes-foreground-repo-star-pilot-reliability.md # Bounded Hermes repo-star pilot reliability receipt
  gbrain-advisory-pilot-outcome-learning-loop.md # Advisory GBrain pilot outcome learning-loop receipt
  downstream-read-only-recovery-runtime-pilot.md # Downstream read-only pilot receipt
  repo-star-genericity-proof-receipt.md # Non-BMA repo-star genericity proof receipt
  repo-star-downstream-genericity-proof-receipt.md # Two-target downstream genericity proof receipt
  gbrain-retrieval-citation-lifecycle.md # Advisory GBrain retrieval/citation lifecycle receipt
  gbrain-repo-local-instruction-distribution.md # Advisory GBrain instruction distribution receipt
  hermes-doer-gbrain-distributed-instructions.md # Hermes doer + GBrain-distributed instruction receipt
  sidecar-prompt-ab-response-shaped.md # Response-shaped Prompt A/B sidecar protocol
scripts/                    # Hook scripts
  pre-commit-hook.sh        # v2 hard-default review (blocks by default)
  pre-push-hook.sh          # Push review warning
  compare-scorecards.sh     # Shared scorecard comparison primitive
  check-compare-scorecards-conformance.sh # Fixture + hash drift gate for consumer copies
docs/
  core-five-owner-surface-contract.md # Issue #164 core-five owner-surface contract
  live-capability-inventory.md # Live tool/agent tracking surface for calibrated drift checks
  goal-episode-evaluation-contract.md # Shared Goal-mode runtime evaluation language
  interruption-recovery-and-batch-reconstitution-contract.md # Goal blocker recovery contract
  foreground-learning-and-recovery-contract.md # Foreground learning/recovery contract
  default-capability-reconciliation-contract.md # Default-first capability reconciliation language
  upstream-capability-intake-contract.md # Compact upstream capability intake contract
  hermes-foreground-launcher-contract.md # One-shot Hermes foreground launcher contract
  hermes-foreground-repo-star-pilot-reliability-contract.md # Bounded Hermes repo-star pilot reliability contract
  gbrain-advisory-pilot-outcome-learning-loop-contract.md # Advisory GBrain pilot outcome learning-loop contract
  foreground-recovery-runtime-contract.md # Compact foreground recovery runtime composition
  downstream-read-only-recovery-runtime-pilot-contract.md # Downstream read-only pilot receipt
  repo-star-genericity-proof-contract.md # Non-BMA repo-star genericity proof contract
  repo-star-downstream-genericity-proof-contract.md # Two-target downstream genericity proof contract
  gbrain-retrieval-citation-lifecycle-contract.md # Advisory GBrain retrieval/citation proof contract
  gbrain-repo-local-instruction-distribution-contract.md # Advisory GBrain repo-local instruction distribution contract
  hermes-doer-gbrain-distributed-instructions-contract.md # Hermes doer + GBrain-distributed instruction contract
  sidecar-prompt-ab-response-shaped-contract.md # Response-shaped sidecar Prompt A/B contract
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

## Live Capability Inventory

The [live capability inventory](docs/live-capability-inventory.md) tracks the
repo-agent-core tools, hooks, skills, Speckit helpers, and scripts that are
intentionally present on disk. It is a documentation tracking surface for
calibrated repo-auditor capability-drift checks, not a runtime registry or
generated control plane.

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

## Upstream Capability Intake Contract

The [upstream capability intake contract](docs/upstream-capability-intake-contract.md)
defines the compact record shape for deciding whether a local component,
tooling surface, model, package, or platform path is behind, duplicated, stale,
covered by native upstream capability, or ready for owner-route/deletion
continuity. Consumers may copy the
[template](templates/upstream-capability-intake.md) or cite the contract, but
must not turn it into a runtime dependency, schema mandate, generated
inventory, scheduler, queue, controller, watcher, daemon, automatic updater, or
background sync mechanism.

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

## Hermes Foreground Repo-Star Pilot Reliability Contract

The [Hermes foreground repo-star pilot reliability contract](docs/hermes-foreground-repo-star-pilot-reliability-contract.md)
defines the shared `HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT`
shape for measuring bounded foreground Hermes attempts against repo-star
downstream read-only pilot prompts. Consumers may copy-sync or cite the
contract, schema, or
[template](templates/hermes-foreground-repo-star-pilot-reliability.md), but
must not turn them into a runtime dependency, daemon, scheduler, queue, retry
loop, controller, hidden registry, `hermes -z` adoption path, autonomous Hermes
operator, automatic GitHub issue creation, downstream mutation path, or
background sync mechanism.

## GBrain Advisory Pilot Outcome Learning Loop Contract

The [GBrain advisory pilot outcome learning-loop contract](docs/gbrain-advisory-pilot-outcome-learning-loop-contract.md)
defines the shared
`GBRAIN_ADVISORY_PILOT_OUTCOME_LEARNING_LOOP_RECEIPT` shape for replaying
Issue #164 pilot outcomes, classifying decision-changing or no-capture learning,
checking citation/source-ref quality, and routing owner repairs when advisory
GBrain evidence is stale, missing, uncited, contradictory, or not
decision-changing. Consumers may copy-sync or cite the contract, schema, or
[template](templates/gbrain-advisory-pilot-outcome-learning-loop.md), but must
not turn them into a runtime dependency, import framework, memory daemon,
scheduler, queue, controller, hidden registry, background sync, MCP server,
automatic GitHub issue creation, downstream mutation path, canonical-memory
claim, or automatic updater.

## Hermes Doer With GBrain-Distributed Instructions Contract

The [Hermes doer with GBrain-distributed instructions contract](docs/hermes-doer-gbrain-distributed-instructions-contract.md)
composes the Hermes foreground launcher, foreground recovery runtime, and
GBrain repo-local instruction distribution contracts. It defines how consumers
may use Hermes as a bounded foreground first-attempt doer while pointing it at
repo-local instruction surfaces that cite advisory GBrain distribution guidance.
Consumers may copy the
[receipt template](templates/hermes-doer-gbrain-distributed-instructions.md) or
cite the contract, but must not turn it into a runtime dependency, daemon,
scheduler, queue, retry loop, controller, MCP server, hidden registry,
background sync, `hermes -z` adoption path, autonomous campaign operator, or
canonical GBrain memory claim.

## Sidecar Prompt A/B Response-Shaped Contract

The [sidecar Prompt A/B response-shaped contract](docs/sidecar-prompt-ab-response-shaped-contract.md)
defines the shared manual sidecar protocol for assumption-gap-first Prompt A and
response-shaped Prompt B. Consumers may copy the
[template](templates/sidecar-prompt-ab-response-shaped.md) or cite the contract,
but must not turn them into a sidecar runner, controller, scheduler, queue,
daemon, hidden registry, retained closure package, or background sync
mechanism. Prompt B may claim reconciliation only after the actual Prompt A
response exists; pre-response Prompt B text must be marked hypothetical. Each
sidecar turn should be one complete paste artifact: the repo-side
tooling/coordinator assembles evidence, and the human operator does not gather
reports, ledgers, transcripts, excerpts, or evidence files for the prompt.

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

## Downstream Read-Only Recovery Runtime Pilot Contract

The [downstream read-only recovery-runtime pilot contract](docs/downstream-read-only-recovery-runtime-pilot-contract.md)
defines a compact receipt shape for downstream read-only pilots that preserve
target repo identity, target path/name, before/after git head and dirty counts,
auditor/advisor/optimizer replay artifacts, generated patch pack metadata,
blocker evidence, apply-check output, and no-downstream-mutation bounded
non-claims. Consumers may copy-sync or cite the contract, but must not turn it
into a runtime dependency, daemon, scheduler, queue, controller, retry loop,
hidden registry, background sync, MCP server, automatic GitHub issue creation,
or downstream PR/issue path. Pilot artifacts can be written only outside the
target repo, usually `/tmp`; the pilot never applies patches.

## Repo-Star Genericity Proof Contract

The [repo-star genericity proof contract](docs/repo-star-genericity-proof-contract.md)
defines the shared `REPO_STAR_GENERICITY_PROOF_RECEIPT` shape for proving that
repo-star capabilities work against a controlled non-BMA target without target
mutation. It records target identity, before/after git state, auditor/advisor/
optimizer artifact paths, owner routing, and bounded non-claims. Consumers may
copy-sync or cite the contract, schema, or
[template](templates/repo-star-genericity-proof-receipt.md), but must not turn
them into a runtime dependency, controller, scheduler, queue, daemon, hidden
registry, automatic GitHub issue creation, downstream mutation path, or
background sync.

## Repo-Star Downstream Genericity Proof Contract

The [repo-star downstream genericity proof contract](docs/repo-star-downstream-genericity-proof-contract.md)
defines the shared `REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT` shape for
proving repo-star genericity across two real non-BMA downstream read-only
targets. It records target identities, before/after git state, target-native
gate matrix, repo-star command list, output roots, privacy redaction notes, BMA
ceremony leakage checks, GitHub summary surface, owner routing, and bounded
non-claims. Consumers may copy-sync or cite the contract, schema, or
[template](templates/repo-star-downstream-genericity-proof-receipt.md), but
must not turn them into a runtime dependency, controller, scheduler, queue,
daemon, hidden registry, automatic GitHub issue creation, downstream mutation
path, `hermes -z` adoption path, background GBrain behavior, or background sync.

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

## GBrain Repo-Local Instruction Distribution Contract

The [GBrain repo-local instruction distribution contract](docs/gbrain-repo-local-instruction-distribution-contract.md)
defines how advisory GBrain records may be copied or cited into repo-local
instruction surfaces such as `AGENTS.md`, repository agent instructions, pull
request templates, and issue templates. Consumers may copy the
[template](templates/gbrain-repo-local-instruction-distribution.md) or cite the
contract, but must not turn it into a runtime dependency, scheduler, queue,
controller, daemon, MCP server, hidden registry, background sync, canonical
memory claim, or automatic updater. GBrain remains advisory and cannot override
operator intent, GitHub issue/PR/check/merge truth, repo evidence, or
repo-local instructions.

## License

MIT
