# repo-agent-core Constitution

## Purpose

repo-agent-core provides shared schemas, templates, hooks, and scripts that the
other 3 fleet repos (repo-auditor, repo-optimizer, repo-upgrade-advisor) consume.
It is the **contract layer** — it defines the shapes of SCORECARD.json,
AUDIT_REPORT.md, OPTIMIZATION_PLAN.md, and pipeline handoff formats.

## Non-Goals

- No LLM invocations (pure deterministic tooling).
- No direct target repo analysis (that's the auditor's job).
- No runtime dependencies beyond bash 3.2+ and python3.

## Core Principles

### 1. Schema-First Contracts
Every shared data format has a JSON Schema in `schemas/`. Downstream repos
validate against these schemas, not narrative descriptions. If the schema and
the docs disagree, the schema wins.

### 2. Backward Compatibility
Schema changes must be additive (new optional fields). Removing or renaming
a required field is a breaking change that requires a migration plan and
version bump. No silent contract breakage.

### 3. Version Discipline
Templates and schemas carry version metadata. Consumers declare which version
they target. Breaking changes increment MAJOR version.

### 4. Shared-Nothing Architecture
Each fleet repo runs standalone. Core provides contracts and templates but
never assumes it will be imported as a library. Duplication is preferred
over coupling.

### 5. Test with Real Data
Schema tests must validate against real artifacts from actual fleet runs,
not synthetic fixtures. If a schema test passes on a fixture but fails on
a real SCORECARD.json, the test is wrong.

### 6. Deterministic Contracts Over Vibes
All outputs conform to strict schemas. Stop rules and budgets make runs
bounded and reproducible.

## Spec-Kit Operating Rules

### Required Workflow (features >160 lines)
1. /speckit.specify → /speckit.plan → /speckit.tasks → implement
2. Every spec includes acceptance scenarios (Given/When/Then)
3. Schema changes require migration plan

### Definition of Done
- All schema tests pass (`make test`)
- No duplicate or obsolete schemas
- Templates updated to match new behavior
- CHANGELOG.md updated

## Governance

This constitution supersedes informal practices. Amendments require
documented rationale and review.

**Version**: 1.0 | **Ratified**: 2026-02-16
