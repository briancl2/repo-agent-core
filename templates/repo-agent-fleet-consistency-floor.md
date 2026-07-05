# Repo-Agent Fleet Consistency Floor Receipt

```json
{
  "artifact": "REPO_AGENT_FLEET_CONSISTENCY_FLOOR",
  "schema_version": 1,
  "generated_at": "<UTC timestamp>",
  "source_issue_or_contract": "https://github.com/briancl2/build-meta-analysis/issues/1214",
  "consuming_repo": "briancl2/<repo>",
  "evidence_refs": [
    {
      "kind": "scorecard",
      "path_or_url": "<scorecard path or run root path>",
      "summary": "<composite and relevant detector findings>"
    },
    {
      "kind": "github_pr_checks",
      "path_or_url": "<PR URL or gh readback artifact>",
      "summary": "<check names and conclusions>"
    },
    {
      "kind": "branch_protection",
      "path_or_url": "<GitHub API readback artifact>",
      "summary": "<required checks or explicit no-protection readback>"
    }
  ],
  "closure_model": {
    "model": "native_issue_pr_checks_merge | make_work_plus_work_close | mixed | none",
    "repo_local_surfaces": ["<paths>"],
    "required_for_prs": true,
    "notes": "<how this repo closes ordinary changes; issue/PR/check/merge is the minimum floor>"
  },
  "ci_check_contract": {
    "branch_protection_required_checks": ["<check names, or empty when unprotected>"],
    "observed_pr_checks": ["<check names>"],
    "workflow_jobs": ["<workflow/job names>"],
    "skipped_check_policy": "<policy or blocker>"
  },
  "gitignore_baseline": {
    "has_gitignore": true,
    "required_entries_present": {
      "work/": true,
      "__pycache__/": true,
      "*.pyc": true,
      ".DS_Store": true
    },
    "repo_local_common_noise": ["<extra repo-local ignores when applicable>"],
    "blockers": []
  },
  "learning_extraction_gate": {
    "available": true,
    "expected_at_close": true,
    "no_novel_findings_supported": true,
    "surfaces": ["LEARNINGS.md", "scripts/work-close.sh"]
  },
  "review_safety_net": {
    "automated_review_expected": true,
    "latest_representative_pr_review_seen": true,
    "review_surface": "chatgpt-codex-connector | make review | other",
    "blockers": []
  },
  "serialization_discipline": {
    "status": "candidate_advisory | candidate_keep | candidate_cut | not_applicable",
    "hot_surfaces": ["<paths>"],
    "duplicated_logic": ["<paths or description>"],
    "drift_gate": "<test/check or blocker>",
    "serial_edit_rule": "<owner path>",
    "notes": "advisory in v0.1; not required for conformance"
  },
  "domain_outcome_delta": {
    "result_class": "not-applicable",
    "reason": "fleet tool, no product-domain eval; domain-outcome gate applies to the assimilation targets it operates on",
    "notes": "declare-mandatory in v0.2; binds to the assimilation-method Domain-Outcome Eval Gate (docs/repo-assimilation-method-contract.md step 9 / Validation Rule 7 / validated_domain_outcome_delta). An assimilation target replaces this with a real result_class (confirmed | null-reported | negative-reported) carrying the gate sub-fields outcome_lever, rejected_proxy, target_variable, pre_registered_metric, target_own_eval, measured_delta, owner_contract_respected; do not restate the gate here."
  },
  "repo_native_validation": [
    {
      "command_or_check": "<command/check>",
      "status": "pass | fail | skipped | blocked",
      "receipt": "<path/url>"
    }
  ],
  "owner_routing": [
    {
      "gap": "<gap>",
      "owner_surface": "<repo/issue/PR>",
      "next_owner_action": "<exact action>"
    }
  ],
  "bounded_non_claims": [
    "ratifying or emitting this receipt does not make the repo conform and does not authorize per-repo change",
    "this contract does not require identical implementation across repos",
    "serialization discipline is advisory in v0.1 and is not required for conformance",
    "domain-outcome delta (dimension 7) is declare-mandatory in v0.2; a fleet tool's not-applicable value is by design, not a hidden gap, and ratifying it does not measure or force conformance",
    "scorecards and detector output do not replace GitHub issue/PR/check/merge truth or operator approval",
    "this receipt is not a controller, scheduler, queue, daemon, registry, dashboard, watcher, cron job, auto-merge path, or background worker",
    "this receipt does not create issues, pull requests, comments, merges, or closures, and does not mutate downstream repositories"
  ]
}
```

This template is for copy-sync or citation only. It is not a schema mandate,
runtime dependency, controller, scheduler, queue, daemon, registry, automatic
issue/PR creator, auto-merge path, downstream mutation path, or canonical
conformance surface.
