# Assimilation GitHub Work Management V1 Receipt

```json
{
  "artifact": "ASSIMILATION_GITHUB_WORK_MANAGEMENT_V1",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/repo-agent-core/issues/117",
  "parent_campaign_url": "https://github.com/briancl2/build-meta-analysis/issues/1318",
  "consuming_repo": "briancl2/<repo>",
  "operator_count": 1,
  "host_count": 1,
  "actual_concurrency": 1,
  "unattended_runtime_need": {
    "state": "none_observed",
    "observed_task": "none",
    "evidence": []
  },
  "smallest_native_architecture": {
    "candidate": "foreground repo-native issue -> branch -> PR -> checks -> merge on the operator laptop",
    "larger_proposed_shape": "none",
    "enterprise_components": [],
    "concrete_observed_need": [],
    "disposition": "admit_smallest_native"
  },
  "stale_native_constraint_intake": {
    "status": "clean",
    "old_constraint": "none observed",
    "current_native_activation_rule": "no native activation change is requested by this receipt",
    "proof_boundary": "current upstream instructions, owner-approved activation evidence, safe native attempt, and repo-native validation",
    "authority_boundary": "GitHub issue/PR/check/review/merge truth and repo-local owner policy remain authoritative",
    "touched_validator_or_test": [],
    "owner_surface_evidence": [],
    "disposition": "no_change"
  },
  "generated_at": "<UTC timestamp>",
  "evidence_refs": [
    {
      "kind": "github_pr_list",
      "path_or_url": "<gh pr list --state all readback or artifact>",
      "summary": "<open/closed/merged PRs, sibling overlap, superset/subset disposition>"
    },
    {
      "kind": "github_checks_and_reviews",
      "path_or_url": "<PR URL or review/check readback>",
      "summary": "<required checks, authoritative reviewer, unresolved required threads>"
    },
    {
      "kind": "repo_native_validation",
      "path_or_url": "<command output, check URL, or blocker>",
      "summary": "<repo-native gate result>"
    }
  ],
  "permission_insufficient": {
    "status": false,
    "surface": "prs | checks | reviews | branch_ruleset | parsed_closure | none",
    "blocked_fields": [],
    "evidence": [],
    "owner_action": "none"
  },
  "github_closure_reconciliation": {
    "github_pr_list_readback": {
      "state_filter": "all",
      "source_issue": "<source issue or spec id>",
      "related_prs": [
        {
          "pr_url": "<PR URL>",
          "state": "open | closed | merged",
          "relationship": "superset | subset | duplicate | sibling | unrelated"
        }
      ]
    },
    "cross_pr_consistency_checked": true,
    "superset_subset_disposition": "kept_superset_closed_subset | no_overlap | blocked_pending_owner_decision",
    "open_review_threads": [
      {
        "pr_url": "<PR URL>",
        "reviewer": "chatgpt-codex-connector | copilot | human | other",
        "severity": "P2 | medium | high | advisory",
        "status": "resolved | unresolved | permission_insufficient"
      }
    ],
    "closing_issue_references": {
      "checked": true,
      "unexpected_closing_issue_urls": [],
      "source": "github_graphql_closingIssuesReferences | gh readback | not_applicable"
    },
    "issue_state_reconciliation": {
      "owner_issue_url": "<issue URL>",
      "state_before_or_current": "OPEN",
      "state_after_when_applicable": "OPEN | CLOSED | not_applicable",
      "closure_truth": "GitHub issue/PR/check/review/merge truth remains authoritative"
    },
    "closure_disposition": "admit | blocked_open_reviews | blocked_cross_pr_inconsistency | blocked_unexpected_closure_reference | permission_insufficient"
  },
  "required_ci_and_reviewer_model": {
    "repo_native_gate": {
      "commands": ["<repo-native command, e.g. make check or pytest tests/unit>"],
      "status": "pass | fail | skipped | blocked",
      "evidence": "<output path, check URL, or blocker>"
    },
    "required_checks": [
      {
        "name": "<GitHub check name>",
        "required_by_branch_protection": true,
        "status": "success | failure | pending | skipped | permission_insufficient"
      }
    ],
    "required_reviewer_model": {
      "authoritative_pr_reviewer": "chatgpt-codex-connector[bot] | copilot-pull-request-reviewer | human | repo-policy",
      "review_surface": "GitHub PR review threads and review decision",
      "repo_discoverability_surface": "AGENTS.md | CONTRIBUTING.md | repo policy | permission_insufficient"
    },
    "local_review_role": "pre_check_only_not_cross_pr_authority",
    "required_review_threshold": "P2+ | medium_and_above | repo_policy",
    "review_truth_source": "GitHub PR review truth or permission_insufficient"
  },
  "shared_fact_control": {
    "fact_name": "<shared regime value, e.g. CLI version pin>",
    "owning_source": "<single constant, config, issue, or policy>",
    "consuming_artifacts": ["<path or artifact>"],
    "drift_check": "<test, lint, review rule, or blocker>",
    "duplicate_copy_disposition": "single_source | copy_sync_with_drift_gate | blocked_duplicate_without_gate | not_applicable"
  },
  "autonomous_merge_eligibility_candidate": {
    "candidate_state": "candidate | not_candidate | blocked | unknown",
    "repo_native_gate_green": true,
    "spec_id_or_spec_exempt_commit_discipline": {
      "available": true,
      "followed_in_candidate_prs": true,
      "evidence": "<commit trailer, policy, or blocker>"
    },
    "required_review_findings_resolved": true,
    "merge_conflicts_resolved_and_verified": true,
    "human_approval_role": "product_directional_only_when_repo_policy_allows | repo_policy_requires_human_review | unknown",
    "autonomous_merge_authority": "candidate_only"
  },
  "validation_scope": [
    {
      "command_or_check": "<focused test/check>",
      "status": "pass | fail | skipped | blocked",
      "evidence": "<output path or URL>"
    }
  ],
  "owner_routing": {
    "owner_surface": "repo-agent-core shared contract plus separate owner surfaces for detector/advisor/optimizer/adoption work",
    "permission_insufficient_route": "request/read access or record GitHub-visible blocker before scoring a gap",
    "first_deliverable": "copy-sync contract/template receipt for ASSIMILATION_GITHUB_WORK_MANAGEMENT_V1",
    "fallback": "record a GitHub-visible blocker; do not infer repo-quality gaps from unreadable GitHub evidence"
  },
  "next_owner_action": "After this contract lands, the coordinator may launch the separate repo-auditor detector arc for assimilation GitHub work-management gaps; do not start it from this receipt.",
  "bounded_non_claims": [
    "does not implement repo-auditor, repo-upgrade-advisor, repo-optimizer, or BMA acceptance arcs",
    "does not score a repo as deficient when GitHub evidence is unreadable because of permission limits",
    "does not replace GitHub issue/PR/check/review/merge truth",
    "does not make local staged-diff review authoritative for cross-PR consistency",
    "does not make local work-close output closure truth when GitHub review threads or issue state disagree",
    "does not justify enterprise coordination complexity for one operator on one laptop without concrete observed need",
    "does not treat a still-current native constraint as migration friction",
    "does not activate native features or weaken valid authority boundaries through stale-native-constraint intake",
    "does not authorize autonomous merge, auto-merge, background merge loops, or a broad waiver of human review",
    "does not create issues, pull requests, comments, merges, or closures",
    "does not mutate downstream repositories",
    "does not create a controller, scheduler, queue, daemon, registry, dashboard, watcher, retry loop, hidden control plane, background poller, automatic updater, automatic issue/PR loop, retained closeout package, or background sync"
  ]
}
```

This template is for copy-sync or citation only. It is not a schema mandate,
runtime dependency, GitHub client, review bot, controller, scheduler, queue,
daemon, registry, automatic issue/PR creator, auto-merge path, downstream
mutation path, or closure surface.
