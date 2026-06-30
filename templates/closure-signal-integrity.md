# Closure Signal Integrity Receipt

```json
{
  "artifact": "CLOSURE_SIGNAL_INTEGRITY_RECEIPT",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/repo-agent-core/issues/99",
  "candidate_id": "AS-54",
  "candidate_disposition": "keep_candidate",
  "evidence_runs": [
    {
      "run_id": "transcript_processor-D1",
      "repo": "transcript_processor",
      "work_close_exit_code": 0,
      "post_audit_signal": "degraded",
      "scorer_signal": "degraded"
    },
    {
      "run_id": "transcript_processor-D2",
      "repo": "transcript_processor",
      "work_close_exit_code": 0,
      "post_audit_signal": "degraded",
      "scorer_signal": "degraded"
    },
    {
      "run_id": "transcript_processor-D3",
      "repo": "transcript_processor",
      "work_close_exit_code": 0,
      "post_audit_signal": "clean",
      "scorer_signal": "clean"
    }
  ],
  "work_close_result": {
    "command": "work-close",
    "exit_code": 0,
    "closure_claim_surface": "foreground work-close output"
  },
  "post_audit_signal": {
    "status": "mixed",
    "degraded_runs": ["transcript_processor-D1", "transcript_processor-D2"],
    "clean_runs": ["transcript_processor-D3"],
    "required_readback": "post-audit fields that changed after work-close"
  },
  "scorer_signal": {
    "status": "mixed",
    "degraded_runs": ["transcript_processor-D1", "transcript_processor-D2"],
    "clean_runs": ["transcript_processor-D3"],
    "required_readback": "scorer fields that changed after work-close"
  },
  "divergence_summary": "D1/D2 showed closure exit 0 while post-audit and scorer signals degraded; D3 was clean, so this remains a keep-candidate rather than a graduated detector.",
  "distinct_repo_count": 1,
  "graduation_disposition": "not_graduated_transcript_processor_only_evidence",
  "validation_scope": [
    "fixture or saved-run evidence for work-close exit code",
    "fixture or saved-run evidence for post-audit signal",
    "fixture or saved-run evidence for scorer signal",
    "negative clean-run evidence"
  ],
  "owner_routing": {
    "owner_surface": "repo-agent-core shared contract plus future repo-auditor/repo-upgrade-advisor owner issue if detector/advisor work is approved",
    "first_deliverable": "copy-sync contract/template receipt for candidate evidence",
    "fallback": "keep candidate open until distinct-repo evidence or GitHub-visible blocker changes the route"
  },
  "bounded_non_claims": [
    "does not graduate AS-54 from one-repo transcript_processor evidence",
    "does not treat D3 clean evidence as a false-candidate proof",
    "does not replace GitHub issue/PR/check/merge truth",
    "does not create issues, pull requests, comments, merges, or closures",
    "does not mutate downstream repositories",
    "does not create a controller, scheduler, queue, daemon, registry, retry loop, watcher, hidden control plane, automatic updater, background sync, auto-merge path, or retained closeout package",
    "does not make local scorecards, reports, ledgers, or memory canonical closure truth"
  ]
}
```

This template is for copy-sync or citation only. It is not a schema mandate,
runtime dependency, controller, scheduler, queue, daemon, registry, automatic
issue/PR creator, auto-merge path, downstream mutation path, or canonical
closure surface.
