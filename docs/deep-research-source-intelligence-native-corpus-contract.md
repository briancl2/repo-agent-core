# Deep Research Source-Intelligence Native Corpus Contract

> Version: 1.0
> Owner: repo-agent-core

## Purpose

This contract defines the portable Issue #164 Arc 4 native corpus shape for
Deep Research and external intelligence source-intelligence work. It starts
from a bounded operator-provided source bundle, gives every source equal
first-pass insight/no-insight/contradiction treatment, maps claims to source
IDs and evidence tiers through `SOURCE_INSIGHT_PACKET`, and routes high-signal
findings to the owning repo surface.

The contract composes existing repo-agent-core primitives:

- `schemas/SOURCE_INSIGHT_PACKET.schema.json`
- `docs/sidecar-prompt-ab-response-shaped-contract.md`
- `templates/sidecar-prompt-ab-response-shaped.md`
- `templates/deep-research-source-intelligence-native-corpus.md`

Consumers may copy-sync or cite this contract and template. Do not turn either
file into a runtime dependency, schema mandate beyond `SOURCE_INSIGHT_PACKET`,
crawler, source registry, watcher, scheduler, queue, daemon, controller,
hidden registry, sidecar runner, Deep Research API runner, automatic GitHub
issue/PR creator, auto-merge path, retained closeout package, background sync,
or downstream mutation path.

## Carrier 1 Input And Carrier 2 Owner Evidence

The first proof source is build-meta-analysis Issue #164 Arc 4 Carrier 1, while
Carrier 2 is the repo-agent-core owner propagation that makes the proof
portable:

- BMA parent campaign: `https://github.com/briancl2/build-meta-analysis/issues/164`
- BMA Carrier 1 child: `https://github.com/briancl2/build-meta-analysis/issues/899`
- BMA Carrier 1 implementation PR: `https://github.com/briancl2/build-meta-analysis/pull/900`
- BMA Carrier 2 child: `https://github.com/briancl2/build-meta-analysis/issues/901`
- repo-agent-core owner issue: `https://github.com/briancl2/repo-agent-core/issues/74`

Carrier 1 proved the BMA corpus kickoff with 19 exact X URLs, public/no-auth
reachability, bounded authenticated exact-url X capture, manual Deep Research sidecar prompt only,
and source-intelligence intake validation. It did not
prove a live Deep Research API run, live Codex Cloud execution, live Codex
remote execution, background source automation, or downstream mutation.
Carrier 2 template examples use the Carrier 2 child URL because they describe
the propagation work; Carrier 1 URLs remain the input evidence.

Official Deep Research and Web Search documentation are capability context for
source access and synthesis. Codex Cloud, remote connection, and worktree
documentation are later placement context for Arc 5 hard gates. None of those
docs prove that this carrier ran a live Deep Research API, Codex Cloud, or
Codex remote task.

## Required Fields

| Field | Requirement |
| --- | --- |
| `artifact` | Must be `DEEP_RESEARCH_SOURCE_INTELLIGENCE_NATIVE_CORPUS`. |
| `schema_version` | Contract version for the corpus wrapper shape. |
| `source_issue_or_pr` | Owner issue or PR requesting the corpus propagation. |
| `parent_campaign_url` | Parent Issue #164 campaign URL when applicable. |
| `carrier_child_url` | BMA child or owner issue governing the carrier. |
| `owner_issue_url` | Owner repo issue when the work propagates outside BMA. |
| `corpus_identity` | Bundle ID, source count, source class, operator intent, and source surface. |
| `source_access_policy` | Public/no-auth first, authenticated exact-url fallback only when approved, and raw capture retention limits. |
| `per_source_disposition_requirements` | Required disposition fields for every supplied source. |
| `source_insight_packet_mapping` | How the corpus maps into `SOURCE_INSIGHT_PACKET` sources, claims, high-signal findings, consumer targets, and bounded non-claims. |
| `deep_research_sidecar` | Manual sidecar prompt and pasteback handling, including whether the pasteback exists. |
| `deep_research_api_disposition` | Exact API disposition. Carrier 1 uses `rescoped_failed_not_authorized`. |
| `official_docs_context` | Official docs used as capability context, with an explicit non-claim boundary. |
| `raw_evidence_requirements` | Evidence required before any live API/cloud/remote claim. |
| `consumer_routes` | repo-agent-core, repo-auditor, repo-upgrade-advisor, and repo-optimizer owner routing. |
| `validation_scope` | Repo-native checks required before publication. |
| `fallback` | Exact blocker route if the corpus cannot be validated or consumed. |
| `bounded_non_claims` | Non-claims for automation, authority, mutation, raw capture retention, and closure truth. |
| `next_owner_action` | Next carrier or repair action after accepted/partial/rejected disposition. |

## Source Access Policy

The access order is:

1. Public/no-auth capture first.
2. Bounded authenticated browser capture only for exact approved URLs when
   public capture is insufficient.
3. Capture visible primary post, visible author continuations, embedded-link
   disposition, media/OCR disposition, and top visible reply/comment
   disposition when the source surface supports it.
4. Do not retain raw authenticated DOM, HTML, screenshots, account context,
   cookies, local storage, unrelated tabs, DMs, notifications, settings, or
   browser/profile state.

Authenticated capture produces safe summaries, counts, source IDs, claim
effects, redaction decisions, and bounded excerpts only when needed. It is not
a crawler, source registry, watcher, or background ingestion process.

## Per-Source Disposition

Every supplied source must receive a disposition row before proof-tier ranking:

- normalized `source_id`
- URL or reference
- source class
- author/date if visible or an explicit not-visible reason
- primary source disposition
- continuation/thread disposition
- top-reply/comment disposition
- embedded-link disposition
- media/OCR disposition
- insight/no-insight/contradiction/inaccessible disposition
- claim effect
- evidence tier
- owner/no-action disposition

Source class affects verification strength, not first-pass eligibility.

## SOURCE_INSIGHT_PACKET Mapping

Use `SOURCE_INSIGHT_PACKET` as the portable packet. This contract does not
replace or fork that schema.

- Corpus sources map to `sources[]`.
- Claims map to `claims[]` with `source_ids`, `evidence_tier`, and
  `effect_on_decision`.
- Owner-routable findings map to `high_signal_findings[]`.
- Expected consumers map to `consumer_targets[]`.
- Boundaries map to `bounded_non_claims[]`.

If a future carrier needs fields outside `SOURCE_INSIGHT_PACKET`, add them first
as additional properties in the sample/template and only propose a schema
change after a consumer proves the existing schema is insufficient.

## Manual Deep Research Sidecar

Manual Deep Research sidecar work must follow the response-shaped Prompt A/B
protocol. Prompt A can ask for assumption gaps, missing evidence, stale claims,
contradictions, and source questions. Prompt B can claim reconciliation only
after the actual Prompt A response exists unless it is explicitly marked
`hypothetical-draft`.

Carrier 1 disposition is:

`deep_research_api_disposition=rescoped_failed_not_authorized`

That value means the API path was not authorized for the carrier. It does not
mean the API failed technically, and it does not prove API execution. Manual
pasteback is evidence only after the operator supplies it and the consuming repo
routes it through the source manifest, equal-insight, claim/effect, and
owner/no-action checks.

## Consumer Routing

- `repo-agent-core` owns this contract/template and the shared
  `SOURCE_INSIGHT_PACKET` primitive.
- `repo-auditor` may detect missing source disposition, weak provenance,
  unsupported Deep Research/API claims, or raw capture retention drift after a
  separate owner issue admits that carrier.
- `repo-upgrade-advisor` may recommend owner action from detector findings after
  a separate owner issue admits that carrier.
- `repo-optimizer` may consume optimizer-ready corpus rows only after an
  explicit optimizer branch gate and an existing report-only/apply-check path.
- BMA coordinates Campaign Sync and carrier acceptance but does not turn this
  contract into BMA closure truth.

## Validation

A consumer should validate at least:

1. The corpus wrapper contains every required field.
2. The `SOURCE_INSIGHT_PACKET` packet validates or is explicitly cited as the
   packet shape being generated.
3. Every supplied source has insight/no-insight/contradiction/inaccessible
   disposition.
4. Every claim cites known source IDs and an evidence tier.
5. High-signal findings have owner/no-action disposition.
6. Deep Research API, Codex Cloud, and Codex remote claims are backed by raw
   run evidence or explicitly listed as non-claims.
7. No raw authenticated DOM, HTML, screenshots, or account context is retained.
8. No crawler, registry, watcher, scheduler, queue, daemon, controller,
   automatic GitHub mutation, auto-merge, retained closeout truth, or downstream
   mutation is introduced.

## Fallback

If the corpus cannot be validated, record the exact blocker on the owner issue
or PR. If the shared contract is insufficient, route the repair to
repo-agent-core. If a detector/recommendation/materialization consumer is
missing, route to repo-auditor, repo-upgrade-advisor, or repo-optimizer through
its own owner issue. Do not preserve a BMA-only proof hunt when an owner surface
can create or reject the missing mechanism.

## Bounded Non-Claims

This contract does not run Deep Research, call the Deep Research API, browse the
web, capture authenticated pages, run Codex Cloud, run Codex remote
connections, create issues, create PRs, post comments, merge PRs, close issues,
schedule jobs, run Hermes, run GBrain, create a crawler, create a source
registry, retain raw authenticated browser captures, mutate downstream repos,
replace GitHub issue/PR/check/merge truth, or create a retained closeout
package.
