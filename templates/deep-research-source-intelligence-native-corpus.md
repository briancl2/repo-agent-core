# Deep Research Source-Intelligence Native Corpus

Copy or cite this template when a repo needs to package a bounded source corpus
for Issue #164-style Deep Research or external intelligence work.

```json
{
  "artifact": "DEEP_RESEARCH_SOURCE_INTELLIGENCE_NATIVE_CORPUS",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/repo-agent-core/issues/74",
  "parent_campaign_url": "https://github.com/briancl2/build-meta-analysis/issues/164",
  "carrier_child_url": "https://github.com/briancl2/build-meta-analysis/issues/901",
  "owner_issue_url": "https://github.com/briancl2/repo-agent-core/issues/74",
  "corpus_identity": {
    "bundle_id": "issue164-arc4-carrier1-x-corpus",
    "source_count": 19,
    "source_class": "operator_provided_x_urls",
    "operator_intent": "Use the supplied external intelligence corpus to seed portable source-intelligence owner routing without claiming live API or cloud execution.",
    "source_surface": "BMA run root and GitHub child #899/#900"
  },
  "source_access_policy": {
    "public_no_auth_first": true,
    "authenticated_exact_url_scope": "only exact approved URLs when public capture is insufficient",
    "allowed_authenticated_observation": [
      "primary post",
      "visible author continuations",
      "embedded-link disposition",
      "media/OCR disposition",
      "top visible replies"
    ],
    "forbidden_retention": [
      "raw authenticated DOM",
      "HTML",
      "screenshots",
      "account context",
      "cookies",
      "local storage",
      "unrelated tabs",
      "DMs",
      "notifications",
      "settings",
      "browser/profile state"
    ]
  },
  "per_source_disposition_requirements": [
    "normalized source_id",
    "url_or_ref",
    "source class",
    "author/date or not-visible reason",
    "primary source disposition",
    "continuation/thread disposition",
    "top-reply/comment disposition",
    "embedded-link disposition",
    "media/OCR disposition",
    "insight/no-insight/contradiction/inaccessible disposition",
    "claim effect",
    "evidence tier",
    "owner/no-action disposition"
  ],
  "source_insight_packet_mapping": {
    "schema": "SOURCE_INSIGHT_PACKET",
    "sources": "one entry per supplied source with access_state and insight_disposition",
    "claims": "claim rows cite source_ids, evidence_tier, and effect_on_decision",
    "high_signal_findings": "owner-routable findings with disposition and owner_surface",
    "consumer_targets": [
      "repo-auditor",
      "repo-upgrade-advisor",
      "repo-optimizer"
    ],
    "bounded_non_claims": "copy the API/cloud/remote/raw-capture/control-plane non-claims into the packet"
  },
  "deep_research_sidecar": {
    "mode": "manual_sidecar_only",
    "prompt_protocol": "sidecar Prompt A/B response-shaped contract",
    "prompt_a_role": "assumption gaps, missing evidence, stale claims, contradictions, risks, and source questions",
    "prompt_b_boundary": "may claim reconciliation only after actual Prompt A response exists; otherwise mark hypothetical-draft",
    "pasteback_status": "not_supplied",
    "pasteback_admission": "route through source manifest, equal-insight, claim/effect, and owner/no-action checks before use"
  },
  "deep_research_api_disposition": "rescoped_failed_not_authorized",
  "official_docs_context": [
    {
      "name": "Deep Research",
      "url": "https://developers.openai.com/api/docs/guides/deep-research",
      "use": "capability context only"
    },
    {
      "name": "Web Search",
      "url": "https://developers.openai.com/api/docs/guides/tools-web-search",
      "use": "capability context only"
    },
    {
      "name": "Codex Cloud Environments",
      "url": "https://developers.openai.com/codex/cloud/environments.md",
      "use": "future Arc 5 placement context only"
    },
    {
      "name": "Codex Remote Connections",
      "url": "https://developers.openai.com/codex/remote-connections.md",
      "use": "future Arc 5 placement context only"
    },
    {
      "name": "Codex Worktrees",
      "url": "https://developers.openai.com/codex/app/worktrees.md",
      "use": "local/worktree context"
    }
  ],
  "raw_evidence_requirements": [
    "runtime ledger",
    "source inventory",
    "public/no-auth reachability",
    "authenticated exact-url capture ledger when used",
    "SOURCE_INSIGHT_PACKET or equivalent intake artifacts",
    "manual sidecar prompt and pasteback when supplied",
    "GitHub issue/PR/check/merge truth",
    "task/session identifiers and logs before any live API, cloud, or remote claim"
  ],
  "consumer_routes": [
    {
      "owner": "repo-agent-core",
      "route": "contract/template/schema primitive"
    },
    {
      "owner": "repo-auditor",
      "route": "detector for missing disposition, provenance, unsupported claims, or retention drift"
    },
    {
      "owner": "repo-upgrade-advisor",
      "route": "recommendation packaging after detector or owner evidence"
    },
    {
      "owner": "repo-optimizer",
      "route": "report-only/apply-check materialization only after explicit optimizer-ready row"
    }
  ],
  "validation_scope": [
    "repo-native focused contract test",
    "SOURCE_INSIGHT_PACKET schema/sample validation",
    "no raw authenticated capture retention",
    "no API/cloud/remote overclaim",
    "GitHub issue/PR/check/merge truth"
  ],
  "fallback": "If validation fails, record the exact blocker on the owner issue or PR and route the next carrier to focused repair.",
  "bounded_non_claims": [
    "does not run Deep Research",
    "does not call the Deep Research API",
    "does not prove live Codex Cloud execution",
    "does not prove live Codex remote execution",
    "does not create a crawler, source registry, watcher, scheduler, queue, daemon, controller, or hidden registry",
    "does not retain raw authenticated DOM, HTML, screenshots, or account context",
    "does not create issues or pull requests automatically",
    "does not auto-merge",
    "does not mutate downstream repos",
    "does not replace GitHub issue/PR/check/merge truth",
    "does not create a retained closeout package"
  ],
  "next_owner_action": "Arc 4 Carrier 3 repo-auditor Deep Research/source-intelligence native corpus detector propagation, or focused repo-agent-core repair if this contract is rejected or blocked"
}
```

This template is a foreground packaging aid. It is not a runtime dependency,
Deep Research API runner, browser automation runner, crawler, scheduler, queue,
daemon, controller, source registry, hidden state store, automatic GitHub issue
or PR creator, auto-merge path, retained closeout package, background sync, or
downstream mutation authority.
