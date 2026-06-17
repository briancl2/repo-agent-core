# Route-Changing Learning Failure Receipt

```json
{
  "artifact": "ROUTE_CHANGING_LEARNING_FAILURE_RECEIPT",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/build-meta-analysis/issues/821",
  "parent_campaign_url": "https://github.com/briancl2/build-meta-analysis/issues/164",
  "route_changed": true,
  "route_change_reason": "corrected GitHub readback replaced a shell-interpolated status comment and preserved literal evidence before final admission",
  "github_surface": "https://github.com/briancl2/build-meta-analysis/issues/811#issuecomment-4713816039",
  "raw_evidence": [
    "/tmp/issue164-hermes-github-reliability-20260615T231816Z/repo-auditor-readonly-bma/as40-bma-final-main-after-all-repairs.json",
    "https://github.com/briancl2/repo-auditor/pull/132",
    "https://github.com/briancl2/build-meta-analysis/pull/817"
  ],
  "hermes_failure_routing": {
    "status": "not_applicable",
    "foreground_receipt": null,
    "failure_guidance": null,
    "github_failure_surface": null,
    "disposition": "route change came from GitHub literal readback and owner detector repair"
  },
  "gbrain_search_disposition": {
    "command": "timeout 10 gbrain search \"Issue 164 route-changing learning failure propagation\" --limit 5",
    "status": "completed",
    "found_route_changing_record": false,
    "note": "Broad search miss is advisory only and does not prove exact handles are absent."
  },
  "gbrain_exact_handle_replay": [
    {
      "slug": "bma/issue164/learning/hermes-failure-visible-fallback-2026-06-14",
      "command": "timeout 10 gbrain get bma/issue164/learning/hermes-failure-visible-fallback-2026-06-14",
      "status": "passed",
      "advisory_status": "advisory",
      "decision_impact": "confirmed that failed foreground Hermes attempts need GitHub-visible receipt or failure guidance before Codex fallback"
    }
  ],
  "gbrain_slug_or_no_capture_reason": "bma/issue164/learning/hermes-failure-visible-fallback-2026-06-14",
  "gbrain_capture_posture": "natural-only foreground capture; exact-read any captured slug with gbrain get before relying on it; no forced launch card, canonical record, or background GBrain behavior",
  "fallback_without_memory": "Use GitHub issue/PR/check/merge truth plus detector receipts and record no_capture_reason when memory does not change the route.",
  "owner_action": "Open the owning repo PR for the route-changing detector or corrected GitHub readback before final Campaign Sync.",
  "literal_safe_github_readback": {
    "required": true,
    "posting_method": "body file or API body argument that avoids shell backtick substitution",
    "comment_url": "https://github.com/briancl2/build-meta-analysis/issues/811#issuecomment-4713816039",
    "superseded_comment_url": "https://github.com/briancl2/build-meta-analysis/issues/811#issuecomment-4713814172",
    "expected_literals": [
      "repo-auditor#132",
      "BMA: #817",
      "fired=false",
      "hermes_github_reliability_gap_count=0"
    ],
    "readback_status": "matched"
  },
  "learning_recovery_block": {
    "decision_changed": "final readback now uses the corrected literal-safe GitHub comment",
    "github_surface": "https://github.com/briancl2/build-meta-analysis/issues/811#issuecomment-4713816039",
    "raw_evidence": "/tmp/issue164-hermes-github-reliability-20260615T231816Z/repo-auditor-readonly-bma/as40-bma-final-main-after-all-repairs.json",
    "optional_gbrain_slug": "bma/issue164/learning/hermes-failure-visible-fallback-2026-06-14",
    "no_capture_reason": "",
    "fallback_without_memory": "Use GitHub issue/PR/check/merge truth plus detector receipts and record no_capture_reason when memory does not change the route.",
    "reusable_learning_text": "Literal-bearing GitHub status comments must be posted and read back through a literal-safe path before they become route-changing evidence.",
    "owner_action": "repair the producing comment or route the missing literal-readback check to the owner repo",
    "bounded_non_claims": "advisory only; no controller, scheduler, queue, daemon, retry loop, background GBrain, background Hermes, downstream mutation, or schedule-proof claim"
  },
  "admission_disposition": "admit",
  "bounded_non_claims": [
    "does not query GitHub by itself",
    "does not mutate GitHub",
    "does not create issues or pull requests",
    "does not post comments",
    "does not merge pull requests",
    "does not close issues",
    "does not repair issue state",
    "does not run Hermes",
    "does not run GBrain",
    "does not create a retained local closeout package",
    "does not start a daemon, scheduler, queue, controller, retry loop, hidden registry, watcher, background poller, or automatic updater",
    "does not mutate downstream repos",
    "does not make GBrain canonical",
    "does not make Hermes the campaign owner",
    "does not replace GitHub issue/PR/check/merge truth"
  ]
}
```

This template is for copy-sync or citation. It is not a schema mandate,
runtime dependency, GitHub client, memory daemon, controller, scheduler, queue,
daemon, registry, issue-state repair mechanism, GBrain authority, Hermes
authority, or closure surface.
