# Standalone External-Intelligence Sidecar Contract

> Version: 2.0
> Date: 2026-06-18
> Owner: repo-agent-core
> Token: `STANDALONE_EXTERNAL_INTELLIGENCE_SIDECAR`
> Supersedes: Sidecar Prompt A/B Response-Shaped Contract v1.0

## Purpose

This contract defines the shared sidecar prompt shape for manual ChatGPT Pro,
manual Deep Research, Opus proxy, or comparable external-intelligence surfaces.
It preserves Prompt A/B response-shaped behavior as a mode while replacing the
old prompt-kit pattern with a strict standalone prompt invariant.

The protected frame is simple: the external model is powerful but outside the
local context. It has no local filesystem access, no private repository access,
no GitHub issue access, no previous chat access, and no workspace context unless
the prompt embeds that context directly.

This is a copy-sync/citation contract and template. It is not a runtime package,
sidecar runner, scheduler, queue, controller, daemon, hidden registry, watcher,
memory import framework, background sync, retry loop, automatic GitHub mutation
path, or retained closure package.

## Required Protocol

| Field | Required meaning |
|---|---|
| Contract token | `STANDALONE_EXTERNAL_INTELLIGENCE_SIDECAR`. |
| Sidecar surface | The external model surface and mode: singleton, Prompt A, Prompt B, Deep Research, or proxy validation. |
| Pure prompt invariant | The pasteable artifact is addressed to the external model only. It contains no operator wrapper text such as "paste this", "copy this", "here is the prompt", or instructions about what the operator should paste. |
| Standalone access boundary | The prompt says the external model has no local filesystem, private repository, GitHub issue, prior chat, or workspace access. |
| Embedded context | All required context, architecture, terms, principles, integration points, challenges, goals, evidence summaries, and response shape are embedded directly. |
| Public URL boundary | Public URLs may appear only as optional and non-load-bearing sources. The prompt must remain understandable without opening them. |
| Definitions | Project jargon and acronyms are defined in plain language before use. |
| Prompt-layer clarity | The external model is asked to execute the task, not to review, critique, or improve the prompt itself. |
| Singleton mode | One-pass advisory review or problem-solving prompt with complete context and explicit response shape. |
| Prompt A mode | First pass in a two-prompt flow. It asks clarifying questions, context gaps, assumptions, and evidence needed for Prompt B. It does not produce the final answer. |
| Prompt B mode | Second pass in a two-prompt flow. It embeds actual Prompt A output and answered context before asking for the final answer. Prompt B without actual Prompt A output is invalid. |
| Deep Research mode | Research-oriented sidecar prompt that embeds research targets, source rules, public-source boundary, and source-ledger response shape. |
| Advisory boundary | Sidecar output is advisory. It does not close GitHub issues, approve pull requests, mutate repositories, replace operator judgment, or become task closure truth. |
| Regrowth boundary | Explicitly forbids automation, retained closure packages, controllers, queues, schedulers, registries, daemons, retry loops, background memory behavior, automatic issue/PR creation, and auto-merge. |

## Mode Requirements

### Singleton

Use singleton mode when the sidecar should perform one broad architectural
review, strategy review, or complex-problem analysis. The prompt must include
the full dossier needed to reason from first principles and must return a
clear response shape such as verdict, findings, risks, tradeoffs, recommended
next step, and missing evidence.

### Prompt A

Use Prompt A when context quality is uncertain. Prompt A asks the external model
to improve the eventual Prompt B by naming:

- clarifying questions;
- context gaps;
- assumptions to confirm;
- evidence that should be embedded in Prompt B;
- terms that need definitions;
- boundaries that may be ambiguous.

Prompt A output is not final planning authority.

### Prompt B

Use Prompt B only after actual Prompt A output exists and the operator or
coordinator has answered it. Prompt B must embed:

- actual Prompt A output;
- answered context for Prompt B;
- accepted, rejected, stale, unsupported, or blocked Prompt A claims when
  relevant;
- current embedded evidence summaries;
- boundaries and non-claims.

Prompt B must not claim reconciliation from a placeholder, expected answer, or
hypothetical Prompt A. If a hypothetical draft is unavoidable, it must be labeled
as non-authoritative and regenerated before use.

### Deep Research

Use Deep Research mode when the sidecar should search public sources or reason
over supplied public URLs. The prompt must include:

- research targets;
- source rules;
- source quality preferences;
- source-ledger response shape;
- confidence and gap reporting;
- an explicit statement that optional public URLs are not load-bearing context.

Live Deep Research API execution is not implied by this contract. Manual Deep
Research pasteback remains a first-class use case, but pasteback is not required
for a contract or detector PR to merge unless the owner issue says so.

## Output Shape

Every mode must include an explicit response shape. Common sections:

- Executive verdict or research verdict.
- Important findings.
- Risks and tradeoffs.
- Recommended next step.
- Missing evidence, context gaps, or assumptions.
- Source ledger for Deep Research mode.
- Prompt A reconciliation for Prompt B mode.

## Owner Routing

- Shared protocol gap: repo-agent-core.
- BMA campaign consumption gap: build-meta-analysis.
- Detector gap for local/private/GitHub dependency, prompt-layer confusion, or
  sidecar-as-authority overclaims: repo-auditor.
- Recommendation packaging gap:
  `standalone_external_intelligence_sidecar_gap` in repo-upgrade-advisor.
- Patch/materialization gap: repo-optimizer only if a later owner issue
  explicitly asks for patch-pack generation.

## Copy-Sync Boundary

Consumers may copy this contract, copy the template, or cite either artifact in
local prompt bundles, issue bodies, PR bodies, or docs. Copy drift is normal
repo-quality debt handled through review. Do not add a runtime dependency,
generated inventory, scheduler, queue, controller, watcher, daemon, hidden
registry, sidecar runner, retry loop, automatic updater, or background sync to
keep copies aligned.
