# Hermes Foreground Launcher Contract

> Version: 1.0
> Date: 2026-06-01
> Owner: repo-agent-core

## Purpose

This contract defines the compact shared Hermes foreground launcher receipt for
Issue #164 core-five propagation. It exists so fleet repos can record bounded,
one-shot Hermes attempts in a consistent shape without inventing a new control
plane.

The launcher is a foreground, operator-visible attempt using `hermes chat -q -Q`
with explicit provider, model, timeout, and turn bounds. It may be used to test
whether a single prompt can produce useful, retained output for a core-five
propagation task. It is copy-sync or citation only.

Do not mutate downstream repos under this contract. Do not mutate Hermes internals under this contract. A receipt can justify a follow-up issue, PR, or
manual action, but the launcher itself does not authorize direct target-repo
writes or Hermes source/config changes.

## One-Shot Launcher Shape

The expected launcher is a single foreground command, for example:

```bash
timeout "$timeout_seconds" hermes chat --provider "$provider" -m "$model" \
  -q "$prompt" --max-turns "$max_turns" -Q \
  >"$stdout_path" 2>"$stderr_path"
```

Equivalent shell wrappers are acceptable only when they preserve the same
semantics: one process invocation, foreground wait, bounded timeout, retained
stdout/stderr, and no hidden continuation.

## Required Receipt Fields

The canonical machine-readable artifact is `HERMES_FOREGROUND_RUN_RECEIPT`, with
schema in `schemas/HERMES_FOREGROUND_RUN_RECEIPT.schema.json`. A Markdown or PR
body summary may cite the receipt, but the JSON receipt is the portable
detector/recommendation/patch-pack surface.

| Field | Required meaning |
|---|---|
| artifact | Literal `HERMES_FOREGROUND_RUN_RECEIPT`. |
| schema_version | Receipt schema version used by the launcher. |
| generated_at | UTC timestamp for receipt generation. |
| command.argv | Exact argv used to launch the one-shot foreground `hermes chat -q -Q` attempt. |
| command.cwd | Working directory where the command was run. |
| command.provider | Provider requested or observed for the run. |
| command.model | Model requested or observed for the run. |
| command.max_turns | Maximum turn budget requested or observed for the run. |
| command.timeout_seconds | Wall-clock timeout bound applied by the caller. |
| stdout_path | Retained path for stdout. |
| stderr_path | Retained path for stderr. |
| prompt.retained_path | Retained path containing the prompt text, when retaining the prompt is allowed. |
| prompt.sha256 | SHA-256 hash of the prompt text. |
| return_code | Process return code, including timeout wrapper code when applicable. |
| validation.passed | `true` or `false` for post-run validation of the final response/artifacts. |
| validation.error | Validation error text, or `null` when validation passed. |
| validation.final_response_lines | Count of non-metadata final response lines in stdout. |
| status | One of `success`, `failed`, `timeout`, or `not_run`. |
| reason | Short human-readable reason for the status. |
| bounded_non_claims | Explicit non-claims that prevent launcher evidence from becoming closure, controller, or downstream mutation authority. |

Receipts must include `prompt.sha256`. They should include
`prompt.retained_path` when retaining the prompt is allowed; if a repo must
redact the prompt, the retained path may point to a redaction note while the
hash preserves drift evidence.

## Validation Rules

A launcher receipt is valid only when:

1. The command is a one-shot foreground `hermes chat -q -Q` invocation or an
   equivalent wrapper around exactly that invocation.
2. `cwd`, stdout, stderr, timeout, return code, and final response location are
   retained.
3. Provider, model, and max-turn budget are recorded when known, and explicitly
   marked `unknown` only when the launcher cannot observe them.
4. Post-run validation records `validation.passed`, `validation.error`, and
   `validation.final_response_lines`.
5. The status and reason distinguish a successful useful response from partial
   output, timeout, validation failure, or launcher failure.

## Bounded non-claims

A valid receipt does not claim that the task shipped, that downstream repos were
changed, that Hermes internals are correct, that GitHub truth was updated, or
that a long-running autonomous system exists. It only claims that one bounded
foreground launcher attempt was made and retained with the listed evidence.

The receipt is not proof of issue closure, PR merge, CI health, production
behavior, downstream mutation, or Hermes runtime correctness beyond the captured
one-shot run.

## Forbidden Regrowth Boundary

This contract must not become, and must not be implemented through, a runtime dependency, daemon, scheduler, queue, retry loop, controller, MCP server,
autopilot, hidden registry, automatic GitHub issue creation, background sync,
watcher, cron job, service, or mandatory package.

If the foreground run exposes a concrete blocker, record the blocker as normal
owner-surface issue truth only through an explicit human/agent action outside
this launcher contract. Do not add automatic GitHub issue creation to the
launcher.

## Copy-Sync Boundary

Consumers may copy this contract and `templates/hermes-foreground-run-receipt.md`
or cite them from repository docs. Copy drift is a repo-quality issue. Keep
alignment by normal review, copy-sync, or citation only; do not create a runtime
registry, dependency, daemon, scheduler, queue, retry loop, controller, MCP
server, autopilot, hidden registry, or background synchronization mechanism to
keep copies aligned.
