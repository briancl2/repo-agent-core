# Downstream Read-Only Recovery Runtime Pilot Receipt

```json
{
  "artifact": "DOWNSTREAM_READ_ONLY_RECOVERY_RUNTIME_PILOT_RECEIPT",
  "schema_version": 1,
  "generated_at": "<UTC timestamp>",
  "source_issue_or_pr": "https://github.com/briancl2/build-meta-analysis/issues/164",
  "target_repo_identity": "owner/example",
  "target_path_or_name": "/tmp/example-target",
  "target_repo_commit": "<exact target commit>",
  "target_git_head_before": "<sha>",
  "target_git_head_after": "<sha>",
  "target_dirty_count_before": 0,
  "target_dirty_count_after": 0,
  "pilot_purpose": "Validate a bounded read-only downstream pilot without exporting BMA ceremony.",
  "selected_repo_star_tools": [
    {
      "tool": "repo-auditor",
      "participation": "used",
      "rationale": "first pilot must check genericity, owner-surface gaps, overclaims, and BMA ceremony leakage"
    },
    {
      "tool": "repo-upgrade-advisor",
      "participation": "used_when_adoption_guidance_needed",
      "rationale": "recommendation packaging participates only when the audit finding implies adoption guidance"
    },
    {
      "tool": "repo-optimizer",
      "participation": "skipped_without_patch_ready_gap",
      "rationale": "materialization participates only when a patch-ready optimization gap is proven"
    }
  ],
  "hermes_foreground_receipt_path": "<run-root>/hermes/HERMES_FOREGROUND_RUN_RECEIPT.json",
  "gbrain_advisory_inputs": [
    {
      "slug": "bma/issue164/distribution/example",
      "advisory_status": "GBrain remains advisory",
      "source_refs_checked": [
        "https://github.com/briancl2/build-meta-analysis/issues/515"
      ],
      "used_for": "repo-local instruction guidance"
    }
  ],
  "commands_run": [
    {
      "command": "git status --short",
      "status": "pass",
      "receipt": "<run-root>/target-status-before.txt"
    }
  ],
  "auditor_as_replay_artifact_path": "<run-root>/auditor/as-replay.json",
  "advisor_artifact_path": "<run-root>/advisor/recommendation.json",
  "optimizer_replay_receipt_path": "<run-root>/optimizer/replay-receipt.json",
  "generated_patch_pack_path": "<run-root>/patches/review.patch",
  "patch_metadata_path": "<run-root>/patches/metadata.json",
  "blocker_path": null,
  "apply_check_result_path": "<run-root>/patches/apply-check.txt",
  "github_summary_surface": "https://github.com/briancl2/build-meta-analysis/issues/164#issuecomment-...",
  "local_artifact_retention_policy": "Local /tmp artifacts are execution evidence only; GitHub issue/PR/check/merge truth remains closure truth.",
  "bma_ceremony_leakage_checklist": [
    "did not copy Issue #164 labels into the target repo",
    "did not copy BMA completion manifests into the target repo",
    "did not copy BMA retained closeout/report packages into the target repo",
    "did not create local closeout receipts in the target repo",
    "did not add campaign-sync machinery to the target repo"
  ],
  "bounded_non_claims": [
    "does not mutate the target repo",
    "does not apply patches",
    "does not open downstream PRs or issues",
    "does not export BMA labels, Issue #164 task-closure semantics, completion manifests, retained closeout packages, local closeout receipts, or campaign-sync machinery into the downstream target",
    "does not make GBrain canonical",
    "does not make Hermes the campaign owner",
    "does not start a daemon, scheduler, queue, controller, retry loop, hidden registry, background sync, MCP server, watcher, cron job, service, or autopilot"
  ]
}
```
