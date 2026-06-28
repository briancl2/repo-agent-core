# Repo-Star Closure Runtime Distribution Record

```json
{
  "artifact": "REPO_STAR_CLOSURE_RUNTIME_DISTRIBUTION",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/build-meta-analysis/issues/579",
  "source_contract_refs": [
    "repo-agent-core/docs/repo-star-closure-runtime-distribution-contract.md",
    "repo-agent-core/docs/native-evidence-before-verdict-contract.md",
    "build-meta-analysis/docs/issue164-ecosystem-architecture.md"
  ],
  "closure_ceremony_regrowth_classes": [
    {
      "class": "retained_report_package_truth",
      "disposition": "detect_and_recommend_owner_repair",
      "positive_surface": "Instruction or helper requires a retained report package for qualifying GitHub-native Issue #164 closure.",
      "negative_surface": "Normal non-qualifying fallback closeout remains allowed."
    },
    {
      "class": "pointer_file_compatibility_after_direct_url_validation",
      "disposition": "detect_when_default_closure_depends_on_pointer_files",
      "positive_surface": "Campaign closure still requires a local pointer file after direct URL validation owns the predicate.",
      "negative_surface": "Historical pointer files mentioned as archive-only evidence are not findings."
    }
  ],
  "runtime_drift_classes": [
    {
      "class": "missing_fresh_coordinator_runtime_context",
      "disposition": "detect_and_package_runtime_repair",
      "positive_surface": "Large Issue #164 launch omits transfer mode, live truth recheck, Goal or Goal-null fallback, run root, ledger, heartbeat, or CI polling discipline.",
      "negative_surface": "Same-thread continuation for already in-flight work is allowed when live truth remains current."
    },
    {
      "class": "category_only_next_action",
      "disposition": "route_to_exact_owner_surface_recommendation",
      "positive_surface": "Recommendation says only do delivery, adoption proof, or repo-star work.",
      "negative_surface": "Recommendation names owner surface, first deliverable, validation, and fallback."
    }
  ],
  "coordinator_autonomy_acceptance_classes": [
    {
      "class": "missing_or_invalid_acceptance_verdict",
      "disposition": "detect_and_route_to_goal_episode_evaluation_repair",
      "positive_surface": "Coordinator autonomy acceptance is claimed without one of accepted, partial, rejected, or not_applicable.",
      "negative_surface": "No acceptance claim is made, or the verdict is explicitly not_applicable."
    },
    {
      "class": "unsupported_foreground_acceptance_claim",
      "disposition": "detect_missing_runtime_and_github_truth",
      "positive_surface": "Accepted or partial verdict lacks GitHub issue/PR/check/merge truth, raw runtime evidence, Goal or Goal-null state, run root ledger, heartbeat disposition, demotion trigger, or next exact owner-surface action.",
      "negative_surface": "Foreground episode cites the raw evidence fields and downgrades the verdict when evidence is incomplete."
    },
    {
      "class": "background_or_tool_primary_autonomy_overclaim",
      "disposition": "demote_or_reject_acceptance_claim",
      "positive_surface": "Acceptance claim implies controller, scheduler, queue, daemon, registry, automatic issue/PR creation, auto-merge, downstream mutation, Hermes-primary ownership, canonical GBrain memory, or unapproved Codex Cloud/remote execution.",
      "negative_surface": "Acceptance stays foreground-only and keeps Hermes/GBrain advisory or bounded by explicit evidence."
    }
  ],
  "native_evidence_before_verdict_classes": [
    {
      "class": "docs_readback_only_verdict",
      "disposition": "detect_and_route_to_native_attempt_or_blocker",
      "positive_surface": "Adoption, readiness, fallback, production, GA, cutover, architecture, repair, downgrade, or replacement verdict is made from docs readback, local doctor output, retained reports, prompt contracts, model summaries, or validation receipts without native result evidence.",
      "negative_surface": "Docs-only orientation is allowed when no verdict is made, or the surface carries a concrete owner-surface blocker before judgment."
    },
    {
      "class": "verdict_bearing_surface_missing_native_evidence",
      "disposition": "require_real_output_or_blocker_on_issue_pr_comment_readout",
      "positive_surface": "The issue, PR, comment, or readout carrying the verdict does not include real command output, native result evidence, or concrete blocker route.",
      "negative_surface": "The verdict-bearing surface carries native output or the exact blocker with owner route."
    }
  ],
  "owner_surface_recommendations": [
    {
      "exact_owner_surface": "repo-auditor",
      "first_deliverable": "Add closure-ceremony or runtime-drift detector fixtures.",
      "validation_scope": "focused detector tests plus repo-native checks",
      "fallback": "Record a GitHub-visible blocker if fixture evidence is insufficient.",
      "github_issue_routing": "https://github.com/briancl2/build-meta-analysis/issues/579",
      "bounded_non_claims": [
        "does not create local closeout truth",
        "does not mutate downstream targets",
        "does not create controller, scheduler, queue, daemon, or registry behavior"
      ],
      "source_citation": "repo-agent-core/docs/repo-star-closure-runtime-distribution-contract.md"
    },
    {
      "exact_owner_surface": "repo-upgrade-advisor",
      "first_deliverable": "Package detector findings into exact owner-actionable recommendations.",
      "validation_scope": "focused advisor recommendation shape tests plus repo-native checks",
      "fallback": "Route unclear or speculative recommendation rows back to the owning GitHub issue.",
      "github_issue_routing": "https://github.com/briancl2/build-meta-analysis/issues/579",
      "bounded_non_claims": [
        "does not hand back a category",
        "does not require retained report-package closure",
        "does not claim GBrain canonicality"
      ],
      "source_citation": "repo-agent-core/docs/repo-star-closure-runtime-distribution-contract.md"
    },
    {
      "exact_owner_surface": "repo-optimizer",
      "first_deliverable": "Materialize only concrete patch/context-reduction changes that replace docs-readback verdicts with native attempts or blocker routing.",
      "validation_scope": "focused materialization checks or GitHub-visible skip evidence when no patchable owner surface exists",
      "fallback": "Skip optimizer materialization with evidence if the finding is not patchable.",
      "github_issue_routing": "https://github.com/briancl2/repo-agent-core/issues/94",
      "bounded_non_claims": [
        "does not apply patches to downstream targets",
        "does not create a controller, scheduler, queue, daemon, or registry",
        "does not treat GBrain as canonical"
      ],
      "source_citation": "repo-agent-core/docs/native-evidence-before-verdict-contract.md"
    }
  ],
  "validation_scope": [
    "repo-agent-core focused contract/template tests",
    "repo-auditor focused detector tests",
    "repo-upgrade-advisor focused recommendation shape tests",
    "repo-optimizer materialization or GitHub-visible skip evidence",
    "BMA final direct campaign validation"
  ],
  "fallback_routes": [
    {
      "blocker_family": "shared contract gap",
      "owner_surface": "repo-agent-core",
      "github_route": "repo-agent-core PR or issue"
    },
    {
      "blocker_family": "detector precision gap",
      "owner_surface": "repo-auditor",
      "github_route": "repo-auditor PR or issue"
    },
    {
      "blocker_family": "recommendation packaging gap",
      "owner_surface": "repo-upgrade-advisor",
      "github_route": "repo-upgrade-advisor PR or issue"
    },
    {
      "blocker_family": "materialization gap",
      "owner_surface": "repo-optimizer",
      "github_route": "repo-optimizer PR, issue, or child-issue skip note"
    }
  ],
  "gbrain_policy": {
    "mode": "foreground_advisory_only",
    "lookup_rule": "bounded sequential reads only when they can affect selection, launch, or reusable learning",
    "write_rule": "draft or shadow advisory learning only when decision-changing",
    "canonical_records_written": 0
  },
  "downstream_mutation_policy": "No downstream target mutation or downstream PR/issue creation without fresh approval.",
  "bounded_non_claims": [
    "does not make retained local reports, work packages, completion manifests, SER, handoff-sync facts, pointer files, or local receipts task-closure truth",
    "does not mutate downstream target repositories",
    "does not open downstream PRs or issues without fresh approval",
    "does not make GBrain canonical",
    "does not start persistent memory automation",
    "does not adopt hermes -z or make Hermes the campaign owner",
    "does not create a controller, scheduler, queue, registry, daemon, retry loop, auto-updater, auto-merge path, hidden control plane, MCP server, minion, cron job, service, or retained report-package closure path"
  ]
}
```
