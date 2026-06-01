# Hermes Foreground Run Receipt Template

The canonical portable artifact is JSON that validates against
`schemas/HERMES_FOREGROUND_RUN_RECEIPT.schema.json`.

```json
{
  "artifact": "HERMES_FOREGROUND_RUN_RECEIPT",
  "schema_version": 1,
  "generated_at": "",
  "status": "success",
  "reason": "ok",
  "command": {
    "argv": [
      "hermes",
      "chat",
      "--provider",
      "<provider>",
      "-m",
      "<model>",
      "-q",
      "<prompt>",
      "--max-turns",
      "40",
      "-Q"
    ],
    "cwd": "",
    "provider": "",
    "model": "",
    "max_turns": 40,
    "timeout_seconds": 900
  },
  "prompt": {
    "source": "inline",
    "sha256": "",
    "retained_path": ""
  },
  "stdout_path": "",
  "stderr_path": "",
  "return_code": 0,
  "validation": {
    "passed": true,
    "final_response_lines": 1,
    "error": null
  },
  "bounded_non_claims": [
    "does not retry or loop",
    "does not create or update GitHub issues automatically",
    "does not schedule background work",
    "does not mutate Hermes internals",
    "does not transfer campaign ownership to Hermes"
  ]
}
```

## Validation

- Validation command or check:
- Validation result:
- Final response location in `stdout_path`:

## Bounded non-claims

- This receipt records one bounded foreground `hermes chat -q -Q` launcher
  attempt only.
- It does not claim downstream repo mutation, Hermes internals mutation, issue
  closure, PR merge, CI health, production behavior, or autonomous runtime
  correctness.
- It is not a runtime dependency, daemon, scheduler, queue, retry loop,
  controller, MCP server, autopilot, hidden registry, automatic GitHub issue
  creation, background sync, watcher, cron job, service, or mandatory package.

## Notes

-
