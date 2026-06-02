# Foreground Recovery Runtime Contract

> Version: 1.0
> Date: 2026-06-01
> Owner: repo-agent-core

## Purpose

This compact contract composes the Issue #164 foreground recovery surfaces that
are already defined in:

- `docs/hermes-foreground-launcher-contract.md`
- `docs/interruption-recovery-and-batch-reconstitution-contract.md`
- `docs/foreground-learning-and-recovery-contract.md`

It exists so core-five propagation can describe one failed foreground Hermes
launcher path, the recovery route, and any decision-changing learning without
creating a new control plane. Consumers may use this contract by copy-sync or citation
only.

## Runtime Composition

A foreground recovery runtime episode is still operator-visible foreground work:

1. A bounded `hermes chat -q -Q` attempt records a
   `HERMES_FOREGROUND_RUN_RECEIPT` under the launcher contract.
2. If the attempt fails or times out, the failure path may emit
   `HERMES_FOREGROUND_FAILURE_GUIDANCE` so an operator can explicitly convert
   the blocker into owner-surface issue truth.
3. If the blocker changes the authorized route, the interruption recovery
   contract names the original objective, blocker class, replacement objective,
   first owner PR or issue shape, fallback, and validation plan.
4. If the failure or recovery changes a reusable decision, the foreground
   learning contract records the decision change, evidence, owner action, and
   bounded non-claims.

This composition is a documentation and artifact boundary. It is not a runtime
dependency, daemon, scheduler, queue, retry loop, controller, MCP server,
background sync, watcher, cron job, service, autopilot, hidden registry,
mandatory package, or automatic GitHub issue creation mechanism. It does not
authorize downstream mutation or Hermes internals mutation.

## Guidance Artifact

The BMA Hermes launcher failure path may produce a compact guidance JSON artifact
named `HERMES_FOREGROUND_FAILURE_GUIDANCE`. The canonical schema is
`schemas/HERMES_FOREGROUND_FAILURE_GUIDANCE.schema.json`, and the compact example
block is `templates/hermes-foreground-failure-guidance.md`.

Required fields use the BMA helper field names:

| Field | Required meaning |
|---|---|
| artifact | Literal `HERMES_FOREGROUND_FAILURE_GUIDANCE`. |
| schema_version | Guidance schema version; currently `1`. |
| campaign_issue_url | Parent campaign GitHub issue URL that owns the propagation context. |
| repo | Owner repository in `owner/name` form for the issue conversion command. |
| command_family | Literal `hermes-foreground`; cross-family guidance must fail closed. |
| failure_code | Normalized short code for the launcher failure. |
| primary_object | Primary object that failed, such as a repo, branch, prompt, or receipt path. |
| status | Failure status normalized for issue conversion, such as `exit 124`, `exit 1`, or a short failure string. |
| attempted_command | Command text attempted by the launcher, or `(no command was launched)`. |
| evidence_file | Path to the retained failure receipt; must match `source_receipt_path`. |
| recommended_owner | Suggested human/agent owner for an explicit follow-up issue or repair. |
| impact | Compact impact statement for the failed foreground attempt. |
| source_receipt_path | Path to the source `HERMES_FOREGROUND_RUN_RECEIPT`. |
| suggested_failure_to_issue_argv | Fully expanded suggested argv beginning with `python3`, `scripts/github-failure-to-issue.py`, intended to run from the BMA repository that ships the helper. |
| suggested_failure_to_issue_command | Shell-rendered command equivalent for operator copy/paste. |
| bounded_non_claims | No-regrowth claims that keep guidance advisory. |

## Guidance Validation Rules

A valid `HERMES_FOREGROUND_FAILURE_GUIDANCE` artifact:

1. Names `command_family` as `hermes-foreground`.
2. Points `evidence_file` and `source_receipt_path` at the same retained
   `HERMES_FOREGROUND_RUN_RECEIPT`.
3. Uses `suggested_failure_to_issue_argv` with one value for each injected BMA
   helper flag: `--campaign-issue-url`, `--repo`, `--command-family`,
   `--failure-code`, `--primary-object`, `--command`, `--status`,
   `--evidence-file`, `--recommended-owner`, and `--impact`.
4. Includes either `--dry-run` or `--live` as the suggested explicit operator
   action; the guidance artifact itself does not invoke the command.
5. Includes no-regrowth `bounded_non_claims` containing the clauses `does not
   invoke gh`, `does not retry`, `does not authorize a daemon`, `does not mutate
   target repos`, and `operator must explicitly run`.

## No-Regrowth Boundary

This contract and its guidance artifact are advisory. They may preserve a
suggested command for the BMA helper, but guidance does not invoke gh. It does
not retry. It does not authorize a daemon. It does not mutate target repos. An
operator must explicitly run any suggested conversion command from the BMA repo
or an equivalent checkout that contains `scripts/github-failure-to-issue.py`.

Do not implement this composition through a runtime dependency, daemon,
scheduler, queue, retry loop, controller, MCP server, background sync, watcher,
cron job, service, autopilot, hidden registry, mandatory package, automatic
GitHub issue creation, or downstream mutation path.

## Copy-Sync Boundary

Consumers may copy this contract, copy the schema/template/sample, or cite them
from repository docs. Copy drift is a repo-quality issue. Keep alignment by
normal review, copy-sync, or citation only; do not introduce any always-on or
hidden synchronization mechanism to keep copies aligned.
