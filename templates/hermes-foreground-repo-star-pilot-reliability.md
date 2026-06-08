# Hermes Foreground Repo-Star Pilot Reliability Receipt

```json
{
  "artifact": "HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT",
  "schema_version": 1,
  "generated_at": "<UTC timestamp>",
  "source_issue_or_pr": "https://github.com/briancl2/build-meta-analysis/issues/<issue>",
  "measurement_root": "/tmp/issue164-hermes-repo-star-reliability-<timestamp>",
  "hermes_launcher": {
    "launcher_path": "scripts/run-hermes-foreground.py",
    "provider": "copilot",
    "model": "gpt-5.5",
    "max_turns": 40,
    "timeout_seconds": 900,
    "hermes_z_used": false,
    "output_root": "<measurement-root>/hermes"
  },
  "target_identities": [
    {
      "target_key": "portfolio_advisor",
      "target_repo_identity": "briancl2/portfolio_advisor",
      "target_path_or_name": "/Users/briancl/Desktop/Projects/portfolio_advisor",
      "target_remote_url": "https://github.com/briancl2/portfolio_advisor.git",
      "target_is_non_bma": true,
      "privacy_redaction_note": "Use target-relative paths, hashes, command status, and short summaries only; do not copy portfolio values or account-level details."
    },
    {
      "target_key": "customer-newsletter",
      "target_repo_identity": "briancl2/CustomerNewsletter",
      "target_path_or_name": "/Users/briancl/repos/CustomerNewsletter",
      "target_remote_url": "https://github.com/briancl2/CustomerNewsletter.git",
      "target_is_non_bma": true,
      "privacy_redaction_note": "Use target-relative paths, hashes, command status, and short summaries only; do not copy proprietary newsletter content."
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
  "reliability_trial_matrix": [
    {
      "trial_id": "portfolio-advisor-readonly-audit-summary",
      "target_key": "portfolio_advisor",
      "prompt_path": "<measurement-root>/prompts/portfolio-advisor-readonly-audit-summary.md",
      "command": "timeout 900 python3 scripts/run-hermes-foreground.py --provider copilot --model gpt-5.5 --prompt-file <prompt> --output-dir <measurement-root>/hermes/portfolio-advisor-readonly-audit-summary --failure-guidance-out <measurement-root>/hermes/portfolio-advisor-readonly-audit-summary/failure-guidance.json --failure-primary-object https://github.com/briancl2/build-meta-analysis/issues/<issue>",
      "exit_status": 0,
      "duration_seconds": 120,
      "receipt_path": "<measurement-root>/hermes/portfolio-advisor-readonly-audit-summary/HERMES_FOREGROUND_RUN_RECEIPT.json",
      "failure_guidance_path": null,
      "outcome": "clean_receipt",
      "target_mutation_observed": false
    }
  ],
  "reliability_summary": {
    "trial_count": 1,
    "clean_receipt_count": 1,
    "failure_count": 0,
    "read_only_targets_preserved": true,
    "reliability_verdict": "partial"
  },
  "repo_star_inputs": [
    {
      "input_family": "genericity-proof",
      "source_path_or_url": "https://github.com/briancl2/build-meta-analysis/issues/<previous-issue>",
      "influence": "scoped the target set and read-only pilot boundary"
    }
  ],
  "output_roots": {
    "prompts": "<measurement-root>/prompts",
    "hermes_receipts": "<measurement-root>/hermes",
    "failure_guidance": "<measurement-root>/hermes",
    "generated_patch_pack": null,
    "apply_check_result": null,
    "blocker_evidence": "<measurement-root>/blockers"
  },
  "failure_conversion": {
    "route_changing_failure_found": false,
    "github_surface": "https://github.com/briancl2/build-meta-analysis/issues/<issue>",
    "conversion_summary": "No route-changing Hermes failure was found; failure guidance conversion was not needed."
  },
  "owner_routing": [
    {
      "blocker_family": "shared reliability receipt contract",
      "owner_surface": "repo-agent-core",
      "next_owner_action": "update the shared schema, template, or contract"
    },
    {
      "blocker_family": "Hermes launcher validation",
      "owner_surface": "build-meta-analysis",
      "next_owner_action": "repair scripts/run-hermes-foreground.py or output validation"
    },
    {
      "blocker_family": "Hermes overclaim or mutation leakage detection",
      "owner_surface": "repo-auditor",
      "next_owner_action": "repair detector precision for foreground Hermes reliability claims"
    },
    {
      "blocker_family": "recommendation packaging",
      "owner_surface": "repo-upgrade-advisor",
      "next_owner_action": "repair guidance for bounded Hermes reliability failures"
    },
    {
      "blocker_family": "patch-pack materialization",
      "owner_surface": "repo-optimizer",
      "next_owner_action": "repair materialization only when a patch-ready owner row exists"
    }
  ],
  "bounded_non_claims": [
    "does not mutate downstream targets",
    "does not apply patches",
    "does not open downstream PRs or issues",
    "does not make Hermes the campaign owner or primary autonomous operator",
    "does not adopt or validate hermes -z",
    "does not mutate Hermes internals or install Hermes-side background behavior",
    "does not make GBrain canonical or start background GBrain behavior",
    "does not start a daemon, scheduler, queue, controller, retry loop, hidden registry, background sync, MCP server, watcher, cron job, service, autopilot, or automatic GitHub issue creation",
    "does not claim broad downstream adoption beyond the named targets and recorded reliability evidence"
  ]
}
```
