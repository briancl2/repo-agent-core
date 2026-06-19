# Deep Research Source-Ledger V2 Adoption

> Based on repo-agent-core `docs/deep-research-source-ledger-v2-adoption-contract.md`.
> Copy this template into the accepting repo or cite the source contract.

```json
{
  "artifact": "DEEP_RESEARCH_SOURCE_LEDGER_V2_ADOPTION",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/build-meta-analysis/pull/924",
  "parent_campaign_url": "https://github.com/briancl2/build-meta-analysis/issues/164",
  "owner_issue_url": "https://github.com/briancl2/repo-agent-core/issues/80",
  "accepted_decision_class": {
    "surface": "manual Deep Research",
    "decision_type": "architecture/source-intelligence advisory decision",
    "source_access": "public/no-auth only",
    "required_prompt_shape": "standalone prompt with all required local/private context embedded",
    "forbidden_expansion": [
      "Deep Research API execution",
      "authenticated-source capture validation",
      "private repository or local filesystem analysis",
      "sidecar closure truth",
      "automatic ingestion or source registry"
    ]
  },
  "manual_trial_evidence": [
    {
      "issue": "https://github.com/briancl2/build-meta-analysis/issues/919",
      "pr": "https://github.com/briancl2/build-meta-analysis/pull/920",
      "disposition": "accepted_for_one_bounded_manual_deep_research_trial",
      "prompt_tier": "3/4",
      "proof": "public sources only, source ledger present, no private/local/GitHub dependency, advisory boundary preserved, exactly one next owner action"
    },
    {
      "issue": "https://github.com/briancl2/build-meta-analysis/issues/921",
      "pr": "https://github.com/briancl2/build-meta-analysis/pull/922",
      "disposition": "quality_ladder_accepted",
      "trial_1": {
        "prompt_tier": "3/4",
        "research_duration": "3 minutes",
        "citations": 8,
        "searches": 87,
        "score": "3.0/3"
      },
      "trial_2": {
        "prompt_tier": "1/2",
        "research_duration": "5 minutes",
        "citations": 10,
        "searches": 108,
        "score": "3.0/3"
      },
      "critique": "no unresolved CRITICAL or HIGH findings"
    },
    {
      "issue": "https://github.com/briancl2/build-meta-analysis/issues/923",
      "pr": "https://github.com/briancl2/build-meta-analysis/pull/924",
      "merge": "41532809f055cecfa00a34ae625db8899a781d5d",
      "disposition": "adopted_for_bounded_decision_class"
    }
  ],
  "prompt_tier_disposition": {
    "default": "3/4",
    "bounded_transport_fit_fallback": "1/2",
    "not_accepted_as_default": "1/3",
    "fallback_requirements": [
      "glossary remains present",
      "source rules remain present",
      "advisory boundary remains present",
      "response contract remains present",
      "source-ledger fields remain present"
    ],
    "generation_rule": "use curated context tiers, not blind truncation"
  },
  "source_ledger_v2_fields": [
    "source_id",
    "url",
    "title_or_source_name",
    "publisher_or_author",
    "source_type",
    "access_method",
    "consulted_status",
    "consulted_on_date",
    "why_included_or_excluded",
    "exclusion_rationale",
    "claim_supported",
    "evidence_tier",
    "confidence",
    "limitations",
    "recommendation_effect"
  ],
  "source_rules": {
    "public_sources_only": true,
    "public_urls_are_optional_or_research_targets": true,
    "no_hidden_required_context": true,
    "inline_citations_or_source_metadata_required": true,
    "source_quality_preference": "official, standards, primary, and well-corroborated sources before commentary"
  },
  "advisory_boundary": "Deep Research output is advisory evidence only; it does not close GitHub issues, approve pull requests, mutate repositories, replace operator judgment, or become task closure truth.",
  "github_truth": {
    "bma_quality_ladder_pr": "https://github.com/briancl2/build-meta-analysis/pull/922",
    "bma_live_adoption_pr": "https://github.com/briancl2/build-meta-analysis/pull/924",
    "bma_live_adoption_merge": "41532809f055cecfa00a34ae625db8899a781d5d",
    "repo_agent_core_owner_issue": "https://github.com/briancl2/repo-agent-core/issues/80",
    "required_check": "repo-agent-core CI/test success before merge"
  },
  "promotion_gate": "Broaden only after a new owner issue proves the target decision class with standalone validation, manual or explicitly authorized API evidence, source-ledger scoring, advisory boundary preservation, GitHub issue/PR/check/merge truth, and explicit bounded non-claims.",
  "demotion_rejection_trigger": "Demote or reject on live Deep Research API overclaim without raw task evidence, sidecar-as-closure-truth, hidden local/private/GitHub context, missing source-ledger v2 fields, missing advisory boundary, 1/3 default claim, authenticated-source capture expansion, crawler/source-registry/control-plane drift, automatic GitHub mutation, auto-merge, or downstream mutation.",
  "kill_switch": "Stop adoption propagation and record a GitHub-visible blocker with the exact next owner action.",
  "bounded_non_claims": [
    "does not run Deep Research",
    "does not call or authorize the Deep Research API",
    "does not prove future standalone prompts are semantically sufficient",
    "does not validate authenticated-source capture",
    "does not inspect private repositories or local files",
    "does not create a source registry, crawler, watcher, scheduler, queue, daemon, controller, retry loop, sidecar runner, automatic issue/PR creator, auto-merge path, retained closeout package, or downstream mutation grant",
    "does not mutate BMA #832",
    "does not mutate BMA PR #801",
    "does not replace GitHub issue/PR/check/merge truth"
  ],
  "next_owner_action": "repo-auditor detector propagation for Deep Research source-ledger v2 adoption gaps"
}
```

## Human Readback

- Accepted decision class:
- Manual trial evidence:
- Prompt-tier disposition:
- Source-ledger v2 fields:
- Source rules:
- Advisory boundary:
- GitHub issue/PR/check/merge truth:
- Promotion gate:
- Demotion/rejection trigger:
- Kill switch:
- Bounded non-claims:
- Next exact owner-surface action:
