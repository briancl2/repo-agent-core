# Hermes Foreground Failure Guidance Template

The canonical portable artifact is JSON that validates against
`schemas/HERMES_FOREGROUND_FAILURE_GUIDANCE.schema.json`. It is advisory
copy-sync or citation guidance for a failed `HERMES_FOREGROUND_RUN_RECEIPT` from
the `hermes-foreground` command family. The suggested command is for the BMA
repository context that ships `scripts/github-failure-to-issue.py`; this
template does not make repo-agent-core a runtime wrapper for that helper.

```json
{
  "artifact": "HERMES_FOREGROUND_FAILURE_GUIDANCE",
  "schema_version": 1,
  "campaign_issue_url": "https://github.com/briancl2/build-meta-analysis/issues/164",
  "repo": "briancl2/build-meta-analysis",
  "command_family": "hermes-foreground",
  "failure_code": "timeout",
  "primary_object": "repo-agent-core foreground propagation prompt",
  "status": "exit 124",
  "attempted_command": "timeout 900 hermes chat --provider copilot -m gpt-5.5 -q <prompt> --max-turns 40 -Q",
  "evidence_file": "artifacts/hermes-foreground-run-receipt-timeout.json",
  "recommended_owner": "build-meta-analysis campaign operator",
  "impact": "One bounded foreground Hermes attempt did not produce usable retained output for Issue #164 propagation.",
  "source_receipt_path": "artifacts/hermes-foreground-run-receipt-timeout.json",
  "suggested_failure_to_issue_argv": [
    "python3",
    "scripts/github-failure-to-issue.py",
    "--dry-run",
    "--campaign-issue-url",
    "https://github.com/briancl2/build-meta-analysis/issues/164",
    "--repo",
    "briancl2/build-meta-analysis",
    "--command-family",
    "hermes-foreground",
    "--failure-code",
    "timeout",
    "--primary-object",
    "repo-agent-core foreground propagation prompt",
    "--command",
    "timeout 900 hermes chat --provider copilot -m gpt-5.5 -q <prompt> --max-turns 40 -Q",
    "--status",
    "exit 124",
    "--evidence-file",
    "artifacts/hermes-foreground-run-receipt-timeout.json",
    "--recommended-owner",
    "build-meta-analysis campaign operator",
    "--impact",
    "One bounded foreground Hermes attempt did not produce usable retained output for Issue #164 propagation."
  ],
  "suggested_failure_to_issue_command": "python3 scripts/github-failure-to-issue.py --dry-run --campaign-issue-url https://github.com/briancl2/build-meta-analysis/issues/164 --repo briancl2/build-meta-analysis --command-family hermes-foreground --failure-code timeout --primary-object 'repo-agent-core foreground propagation prompt' --command 'timeout 900 hermes chat --provider copilot -m gpt-5.5 -q <prompt> --max-turns 40 -Q' --status 'exit 124' --evidence-file artifacts/hermes-foreground-run-receipt-timeout.json --recommended-owner 'build-meta-analysis campaign operator' --impact 'One bounded foreground Hermes attempt did not produce usable retained output for Issue #164 propagation.'",
  "bounded_non_claims": [
    "does not invoke gh",
    "does not retry",
    "does not authorize a daemon",
    "does not mutate target repos",
    "operator must explicitly run the suggested command"
  ]
}
```

## Boundary

This guidance can preserve a suggested command, but it does not invoke gh, does
not retry, does not authorize a daemon, does not mutate target repos, and the
operator must explicitly run any conversion command. It is not a runtime
dependency, daemon, scheduler, queue, retry loop, controller, MCP server,
background sync, automatic GitHub issue creation path, or owner-truth mutation.
Run the suggested command from the BMA repository, or from an equivalent checkout
that contains `scripts/github-failure-to-issue.py`.
