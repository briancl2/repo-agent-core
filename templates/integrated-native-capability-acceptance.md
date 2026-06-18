# Integrated Native Capability Acceptance

> Based on repo-agent-core `docs/integrated-native-capability-acceptance-contract.md`.
> Copy this template into the accepting repo or cite the source contract.

```json
{
  "artifact": "INTEGRATED_NATIVE_CAPABILITY_ACCEPTANCE",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/build-meta-analysis/pull/911",
  "parent_campaign_url": "https://github.com/briancl2/build-meta-analysis/issues/164",
  "carrier_child_url": "https://github.com/briancl2/build-meta-analysis/issues/909",
  "owner_issue_url": "https://github.com/briancl2/repo-agent-core/issues/76",
  "capability": "Integrated Native Capability Acceptance",
  "cloud_proof": {
    "task_id": "task_e_6a34120847c4832b94a1a08423530556",
    "hosted_repo": "briancl2/build-meta-analysis",
    "commit": "5d5bc96609e8b059b327c2309da7d07171c99f0c",
    "repo_path": "/workspace/build-meta-analysis",
    "branch": "work",
    "agents_md_present": true,
    "preflight_helper_available": true,
    "preflight_helper_command": "python3 scripts/issue164-native-preflight.py --help",
    "git_status_before": "clean / no output",
    "git_status_after": "clean / no output",
    "files_changed": 0,
    "lines_added": 0,
    "lines_removed": 0,
    "task_status": "READY",
    "diff_disposition": "no diff"
  },
  "codex_cloud_proof_disposition": "accepted_ready_no_diff",
  "codex_remote_proof_disposition": "deferred_not_validated",
  "external_intelligence_sidecar_disposition": "failed_prompt_generation_deferred_outside_arc5",
  "github_truth": {
    "bma_correction_pr": "https://github.com/briancl2/build-meta-analysis/pull/911",
    "bma_correction_merge": "ae87e1fb6a646be0575a0b3330f288c9a41bf6b7",
    "bma_child_issue": "https://github.com/briancl2/build-meta-analysis/issues/909",
    "bma_campaign_issue": "https://github.com/briancl2/build-meta-analysis/issues/164",
    "required_check": "CI / check success",
    "campaign_sync_next": "Arc 5 Carrier 2 repo-agent-core Integrated Native Capability Acceptance contract propagation"
  },
  "arc_gate_matrix": [
    {
      "arc": "Arc 1 GBrain Operational Semantic Spine",
      "disposition": "advisory_only_no_canonical_memory_claim"
    },
    {
      "arc": "Arc 2 Hermes Maker/Checker Expansion",
      "disposition": "bounded_foreground_doer_checker_shadow_no_primary_ownership"
    },
    {
      "arc": "Arc 3 Codex Native Runtime / Cloud / Remote Readiness",
      "disposition": "local_worktree_plus_cloud_proof_accepted_remote_deferred"
    },
    {
      "arc": "Arc 4 Deep Research And External Intelligence Native Corpus",
      "disposition": "source_corpus_contract_accepted_sidecar_failed_outside_arc5"
    },
    {
      "arc": "Arc 5 Integrated Native Capability Acceptance",
      "disposition": "cloud_backed_propagation_allowed_with_remote_and_sidecar_non_claims"
    }
  ],
  "promotion_gate": "Repeat only with GitHub issue/PR/check/merge truth, raw task evidence for every accepted runtime surface, Cloud task no-diff proof when Cloud is accepted, remote proof only when raw remote task/session evidence exists, sidecar acceptance only after a separate replacement owner route, and bounded non-claims.",
  "demotion_rejection_trigger": "Demote or reject on docs-as-proof, missing Cloud raw evidence, false remote acceptance, sidecar-as-accepted overclaim, GBrain canonicality, Hermes primary ownership, controller/scheduler/queue/daemon/registry drift, automatic GitHub mutation, auto-merge, retained closeout truth, or downstream mutation.",
  "kill_switch": "Stop propagation and record a GitHub-visible blocker with the exact next owner action.",
  "bounded_non_claims": [
    "does not prove live Codex remote execution",
    "does not accept external-intelligence sidecar output",
    "does not run or authorize live Deep Research API execution",
    "does not use official documentation as live proof",
    "does not claim GBrain canonical memory",
    "does not grant Hermes primary ownership",
    "does not create a controller, scheduler, queue, daemon, registry, retry loop, sidecar runner, automatic issue/PR creator, auto-merge path, retained closeout package, or downstream mutation grant"
  ],
  "next_owner_action": "Arc 5 Carrier 3 repo-auditor AS-47 detector propagation"
}
```

## Human Readback

- Capability:
- Cloud proof disposition:
- Cloud task id and no-diff evidence:
- Remote disposition:
- Sidecar disposition:
- GitHub issue/PR/check/merge truth:
- Arc gate matrix:
- Promotion gate:
- Demotion/rejection trigger:
- Kill switch:
- Bounded non-claims:
- Next exact owner-surface action:
