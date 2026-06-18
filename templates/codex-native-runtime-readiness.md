# Codex Native Runtime Readiness

> Based on repo-agent-core `docs/codex-native-runtime-readiness-contract.md`.
> Copy this template into the assessing repo or cite the source contract.

```json
{
  "artifact": "CODEX_NATIVE_RUNTIME_READINESS",
  "schema_version": 1,
  "source_issue_or_pr": "",
  "capability": "Codex Native Runtime / Cloud / Remote Readiness",
  "transfer_mode": "fresh_thread",
  "launch_fallback": null,
  "runtime_surfaces_checked": [
    "local_environments",
    "worktrees",
    "cloud_environments",
    "automations",
    "remote_connections",
    "subagents"
  ],
  "official_codex_context": {
    "source": "official Codex manual/docs",
    "sections": [
      "Local environments",
      "Worktrees",
      "Cloud environments",
      "Automations",
      "Remote connections",
      "Subagents"
    ],
    "used_as": "capability context only unless raw runtime evidence proves live execution"
  },
  "raw_evidence_basis": {
    "session_or_goal": "",
    "command_transcripts": [],
    "ci_or_check_runs": [],
    "issue_pr_merge_truth": []
  },
  "goal_state": {
    "state": "goal_null",
    "source": ""
  },
  "run_root": "/tmp/issue164-...",
  "progress_ledger": "/tmp/issue164-.../progress-ledger.jsonl",
  "runtime_context_payload": {
    "path": "",
    "preflight_command": "",
    "summary_result": ""
  },
  "heartbeat_lifecycle": {
    "id": "",
    "created_after_child_issue": true,
    "created_after_run_root": true,
    "prompt_authority": "inspect_only",
    "capture_or_disposition": "",
    "deleted_or_unavailable": ""
  },
  "local_worktree_dogfood": {
    "worktree_path": "",
    "branch": "",
    "head_sha": "",
    "validation": []
  },
  "cloud_remote_disposition": "not_run_context_only",
  "automation_subagent_disposition": "context_only_no_background_controller",
  "github_truth": {
    "issues": [],
    "prs": [],
    "checks": [],
    "merge_or_blocker": ""
  },
  "ci_polling_terminal_condition": "",
  "promotion_gate": "",
  "demotion_rejection_trigger": "",
  "kill_switch": "",
  "bounded_non_claims": [
    "does not prove live Codex Cloud or remote execution without raw execution evidence",
    "does not use official Codex documentation as a substitute for raw runtime evidence",
    "does not claim Goal-mode runtime improvement without raw runtime evidence",
    "does not make automations or subagents background controllers",
    "does not create a controller, scheduler, queue, daemon, registry, automatic issue/PR creator, auto-merge path, retained closeout package, or downstream mutation grant"
  ],
  "next_owner_action": ""
}
```

## Human Readback

- Capability:
- Transfer mode:
- Goal or Goal-null state:
- Run root and `progress-ledger.jsonl`:
- Runtime-context payload/preflight:
- Heartbeat lifecycle:
- Local/worktree dogfood:
- Cloud/remote disposition:
- Automation/subagent disposition:
- GitHub issue/PR/check/merge truth:
- CI polling terminal condition:
- Promotion gate:
- Demotion/rejection trigger:
- Kill switch:
- Bounded non-claims:
- Next exact owner-surface action:
