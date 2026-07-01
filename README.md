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
  capability-placement.md # Advisory capability placement / Autonomy Preview
  default-capability-reconciliation.md # Upstream/default capability decision template
  upstream-capability-intake.md # Compact upstream capability intake template
  native-evidence-before-verdict.md # Native evidence before adoption/readiness/fallback verdicts
  hermes-foreground-run-receipt.md # One-shot Hermes foreground launcher receipt
  hermes-foreground-failure-guidance.md # Advisory Hermes foreground failure guidance
  foreground-failure-to-issue-conversion.md # Foreground failure-to-issue conversion record
  hermes-foreground-failure-disposition.md # Foreground Hermes failure disposition record
  hermes-foreground-reliability.md # Foreground Hermes doer/checker reliability record
  hermes-foreground-repo-star-pilot-reliability.md # Bounded Hermes repo-star pilot reliability receipt
  gbrain-advisory-pilot-outcome-learning-loop.md # Advisory GBrain pilot outcome learning-loop receipt
  downstream-read-only-recovery-runtime-pilot.md # Downstream read-only pilot receipt
  repo-star-genericity-proof-receipt.md # Non-BMA repo-star genericity proof receipt
  repo-star-downstream-genericity-proof-receipt.md # Two-target downstream genericity proof receipt
  repo-star-closure-runtime-distribution.md # Closure/runtime detector-advisor distribution record
  gbrain-retrieval-citation-lifecycle.md # Advisory GBrain retrieval/citation lifecycle receipt
  gbrain-repo-local-instruction-distribution.md # Advisory GBrain instruction distribution receipt
  hermes-doer-gbrain-distributed-instructions.md # Hermes doer + GBrain-distributed instruction receipt
  sidecar-prompt-ab-response-shaped.md # Response-shaped Prompt A/B sidecar protocol
  external-critique-capability.md # Localizable external critique capability rule
  scheduled-runtime-learning-shadow-readback.md # Scheduled Runtime Learning Shadow readback receipt
  scheduled-readback-owner-proof.md # Scheduled readback owner proof receipt
  codex-native-runtime-readiness.md # Codex native local/worktree/cloud/remote readiness receipt
  deep-research-source-intelligence-native-corpus.md # Deep Research/source-intelligence native corpus template
  deep-research-source-ledger-v2-adoption.md # Deep Research source-ledger v2 adoption template
  integrated-native-capability-acceptance.md # Integrated native capability acceptance receipt
  github-parsed-closure-semantics.md # GitHub parsed closure semantics receipt
  route-changing-learning-failure.md # Route-changing learning/failure receipt
  closure-signal-integrity.md # Closure signal integrity + external coupling receipt
  review-ergonomics-working-memory-lightness.md # Review working-memory lightness receipt
  validation-integrity-format-tracking.md # Validation format drift tracking receipt
  repo-assimilation-method.md # Repo-agent assimilation method record (11-step skeleton)
  principle-alignment-anchor.md # Principle-alignment anchor record (assimilation step-0)
  repo-anthropology.md # Repo anthropology surface record (purpose/use-cases/principles)
  benchmark-before-repair.md # Benchmark-before-repair record (dimensions before selection)
  repair-decision-block.md # Repair decision-block record (selection-changing admission)
  maturity-boundary-claim.md # Maturity-boundary claim-separation record
scripts/                    # Hook scripts
  pre-commit-hook.sh        # v2 hard-default review (blocks by default)
  pre-push-hook.sh          # Push review warning
  compare-scorecards.sh     # Shared scorecard comparison primitive
  check-compare-scorecards-conformance.sh # Fixture + hash drift gate for consumer copies
docs/
  core-five-owner-surface-contract.md # Issue #164 core-five owner-surface contract
  live-capability-inventory.md # Live tool/agent tracking surface for calibrated drift checks
  capability-placement-contract.md # Advisory capability placement / Autonomy Preview
  goal-episode-evaluation-contract.md # Shared Goal-mode runtime evaluation language
  interruption-recovery-and-batch-reconstitution-contract.md # Goal blocker recovery contract
  foreground-learning-and-recovery-contract.md # Foreground learning/recovery contract
  default-capability-reconciliation-contract.md # Default-first capability reconciliation language
  upstream-capability-intake-contract.md # Compact upstream capability intake contract
  native-evidence-before-verdict-contract.md # Native evidence before adoption/readiness/fallback verdicts
  hermes-foreground-launcher-contract.md # One-shot Hermes foreground launcher contract
  hermes-foreground-reliability-contract.md # Foreground Hermes doer/checker reliability contract
  hermes-foreground-repo-star-pilot-reliability-contract.md # Bounded Hermes repo-star pilot reliability contract
  gbrain-advisory-pilot-outcome-learning-loop-contract.md # Advisory GBrain pilot outcome learning-loop contract
  foreground-recovery-runtime-contract.md # Compact foreground recovery runtime composition
  foreground-failure-to-issue-conversion-contract.md # Foreground failure-to-issue conversion contract
  hermes-foreground-failure-disposition-contract.md # Foreground Hermes failure disposition contract
  downstream-read-only-recovery-runtime-pilot-contract.md # Downstream read-only pilot receipt
  repo-star-genericity-proof-contract.md # Non-BMA repo-star genericity proof contract
  repo-star-downstream-genericity-proof-contract.md # Two-target downstream genericity proof contract
  repo-star-closure-runtime-distribution-contract.md # Closure/runtime detector-advisor distribution contract
  gbrain-retrieval-citation-lifecycle-contract.md # Advisory GBrain retrieval/citation proof contract
  gbrain-repo-local-instruction-distribution-contract.md # Advisory GBrain repo-local instruction distribution contract
  hermes-doer-gbrain-distributed-instructions-contract.md # Hermes doer + GBrain-distributed instruction contract
  sidecar-prompt-ab-response-shaped-contract.md # Response-shaped sidecar Prompt A/B contract
  external-critique-capability-contract.md # Localizable external critique capability contract
  scheduled-runtime-learning-shadow-readback-contract.md # Scheduled Runtime Learning Shadow readback contract
  scheduled-readback-owner-proof-contract.md # Scheduled readback owner proof contract
  codex-native-runtime-readiness-contract.md # Codex native runtime readiness contract
  deep-research-source-intelligence-native-corpus-contract.md # Deep Research/source-intelligence native corpus contract
  deep-research-source-ledger-v2-adoption-contract.md # Deep Research source-ledger v2 adoption contract
  integrated-native-capability-acceptance-contract.md # Integrated native capability acceptance contract
  github-parsed-closure-semantics-contract.md # GitHub parsed closure semantics contract
  route-changing-learning-failure-contract.md # Route-changing learning/failure contract
  closure-signal-integrity-contract.md # Closure signal integrity + external coupling contract
  review-ergonomics-working-memory-lightness-contract.md # Review working-memory lightness contract
  validation-integrity-format-tracking-contract.md # Validation format drift tracking contract
  repo-assimilation-method-contract.md # Repo-agent assimilation method umbrella contract (n=2)
  principle-alignment-anchor-contract.md # Principle-alignment anchor (assimilation step-0) contract
  repo-anthropology-contract.md # Repo anthropology surface contract
  benchmark-before-repair-contract.md # Benchmark-before-repair contract
  repair-decision-block-contract.md # Repair decision-block contract
  maturity-boundary-claim-contract.md # Maturity-boundary claim-separation contract
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

## Capability Placement Contract

The [capability placement contract](docs/capability-placement-contract.md)
defines the portable Autonomy Preview shape for naming best current owner, best
future owner, allowed reach, native signal, promotion gate, demotion/rejection
trigger, kill switch, forbidden mode, and GBrain slug/no-capture reason before
high-priority owner-surface work launches. Consumers may copy-sync or cite the
[template](templates/capability-placement.md), but must not turn it into a
dashboard, registry, central ledger, scheduler, queue, daemon, controller,
runtime dependency, automatic issue/PR creator, auto-merge path, background
Hermes/GBrain behavior, Codex cloud/background write authority, downstream
mutation path, or replacement closure truth.

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
changes the default path. Adoption or substitution verdicts also follow the
[native evidence before verdict contract](docs/native-evidence-before-verdict-contract.md):
upstream docs/root instructions are necessary but not sufficient, and the
verdict-bearing surface needs native command/workflow output or a concrete
owner-surface blocker.

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

## Native Evidence Before Verdict Contract

The [native evidence before verdict contract](docs/native-evidence-before-verdict-contract.md)
defines the shared repo-agent rule for external-system, upstream-tool, library,
product, and native-capability verdicts: upstream docs/root instructions are
necessary but not sufficient, and adoption/readiness/fallback/production/GA/
cutover/architecture judgments need a safe documented native attempt or a
concrete owner-surface blocker carried on the verdict-bearing surface.
Consumers may copy the [template](templates/native-evidence-before-verdict.md)
or cite the contract, but must not turn it into a runtime dependency,
validator theater, controller, scheduler, queue, daemon, registry, background
memory process, automatic issue/PR creator, auto-updater, or downstream
mutation grant. GBrain references stay advisory and cannot override operator
intent, GitHub truth, repo evidence, or repo-local instructions.

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

## Hermes Foreground Reliability Contract

The [Hermes foreground reliability contract](docs/hermes-foreground-reliability-contract.md)
defines the portable Issue #164 evidence shape for using Hermes as a bounded
foreground doer or advisory checker. Consumers may copy the
[template](templates/hermes-foreground-reliability.md) or cite the contract,
but must not turn it into a runtime dependency, schema mandate, daemon,
scheduler, queue, retry loop, controller, hidden registry, MCP server,
background sync, automatic GitHub issue/PR creation, auto-merge, downstream
mutation, Hermes repo mutation, background Hermes/GBrain behavior, `hermes -z`
adoption path, or Hermes-primary campaign/control claim.

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

## Scheduled Runtime Learning Shadow Readback Contract

The [scheduled Runtime Learning Shadow readback contract](docs/scheduled-runtime-learning-shadow-readback-contract.md)
defines the shared receipt shape for admitting an actual `event=schedule`
Runtime Learning Shadow run after it exists. Consumers may copy-sync or cite the
[template](templates/scheduled-runtime-learning-shadow-readback.md), but must
not turn it into a runner, scheduler, queue, daemon, controller, registry,
automatic GitHub issue/PR creator, retained closeout package, background
GBrain/Hermes behavior, or task-closure authority. Comments and artifacts are
evidence only; GitHub issue/PR/check/merge truth remains closure truth.

## Scheduled Readback Owner Proof Contract

The [scheduled readback owner proof contract](docs/scheduled-readback-owner-proof-contract.md)
defines the shared `SCHEDULED_READBACK_OWNER_PROOF` shape for deciding whether
a read-only scheduled-readback candidate has owner-admissible schedule
evidence. Consumers may copy-sync or cite the
[template](templates/scheduled-readback-owner-proof.md), but must not turn it
into a workflow runner, scheduler, queue, daemon, controller, registry,
automatic GitHub issue/PR mutation path, auto-merge path, background
GBrain/Hermes behavior, or closure authority. `workflow_dispatch` is context
only and never scheduled proof.

## Codex Native Runtime Readiness Contract

The [Codex native runtime readiness contract](docs/codex-native-runtime-readiness-contract.md)
defines the shared evidence shape for assessing Codex local, worktree, cloud,
remote, automation, and subagent readiness before promoting a foreground owner
lane to a different runtime placement. Consumers may copy-sync or cite the
[template](templates/codex-native-runtime-readiness.md), but must not turn it
into a runtime dependency, controller, scheduler, queue, daemon, registry,
automatic issue/PR creator, auto-merge path, retained closeout package,
downstream mutation grant, or live Codex Cloud/remote execution proof. Official
Codex docs are capability context only unless raw task evidence proves the live
run.

## GitHub Parsed Closure Semantics Contract

The [GitHub parsed closure semantics contract](docs/github-parsed-closure-semantics-contract.md)
defines the shared receipt shape for checking GitHub's parsed
`closingIssuesReferences` surface before Issue #164 carrier PRs can affect
child issue state. Consumers may copy-sync or cite the
[template](templates/github-parsed-closure-semantics.md), but must not turn it
into a GitHub client, runtime dependency, controller, scheduler, queue, daemon,
registry, retained closeout package, automatic issue/PR creator, issue-state
repair mechanism, or closure authority. It exists to catch cases where negated
body wording still creates a parsed closing reference; GitHub issue/PR/check/
merge truth remains closure truth.

## Route-Changing Learning Failure Contract

The [route-changing learning failure contract](docs/route-changing-learning-failure-contract.md)
defines the shared receipt shape for owner-surface events where foreground
Hermes failure routing, GitHub evidence, advisory GBrain exact-handle replay,
fallback without memory, or literal-safe GitHub readback changes the route.
Consumers may copy-sync or cite the
[template](templates/route-changing-learning-failure.md), but must not turn it
into a runtime dependency, GitHub client, memory daemon, controller, scheduler,
queue, retry loop, hidden registry, automatic issue/PR creator, retained
closeout package, background Hermes/GBrain behavior, Hermes authority, GBrain
authority, downstream mutation path, or closure surface.

## GBrain Advisory Pilot Outcome Learning Loop Contract

The [GBrain advisory pilot outcome learning-loop contract](docs/gbrain-advisory-pilot-outcome-learning-loop-contract.md)
defines the shared
`GBRAIN_ADVISORY_PILOT_OUTCOME_LEARNING_LOOP_RECEIPT` shape for replaying
Issue #164 pilot outcomes, classifying decision-changing or no-capture learning,
checking citation/source-ref quality, and routing owner repairs when advisory
GBrain evidence is stale, missing, uncited, contradictory, or not
decision-changing. It also records semantic search/query disposition and
exact-handle replay rows before route-changing advisory memory can influence an
owner action. Consumers may copy-sync or cite the contract, schema, or
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

## Standalone External-Intelligence Sidecar Contract

The [standalone external-intelligence sidecar contract](docs/sidecar-prompt-ab-response-shaped-contract.md)
defines the shared manual sidecar protocol for singleton, Prompt A, Prompt B,
and Deep Research modes under `STANDALONE_EXTERNAL_INTELLIGENCE_SIDECAR`.
Consumers may copy the
[template](templates/sidecar-prompt-ab-response-shaped.md) or cite the contract,
but must not turn them into a sidecar runner, controller, scheduler, queue,
daemon, hidden registry, retained closure package, or background sync
mechanism. Each sidecar prompt must be a pure standalone prompt addressed to the
external model, with no operator wrapper text, all required context embedded,
public URLs optional and non-load-bearing, and all jargon/acronyms defined.
Prompt A asks clarifying questions and context gaps. Prompt B embeds actual
Prompt A output plus answered context before final analysis. Deep Research mode
includes research targets, source rules, and a source-ledger response shape.

## External Critique Capability Contract

The [external critique capability contract](docs/external-critique-capability-contract.md)
defines the localizable invocation and admission rule for bounded external
critique under `EXTERNAL_CRITIQUE_CAPABILITY`. Consumers may copy the
[template](templates/external-critique-capability.md) or cite the contract, but
must not turn them into a controller, scheduler, queue, daemon, registry,
dashboard, retry loop, background memory process, automatic issue/PR system,
standing paired-probe program, central service, sidecar runner, runtime
dependency, live-probe authorization, auto-merge path, downstream mutation
grant, or background sync mechanism. The default path is one critic. A panel or
latest-panel requires named high-stakes context. There is no forced finding
quota. Findings must separate blocker from advisory, critique gets one initial
pass plus one follow-up unless explicitly approved, and effectiveness requires
independent owner evidence. Target repo principles outrank imported BMA
phrasing; literal BMA wording is seed evidence only, not canonical target text.
When a repo has a skill system or capability convention, reusable repo-agent
mechanisms should localize there before prompt files; prompts remain request,
sidecar, or provenance artifacts. Model/path availability belongs in observed
receipt or output fields, not static routing promises or probe programs.

## Deep Research Source-Intelligence Native Corpus Contract

The [Deep Research source-intelligence native corpus contract](docs/deep-research-source-intelligence-native-corpus-contract.md)
defines the shared Issue #164 Arc 4 corpus shape for operator-provided external
source bundles, manual Deep Research sidecar prompts, and `SOURCE_INSIGHT_PACKET`
mapping. Consumers may copy the
[template](templates/deep-research-source-intelligence-native-corpus.md) or cite
the contract, but must not turn it into a runtime dependency, schema mandate
beyond `SOURCE_INSIGHT_PACKET`, crawler, source registry, watcher, scheduler,
queue, daemon, controller, hidden registry, Deep Research API runner, automatic
GitHub issue/PR creator, auto-merge path, retained closeout package, background
sync, raw authenticated DOM/HTML/screenshot/account-context retention,
downstream mutation path, live Codex Cloud execution, or live Codex remote
execution. Official Deep Research and Web Search docs are capability context
until raw run evidence proves a live API path.

## Deep Research Source-Ledger V2 Adoption Contract

The [Deep Research source-ledger v2 adoption contract](docs/deep-research-source-ledger-v2-adoption-contract.md)
defines the shared `DEEP_RESEARCH_SOURCE_LEDGER_V2_ADOPTION` record for the
bounded BMA #919/#921-shaped manual Deep Research workflow: public/no-auth
architecture/source-intelligence advisory decisions, standalone prompts with
embedded context, `3/4` default prompt tier, `1/2` bounded transport-fit
fallback, `1/3` not accepted as default, and source-ledger v2 fields including
consulted-on date, exclusion rationale, and recommendation effect. Consumers
may copy the
[template](templates/deep-research-source-ledger-v2-adoption.md) or cite the
contract, but must not turn it into a Deep Research API runner, sidecar runner,
crawler, source registry, watcher, scheduler, queue, daemon, controller, hidden
registry, automatic GitHub issue/PR creator, auto-merge path, retained closeout
package, authenticated capture grant, or downstream mutation path. Sidecar
output remains advisory evidence only and never replaces GitHub
issue/PR/check/merge truth.

## Integrated Native Capability Acceptance Contract

The [integrated native capability acceptance contract](docs/integrated-native-capability-acceptance-contract.md)
defines the shared `INTEGRATED_NATIVE_CAPABILITY_ACCEPTANCE` record for Issue
#164 Arc 5 propagation after BMA accepted Codex Cloud proof while keeping
Codex remote validation deferred and failed sidecar prompting outside Arc 5.
Consumers may copy-sync or cite the
[template](templates/integrated-native-capability-acceptance.md), but must not
turn it into a runtime dependency, controller, scheduler, queue, daemon,
registry, automatic issue/PR creator, auto-merge path, retained closeout
package, sidecar runner, Codex remote proof substitute, or downstream mutation
grant. Official docs, remote setup screenshots, and sidecar prompts are not
live acceptance proof without raw task/session evidence and GitHub truth.

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

## Foreground Failure-To-Issue Conversion Contract

The [foreground failure-to-issue conversion contract](docs/foreground-failure-to-issue-conversion-contract.md)
defines the compact owner-surface conversion record for turning foreground
failure guidance, including `HERMES_FOREGROUND_FAILURE_GUIDANCE`, into GitHub
issue or issue comment truth with exact-marker dedupe, evidence path, owner
action, and bounded non-claims. Consumers may copy the
[template](templates/foreground-failure-to-issue-conversion.md) or cite the
contract, but must not turn it into a runtime dependency, daemon, scheduler,
queue, retry loop, registry, controller, hidden registry, background GBrain
behavior, automatic background issue creation, auto-merge, downstream mutation,
Hermes/GBrain internals mutation, or runtime dependency behavior.

## Hermes Foreground Failure Disposition Contract

The [Hermes foreground failure disposition contract](docs/hermes-foreground-failure-disposition-contract.md)
defines the portable `HERMES_FOREGROUND_FAILURE_DISPOSITION` record for deciding
whether a converted foreground Hermes failure issue may close, must stay open,
or needs a GitHub-visible blocker. Consumers may copy the
[template](templates/hermes-foreground-failure-disposition.md) or cite the
contract, but must not turn it into a runtime dependency, schema mandate,
controller, scheduler, queue, daemon, registry, retry loop, auto-close,
auto-merge, automatic issue/PR creation, downstream mutation, upstream Hermes
mutation, or background Hermes/GBrain behavior. Close allowance requires
unambiguous GitHub truth: exactly one merged related repair PR that references
the failure issue itself or complete current provider-policy supersession;
otherwise blocker evidence keeps the issue open.

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

## Repo-Star Closure Runtime Distribution Contract

The [repo-star closure runtime distribution contract](docs/repo-star-closure-runtime-distribution-contract.md)
defines the shared Issue #164 closure-ceremony and runtime-drift distribution
shape for detector, advisor, and optimizer owner surfaces. It also carries
native-evidence-before-verdict classes so repo-star work can detect docs-only
adoption/readiness/fallback judgments and route them to native attempts or
owner-surface blockers. Consumers may copy the
[template](templates/repo-star-closure-runtime-distribution.md) or cite the
contract, but must not turn it into a runtime dependency, daemon, scheduler,
queue, controller, retry loop, hidden registry, retained report-package truth,
background memory process, auto-merge path, or downstream mutation grant.

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
