# AGENTS.md — repo-agent-core

> Shared primitives for the repo-agent fleet.
> This repo provides schemas, templates, hooks, and scoring infrastructure
> used by repo-auditor, repo-upgrade-advisor, and repo-optimizer.

## Purpose

`repo-agent-core` is the foundation layer. It contains:
- **Schemas** — Machine-readable formats (SCORECARD, OPPORTUNITIES, OPTIMIZATION_SCORECARD, COMMAND_OUTPUT_ROI_RECEIPT, SOURCE_INSIGHT_PACKET)
- **Templates** — Handoff templates, policy YAML, findings table format
- **Hooks** — Pre-commit and pre-push review enforcement scripts
- **Skills** — Shared skills (reviewing-code-locally)
- **Detection signatures** — DS-1 through DS-21

## Key Conventions

- Every change goes through `make review` before committing
- `--no-verify` is NEVER permitted (L102)
- Pre-commit hook blocks by default — SKIP_REVIEW=1 only for emergency (L105)
- Schemas are the inter-agent contract. Changing a schema is a breaking change.
- The Issue #164 core-five owner-surface model lives in
  `docs/core-five-owner-surface-contract.md`; consume it by copy-sync or citation,
  not by runtime dependency, scheduler, queue, controller, or background sync.
- The upstream capability intake contract lives in
  `docs/upstream-capability-intake-contract.md` and
  `templates/upstream-capability-intake.md`; consume it by copy-sync or
  citation, not by runtime dependency, schema mandate, generated inventory,
  scheduler, queue, controller, watcher, daemon, automatic updater, or
  background sync.
- Goal-mode runtime/self-healing evaluation language lives in
  `docs/goal-episode-evaluation-contract.md` and
  `templates/goal-episode-evaluation.md`; consume it by copy-sync or citation,
  not by runtime dependency, scheduler, queue, controller, or background sync.
- Interruption recovery and batch reconstitution guidance lives in
  `docs/interruption-recovery-and-batch-reconstitution-contract.md` and
  `templates/interruption-recovery-and-batch-reconstitution.md`; consume it by
  copy-sync or citation, not by runtime dependency, scheduler, queue,
  controller, retry loop, or background sync.
- Foreground learning and recovery guidance lives in
  `docs/foreground-learning-and-recovery-contract.md` and
  `templates/foreground-learning-and-recovery-block.md`; consume it by
  copy-sync or citation, not by runtime dependency, memory daemon, scheduler,
  queue, controller, or background sync.
- The Issue #164 Hermes foreground launcher receipt lives in
  `docs/hermes-foreground-launcher-contract.md` and
  `schemas/HERMES_FOREGROUND_RUN_RECEIPT.schema.json` plus
  `templates/hermes-foreground-run-receipt.md`; consume it by copy-sync or
  citation only, not by runtime dependency, daemon, scheduler, queue, retry loop,
  controller, MCP server, autopilot, hidden registry, automatic GitHub issue
  creation, or background sync. It does not authorize mutating downstream repos
  or Hermes internals.
- The Issue #164 foreground recovery runtime composition lives in
  `docs/foreground-recovery-runtime-contract.md` and
  `schemas/HERMES_FOREGROUND_FAILURE_GUIDANCE.schema.json` plus
  `templates/hermes-foreground-failure-guidance.md`; consume it by copy-sync or
  citation only, not by runtime dependency, daemon, scheduler, queue, retry loop,
  controller, MCP server, background sync, automatic GitHub issue creation, or
  downstream mutation. Guidance is advisory and does not invoke gh; an operator
  must explicitly run any suggested conversion command.
- The Issue #164 downstream read-only recovery-runtime pilot receipt lives in
  `docs/downstream-read-only-recovery-runtime-pilot-contract.md` and
  `templates/downstream-read-only-recovery-runtime-pilot.md`; consume it by
  copy-sync or citation only, not by runtime dependency, daemon, scheduler,
  queue, controller, retry loop, hidden registry, background sync, MCP server,
  automatic GitHub issue creation, downstream PR/issue creation, or patch
  application. Pilot artifacts can be written only outside the target repo,
  usually `/tmp`, and do not authorize downstream mutation.
- The Issue #164 repo-star genericity proof receipt lives in
  `docs/repo-star-genericity-proof-contract.md` and
  `schemas/REPO_STAR_GENERICITY_PROOF_RECEIPT.schema.json` plus
  `templates/repo-star-genericity-proof-receipt.md`; consume it by copy-sync or
  citation only, not by runtime dependency, daemon, scheduler, queue,
  controller, retry loop, hidden registry, background sync, MCP server,
  automatic GitHub issue creation, downstream PR/issue creation, or patch
  application. Proof artifacts must use a non-BMA target and preserve target git
  head/status before and after.
- The Issue #164 repo-star downstream genericity proof receipt lives in
  `docs/repo-star-downstream-genericity-proof-contract.md` and
  `schemas/REPO_STAR_DOWNSTREAM_GENERICITY_PROOF_RECEIPT.schema.json` plus
  `templates/repo-star-downstream-genericity-proof-receipt.md`; consume it by
  copy-sync or citation only, not by runtime dependency, daemon, scheduler,
  queue, controller, retry loop, hidden registry, background sync, MCP server,
  automatic GitHub issue creation, downstream PR/issue creation, `hermes -z`
  adoption, background GBrain behavior, or patch application. Proof artifacts
  must use real non-BMA downstream read-only targets, preserve each target git
  head/status before and after, classify target-native gate evidence without
  flattening ambiguity, keep evidence outside targets, and avoid exporting BMA
  labels or Issue #164 closure semantics into target repos.
- The Issue #164 GBrain retrieval/citation lifecycle proof lives in
  `docs/gbrain-retrieval-citation-lifecycle-contract.md` and
  `templates/gbrain-retrieval-citation-lifecycle.md`; consume it by copy-sync
  or citation only, not by runtime dependency, import framework, daemon,
  scheduler, queue, controller, hidden registry, background sync, MCP server,
  autopilot, dream, jobs worker, or canonical-memory claim. GBrain remains
  advisory until retrieval, citation, typed-link, timeline, write-parity,
  distribution, and human-acceptance gates are proven.
- The Issue #164 GBrain repo-local instruction distribution contract lives in
  `docs/gbrain-repo-local-instruction-distribution-contract.md` and
  `templates/gbrain-repo-local-instruction-distribution.md`; consume it by
  copy-sync or citation only, not by runtime dependency, import framework,
  daemon, scheduler, queue, controller, hidden registry, background sync, MCP
  server, autopilot, dream, jobs worker, or canonical-memory claim. GBrain
  remains advisory and cannot override operator intent, GitHub truth, repo
  evidence, or repo-local instructions.
- The Issue #164 Hermes doer with GBrain-distributed repo-local instructions
  contract lives in
  `docs/hermes-doer-gbrain-distributed-instructions-contract.md` and
  `templates/hermes-doer-gbrain-distributed-instructions.md`; consume it by
  copy-sync or citation only, not by runtime dependency, daemon, scheduler,
  queue, controller, retry loop, hidden registry, background sync, MCP server,
  autonomous campaign operation, `hermes -z` adoption, GBrain background
  behavior, or canonical-memory claim. Hermes remains a bounded foreground
  first-attempt doer, and GBrain remains advisory.

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
