# AGENTS.md — repo-agent-core

> Shared primitives for the repo-agent fleet.
> This repo provides schemas, templates, hooks, and scoring infrastructure
> used by repo-auditor, repo-upgrade-advisor, and repo-optimizer.

## Purpose

`repo-agent-core` is the foundation layer. It contains:
- **Schemas** — Machine-readable formats (SCORECARD, OPPORTUNITIES, OPTIMIZATION_SCORECARD)
- **Templates** — Handoff templates, policy YAML, findings table format
- **Hooks** — Pre-commit and pre-push review enforcement scripts
- **Skills** — Shared skills (reviewing-code-locally)
- **Detection signatures** — DS-1 through DS-21

## Key Conventions

- Every change goes through `make review` before committing
- `--no-verify` is NEVER permitted (L102)
- Pre-commit hook blocks by default — SKIP_REVIEW=1 only for emergency (L105)
- Schemas are the inter-agent contract. Changing a schema is a breaking change.

## Skills

| # | Skill | Purpose |
|---|---|---|
| 1 | reviewing-code-locally | Pre-commit code review via Copilot CLI |

## How to Use

Other fleet repos copy primitives from this repo (not symlinked — each agent is independent per P1/P9).

```bash
make review      # Run code review on staged changes
make test        # Validate schemas
```
