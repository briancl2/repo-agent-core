# Repo-Star Downstream Genericity Proof Receipt

```json
{
  "artifact": "REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT",
  "schema_version": 1,
  "generated_at": "<UTC timestamp>",
  "source_issue_or_pr": "https://github.com/briancl2/build-meta-analysis/issues/<issue>",
  "proof_root": "/tmp/issue164-repo-star-downstream-genericity-<timestamp>",
  "target_identities": [
    {
      "target_key": "portfolio_advisor",
      "target_repo_identity": "briancl2/portfolio_advisor",
      "target_path_or_name": "/Users/briancl/Desktop/Projects/portfolio_advisor",
      "target_remote_url": "https://github.com/briancl2/portfolio_advisor.git",
      "target_is_non_bma": true,
      "privacy_redaction_note": "Use target-relative paths, hashes, and short summaries only; do not copy portfolio values or account-level details."
    },
    {
      "target_key": "customer-newsletter",
      "target_repo_identity": "briancl2/CustomerNewsletter",
      "target_path_or_name": "/Users/briancl/repos/CustomerNewsletter",
      "target_remote_url": "https://github.com/briancl2/CustomerNewsletter.git",
      "target_is_non_bma": true,
      "privacy_redaction_note": "Use target-relative paths, hashes, and short summaries only; do not copy proprietary newsletter content."
    }
  ],
  "target_git_state_matrix": [
    {
      "target_key": "portfolio_advisor",
      "git_head_before": "<sha>",
      "git_head_after": "<same sha for read-only success>",
      "git_status_before": "",
      "git_status_after": "",
      "read_only_state_preserved": true
    },
    {
      "target_key": "customer-newsletter",
      "git_head_before": "<sha>",
      "git_head_after": "<same sha for read-only success>",
      "git_status_before": "",
      "git_status_after": "",
      "read_only_state_preserved": true
    }
  ],
  "target_native_gate_matrix": [
    {
      "target_key": "portfolio_advisor",
      "target_gate_state": "parseable_pass",
      "gate_receipt_path": "<proof-root>/replay/portfolio-advisor/repo-auditor/TARGET_NATIVE_QUALITY_GATES.json",
      "evidence_summary": "target-native gate parsed without BMA ceremony leakage"
    },
    {
      "target_key": "customer-newsletter",
      "target_gate_state": "amendment_required_unknown",
      "gate_receipt_path": "<proof-root>/replay/customer-newsletter/repo-auditor/TARGET_NATIVE_QUALITY_GATES.json",
      "evidence_summary": "gate ambiguity routed to repo-auditor owner repair"
    }
  ],
  "repo_star_command_list": [
    {
      "tool": "repo-auditor",
      "target_key": "portfolio_advisor",
      "command": "make -C /Users/briancl/repos/repo-auditor audit TARGET=/Users/briancl/Desktop/Projects/portfolio_advisor OUTPUT_DIR=<proof-root>/replay/portfolio-advisor/repo-auditor",
      "status": "pass",
      "receipt_path": "<proof-root>/replay/portfolio-advisor/repo-auditor/SCORECARD.json"
    },
    {
      "tool": "repo-upgrade-advisor",
      "target_key": "customer-newsletter",
      "command": "make -C /Users/briancl/repos/repo-upgrade-advisor advise-run TARGET=/Users/briancl/repos/CustomerNewsletter SCORECARD=<auditor-output>/SCORECARD.json OUTPUT_DIR=<proof-root>/replay/customer-newsletter/repo-upgrade-advisor TIMEOUT=900",
      "status": "skipped",
      "skip_reason": "auditor evidence did not warrant advisor packaging"
    }
  ],
  "output_roots": {
    "repo_auditor": "<proof-root>/replay",
    "repo_upgrade_advisor": "<proof-root>/replay",
    "repo_optimizer": null,
    "generated_patch_pack": null,
    "apply_check_result": null,
    "blocker_evidence": "<proof-root>/blockers"
  },
  "privacy_redaction_note": "Worker and GitHub summaries use target-relative paths, hashes, command status, and short summaries only; portfolio values, account-level details, secrets, and proprietary newsletter content are not copied.",
  "bma_ceremony_leakage_checklist": [
    "no BMA labels added to targets",
    "no Issue #164 closure semantics added to targets",
    "no retained report packages added to targets",
    "no completion manifests added to targets",
    "no local closeout receipts added to targets",
    "no campaign-sync machinery added to targets",
    "no BMA-only receipt paths added to targets"
  ],
  "github_summary_surface": "https://github.com/briancl2/build-meta-analysis/issues/<issue>",
  "owner_routing": [
    {
      "blocker_family": "shared receipt contract",
      "owner_surface": "repo-agent-core",
      "next_owner_action": "update the shared schema, template, or contract"
    },
    {
      "blocker_family": "target-native gate classification",
      "owner_surface": "repo-auditor",
      "next_owner_action": "repair the target-native gate adapter or detector precision"
    },
    {
      "blocker_family": "recommendation packaging",
      "owner_surface": "repo-upgrade-advisor",
      "next_owner_action": "repair downstream genericity recommendation fields"
    },
    {
      "blocker_family": "patch-pack materialization",
      "owner_surface": "repo-optimizer",
      "next_owner_action": "repair patch-pack or apply-check receipt generation"
    }
  ],
  "genericity_verdict": "partial",
  "bounded_non_claims": [
    "does not mutate downstream targets",
    "does not apply patches",
    "does not open downstream PRs or issues",
    "does not add BMA labels, Issue #164 closure semantics, retained report packages, completion manifests, local closeout receipts, campaign-sync machinery, or BMA-only receipt paths to target repositories",
    "does not make GBrain canonical or start background GBrain behavior",
    "does not adopt hermes -z or make Hermes the campaign owner",
    "does not start a daemon, scheduler, queue, controller, retry loop, hidden registry, background sync, MCP server, watcher, cron job, service, autopilot, or automatic GitHub issue creation",
    "does not claim broad downstream adoption beyond the named targets and recorded owner-surface evidence"
  ]
}
```
