# GitHub Parsed Closure Semantics Receipt

```json
{
  "artifact": "GITHUB_PARSED_CLOSURE_SEMANTICS_RECEIPT",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/repo-agent-core/issues/56",
  "parent_campaign_url": "https://github.com/briancl2/build-meta-analysis/issues/164",
  "pr_url": "https://github.com/briancl2/build-meta-analysis/pull/807",
  "pr_state": "MERGED",
  "pr_merged": true,
  "campaign_sync_status": "non_final",
  "target_child_issue_url": "https://github.com/briancl2/build-meta-analysis/issues/806",
  "active_child_issue_url": "https://github.com/briancl2/build-meta-analysis/issues/798",
  "pr_body_closure_keyword_scan": {
    "scan_performed": true,
    "hazards": [
      {
        "issue_url": "https://github.com/briancl2/build-meta-analysis/issues/798",
        "matched_text": "does not close #798",
        "hazard": "negated_closure_keyword_near_issue_reference"
      }
    ]
  },
  "closing_issues_references": [
    {
      "issue_url": "https://github.com/briancl2/build-meta-analysis/issues/798",
      "number": 798,
      "repository": "briancl2/build-meta-analysis",
      "state": "OPEN",
      "source": "github_graphql_closingIssuesReferences"
    }
  ],
  "campaign_sync_completed_track_readback": {
    "required_when": "campaign_sync_status == final_for_own_child",
    "status": "not_applicable_non_final",
    "pr_completed_track": null,
    "campaign_completed_latest_track": null,
    "campaign_marker": "Completed latest track:",
    "matched": null,
    "note": "Final Campaign Sync PRs must set matched true using the live marker value, not a loose body substring."
  },
  "allowed_closing_issue_urls": [],
  "unexpected_closing_issue_urls": [
    "https://github.com/briancl2/build-meta-analysis/issues/798"
  ],
  "issue_state_before": {
    "https://github.com/briancl2/build-meta-analysis/issues/798": "OPEN",
    "https://github.com/briancl2/build-meta-analysis/issues/806": "OPEN"
  },
  "issue_state_after": {
    "https://github.com/briancl2/build-meta-analysis/issues/798": "OPEN",
    "https://github.com/briancl2/build-meta-analysis/issues/806": "CLOSED"
  },
  "state_drift_detected": false,
  "repair_action": {
    "required": true,
    "owner_surface": "build-meta-analysis",
    "action": "remove the parsed-closing wording or repair affected issue state before final Campaign Sync"
  },
  "admission_disposition": "block_non_final_parsed_closure",
  "closure_truth": "This receipt is evidence only; GitHub issue/PR/check/merge truth and intended issue state remain closure truth.",
  "bounded_non_claims": [
    "does not query GitHub by itself",
    "does not mutate GitHub",
    "does not create issues or pull requests",
    "does not post comments",
    "does not merge pull requests",
    "does not close issues",
    "does not repair issue state",
    "does not install a checker",
    "does not create a retained local closeout package",
    "does not start a daemon, scheduler, queue, controller, retry loop, hidden registry, watcher, background poller, or automatic updater",
    "does not mutate downstream repos",
    "does not replace GitHub issue/PR/check/merge truth"
  ]
}
```

This template is for copy-sync or citation. It is not a schema mandate,
runtime dependency, GitHub client, controller, scheduler, queue, daemon,
registry, issue-state repair mechanism, or closure surface.
