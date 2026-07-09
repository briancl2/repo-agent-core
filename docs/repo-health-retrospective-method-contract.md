# Repo-Health Retrospective Method Contract

> Version: 1.0
> Date: 2026-07-08
> Owner: repo-agent-core

## Purpose

This contract defines the shared repo-agent method for running a rigorous
repo-health / operating-model / anti-pattern **retrospective** on any fleet
repo — not just BMA. It promotes a one-off BMA operating-model retrospective
into a reusable fleet convention so any repo can test a repo-health thesis
against canonical evidence, rank findings by add-lightness, and hand back a
candidate-detector register without implementing anything.

The triggering source is BMA Issue #1270 Track D: the operating-model
meta-learning retrospective (`research/reports/operating-model-metalearning-retrospective-2026-07-07.md`)
plus the BMA `.agents/skills/retro-orchestrator/` skill. That retrospective
proved a repeatable method: five operating surfaces examined with three passes
each, a falsifiable thesis, an add-lightness ranking cross-checked by an
independent outcome-proxy re-rank, a candidate-detector register, and a
primary-evidence-first hierarchy. This contract captures that method so it
travels as a copy-sync/citation convention.

A repo-health retrospective is advisory synthesis, not a mutation. It must not
turn a ranking preference into a measured verdict, must not rest any finding on
secondary session-log evidence alone, and must not implement detectors, open
issues, or mutate sibling repos as a side effect of running.

This contract is copy-sync/citation guidance for repo-local instructions,
retrospective reports, issue/PR bodies, auditor detectors, advisor
recommendations, and optimizer materialization checks. It is not a runtime
dependency, controller, scheduler, queue, daemon, registry, generated
inventory, background memory process, auto-updater, MCP server, automatic
issue/PR creator, or downstream mutation.

## Related Contracts And Evidence

- `docs/native-evidence-before-verdict-contract.md`
- `docs/repo-assimilation-method-contract.md`
- `docs/repo-anthropology-contract.md`
- `docs/closure-signal-integrity-contract.md`
- `docs/review-ergonomics-working-memory-lightness-contract.md`
- BMA Issue #1270: https://github.com/briancl2/build-meta-analysis/issues/1270
- BMA maintained lane #1282
- BMA source retrospective: `research/reports/operating-model-metalearning-retrospective-2026-07-07.md`
- BMA skill: `.agents/skills/retro-orchestrator/SKILL.md`

## Required Record

| Field | Required meaning |
|---|---|
| artifact | Literal `REPO_HEALTH_RETROSPECTIVE_METHOD`. |
| schema_version | Record shape version; currently `1`. |
| repo_identity | The fleet repo (or target repo) whose operating health the retrospective examines. |
| operator_intent | The operator-valued question the retrospective answers and the repo-health outcome it serves. |
| thesis | The single falsifiable thesis under test, phrased so canonical evidence can confirm, refute, or partially refute it. |
| evidence_hierarchy | Primary canonical repo/GitHub truth (git, LEARNINGS, reports, AGENTS.md, GitHub issue/PR/check/merge state, signature scans) vs secondary session-log/runtime evidence, with the rule that no finding rests on secondary evidence alone. |
| operating_surfaces | The five operating surfaces, each examined with three passes: Pass A known anti-pattern still exhibited, Pass B emerging/unnamed anti-pattern, Pass C detection/add-lightness verdict. |
| candidate_register | The candidate-detector register: rows of id · verdict · anti-pattern · evidence · owner_surface · acceptance_sketch, handed back unbuilt. |
| add_lightness_ranking | Findings ranked by mechanism weight — CUT/SIMPLIFY first, cheap git-observable ADD next, heavy new surface last; ties broken toward deletion. This ordering is a preference, not a measurement. |
| outcome_proxy_rerank | An INDEPENDENT re-rank by a raw outcome proxy such as friction frequency, capable of disagreeing with and refuting the add-lightness ranking; records whether the two orderings disagree and which verdicts survive both. |
| thesis_verdict | Confirmed, refuted, or partially refuted, each with the decisive primary anchor; negative or partial verdicts count. |
| cut_simplify_add_tally | Tally of verdicts across CUT, SIMPLIFY, ADD, BOUNDED-HELPER, DO-NOT-BUILD, and CONDITIONAL. |
| owner_surface | GitHub issue/PR that owns the register hand-back and the next add-lightness moves. |
| bounded_non_claims | Boundaries for what the retrospective does not prove, automate, adopt, or mutate. |

## Register Verdict Vocabulary

Every candidate_register row carries exactly one verdict:

- `CUT` — remove a dead, duplicated, or net-negative mechanism (may include one
  small fail-loud guard that makes the cut safe; the deletion must dominate).
- `SIMPLIFY` — converge or finish an existing mechanism rather than add a new
  one.
- `ADD` — add a cheap, git-observable detector or check; label it an ADD
  honestly rather than branding it a cut.
- `BOUNDED-HELPER` — a bounded helper (for example a `gh`-truth status helper),
  explicitly not a controller, scheduler, or new surface.
- `DO-NOT-BUILD` — the explicit decision not to build a proposed heavy surface;
  naming what not to build is itself an add-lightness move.
- `CONDITIONAL` — build or capture only if a specific future decision needs it.

## Method Rules

1. Examine exactly five operating surfaces with three passes each (A known, B
   emerging, C detection/add-lightness verdict). Fewer surfaces or missing
   passes is an incomplete retrospective.
2. State one falsifiable thesis and test it against canonical evidence; record
   the verdict as confirmed, refuted, or partially refuted with the decisive
   primary anchor.
3. Rank findings by add-lightness: prefer CUT/SIMPLIFY over new mechanism, put
   cheap git-observable ADD next, put a heavy new surface last, and break ties
   toward deletion. State plainly that this ordering encodes a preference, not
   a measurement.
4. Carry an INDEPENDENT outcome-proxy re-rank (for example raw friction
   frequency) that can disagree with the add-lightness ranking. The re-rank is
   what keeps the thesis genuinely falsifiable: an add-lightness order alone can
   self-justify, so a preference ranking without a refutable outcome-proxy
   cross-check is not a valid retrospective. Record where the two orderings
   disagree and which verdicts survive both.
5. Keep canonical repo/GitHub truth as primary evidence and session-log/runtime
   evidence as secondary; no finding may rest on secondary evidence alone.
6. Produce a candidate-detector register and hand it back unbuilt: do not
   implement detectors, open new issues, or mutate sibling repos as a side
   effect of the retrospective. The only repository mutation is the report
   itself.
7. Split cross-repo narration from landed change so no reader mistakes a
   surface write-up for an owner-surface mutation.

## Repo-Star Fleet Roles

- `repo-agent-core` owns this shared contract and template.
- `repo-auditor` may detect retrospectives that skip surfaces or passes, that
  ship an add-lightness ranking with no independent outcome-proxy re-rank, that
  rest a verdict on secondary session-log evidence alone, or that implement
  detectors instead of handing back a register.
- `repo-upgrade-advisor` should package register rows into exact owner-surface
  recommendations with first deliverable, validation scope, fallback, GitHub
  routing, source citation, and bounded non-claims.
- `repo-optimizer` should materialize only concrete CUT/SIMPLIFY changes with a
  patchable owner surface and skip speculative new-surface ADD work that lacks
  one.

## Running This Retrospective On Your Own Repo (Self-Serve)

This method is a standing, per-repo capability: any fleet repo can run its own
repo-health retrospective against its own evidence, on demand, without a new
mechanism. It is an agent-run, **foreground, on-demand** procedure — not a
controller, scheduler, cron, daemon, registry, or standing process.

To run one on a repo:

1. Gather that repo's own primary evidence first: git history, `LEARNINGS.md`,
   reports, `AGENTS.md`, GitHub issue/PR/check/merge state, and its
   signature/anti-pattern scan catalog. Session-log/runtime exhaust is secondary
   and may only corroborate.
2. Apply the Method Rules above: state one falsifiable thesis, examine the five
   operating surfaces with three passes each, rank findings by add-lightness,
   carry an independent outcome-proxy re-rank that can refute the ranking, and
   produce a candidate-detector register handed back unbuilt.
3. Fill the record in `templates/repo-health-retrospective-method.md` and land
   the completed record as **one report** in that repo's own convention
   (`research/reports/` in BMA, `docs/` in the inner-loop fleet repos). The
   report is the only repository mutation.

Reuse by reference, not relocation. This contract plus the template are the
portable method; a repo does not need to copy any BMA-specific runner skill to
run a retrospective. Each fleet repo makes the capability discoverable by adding
a one-line pointer to this contract in its `AGENTS.md`.

## Add-Lightness Discipline

The ranking rule prefers cutting and simplifying over adding new governance or
mechanism, and breaks ties toward deletion. Honest accounting is required: a
CUT that adds a small guard is a "CUT (net-negative code) plus small guard," and
a cheap detector is an ADD, not a disguised cut. The independent outcome-proxy
re-rank protects the ranking from circular self-justification — if the only
conclusion that survives both orderings is the rejection of a heavy new surface,
that rejection is the one non-preference-driven result.

## Bounded Non-Claims

Every repo-health retrospective record should include clauses equivalent to:

- This record does not turn its add-lightness ranking into a measured return; it
  is a preference cross-checked by an outcome proxy.
- This record does not rest any verdict on secondary session-log or runtime
  evidence alone.
- This record does not implement detectors, open new issues, or mutate sibling
  repos; the candidate register is an advisory hand-back.
- This record does not authorize background sync/watch, cron, autopilot, jobs
  worker, MCP serving, queues, daemons, schedulers, hidden registries,
  generated inventories, automatic updates, automatic issue/PR creation, or
  downstream mutation.
- This record does not create a controller, scheduler, queue, registry, daemon,
  retry loop, hidden control plane, or retained proof ritual.

## Copy-Sync Boundary

Consumers may copy-sync this contract or template into repo-local instruction
surfaces, retrospective reports, detector fixtures, advisor recommendation
guidance, or optimizer materialization checks. Copy drift is repo quality debt
handled through review and focused drift gates. Do not add a runtime
dependency, generated registry, scheduler, queue, controller, daemon, watcher,
retry loop, automatic updater, background sync, or canonical memory bridge to
keep copies aligned.
