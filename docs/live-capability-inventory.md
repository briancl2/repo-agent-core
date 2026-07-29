# Owner package inventory

This is the single human-readable owner inventory. Active exports carry
path-and-literal-token evidence for their repo-native owner caller and for every
declared exact consumer caller. A dash means that no consumer claim is made.
The validator reads cached Git blobs, never an unstaged working-tree view.

## Active exports

Each evidence cell uses `path::literal-token`. Active patterns must be
non-overlapping, and every row must have verified owner evidence.

| Path | Class | Owner evidence | Auditor evidence | Advisor evidence | Optimizer evidence |
|---|---|---|---|---|---|
| `CONSTITUTION.md` | shared semantic floor | `AGENTS.md::CONSTITUTION.md` | - | - | - |
| `AGENTS.md` | compact bootloader | `README.md::AGENTS.md` | - | - | - |
| `README.md` | package entrypoint | `AGENTS.md::repo-agent-core` | - | - | - |
| `docs/live-capability-inventory.md` | owner-manifest | `AGENTS.md::docs/live-capability-inventory.md` | - | - | - |
| `.github/workflows/ci.yml` | native CI | `tests/test-closure-identity.sh::.github/workflows/ci.yml` | - | - | - |
| `Makefile` | native command surface | `.github/workflows/ci.yml::make test` | - | - | - |
| `.agents/skills/reviewing-code-locally/SKILL.md` | portable review skill | `AGENTS.md::reviewing-code-locally` | - | - | - |
| `.agents/skills/reviewing-code-locally/references/review-prompt.md` | portable review prompt | `.agents/skills/reviewing-code-locally/SKILL.md::references/review-prompt.md` | - | - | - |
| `.agents/skills/reviewing-code-locally/scripts/local_review.sh` | portable review command | `Makefile::.agents/skills/reviewing-code-locally/scripts/local_review.sh` | `Makefile::.agents/skills/reviewing-code-locally/scripts/local_review.sh` | `Makefile::.agents/skills/reviewing-code-locally/scripts/local_review.sh` | `Makefile::.agents/skills/reviewing-code-locally/scripts/local_review.sh` |
| `schemas/ADAPTER_AUDIT_SUMMARY.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/AGENTIC_ROOT_CAUSE_BRIEFS.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/COMMAND_OUTPUT_ROI_RECEIPT.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/CRITIQUE_RESULT.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/FINDINGS.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | `tests/test-auditor-schemas.sh::schemas/FINDINGS.schema.json` | - | - |
| `schemas/GBRAIN_ADVISORY_PILOT_OUTCOME_LEARNING_LOOP_RECEIPT.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/HERMES_FOREGROUND_FAILURE_GUIDANCE.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/HERMES_FOREGROUND_RUN_RECEIPT.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/HOTSPOT_EVIDENCE_PACKETS.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/OPPORTUNITIES.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | `scripts/score-operation.sh::schemas/OPPORTUNITIES.schema.json` | - |
| `schemas/OPTIMIZATION_SCORECARD.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | `scripts/repo-optimizer.sh::OPTIMIZATION_SCORECARD.json` |
| `schemas/PLAYBOOK_MANIFEST_AUTHORITY.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/REPO_STAR_GENERICITY_PROOF_RECEIPT.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/SCORECARD.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | `docs/invocation-contract.md::schemas/SCORECARD.schema.json` | - | - |
| `schemas/SOURCE_INSIGHT_PACKET.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/TOKEN_MEASUREMENT_SUMMARY.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | - |
| `schemas/TRANSFER_ORACLE_RECEIPT.schema.json` | exported schema byte | `Makefile::schemas/*.schema.json` | - | - | `tests/test-transfer-oracle-consumer.sh::schemas/TRANSFER_ORACLE_RECEIPT.schema.json` |
| `scripts/validate-floor-receipt.sh` | canonical portable floor validator | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` | `tests/test-floor-receipt-conformance.sh::scripts/validate-floor-receipt.sh` |
| `scripts/fleet-floor-conformance-audit.sh` | read-only fleet floor audit | `tests/test-floor-receipt-conformance.sh::scripts/fleet-floor-conformance-audit.sh` | - | - | - |
| `scripts/validate-artifacts.sh` | artifact validator | `tests/test-schemas.sh::scripts/validate-artifacts.sh` | - | - | `tests/test-transfer-oracle-consumer.sh::scripts/validate-artifacts.sh` |
| `scripts/compare-scorecards.sh` | scorecard comparison primitive | `tests/test-compare-scorecards.sh::scripts/compare-scorecards.sh` | `tests/test-compare-scorecards.sh::scripts/compare-scorecards.sh` | - | `docs/agent-operations.md::scripts/compare-scorecards.sh` |
| `scripts/check-compare-scorecards-conformance.sh` | copy-sync conformance gate | `Makefile::scripts/check-compare-scorecards-conformance.sh` | - | - | - |
| `docs/compare-scorecards-distribution.md` | distribution contract | `tests/test-compare-scorecards.sh::docs/compare-scorecards-distribution.md` | - | - | - |
| `scripts/install-hooks.sh` | consumer-called installer | `Makefile::scripts/install-hooks.sh` | `Makefile::repo-agent-core/scripts/install-hooks.sh` | - | `Makefile::repo-agent-core/scripts/install-hooks.sh` |
| `hooks/pre-commit-hook.sh` | installable hook | `scripts/install-hooks.sh::hooks/pre-commit-hook.sh` | - | - | - |
| `hooks/pre-push-hook.sh` | installable hook | `scripts/install-hooks.sh::hooks/pre-push-hook.sh` | - | - | - |
| `scripts/record-closure-identity.sh` | native test helper | `Makefile::scripts/record-closure-identity.sh` | - | - | - |
| `scripts/validate_owner_convergence.py` | cached-index convergence guard | `Makefile::scripts/validate_owner_convergence.py` | - | - | - |
| `tests/test-owner-convergence.sh` | focused convergence tests | `Makefile::tests/test-*.sh` | - | - | - |
| `tests/test-floor-receipt-conformance.sh` | canonical floor validator behavior tests | `Makefile::tests/test-*.sh` | - | - | - |
| `tests/test-compare-scorecards.sh` | comparison behavior tests | `Makefile::tests/test-*.sh` | - | - | - |
| `tests/test-closure-identity.sh` | closure helper tests | `Makefile::tests/test-*.sh` | - | - | - |
| `tests/test-schemas.sh` | schema syntax and sample tests | `Makefile::tests/test-*.sh` | - | - | - |

## Compatibility-only retained paths

Every pattern must resolve to the same path set and blob identities in the
rollback base and cached index. Removing or changing even one retained contract
therefore fails closed. `.gitignore` is intentionally included in this
byte-preserved hygiene bucket for this convergence change; a later ignore-rule
edit needs its own owner change and base comparison.

| Pattern | Classification |
|---|---|
| `.gitignore` | owner hygiene and generated-artifact exclusion |
| `docs/*-contract.md` | compatibility/history-only contract evidence |
| `docs/repo-agent-fleet-consistency-floor-receipt.md` | compatibility/history-only receipt |
| `templates/*` | compatibility/history-only templates |
| `tests/samples/*.json` | schema compatibility samples |
| `tests/fixtures/*.json` | schema compatibility fixtures |
| `schemas/*.schema.json` | active byte exports with preserved identities |
| `scripts/pre-*-hook.sh` | retained legacy hook copies |
| `LEARNINGS.md` | historical owner learning log |

## Removed-name successor rules

The base-tree-minus-index deletion set must be covered exactly once by these
rules. Every base match must be absent from the index and every successor must
be present.

| Removed pattern | Successor |
|---|---|
| `.github/agents/speckit.*.agent.md` | `AGENTS.md` |
| `.github/prompts/speckit.*.prompt.md` | `AGENTS.md` |
| `.specify/**` | `AGENTS.md` |
| `.vscode/settings.json` | `README.md` |
| `specs/001-schema-validation-tests/spec.md` | `tests/test-schemas.sh` |
| `docs/current-program-status.md` | `docs/live-capability-inventory.md` |
| `tests/test-*-contract.sh` | `tests/test-owner-convergence.sh` |

## Boundaries

- Compatibility retention does not make historical material active policy.
- Schema bytes and current consumer exports remain unchanged by this owner
  convergence.
- Installed and harness discovery is count-only by category; private names and
  contents are never emitted.
- The package creates no controller, registry, dashboard, plan family,
  scheduler, queue, daemon, background sync, or sibling mutation route.
