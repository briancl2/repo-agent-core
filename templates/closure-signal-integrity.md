# Closure Signal Integrity Receipt

```json
{
  "artifact": "CLOSURE_SIGNAL_INTEGRITY_RECEIPT",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/repo-agent-core/issues/99",
  "candidate_id": "AS-54",
  "candidate_disposition": "keep_candidate",
  "companion_signal_ids": ["AS-56 when external closure coupling is present"],
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
  "closure_dependency_surface": {
    "default_closure_entrypoint": "scripts/work-close.sh",
    "required_repo_local_dependencies": ["repo-local tests or checks required by the target repo"],
    "optional_advisory_dependencies": ["repo-auditor post-audit when explicitly available"],
    "external_repo_path_references": ["$HOME/repos/repo-auditor/scripts/repo-auditor.sh"],
    "external_dependency_role": "advisory_post_audit",
    "absence_behavior": "explicit skip evidence; unknown post-audit metrics are not clean-result proof",
    "failure_behavior": "warning or blocker routed to the owner surface; closure success must not hide it"
  },
  "external_closure_coupling": {
    "status": "present_when_default_closure_reaches_sibling_repo_paths",
    "detector_id": "AS-56",
    "evidence": ["scripts/work-close.sh references $HOME/repos/repo-auditor"],
    "owner_route": "closure-script owner issue plus repo-auditor/repo-upgrade-advisor owner issue when generalized"
  },
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
  "unknown_metric_behavior": {
    "post_audit_delta": "unknown values such as PRE=? POST=? DELTA=? are unavailable/advisory, not clean proof",
    "owner_route": "make skip/failure explicit or route a GitHub-visible blocker"
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
    "does not treat AS-56 external closure coupling as AS-54 graduation evidence",
    "does not treat D3 clean evidence as a false-candidate proof",
    "does not replace GitHub issue/PR/check/merge truth",
    "does not require default closure to reach into sibling repo local paths",
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
