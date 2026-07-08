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
- The native evidence before verdict contract lives in
  `docs/native-evidence-before-verdict-contract.md` and
  `templates/native-evidence-before-verdict.md`; consume it by copy-sync or
  citation only, not by runtime dependency, validator theater, controller,
  scheduler, queue, daemon, registry, background memory process, automatic
  issue/PR creator, auto-updater, or downstream mutation. For external-system,
  upstream-tool, library, product, or native-capability verdicts, current
  upstream docs/root instructions are necessary but not sufficient; require a
  safe documented native attempt or concrete owner-surface blocker, and carry
  real native output or blocker evidence on the verdict-bearing surface.
- The repo-health retrospective method contract lives in
  `docs/repo-health-retrospective-method-contract.md` and
  `templates/repo-health-retrospective-method.md`; consume it by copy-sync or
  citation only, not by runtime dependency, controller, scheduler, queue,
  registry, generated inventory, daemon, background memory process, automatic
  issue/PR creator, auto-updater, or downstream mutation. It generalizes BMA's
  operating-model retrospective (BMA #1270 Track D) and fixes five method
  elements: five operating surfaces with three passes each (known / emerging /
  detection-verdict), a falsifiable thesis, an add-lightness ranking
  (CUT/SIMPLIFY over new mechanism, ties broken toward deletion) cross-checked
  by an INDEPENDENT outcome-proxy re-rank that can refute the thesis, a
  candidate-detector register handed back unbuilt, and a primary-evidence-first
  hierarchy that keeps canonical repo/GitHub truth above secondary session-log
  evidence. It does not implement detectors, open issues, or mutate sibling
  repos.
- Goal-mode runtime/self-healing evaluation language lives in
  `docs/goal-episode-evaluation-contract.md` and
  `templates/goal-episode-evaluation.md`; consume it by copy-sync or citation,
  not by runtime dependency, scheduler, queue, controller, or background sync.
- The Issue #164 capability placement contract lives in
  `docs/capability-placement-contract.md` and
  `templates/capability-placement.md`; consume it by copy-sync or citation only,
  not by runtime dependency, dashboard, registry, scheduler, queue, daemon,
  controller, central autonomy ledger, automatic issue/PR creation, auto-merge,
  background Hermes/GBrain behavior, Codex cloud/background write authority,
  downstream mutation, or replacement closure truth. Autonomy Preview remains
  advisory-first and must route boilerplate back to deletion or demotion.
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
- The Issue #164 Hermes foreground reliability contract lives in
  `docs/hermes-foreground-reliability-contract.md` and
  `templates/hermes-foreground-reliability.md`; consume it by copy-sync or
  citation only, not by runtime dependency, schema mandate, daemon, scheduler,
  queue, retry loop, controller, hidden registry, MCP server, background sync,
  automatic GitHub issue/PR creation, auto-merge, downstream mutation, Hermes
  repo mutation, background Hermes/GBrain behavior, `hermes -z` adoption, or
  Hermes-primary campaign/control claims. It records doer/checker eligibility,
  launcher receipt, failure guidance or clean-success reason, coordinator
  review, validation owner, promotion/demotion evidence, and forbidden mode.
- The Issue #164 Hermes foreground repo-star pilot reliability receipt lives in
  `docs/hermes-foreground-repo-star-pilot-reliability-contract.md` and
  `schemas/HERMES_FOREGROUND_REPO_STAR_PILOT_RELIABILITY_RECEIPT.schema.json`
  plus `templates/hermes-foreground-repo-star-pilot-reliability.md`; consume it
  by copy-sync or citation only, not by runtime dependency, daemon, scheduler,
  queue, controller, retry loop, hidden registry, background sync, MCP server,
  automatic GitHub issue creation, downstream PR/issue creation, downstream
  mutation, `hermes -z` adoption, Hermes primary campaign ownership, or patch
  application. Reliability artifacts must preserve downstream target git
  head/status before and after, write prompts/receipts/failure guidance outside
  targets, classify foreground Hermes runtime outcomes, and route failures to
  the owning surface.
- The Issue #164 GBrain advisory pilot outcome learning-loop receipt lives in
  `docs/gbrain-advisory-pilot-outcome-learning-loop-contract.md` and
  `schemas/GBRAIN_ADVISORY_PILOT_OUTCOME_LEARNING_LOOP_RECEIPT.schema.json`
  plus `templates/gbrain-advisory-pilot-outcome-learning-loop.md`; consume it
  by copy-sync or citation only, not by runtime dependency, import framework,
  memory daemon, scheduler, queue, controller, hidden registry, background
  sync, MCP server, automatic GitHub issue creation, downstream mutation, or
  canonical-memory claim. GBrain remains advisory; capture only reusable
  decision-changing learning with source/citation or GitHub surface references,
  use explicit no-capture reasons for routine, duplicate, or null results, and
  record semantic search/query weakness plus exact-handle replay before
  route-changing memory influences an owner action.
- The Issue #164 foreground recovery runtime composition lives in
  `docs/foreground-recovery-runtime-contract.md` and
  `schemas/HERMES_FOREGROUND_FAILURE_GUIDANCE.schema.json` plus
  `templates/hermes-foreground-failure-guidance.md`; consume it by copy-sync or
  citation only, not by runtime dependency, daemon, scheduler, queue, retry loop,
  controller, MCP server, background sync, automatic GitHub issue creation, or
  downstream mutation. Guidance is advisory and does not invoke gh; an operator
  must explicitly run any suggested conversion command.
- The Issue #164 foreground failure-to-issue conversion contract lives in
  `docs/foreground-failure-to-issue-conversion-contract.md` and
  `templates/foreground-failure-to-issue-conversion.md`; consume it by copy-sync
  or citation only, not by runtime dependency, daemon, scheduler, queue, retry
  loop, registry, controller, hidden registry, background GBrain behavior,
  automatic background issue creation, auto-merge, downstream mutation,
  Hermes/GBrain internals mutation, or runtime dependency behavior. Conversions
  turn foreground failure guidance, including `HERMES_FOREGROUND_FAILURE_GUIDANCE`,
  into explicit GitHub issue or issue comment truth with exact-marker dedupe,
  evidence path, owner action, and no automatic retry/repair.
- The Issue #164 Hermes foreground failure disposition contract lives in
  `docs/hermes-foreground-failure-disposition-contract.md` and
  `templates/hermes-foreground-failure-disposition.md`; consume it by
  copy-sync or citation only, not by runtime dependency, schema mandate,
  controller, scheduler, queue, daemon, registry, retry loop, auto-close,
  auto-merge, automatic issue/PR creation, downstream mutation, upstream Hermes
  mutation, or background Hermes/GBrain behavior. Close allowance requires
  unambiguous GitHub truth: exactly one merged related repair PR that references
  the failure issue itself or complete current provider-policy supersession;
  otherwise explicit blocker evidence keeps the issue open.
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
- The Issue #164 repo-star closure/runtime distribution contract lives in
  `docs/repo-star-closure-runtime-distribution-contract.md` and
  `templates/repo-star-closure-runtime-distribution.md`; consume it by
  copy-sync or citation only, not by runtime dependency, daemon, scheduler,
  queue, controller, retry loop, hidden registry, retained report-package
  truth, background memory process, automatic updater, auto-merge path, or
  downstream mutation. Distribution records must name closure ceremony regrowth
  classes, runtime drift classes, exact owner-surface recommendation fields,
  validation scope, fallback routing, foreground-only advisory GBrain policy,
  and bounded non-claims.
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
- The Issue #164 standalone external-intelligence sidecar contract lives in
  `docs/sidecar-prompt-ab-response-shaped-contract.md` and
  `templates/sidecar-prompt-ab-response-shaped.md`; consume it by copy-sync or
  citation only, not by runtime dependency, sidecar runner, daemon, scheduler,
  queue, controller, retry loop, hidden registry, retained closure package, or
  background sync. It preserves Prompt A/B as modes under
  `STANDALONE_EXTERNAL_INTELLIGENCE_SIDECAR`: pure prompt only, no operator
  wrapper text, all required context embedded, public URLs optional and
  non-load-bearing, Prompt B only after actual Prompt A output plus answered
  context, and Deep Research only with research targets, source rules, and a
  source-ledger response shape.
- The Issue #164 external critique capability contract lives in
  `docs/external-critique-capability-contract.md` and
  `templates/external-critique-capability.md`; consume it by copy-sync or
  citation only, not by runtime dependency, controller, scheduler, queue,
  daemon, registry, dashboard, retry loop, background memory process,
  automatic issue/PR system, standing paired-probe program, central service,
  sidecar runner, live-probe authorization, auto-merge, downstream mutation, or
  background sync. External critique is a bounded risk sensor, not authority:
  one critic is the default, panel/latest-panel requires named high-stakes
  context, no finding quota is forced, blocker/advisory disposition and
  independent owner evidence are required, and target repo principles outrank
  literal BMA wording. When a repo has a skill system or capability convention,
  reusable repo-agent mechanisms localize there before prompt files; prompts
  remain request, sidecar, or provenance artifacts. Model/path availability is
  observed receipt or output evidence, not a static routing promise or probe
  program.
- The Issue #164 Deep Research/source-intelligence native corpus contract lives
  in `docs/deep-research-source-intelligence-native-corpus-contract.md` and
  `templates/deep-research-source-intelligence-native-corpus.md`; consume it by
  copy-sync or citation only, not by runtime dependency, schema mandate beyond
  `SOURCE_INSIGHT_PACKET`, crawler, source registry, watcher, scheduler, queue,
  daemon, controller, hidden registry, sidecar runner, Deep Research API runner,
  automatic GitHub issue/PR creation, auto-merge, retained closeout package,
  background sync, raw authenticated DOM/HTML/screenshot/account-context
  retention, downstream mutation, live Codex Cloud execution, or live Codex
  remote execution. Carrier 1 used manual sidecar prompt only and
  `deep_research_api_disposition=rescoped_failed_not_authorized`; raw evidence
  is required before any future live API/cloud/remote claim.
- The Issue #164 Deep Research source-ledger v2 adoption contract lives in
  `docs/deep-research-source-ledger-v2-adoption-contract.md` and
  `templates/deep-research-source-ledger-v2-adoption.md`; consume it by
  copy-sync or citation only, not by runtime dependency, Deep Research API
  runner, sidecar runner, crawler, source registry, watcher, scheduler, queue,
  daemon, controller, retry loop, hidden registry, automatic GitHub issue/PR
  creator, auto-merge path, retained closeout package, background sync,
  authenticated browser capture grant, or downstream mutation. The accepted
  scope is #919/#921-shaped public/no-auth manual Deep Research architecture/
  source-intelligence advisory decisions only: `3/4` prompt tier default,
  `1/2` bounded transport-fit fallback, `1/3` not default, source-ledger v2
  fields including consulted-on date, exclusion rationale, and recommendation
  effect, and sidecar output as advisory evidence only.
- The scheduled Runtime Learning Shadow readback contract lives in
  `docs/scheduled-runtime-learning-shadow-readback-contract.md` and
  `templates/scheduled-runtime-learning-shadow-readback.md`; consume it by
  copy-sync or citation only, not by runtime dependency, workflow runner,
  scheduler, queue, daemon, controller, retry loop, hidden registry, retained
  closeout package, automatic GitHub issue/PR creation, background
  GBrain/Hermes behavior, or task-closure authority. It admits actual
  `event=schedule` readback evidence only after the run exists; workflow
  comments and artifacts remain evidence only and never replace GitHub
  issue/PR/check/merge truth.
- The Issue #164 scheduled readback owner proof contract lives in
  `docs/scheduled-readback-owner-proof-contract.md` and
  `templates/scheduled-readback-owner-proof.md`; consume it by copy-sync or
  citation only, not by runtime dependency, workflow runner, scheduler, queue,
  daemon, controller, retry loop, hidden registry, retained closeout package,
  automatic GitHub issue/PR mutation, auto-merge, background GBrain/Hermes
  behavior, or task-closure authority. It keeps `workflow_dispatch` as context
  only and requires actual `event=schedule` evidence, owner issue, candidate id,
  cadence, event filter, blocker rule, promotion/demotion, kill switch, and
  bounded non-claims.
- The Issue #164 Codex native runtime readiness contract lives in
  `docs/codex-native-runtime-readiness-contract.md` and
  `templates/codex-native-runtime-readiness.md`; consume it by copy-sync or
  citation only, not by runtime dependency, daemon, scheduler, queue,
  controller, retry loop, hidden registry, retained closeout package,
  background sync, automatic GitHub issue/PR creation, auto-merge, downstream
  mutation, or live Codex Cloud/remote execution proof. Official Codex local,
  worktree, cloud, automation, remote, and subagent documentation is capability
  context only until raw task evidence proves a live run.
- The Issue #164 integrated native capability acceptance contract lives in
  `docs/integrated-native-capability-acceptance-contract.md` and
  `templates/integrated-native-capability-acceptance.md`; consume it by
  copy-sync or citation only, not by runtime dependency, controller, scheduler,
  queue, daemon, retry loop, registry, sidecar runner, automatic issue/PR
  creator, auto-merge path, retained closeout package, Codex remote proof
  substitute, background Hermes/GBrain behavior, or downstream mutation. The
  current accepted disposition is Cloud proof accepted from BMA task
  `task_e_6a34120847c4832b94a1a08423530556`, remote deferred, and
  external-intelligence sidecar prompting failed and outside Arc 5.
- The Issue #164 GitHub parsed closure semantics contract lives in
  `docs/github-parsed-closure-semantics-contract.md` and
  `templates/github-parsed-closure-semantics.md`; consume it by copy-sync or
  citation only, not by runtime dependency, GitHub client, daemon, scheduler,
  queue, controller, retry loop, hidden registry, background poller, automatic
  GitHub issue/PR creation, issue-state repair mechanism, retained closeout
  package, or task-closure authority. The parsed GitHub
  `closingIssuesReferences` surface plus before/after issue state is the
  authoritative evidence when PR body wording, including negated wording, could
  affect a child issue unexpectedly.
- The Issue #164 route-changing learning/failure contract lives in
  `docs/route-changing-learning-failure-contract.md` and
  `templates/route-changing-learning-failure.md`; consume it by copy-sync or
  citation only, not by runtime dependency, GitHub client, memory daemon,
  scheduler, queue, controller, retry loop, hidden registry, background
  GitHub/GBrain/Hermes process, automatic GitHub issue/PR creation, retained
  closeout package, Hermes authority, GBrain authority, downstream mutation, or
  closure surface. Route-changing records must preserve GitHub owner-surface
  evidence, raw evidence, Hermes failure disposition when applicable, GBrain
  exact-handle replay or no-capture reason, fallback without memory, owner
  action, and literal-safe GitHub comment readback for code or shell evidence.
- The repo-star closure signal integrity contract lives in
  `docs/closure-signal-integrity-contract.md` and
  `templates/closure-signal-integrity.md`; consume it by copy-sync or citation
  only, not by runtime dependency, controller, scheduler, queue, daemon,
  registry, retry loop, automatic issue/PR creation, auto-merge, downstream
  mutation, or canonical closure truth. AS-54 remains a keep-candidate from
  transcript_processor-only one-repo evidence; AS-56-style external closure
  coupling is companion portability evidence, not AS-54 graduation evidence.
- The repo-star review ergonomics working-memory lightness contract lives in
  `docs/review-ergonomics-working-memory-lightness-contract.md` and
  `templates/review-ergonomics-working-memory-lightness.md`; consume it by
  copy-sync or citation only, not by runtime dependency, review bot, controller,
  scheduler, queue, daemon, registry, retry loop, automatic issue/PR creation,
  auto-merge, downstream mutation, or canonical memory. AS-55 remains a
  keep-candidate and remedies should add lightness rather than governance.
- The validation integrity format tracking contract lives in
  `docs/validation-integrity-format-tracking-contract.md` and
  `templates/validation-integrity-format-tracking.md`; consume it by copy-sync
  or citation only, not by runtime dependency, schema mandate, controller,
  scheduler, queue, daemon, registry, retry loop, automatic issue/PR creation,
  auto-merge, downstream mutation, or canonical validation ledger. It records the
  D3 correction: `briancl2/transcript_processor-private#56` binds the Phase-3
  format, `briancl2/transcript_processor-private#58` adds fail-closed saved-run
  drift protection, and this is not AS-56 detector evidence this round.
- The repo-agent assimilation method (the recovered portfolio_advisor +
  transcript_processor pre-flight process, n=2) is distributed as a copy-sync
  contract family. The umbrella is `docs/repo-assimilation-method-contract.md`
  with `templates/repo-assimilation-method.md`; it composes the
  principle-alignment anchor (`docs/principle-alignment-anchor-contract.md`,
  `templates/principle-alignment-anchor.md`), repo anthropology
  (`docs/repo-anthropology-contract.md`, `templates/repo-anthropology.md`),
  benchmark-before-repair (`docs/benchmark-before-repair-contract.md`,
  `templates/benchmark-before-repair.md`), the repair decision-block
  (`docs/repair-decision-block-contract.md`,
  `templates/repair-decision-block.md`), and maturity-boundary claim separation
  (`docs/maturity-boundary-claim-contract.md`,
  `templates/maturity-boundary-claim.md`). Consume by copy-sync or citation only
  — not as a runtime dependency, controller, scheduler, queue, daemon, registry,
  auto issue/PR creator, auto-merge, or downstream mutation. The method is an
  n=2 observation, not proven cross-repo doctrine, and proves operating-model
  readiness rather than repo-agent domain capability.
- The repo-agent fleet consistency floor contract lives in
  `docs/repo-agent-fleet-consistency-floor-contract.md` and
  `templates/repo-agent-fleet-consistency-floor.md`; consume it by copy-sync or
  citation only, not by runtime dependency, controller, scheduler, queue, daemon,
  registry, dashboard, watcher, cron job, background worker, automatic issue/PR
  creation, auto-merge, or downstream mutation. It ratifies a five-dimension
  shared floor (closure model, CI-check contract, gitignore baseline,
  learning-extraction gate, review safety net) plus a candidate/advisory sixth
  dimension (serialization discipline on hot/duplicated routing surfaces) not
  required for conformance in v0.1, and a v0.2 declare-mandatory seventh
  dimension (`domain_outcome_delta`, bound to the assimilation-method
  Domain-Outcome Eval Gate in briancl2/repo-agent-core#108) where fleet tools
  declare a justified null. It is grounded in the BMA AS-56 sweep retrospective
  and Phase 0 self-assimilation baseline (briancl2/build-meta-analysis#1214;
  v0.2 via Phase 3); ratifying it does not make any repo conform and does not
  authorize any per-repo change. GitHub issue/PR/check/merge truth and operator
  approval remain binding.
- Floor-conformance drift is self-catching via two verification-only tools
  (BMA #1214 Phase 4 item b), neither of which adds a floor dimension, changes the
  receipt schema (`schema_version` stays `1`), edits any receipt, or re-touches
  branch protection: `scripts/validate-floor-receipt.sh` is the canonical
  read-only static receipt validator (each consuming repo vendors a byte-identical
  copy and runs it on its own receipt inside that repo's already-required check —
  no new required status context), and `scripts/fleet-floor-conformance-audit.sh`
  is an on-demand, read-only live-drift fleet self-audit that compares each
  receipt's recorded `branch_protection_required_checks` against live GitHub
  protection contexts and exits non-zero on drift. The audit is manual/on-demand
  only — not a CI check, controller, scheduler, daemon, cron job, registry,
  watcher, or background process — and never mutates any repo.

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
