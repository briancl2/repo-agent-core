# GBrain Retrieval/Citation Lifecycle Receipt

```json
{
  "artifact": "GBRAIN_RETRIEVAL_CITATION_LIFECYCLE",
  "schema_version": 1,
  "generated_at": "<UTC timestamp>",
  "proof_root": "/tmp/gbrain-retrieval-citation-lifecycle-<timestamp>",
  "source_issue_or_contract": "<issue, PR, or contract URL>",
  "gbrain_version": "<gbrain version or stats receipt>",
  "advisory_status": "GBrain remains advisory",
  "allowed_record_states": ["draft", "shadow_canonical"],
  "canonical_records_written": 0,
  "records_written": [
    "bma/issue164/spine/r01-example"
  ],
  "typed_links_written": [
    {
      "from": "bma/issue164/spine/r02-example",
      "to": "bma/issue164/spine/r01-example",
      "link_type": "supports",
      "context": "Why this edge improves provenance, retrieval, or decision traceability."
    }
  ],
  "timeline_entries_written": [
    {
      "slug": "bma/issue164/spine/r01-example",
      "date": "2026-06-07",
      "summary": "Short event summary",
      "source": "https://github.com/example/repo/pull/1",
      "detail": "Full timestamp and decision/proof detail."
    }
  ],
  "baseline_stats": {
    "pages": 33,
    "links": 1,
    "timeline": 1
  },
  "postwrite_stats": {
    "pages": 42,
    "links": 8,
    "timeline": 9
  },
  "seed_question_count": 30,
  "baseline_expected_record_hits": 9,
  "postwrite_expected_record_hits": 20,
  "baseline_citation_hits": 9,
  "postwrite_citation_hits": 20,
  "retrieval_pass_threshold": 20,
  "citation_pass_threshold": 15,
  "pass": true,
  "command_receipts": {
    "baseline_eval": "<proof-root>/baseline/eval-summary.json",
    "put_receipts": "<proof-root>/put-receipts/status.tsv",
    "link_receipts": "<proof-root>/link-receipts/links.tsv",
    "timeline_receipts": "<proof-root>/timeline-receipts/timeline.tsv",
    "embed_receipt": "<proof-root>/postwrite/embed.stdout",
    "postwrite_eval": "<proof-root>/postwrite/eval-summary.json"
  },
  "no_background_commands_used": true,
  "owner_routing": [
    {
      "blocker_family": "shared lifecycle contract",
      "owner_surface": "repo-agent-core",
      "next_owner_action": "update this contract or template"
    }
  ],
  "bounded_non_claims": [
    "does not make GBrain canonical",
    "does not write canonical records",
    "does not bulk-import a corpus",
    "does not run sync --watch, cron, autopilot, dream, jobs worker, MCP serving, minions, daemons, schedulers, queues, hidden registries, or background memory behavior",
    "does not mutate downstream target repos",
    "does not prove long-term retention, cross-repo distribution, or human acceptance"
  ]
}
```

