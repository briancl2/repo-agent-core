# GBrain Repo-Local Instruction Distribution Receipt

```json
{
  "artifact": "GBRAIN_REPO_LOCAL_INSTRUCTION_DISTRIBUTION",
  "schema_version": 1,
  "generated_at": "<UTC timestamp>",
  "source_issue_or_contract": "<issue, PR, or contract URL>",
  "consuming_repo": "briancl2/example-repo",
  "instruction_surfaces": [
    {
      "path": "AGENTS.md",
      "action": "copy-sync guidance",
      "validation": "make check"
    }
  ],
  "gbrain_records_used": [
    {
      "slug": "bma/issue164/distribution/example",
      "record_state": "draft",
      "used_for": "advisory repo-local instruction guidance"
    }
  ],
  "source_refs_checked": [
    {
      "slug": "bma/issue164/distribution/example",
      "source_refs": [
        "https://github.com/briancl2/build-meta-analysis/issues/515"
      ],
      "citation_ok": true
    }
  ],
  "advisory_status": "GBrain remains advisory",
  "canonical_override_allowed": false,
  "background_gbrain_behavior_used": false,
  "repo_native_validation": [
    {
      "command": "make check",
      "status": "pass",
      "receipt": "<local or CI receipt>"
    }
  ],
  "owner_routing": [
    {
      "blocker_family": "shared distribution contract",
      "owner_surface": "repo-agent-core",
      "next_owner_action": "update this contract or template"
    }
  ],
  "bounded_non_claims": [
    "does not make GBrain canonical",
    "does not let GBrain override operator intent, GitHub truth, repo evidence, or repo-local instructions",
    "does not prove human acceptance",
    "does not bulk-import a corpus",
    "does not run sync --watch, cron, autopilot, dream, jobs worker, MCP serving, minions, daemons, schedulers, queues, hidden registries, or background memory behavior",
    "does not mutate downstream target repos",
    "does not add a runtime dependency, scheduler, controller, queue, daemon, MCP server, generated registry, or background sync mechanism"
  ]
}
```
