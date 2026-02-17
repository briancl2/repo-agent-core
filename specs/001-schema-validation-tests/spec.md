# Feature Specification: Schema Validation Tests

> **ID:** 001-schema-validation-tests
> **Date:** 2026-02-17
> **Author:** build-meta-analysis pipeline (spec 013 fleet dispatch)
> **Status:** Draft
> **Constitution check:** ✅ §1 (Schema-First Contracts — schemas are the source of truth), §2 (Backward Compatibility — tests catch breaking changes), §5 (Test with Real Data — validate against real artifacts)

## Problem Statement

repo-agent-core defines 4 JSON schemas (SCORECARD, OPPORTUNITIES, OPTIMIZATION_SCORECARD, FINDINGS) that serve as the contract layer for the entire fleet. Downstream repos (repo-auditor, repo-optimizer, repo-upgrade-advisor) consume these schemas to validate their output. However, the schemas themselves have no automated validation tests — there is no mechanism to verify that the schemas are internally consistent, that they accept known-good artifacts, or that they reject known-bad artifacts. This means a schema regression (e.g., a typo in a required field name) could silently break all downstream repos.

The constitution mandates "Schema-First Contracts" (§1) and "Test with Real Data" (§5), but without validation tests, these principles are aspirational rather than enforced.

## Goal

1. **Add automated validation tests** for all 4 JSON schemas in `schemas/` that verify each schema accepts known-good artifacts and rejects known-bad artifacts
2. **Ensure backward compatibility** by testing that real artifacts from prior fleet runs validate successfully against current schemas
3. **Establish a test harness** that runs via `make test` so schema validation is part of the standard CI workflow

## Non-Goals

- Modifying the existing schemas (this spec tests them, not changes them)
- Adding runtime schema validation to downstream repos (that's each repo's responsibility)
- Testing schemas against every possible edge case (focus on critical paths)
- Adding new schemas (only test the existing 4)

## Hypotheses

| ID | Hypothesis | Test Method | PASS Criterion |
|---|---|---|---|
| H-1 | If automated validation tests exist for each schema, then breaking changes to required fields will be caught before downstream repos are affected | Introduce a deliberate required-field rename in a test fixture and verify the test fails | Test correctly rejects the invalid fixture with a clear error message |
| H-2 | If tests validate against real artifacts from fleet runs, then schema drift between defined and actual output is detected | Run validation against 2+ real SCORECARD.json files from prior runs | All real artifacts validate successfully; any that don't reveal schema drift |

## User Stories

### User Story 1 - Schema Validation on Commit (Priority: P1)

As a fleet developer modifying a schema in repo-agent-core, I want automated tests to verify that my changes don't break the contract with downstream repos, so that I can confidently merge schema updates.

**Why this priority**: Schema breakage silently propagates to all 3 downstream repos. This is the highest-impact failure mode for repo-agent-core.

**Independent Test**: Run `make test` after adding validation tests — all 4 schemas should have at least one positive (accepts valid) and one negative (rejects invalid) test case.

**Acceptance Scenarios**:

1. **Given** the 4 JSON schemas exist in `schemas/`, **When** `make test` is run, **Then** all schema validation tests pass with 0 failures.
2. **Given** a test fixture with a missing required field, **When** the validation test runs against it, **Then** the test reports a clear validation error identifying the missing field.
3. **Given** a real SCORECARD.json from a prior fleet run, **When** validated against `SCORECARD.schema.json`, **Then** it passes validation without errors.

---

### User Story 2 - Schema Regression Detection (Priority: P2)

As the fleet maintainer, I want schema tests to catch accidental regressions when templates or hooks are updated, so that I don't discover contract breakage only after a failed fleet run.

**Why this priority**: Regressions are discovered late (during fleet pipeline runs) without proactive tests.

**Independent Test**: Deliberately modify a required field name in a schema copy, run validation, and verify failure.

**Acceptance Scenarios**:

1. **Given** a schema with `"composite"` as a required field, **When** a fixture uses `"composite_score"` instead, **Then** the validation test fails with a descriptive error.

## Requirements

- **FR-001**: Each of the 4 schemas (`SCORECARD.schema.json`, `OPPORTUNITIES.schema.json`, `OPTIMIZATION_SCORECARD.schema.json`, `FINDINGS.schema.json`) MUST have at least one validation test.
- **FR-002**: Tests MUST include both positive cases (valid artifacts accepted) and negative cases (invalid artifacts rejected).
- **FR-003**: Tests MUST validate against at least one real artifact from a prior fleet run (constitution §5: "Test with Real Data").
- **FR-004**: All tests MUST be runnable via `make test` from the repo root.
- **FR-005**: Tests MUST run without LLM invocations (constitution non-goals: "No LLM invocations").

## Success Criteria

- **SC-001**: `make test` runs all schema validation tests and reports 0 failures
- **SC-002**: Each of the 4 schemas has ≥1 positive and ≥1 negative test case
- **SC-003**: At least 2 real fleet artifacts validate successfully against their schemas
- **SC-004**: A deliberately broken fixture is correctly rejected by the test harness
