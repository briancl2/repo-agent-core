# Repo-Star Genericity Proof Receipt

```json
{
  "artifact": "REPO_STAR_GENERICITY_PROOF_RECEIPT",
  "schema_version": 1,
  "generated_at": "<UTC timestamp>",
  "proof_root": "/tmp/repo-star-genericity-<timestamp>",
  "target_repo_identity": "<non-BMA repo identity>",
  "target_path_or_name": "<target path or repo name>",
  "target_is_non_bma": true,
  "target_git_head_before": "<sha>",
  "target_git_head_after": "<same sha for read-only success>",
  "target_dirty_count_before": 0,
  "target_dirty_count_after": 0,
  "evidence_written_outside_target": true,
  "target_mutation_performed": false,
  "auditor_artifact_path": "<proof-root>/auditor/output.json",
  "advisor_artifact_path": "<proof-root>/advisor/recommendation.json",
  "optimizer_artifact_path": "<proof-root>/optimizer/receipt.json",
  "apply_check_result_path": "<proof-root>/optimizer/apply-check.txt",
  "blocker_path": null,
  "owner_routing": [
    {
      "blocker_family": "shared receipt contract",
      "owner_surface": "repo-agent-core",
      "next_owner_action": "update the shared schema, template, or contract"
    }
  ],
  "genericity_verdict": "pass",
  "bounded_non_claims": [
    "does not mutate the target repo",
    "does not apply patches",
    "does not open downstream PRs or issues",
    "does not start a daemon, scheduler, queue, controller, retry loop, hidden registry, background sync, MCP server, watcher, cron job, service, or autopilot"
  ]
}
```

