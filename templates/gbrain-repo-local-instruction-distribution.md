# GBrain Repo-Local Instruction Distribution Receipt

```json
{
  "artifact": "GBRAIN_REPO_LOCAL_INSTRUCTION_DISTRIBUTION",
  "schema_version": 1,
  "generated_at": "<UTC timestamp>",
  "source_issue_or_contract": "<issue, PR, or contract URL>",
  "contract_url": "docs/gbrain-repo-local-instruction-distribution-contract.md",
  "repos_updated": [
    "build-meta-analysis",
    "repo-agent-core"
  ],
  "instruction_surfaces_updated": [
    {
      "repo": "build-meta-analysis",
      "paths": [
        "AGENTS.md",
        ".github/copilot-instructions.md"
      ]
    },
    {
      "repo": "repo-agent-core",
      "paths": [
        "AGENTS.md",
        "docs/gbrain-repo-local-instruction-distribution-contract.md",
        "templates/gbrain-repo-local-instruction-distribution.md"
      ]
    }
  ],
  "gbrain_records_referenced": [
    "bma/issue164/distribution/example"
  ],
  "citation_expectation": "Decision-changing GBrain retrieval cites the slug and source refs, or records an explicit no-hit/no-capture reason on the GitHub issue or PR surface.",
  "advisory_status": "GBrain remains advisory",
  "canonical_records_written": 0,
  "background_behavior_used": false,
  "validation": [
    {
      "repo": "build-meta-analysis",
      "command": "make check",
      "status": "pass"
    }
  ],
  "owner_routing": [
    {
      "blocker_family": "shared distribution contract",
      "owner_surface": "repo-agent-core",
      "next_owner_action": "update this contract or template"
    },
    {
      "blocker_family": "instruction overclaim detection",
      "owner_surface": "repo-auditor",
      "next_owner_action": "add or repair a GBrain instruction-surface overclaim detector"
    },
    {
      "blocker_family": "adoption recommendation packaging",
      "owner_surface": "repo-upgrade-advisor",
      "next_owner_action": "add or repair GBrain distribution recommendation packaging"
    }
  ],
  "bounded_non_claims": [
    "does not make GBrain canonical",
    "does not write canonical records",
    "does not prove long-term retention, human acceptance, or distribution completeness beyond the measured repo set",
    "does not bulk-import a corpus",
    "does not run sync --watch, cron, autopilot, dream, jobs worker, MCP serving, minions, daemons, schedulers, queues, hidden registries, or background memory behavior",
    "does not mutate downstream target repos"
  ]
}
```
