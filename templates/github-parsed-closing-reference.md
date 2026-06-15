# GitHub Parsed Closing Reference Review

```json
{
  "artifact": "GITHUB_PARSED_CLOSING_REFERENCE_REVIEW",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/build-meta-analysis/issues/811",
  "parent_campaign_url": "https://github.com/briancl2/build-meta-analysis/issues/164",
  "child_issue_url": "https://github.com/briancl2/build-meta-analysis/issues/798",
  "pr_url": "https://github.com/briancl2/build-meta-analysis/pull/807",
  "pr_intended_role": "non_final_carrier_pr",
  "github_parsed_closing_references": [],
  "raw_reference_evidence": {
    "source": "gh_pr_view_or_required_check",
    "path_or_url": "https://github.com/briancl2/build-meta-analysis/pull/807",
    "summary": "GitHub parsed no closing reference to the protected child issue."
  },
  "human_intent_summary": "Non-final carrier PR; references child issue but must leave it open.",
  "parsed_vs_intent_disposition": "match",
  "non_final_child_closure_allowed": false,
  "final_child_closure_required": false,
  "closure_keyword_hazard_classes": [
    "negated_closure_keyword",
    "quoted_or_example_closure_keyword",
    "checklist_closure_keyword",
    "historical_closure_summary",
    "cross_issue_crosstalk"
  ],
  "required_action": "Proceed only if required checks are green and no protected child issue appears in GitHub parsed closing references.",
  "owner_routing": [
    {
      "owner_surface": "build-meta-analysis",
      "condition": "non-final Issue #164 PR parses as closing the protected child",
      "next_owner_action": "repair PR body/check logic before merge or reopen the child and record the GitHub-visible hazard"
    },
    {
      "owner_surface": "repo-auditor",
      "condition": "closure keyword parse hazard repeats across campaign PRs",
      "next_owner_action": "add or update a detector row with GitHub evidence"
    },
    {
      "owner_surface": "repo-upgrade-advisor",
      "condition": "detector lands and needs propagation or replay admission guidance",
      "next_owner_action": "admit the detector row into replay/advisor coverage without treating local artifacts as closure truth"
    }
  ],
  "bounded_non_claims": [
    "does not parse GitHub without a GitHub/API/check readback",
    "does not close or reopen issues",
    "does not merge PRs",
    "does not replace GitHub issue/PR/check/merge truth",
    "does not mutate downstream repos",
    "does not mutate Hermes or GBrain internals",
    "does not make Hermes the campaign owner",
    "does not create automatic issue or PR creation behavior",
    "does not start a daemon, scheduler, queue, controller, retry loop, hidden registry, watcher, service, or background sync"
  ]
}
```

This template is for copy-sync or citation. It is not a schema mandate, runtime
dependency, parser, GitHub app, scheduler, queue, daemon, controller, registry,
retry loop, or closure surface.
