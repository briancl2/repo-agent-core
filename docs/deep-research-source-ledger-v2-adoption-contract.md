# Deep Research Source-Ledger V2 Adoption Contract

> Version: 1.0
> Date: 2026-06-19
> Owner: repo-agent-core
> Token: `DEEP_RESEARCH_SOURCE_LEDGER_V2_ADOPTION`

## Purpose

This contract defines the portable Issue #164 adoption record for the repaired
manual Deep Research source-ledger workflow. It applies after BMA proved that a
standalone Deep Research sidecar can carry enough embedded context, source
rules, advisory boundaries, and source-ledger fields to support a bounded
source-intelligence architecture decision.

This contract composes, but does not replace, these repo-agent-core primitives:

- `STANDALONE_EXTERNAL_INTELLIGENCE_SIDECAR`
- `docs/sidecar-prompt-ab-response-shaped-contract.md`
- `templates/sidecar-prompt-ab-response-shaped.md`
- `docs/deep-research-source-intelligence-native-corpus-contract.md`
- `templates/deep-research-source-intelligence-native-corpus.md`
- `templates/deep-research-source-ledger-v2-adoption.md`

Consumers may copy-sync or cite this contract and template. Do not turn either
file into a runtime dependency, Deep Research API runner, sidecar runner,
crawler, source registry, watcher, scheduler, queue, daemon, controller, retry
loop, hidden registry, automatic GitHub issue/PR creator, auto-merge path,
retained closeout package, background sync, authenticated browser capture grant,
or downstream mutation path.

## Input And Owner Evidence

The accepted input is the BMA post-Arc-5 sidecar repair sequence:

- BMA parent campaign: `https://github.com/briancl2/build-meta-analysis/issues/164`
- BMA standalone sidecar replacement child: `https://github.com/briancl2/build-meta-analysis/issues/916`
- BMA standalone sidecar replacement PR: `https://github.com/briancl2/build-meta-analysis/pull/917`
- BMA manual sidecar adoption child: `https://github.com/briancl2/build-meta-analysis/issues/919`
- BMA manual sidecar adoption PR: `https://github.com/briancl2/build-meta-analysis/pull/920`
- BMA quality ladder child: `https://github.com/briancl2/build-meta-analysis/issues/921`
- BMA quality ladder PR: `https://github.com/briancl2/build-meta-analysis/pull/922`
- BMA live adoption child: `https://github.com/briancl2/build-meta-analysis/issues/923`
- BMA live adoption PR: `https://github.com/briancl2/build-meta-analysis/pull/924`
- BMA live adoption merge: `41532809f055cecfa00a34ae625db8899a781d5d`
- repo-agent-core owner issue: `https://github.com/briancl2/repo-agent-core/issues/80`

BMA #919 accepted one manual ChatGPT Pro Prompt B trial and one manual Deep
Research trial. BMA #921 ran two manual Deep Research trials with prompt-length
variants, deterministic scorecards, ROI rows, and a local-aware panel critique.
BMA #923 adopted the repaired Deep Research source-ledger workflow only for the
#919/#921-shaped decision class described below.

Official OpenAI Deep Research, prompt guidance, and accuracy-optimization docs
are capability context for source-backed research and prompt clarity. They are
not live proof that any manual or API Deep Research task was accepted. GitHub
issue/PR/check/merge truth plus the BMA manual pasteback scorecards are the
evidence for this adoption record.

## Accepted Decision Class

`DEEP_RESEARCH_SOURCE_LEDGER_V2_ADOPTION` applies only when all of these are
true:

1. The sidecar is manual Deep Research, not Deep Research API execution.
2. The decision is an architecture or source-intelligence advisory decision.
3. The source access model is public/no-auth only.
4. The prompt is standalone and embeds the required local/private context.
5. Public URLs are research targets or optional sources, not hidden required
   context.
6. The output is advisory evidence only and cannot close an issue, approve a
   PR, replace operator judgment, mutate a repository, or become task closure
   truth.

Do not apply this adoption record to authenticated-source capture, private
repository analysis, local filesystem analysis, source ingestion automation,
Deep Research API execution, broad future sidecar prompts, or any decision that
requires private GitHub or workspace context not embedded in the prompt.

## Required Fields

| Field | Requirement |
| --- | --- |
| `artifact` | Literal `DEEP_RESEARCH_SOURCE_LEDGER_V2_ADOPTION`. |
| `schema_version` | Contract version for this wrapper shape. |
| `source_issue_or_pr` | Issue, PR, or campaign surface authorizing the adoption record. |
| `parent_campaign_url` | Parent Issue #164 campaign URL when applicable. |
| `owner_issue_url` | Owner repo issue for the propagation work. |
| `accepted_decision_class` | The bounded #919/#921-shaped public/no-auth manual Deep Research architecture/source-intelligence decision class. |
| `manual_trial_evidence` | BMA #919 and #921 manual trial URLs, prompt tiers, pasteback dispositions, scorecards, and critique dispositions. |
| `prompt_tier_disposition` | `3/4` default; `1/2` bounded transport-fit fallback; `1/3` not accepted as default. |
| `source_ledger_v2_fields` | Source ledger fields including consulted-on date, exclusion rationale, and recommendation effect. |
| `source_rules` | Public-source-only, source quality, citation/source metadata, and no private/local/GitHub dependency rules. |
| `advisory_boundary` | Sidecar output remains advisory evidence only. |
| `github_truth` | Linked issues, PRs, required checks, merge commits, and Campaign Sync. |
| `promotion_gate` | Evidence required before broadening the decision class. |
| `demotion_rejection_trigger` | Exact conditions that demote or reject the claim. |
| `kill_switch` | Owner action when proof is missing or a forbidden boundary is crossed. |
| `bounded_non_claims` | Explicit no-API, no-broad-future-prompt, no-authenticated-capture, no-automation, no-closure-truth, and no-downstream-mutation claims. |
| `next_owner_action` | Next carrier or repair owner action after accepted, partial, blocked, or rejected disposition. |

## Prompt Tier Disposition

The accepted prompt-length guidance is:

- `3/4` is the default manual Deep Research source-ledger prompt tier for this
  decision class.
- `1/2` is a bounded transport-fit fallback only when the prompt still includes
  the glossary, source rules, advisory boundary, response contract, and source
  ledger fields.
- `1/3` is not accepted as a default and is not proven safe for this use case.
- The full prompt can remain a retained diagnostic or local preflight artifact,
  but it had manual transport friction and is not the default paste tier.

Prompt tiers must be generated from curated context tiers, not blind truncation.

## Source-Ledger V2 Fields

Every accepted Deep Research pasteback or scoring surface should preserve a
source ledger with these fields or a clear equivalent:

- `source_id`
- `url`
- `title_or_source_name`
- `publisher_or_author`
- `source_type`
- `access_method`
- `consulted_status`
- `consulted_on_date`
- `why_included_or_excluded`
- `exclusion_rationale`
- `claim_supported`
- `evidence_tier`
- `confidence`
- `limitations`
- `recommendation_effect`

The source ledger is a review aid. It does not become a source registry,
crawler index, standing ingestion queue, or retained closeout truth.

## Promotion And Demotion

Promote this adoption record only when:

1. The prompt passed the standalone sidecar static validator.
2. Manual Deep Research transport completed or the consumer cites an accepted
   prior manual trial for the same decision class.
3. The pasteback or accepted prior trial includes source-ledger behavior,
   public-source-only behavior, advisory boundary preservation, and exactly one
   next owner action.
4. GitHub issue/PR/check/merge truth records the adopted decision.
5. Bounded non-claims are explicit.

Demote or reject the record when it claims live Deep Research API execution
without raw API task evidence, treats a sidecar answer as closure truth, relies
on hidden local/private/GitHub context, lacks source-ledger fields, omits the
advisory boundary, accepts `1/3` as default, expands to authenticated-source
capture, introduces crawlers or source registries, creates controller/
scheduler/queue/daemon behavior, creates automatic GitHub mutation, auto-merges,
or mutates downstream repos.

## Consumer Routing

- `repo-agent-core` owns this contract and template.
- `repo-auditor` may detect missing source-ledger v2 fields, false Deep
  Research/API adoption, prompt-tier overclaims, private-context dependence, or
  control-plane drift after a separate owner issue admits that carrier.
- `repo-upgrade-advisor` may recommend owner action from those detector findings
  after a separate owner issue admits that carrier.
- `repo-optimizer` is not part of this propagation route unless a later owner
  issue proves an optimizer-ready materialization need.
- BMA coordinates Campaign Sync and adoption readback, but this contract is not
  BMA closure truth.

## Copy-Sync Boundary

Consumers may copy-sync this contract or template into issue bodies, PR bodies,
repo-local docs, detector fixtures, advisor examples, or local validation
guards. Copy drift is repo-quality debt handled by focused review and tests. Do
not add a runtime dependency, generated registry, watcher, scheduler, queue,
controller, daemon, retry loop, automatic updater, or background sync to keep
copies aligned.

## Bounded Non-Claims

This contract does not run Deep Research, call the Deep Research API, prove
future standalone prompts are semantically sufficient, validate authenticated
source capture, browse private repositories, inspect local files, create source
registries, create crawlers, create watchers, create queues, schedule jobs,
start daemons, create controllers, create issues, create PRs, post comments,
merge PRs, close issues, run Hermes, run GBrain, mutate BMA #832, mutate BMA
PR #801, mutate repo-auditor, mutate repo-upgrade-advisor, mutate
repo-optimizer, mutate downstream repos, replace GitHub issue/PR/check/merge
truth, or create a retained closeout package.
