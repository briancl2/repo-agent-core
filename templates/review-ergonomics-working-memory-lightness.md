# Review Ergonomics Working-Memory Lightness Receipt

```json
{
  "artifact": "REVIEW_ERGONOMICS_WORKING_MEMORY_LIGHTNESS_RECEIPT",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/repo-agent-core/issues/99",
  "candidate_id": "AS-55",
  "candidate_disposition": "keep_candidate",
  "evidence_runs": [
    {
      "run_id": "transcript_processor-D1",
      "repo": "transcript_processor",
      "review_timeout_override": true,
      "working_memory_surface": "CURRENT_STATE.md",
      "surface_status": "oversized"
    },
    {
      "run_id": "transcript_processor-D2",
      "repo": "transcript_processor",
      "review_timeout_override": true,
      "working_memory_surface": "CURRENT_STATE.md",
      "surface_status": "oversized"
    },
    {
      "run_id": "transcript_processor-D3",
      "repo": "transcript_processor",
      "review_timeout_override": true,
      "working_memory_surface": "CURRENT_STATE.md",
      "surface_status": "oversized"
    }
  ],
  "review_timeout_override_evidence": {
    "status": "present_in_all_runs",
    "required_readback": "command, env, log, or run receipt proving review timeout override"
  },
  "working_memory_surface": {
    "path": "CURRENT_STATE.md",
    "status": "oversized_review_state",
    "risk": "reviewer and agent working-memory load exceeds useful review scope"
  },
  "lightness_remedy": {
    "preferred_actions": [
      "delete stale state",
      "compact active state",
      "split by owner surface",
      "demote historical detail to linked evidence",
      "reduce review prompt scope"
    ],
    "forbidden_remedy": "do not add controller, scheduler, queue, daemon, registry, review bot, or canonical memory behavior to manage bloated state"
  },
  "distinct_repo_count": 1,
  "graduation_disposition": "not_graduated_transcript_processor_only_evidence",
  "validation_scope": [
    "before/after size or scope evidence for the review surface",
    "owner-context preservation check",
    "negative compact-review fixture if detector work is approved"
  ],
  "owner_routing": {
    "owner_surface": "repo-agent-core shared contract plus future repo-auditor/repo-upgrade-advisor owner issue if detector/advisor work is approved",
    "first_deliverable": "copy-sync contract/template receipt for candidate evidence",
    "fallback": "record a GitHub-visible blocker if the review surface cannot be safely compacted"
  },
  "bounded_non_claims": [
    "does not graduate AS-55 from one-repo transcript_processor evidence",
    "does not prescribe a global size cap without repo-local review evidence",
    "does not make CURRENT_STATE.md or any review state file canonical memory",
    "does not create issues, pull requests, comments, merges, or closures",
    "does not mutate downstream repositories",
    "does not create a review bot, controller, scheduler, queue, daemon, registry, retry loop, watcher, hidden control plane, automatic updater, background sync, auto-merge path, or retained state package",
    "does not replace GitHub issue/PR/check/merge truth"
  ]
}
```

This template is for copy-sync or citation only. It is not a schema mandate,
runtime dependency, controller, scheduler, queue, daemon, registry, review bot,
automatic issue/PR creator, auto-merge path, downstream mutation path, or
canonical memory surface.
