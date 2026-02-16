# Canonical Findings Table Format

> 7-column findings table used by all domain subagents (auditor and optimizer).
> Based on portfolio_advisor pattern, validated across 55+ production runs.

## Format

| Rank | Severity | Finding | File | Token Impact | Evidence Quote | Verification |
|---:|---|---|---|---|---|---|
| 1 | Critical | {finding description ≥10 chars} | {file path} | {estimated tokens} | {literal substring ≥20 chars, no ellipses} | {shell command to verify} |

## Rules

1. **Rank** — Integer starting at 1 (most critical first)
2. **Severity** — One of: Critical, High, Medium, Low, Info
3. **Finding** — Minimum 10 characters, descriptive
4. **File** — Exact path relative to repo root
5. **Token Impact** — Estimate: "~500 tokens", "~2K tokens", or "N/A"
6. **Evidence Quote** — ≥20 characters, literal substring from the file, NO ellipses
7. **Verification** — Shell command that proves the finding exists (e.g., `grep -c "pattern" file`)

## Example

| Rank | Severity | Finding | File | Token Impact | Evidence Quote | Verification |
|---:|---|---|---|---|---|---|
| 1 | High | AGENTS.md missing skill registry table | AGENTS.md | ~200 tokens | `## Skills` section exists but contains no table rows | `grep -c '|.*skill.*|' AGENTS.md` |
| 2 | Medium | Pre-commit hook not installed | .git/hooks/pre-commit | ~50 tokens | File does not exist at .git/hooks/pre-commit | `test -f .git/hooks/pre-commit && echo OK \|\| echo MISSING` |
