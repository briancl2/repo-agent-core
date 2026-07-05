# Repo-Agent Fleet Consistency Floor Contract

> Version: 0.2
> Date: 2026-07-03 (v0.1); 2026-07-04 (v0.2)
> Owner: repo-agent-core
> Source issue: briancl2/build-meta-analysis#1214 (Phase 1 floor; Phase 3 v0.2 dimension 7)
> Ratified in: briancl2/repo-agent-core#104 (v0.1)
> v0.2 note: BMA #1214 Phase 3 adds dimension 7 `domain_outcome_delta`, bound to the
> Domain-Outcome Eval Gate merged in briancl2/repo-agent-core#108 (merge 8230493).

## Purpose

This contract defines the minimum shared operating floor for the five
repo-agent repos: build-meta-analysis, repo-auditor, repo-agent-core,
repo-upgrade-advisor, and repo-optimizer.

The floor exists to make fleet drift detector-caught instead of hand-found. The
AS-56 closure-coupling sweep (five merged PRs on 2026-07-01) delivered coherent
output but was **consistent in output and inconsistent in process**: closure
rigor, CI topology, review coverage, gitignore hygiene, and learning-extraction
each existed in a different subset of repos. The read-only Phase 0
self-assimilation baseline confirmed the same drift with real detector output
(DS-36 green-only CI on three repos, AS-56 external closure coupling on every
scored repo, AS-42 route-changing learning gaps, and a repo-upgrade-advisor
dirty-start `scripts/__pycache__/` guard that blocked scoring entirely).

Evidence:

- `research/reports/fleet-as56-sweep-retrospective-2026-07-01.md`
  (build-meta-analysis) — the hand-found friction this floor is built to catch.
- `research/reports/fleet-self-assimilation-phase0-baseline-2026-07-01.md`
  (build-meta-analysis) — the read-only baseline that measured the five
  dimensions and drafted this contract, template, and receipt schema.

This contract does not make the five repos identical, does not replace repo-local
ownership, does not measure or assert conformance by itself, and does not
authorize controllers, schedulers, queues, daemons, registries, dashboards,
watchers, cron jobs, background workers, automatic issue/PR creation, auto-merge,
downstream mutation, or per-repo changes. Ratifying this contract does not make
any repo conform.

Consumers use this contract by copy-sync or citation only. There is no runtime
import.

## Floor Dimensions

A conforming repo declares and validates these fields. Dimensions 1-5 are the
mandatory floor. Dimension 6 is a **candidate/advisory** field in v0.1 and is
not required for conformance. Dimension 7 (`domain_outcome_delta`), added in
v0.2, is **declare-mandatory**: every conforming repo declares its
domain-outcome posture, and fleet tools with no product-domain evaluation
declare an explicitly justified null.

| # | Field | Required meaning | Evidence origin |
|---|---|---|---|
| 1 | `closure_model` | The repo's closure model, with issue/PR/check/merge truth as the minimum floor and any `make work` / `work-close` posture stated explicitly as required, optional, or absent. | AS-56 retrospective: three closure models across five repos (native-issue only / `make work`+`work-close` / no work machinery). Phase 0 matrix confirmed the same split. |
| 2 | `ci_check_contract` | The expected PR checks by name, source workflow/job, branch-protection status, and the rule for skipped checks. | AS-56 retrospective: 1-3 checks per repo, all differently named. Phase 0 branch-protection readback: only BMA has a protected required check (`check`); the other four `main` branches reported no required status-check protection. |
| 3 | `gitignore_baseline` | Required local-noise ignores, at minimum `work/`, `__pycache__/`, `*.pyc`, and `.DS_Store`, plus repo-local common-noise entries when applicable. | AS-56 retrospective: `__pycache__` ignore in only 1 of 4 star repos, forcing hand-deletion mid-sweep. Phase 0: repo-upgrade-advisor dirty `scripts/__pycache__/` blocked scorecard generation. |
| 4 | `learning_extraction_gate` | How closeout records a novel learning or an explicit no-novel-finding disposition. Silence is not a disposition. | AS-56 retrospective: the `--no-novel-findings` learning-extraction gate ran in only 1 of 5 repos. Phase 0: AS-42 route-changing learning gaps fired on four audited repos. |
| 5 | `review_safety_net` | How automated review/critique is expected to fire on PRs, verified against GitHub PR review truth, or the explicit reason it is unavailable for that repo. | AS-56 retrospective: automated Codex review fired on only 3 of 5 PRs, missing the two largest-blast-radius changes. Phase 0: AS-08 fired on every audited repo; GitHub review readback matched. |
| 6 | `serialization_discipline` | **Candidate/advisory in v0.1.** Serialization discipline on hot or duplicated routing surfaces: hot files, duplicated logic, drift gate, and the intended serial edit path. Not required for conformance until a future ratification promotes it with a narrow definition. | AS-56 retrospective: repo-optimizer hot-file merge contention on `generate-patches.sh` and the two-parallel-Python-block hazard. Phase 0: optimizer emitted unsupported/unpatchable blockers, not safe patches. Phase 0 produced no fleet-wide detector for duplicated routing surfaces, so this stays advisory. |
| 7 | `domain_outcome_delta` | **Declare-mandatory (v0.2).** The repo's domain-outcome evaluation posture, bound to the assimilation-method **Domain-Outcome Eval Gate** (`docs/repo-assimilation-method-contract.md` step 9 / Validation Rule 7 / receipt field `validated_domain_outcome_delta`). For any domain enhancement the repo commits to proving a validated domain-outcome delta on the target's own evaluation — targeting the root-cause `outcome_lever` within owner-stated product contracts, never a proxy — or reporting an explicit null/negative. A fleet tool with no product-domain eval declares a justified null. Do not restate the gate mechanics; reference the method contract. | BMA #1214 Phase 3 ratification and repo-agent-core#108 (merge 8230493), which added the eval gate after the TP spec 007 row-size proxy and the D4 sanitizer-backstop misdiagnosis closed domain enhancements on proxies instead of validated outcome deltas. |

## Receipt/Distribution Shape

A conforming repo emits a `REPO_AGENT_FLEET_CONSISTENCY_FLOOR` receipt using the
shared template. The receipt includes these fields:

| Field | Required meaning |
|---|---|
| `artifact` | Literal `REPO_AGENT_FLEET_CONSISTENCY_FLOOR`. |
| `schema_version` | Receipt shape version; currently `1`. |
| `generated_at` | UTC timestamp when the receipt was produced. |
| `source_issue_or_contract` | The umbrella issue or contract that requested the floor readback. |
| `consuming_repo` | The `briancl2/<repo>` the receipt describes. |
| `evidence_refs` | Cited scorecard, GitHub PR checks, and branch-protection readback evidence. |
| `closure_model` | Dimension 1 declaration: model, repo-local surfaces, whether required for PRs, and how ordinary changes close. |
| `ci_check_contract` | Dimension 2 declaration: branch-protection required checks, observed PR checks, workflow/job names, and the skipped-check policy. |
| `gitignore_baseline` | Dimension 3 declaration: whether a `.gitignore` exists, which required entries are present, and any blockers. |
| `learning_extraction_gate` | Dimension 4 declaration: whether the gate is available, expected at close, supports a no-novel-findings disposition, and its surfaces. |
| `review_safety_net` | Dimension 5 declaration: whether automated review is expected, whether the latest representative PR review was seen, the review surface, and any blockers. |
| `serialization_discipline` | Dimension 6 declaration (candidate/advisory): status, hot surfaces, duplicated logic, drift gate, and serial edit rule. Optional in v0.1. |
| `domain_outcome_delta` | Dimension 7 declaration (declare-mandatory): the domain-outcome posture bound to the method contract's `validated_domain_outcome_delta` sub-fields (`outcome_lever`, `rejected_proxy`, `target_variable`, `pre_registered_metric`, `target_own_eval`, `measured_delta`, `owner_contract_respected`, `result_class`). A fleet tool may declare `{"result_class": "not-applicable", "reason": "…"}`; an assimilation target carries a real `result_class`. See the method contract; do not restate the gate. |
| `repo_native_validation` | The repo's native checks/commands run to validate the receipt, with pass/fail/skipped/blocked status and receipt paths. |
| `owner_routing` | The exact GitHub owner surface and next owner action for each gap. |
| `bounded_non_claims` | Explicit limits on automation, mutation, conformance, and canonical truth. |

## Validation Rules

1. Every consuming repo must provide a `REPO_AGENT_FLEET_CONSISTENCY_FLOOR`
   receipt using the shared template.
2. The receipt must cite current repo-local evidence: files, workflows, GitHub
   branch-protection readback, and the latest representative PR check/review
   readback. Memory is not evidence.
3. The closure model must keep GitHub issue/PR/check/merge truth as the minimum
   floor and must not depend on retained local closeout packages as truth when
   GitHub truth is available.
4. The CI-check contract must name checks exactly as GitHub reports them. If
   branch protection is absent, the receipt must say so explicitly rather than
   implying a protected required check.
5. The gitignore baseline must prevent Python bytecode and common local noise
   (`work/`, `__pycache__/`, `*.pyc`, `.DS_Store`) from appearing as untracked
   files during fleet audit/advice/optimize runs.
6. The learning-extraction gate must record either a novel learning routed to the
   owner surface or an explicit no-novel-finding disposition. Silence is not
   enough.
7. The review safety net must be verified against GitHub PR review truth or record
   an explicit blocker/reason. A configured workflow is not sufficient if it did
   not fire on representative PRs.
8. Serialization discipline (dimension 6) is advisory in v0.1. A repo may omit it
   without failing conformance. If a repo keeps it, it must list hot files or
   duplicated logic, the change owner, a copy-sync/drift check when duplicates
   exist, and the intended serial edit path.
9. Validation must run through the repo's native checks or record the exact
   blocker. This contract does not measure conformance on its own and does not
   mutate any repo.
10. Scorecards and detector output corroborate floor gaps but do not replace
    GitHub issue/PR/check/merge truth, branch protection, repo-local evidence, or
    operator approval.
11. Domain-outcome delta (dimension 7) is **declare-mandatory** in v0.2: every
    conforming repo declares a `domain_outcome_delta` bound to the
    assimilation-method Domain-Outcome Eval Gate (step 9 / Validation Rule 7 /
    `validated_domain_outcome_delta`). A fleet tool (repo-auditor,
    repo-upgrade-advisor, repo-optimizer, repo-agent-core, build-meta-analysis)
    with no product-domain evaluation may declare
    `{"result_class": "not-applicable", "reason": "fleet tool, no product-domain
    eval; domain-outcome gate applies to assimilation targets it operates on"}`,
    while an assimilation target must carry a real `result_class` of `confirmed`
    / `null-reported` / `negative-reported` — a proxy metric or a `pending` delta
    is inadmissible, and a null or negative result must be reported, not hidden or
    relabeled. This rule ratifies a declaration requirement; it does not measure
    or force conformance and does not restate the gate mechanics.

## Owner Routing

| Gap | Owner surface |
|---|---|
| Shared floor contract/template gap | repo-agent-core |
| Detector coverage gap for a floor dimension | repo-auditor |
| Recommendation packaging gap | repo-upgrade-advisor |
| Patch/materialization gap | repo-optimizer |
| Repo-local adoption gap | the consuming repo, via its own issue → branch → PR → checks → merge |
| BMA campaign/coordination policy gap | build-meta-analysis |

- A missing or ambiguous floor dimension routes to the owning repo, not to a
  central controller.
- If a floor gap is not patchable, record a GitHub-visible blocker instead of
  generating a speculative patch.
- Per-repo conformance is a separate operator-gated step (BMA #1214 Phase 2),
  one repo at a time, through that repo's own native closure.

## Bounded Non-Claims

This contract does not:

- make any repo conform, or authorize any per-repo change;
- require identical implementation across the five repos;
- measure or assert conformance by itself;
- promote the candidate serialization-discipline dimension to mandatory in v0.1;
- measure or force conformance by ratifying the domain-outcome delta dimension —
  dimension 7 is declare-mandatory in v0.2, not a conformance measurement, and a
  fleet tool's justified-null value is by design, not a hidden gap;
- replace GitHub issue/PR/check/merge truth, branch protection, or operator
  approval;
- make scorecards, detector output, reports, or receipts canonical truth;
- create issues, create PRs, post comments, merge PRs, or close issues;
- mutate downstream or target repositories;
- create a controller, scheduler, queue, daemon, registry, dashboard, watcher,
  cron job, background worker, retry loop, hidden control plane, automatic
  updater, background sync, or auto-merge path.

## Copy-Sync Boundary

Consumers may copy-sync this contract or
`templates/repo-agent-fleet-consistency-floor.md`, or cite them from detector,
advisor, optimizer, or campaign surfaces. Copy drift is review debt handled by
focused tests and owner review. Do not add a runtime dependency, generated
registry, controller, scheduler, queue, daemon, watcher, retry loop, background
sync, automatic updater, auto-merge path, or downstream mutation path to keep
copies aligned.
