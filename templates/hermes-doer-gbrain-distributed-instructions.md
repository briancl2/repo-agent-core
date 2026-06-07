# Hermes Doer With GBrain-Distributed Repo-Local Instructions Receipt

```json
{
  "artifact": "HERMES_DOER_WITH_GBRAIN_DISTRIBUTED_REPO_LOCAL_INSTRUCTIONS",
  "schema_version": 1,
  "generated_at": "<UTC timestamp>",
  "source_issue_or_pr": "<issue or PR URL>",
  "consuming_repo": "briancl2/example-repo",
  "instruction_surfaces": [
    {
      "path": "AGENTS.md",
      "used_for": "repo-local instruction guidance cited in the Hermes prompt"
    }
  ],
  "gbrain_distribution_contract": "docs/gbrain-repo-local-instruction-distribution-contract.md",
  "gbrain_records_or_no_capture_reason": [
    {
      "slug": "bma/issue164/distribution/example",
      "record_state": "draft",
      "source_refs_checked": [
        "https://github.com/briancl2/build-meta-analysis/issues/515"
      ],
      "used_for": "advisory repo-local instruction guidance"
    }
  ],
  "hermes_launcher_contract": "docs/hermes-foreground-launcher-contract.md",
  "hermes_receipt": "<path or URL to HERMES_FOREGROUND_RUN_RECEIPT>",
  "failure_guidance": {
    "status": "not_applicable",
    "reason": "foreground Hermes attempt produced a valid receipt"
  },
  "repo_native_validation": [
    {
      "command": "make check",
      "status": "pass",
      "receipt": "<local or CI receipt>"
    }
  ],
  "owner_routing": [
    {
      "blocker_family": "shared composition contract",
      "owner_surface": "repo-agent-core",
      "next_owner_action": "update this contract or template"
    }
  ],
  "advisory_status": "GBrain remains advisory",
  "hermes_campaign_owner": false,
  "canonical_override_allowed": false,
  "background_gbrain_behavior_used": false,
  "bounded_non_claims": [
    "does not make Hermes the campaign owner",
    "does not prove Hermes primary-doer autonomy",
    "does not make GBrain canonical",
    "does not let GBrain override operator intent, GitHub truth, repo evidence, or repo-local instructions",
    "does not bulk-import a corpus",
    "does not run gbrain sync --watch, cron, autopilot, dream, jobs worker, MCP serving, minions, daemons, schedulers, queues, hidden registries, or background memory behavior",
    "does not adopt hermes -z as production proof",
    "does not mutate downstream target repos",
    "does not add a runtime dependency, scheduler, controller, queue, daemon, retry loop, MCP server, generated registry, automatic updater, or background sync mechanism"
  ]
}
```
