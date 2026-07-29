# Owner package inventory

This is the single human-readable owner inventory. The active package is small;
retained historical families are compatibility evidence only. The inventory is
validated from cached Git index entries and blobs, never from an unstaged
working-tree view.

## Active exports

The `Callers` column is an owner declaration used for orphan checks. `owner`
means repo-native use; the other values name the three exact consumer classes.
Patterns must match at least one cached index path.

| Path | Class | Callers |
|---|---|---|
| `CONSTITUTION.md` | shared semantic floor | owner,auditor,advisor,optimizer |
| `AGENTS.md` | compact bootloader | owner |
| `README.md` | package entrypoint | owner |
| `docs/live-capability-inventory.md` | owner-manifest | owner |
| `.github/workflows/ci.yml` | native CI | owner |
| `Makefile` | native command surface | owner |
| `.agents/skills/reviewing-code-locally/**` | portable review skill | owner,auditor,advisor,optimizer |
| `schemas/*.schema.json` | exported schema bytes | owner,auditor,advisor,optimizer |
| `scripts/validate-artifacts.sh` | artifact validator | owner,optimizer |
| `scripts/compare-scorecards.sh` | scorecard comparison primitive | owner,auditor,optimizer |
| `scripts/check-compare-scorecards-conformance.sh` | copy-sync conformance gate | owner,auditor,optimizer |
| `docs/compare-scorecards-distribution.md` | distribution contract | owner,auditor,optimizer |
| `scripts/install-hooks.sh` | consumer-called installer | owner,auditor,advisor,optimizer |
| `scripts/pre-commit-hook.sh` | installer source | owner,auditor,advisor,optimizer |
| `scripts/pre-push-hook.sh` | installer source | owner,auditor,advisor,optimizer |
| `hooks/pre-commit-hook.sh` | installable hook | owner,auditor,advisor,optimizer |
| `hooks/pre-push-hook.sh` | installable hook | owner,auditor,advisor,optimizer |
| `scripts/record-closure-identity.sh` | native test helper | owner |
| `scripts/validate_owner_convergence.py` | cached-index convergence guard | owner |
| `tests/test-owner-convergence.sh` | focused convergence tests | owner |
| `tests/test-compare-scorecards.sh` | comparison behavior tests | owner |
| `tests/test-closure-identity.sh` | closure helper tests | owner |
| `tests/test-schemas.sh` | schema syntax and sample tests | owner |
| `templates/findings-table.md` | findings export | auditor |
| `templates/transfer-readiness.md` | transfer receipt export | optimizer |
| `templates/optimizer_policy.yaml` | optimizer policy export | optimizer |
| `templates/v3.1-markdown-handoff.md` | portable handoff export | auditor,advisor,optimizer |

## Compatibility-only retained paths

These existing paths remain byte-preserved unless changed by a separate owner
decision. Current exact consumers cite portions of these families, so they are
not bulk-deleted. They are not active authority and are excluded from active
prose checks.

| Pattern | Classification |
|---|---|
| `docs/*-contract.md` | compatibility/history-only contract evidence |
| `docs/repo-agent-fleet-consistency-floor-receipt.md` | compatibility/history-only receipt |
| `templates/*.md` | compatibility/history-only template unless listed active above |
| `tests/samples/*.json` | schema compatibility sample |
| `tests/fixtures/*.json` | schema compatibility fixture |
| `schemas/*.schema.json` | active byte export; historical semantics remain compatibility-bound |
| `LEARNINGS.md` | historical owner learning log |

## Removed-name successors

Every retired tracked name has one current successor. Rollback is Git history at
the exact pre-convergence base; the successor is the active owner route, not a
redirect or compatibility stack.

| Removed path | Successor |
|---|---|
| `.github/agents/speckit.analyze.agent.md` | `AGENTS.md` |
| `.github/agents/speckit.checklist.agent.md` | `AGENTS.md` |
| `.github/agents/speckit.clarify.agent.md` | `AGENTS.md` |
| `.github/agents/speckit.constitution.agent.md` | `CONSTITUTION.md` |
| `.github/agents/speckit.implement.agent.md` | `AGENTS.md` |
| `.github/agents/speckit.plan.agent.md` | `AGENTS.md` |
| `.github/agents/speckit.specify.agent.md` | `AGENTS.md` |
| `.github/agents/speckit.tasks.agent.md` | `AGENTS.md` |
| `.github/agents/speckit.taskstoissues.agent.md` | `AGENTS.md` |
| `.github/prompts/speckit.analyze.prompt.md` | `AGENTS.md` |
| `.github/prompts/speckit.checklist.prompt.md` | `AGENTS.md` |
| `.github/prompts/speckit.clarify.prompt.md` | `AGENTS.md` |
| `.github/prompts/speckit.constitution.prompt.md` | `CONSTITUTION.md` |
| `.github/prompts/speckit.implement.prompt.md` | `AGENTS.md` |
| `.github/prompts/speckit.plan.prompt.md` | `AGENTS.md` |
| `.github/prompts/speckit.specify.prompt.md` | `AGENTS.md` |
| `.github/prompts/speckit.tasks.prompt.md` | `AGENTS.md` |
| `.github/prompts/speckit.taskstoissues.prompt.md` | `AGENTS.md` |
| `.specify/memory/constitution.md` | `CONSTITUTION.md` |
| `.specify/scripts/bash/check-prerequisites.sh` | `Makefile` |
| `.specify/scripts/bash/common.sh` | `Makefile` |
| `.specify/scripts/bash/create-new-feature.sh` | `AGENTS.md` |
| `.specify/scripts/bash/setup-plan.sh` | `AGENTS.md` |
| `.specify/scripts/bash/update-agent-context.sh` | `AGENTS.md` |
| `.specify/templates/agent-file-template.md` | `AGENTS.md` |
| `.specify/templates/checklist-template.md` | `AGENTS.md` |
| `.specify/templates/constitution-template.md` | `CONSTITUTION.md` |
| `.specify/templates/plan-template.md` | `AGENTS.md` |
| `.specify/templates/spec-template.md` | `AGENTS.md` |
| `.specify/templates/tasks-template.md` | `AGENTS.md` |
| `.vscode/settings.json` | `README.md` |
| `specs/001-schema-validation-tests/spec.md` | `tests/test-schemas.sh` |
| `docs/current-program-status.md` | `docs/live-capability-inventory.md` |

## Boundaries

- Compatibility retention does not make historical material active policy.
- Schema bytes and current consumer exports remain unchanged by this owner
  convergence.
- Installed and harness discovery is count-only by category; private names and
  contents are never emitted.
- The package creates no controller, registry, dashboard, plan family,
  scheduler, queue, daemon, background sync, or sibling mutation route.
