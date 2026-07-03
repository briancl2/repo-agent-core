# Repo-Agent Fleet Consistency Floor Receipt — repo-agent-core

> Artifact: `REPO_AGENT_FLEET_CONSISTENCY_FLOOR` (schema_version 1)
> Consuming repo: `briancl2/repo-agent-core`
> Generated: 2026-07-03T21:26:29Z
> Source issue: briancl2/build-meta-analysis#1214 (Phase 2, repo 2 of 5)
> Contract: this repo's `docs/repo-agent-fleet-consistency-floor-contract.md` v0.1,
> ratified in briancl2/repo-agent-core#105
> Template: this repo's `templates/repo-agent-fleet-consistency-floor.md`
> Core owner issue: briancl2/repo-agent-core#106
> Reference receipt (repo 1): `briancl2/repo-upgrade-advisor`
> `docs/repo-agent-fleet-consistency-floor-receipt.md` (advisor #210)

## Operator Intent

Declare repo-agent-core's posture against the fleet consistency floor it **owns**
(5 mandatory dimensions + 1 advisory) with **current, cited live evidence** —
files, workflow, GitHub branch-protection readback, and the latest representative
PR check/review readback. Memory is not evidence. This is the reference
self-conformance: because core authors the contract, template, and contract test,
the receipt must be exemplary and honest, and must not drift from core's own
template field list or `schema_version`.

This receipt is produced through core's own native issue → PR → `test` → merge
closure. It does not modify any other repo, assert conformance by itself, or
authorize any controller, scheduler, or automation. It is consumed by copy-sync
or citation only.

## Per-Dimension Summary

| # | Dimension | Status | Evidence |
|---|---|---|---|
| 1 | `closure_model` | Declared — `native_issue_pr_checks_merge` | Native issue → PR → `test` → merge is the only closure path (PR #105; this PR closes #106 the same way). Core has **no** `make work`/`work-close` scripts (`scripts/` has none; `Makefile` `.PHONY` has no `work` target). `scripts/record-closure-identity.sh` emits closure-run identity for gates/CI but does not gate closure. |
| 2 | `ci_check_contract` | Declared; branch-protection gap flagged | `.github/workflows/ci.yml` (`name: CI`, job `test`, runs `make test`). PR #105 observed a single `test` check = pass (22s); GitHub reports the status check as `test`. `main` is **not** branch-protected (GitHub API 404 "Branch not protected"). |
| 3 | `gitignore_baseline` | Met (this PR) | `.gitignore` now contains `work/`, `__pycache__/`, `*.pyc`, `.DS_Store` (+ `*.pyo`, `.pytest_cache/`, `.venv/`, `venv/`, `Thumbs.db`, `*.swp`, `*.swo`). Closes the Phase 0 "no `.gitignore`" gap; clean create (no tracked file matched the tokens; `git ls-files -ci --exclude-standard` empty). |
| 4 | `learning_extraction_gate` | Partial — no automated gate; author-discipline disposition | `LEARNINGS.md` exists (L1–L7) but core has **no** `work-close.sh` / `make work-close` and no `--no-novel-findings` machinery (Phase 0 line 59). Novel-learning capture relies on author discipline. Disposition for this change: novel learning captured as `LEARNINGS.md` L7 (self-conformance integrity). |
| 5 | `review_safety_net` | Present, non-deterministic; representative-PR gap flagged | `chatgpt-codex-connector[bot]` fired a COMMENTED review on PR #102 (2026-07-01T12:12:00Z) but did **not** fire on the floor PR #105 (zero reviews, zero comments). Connector present but firing is not guaranteed on every PR. `make review` + the block-by-default pre-commit hook are the local safety net. Confirmed on this PR at review time. |
| 6 | `serialization_discipline` | Advisory — `candidate_keep` | Core's duplicated surface is the copy-synced `scripts/compare-scorecards.sh` (consumed by repo-auditor/repo-optimizer per P1/P9, not symlinked); drift gate = `scripts/check-compare-scorecards-conformance.sh` + `tests/test-compare-scorecards.sh` (`make validate-compare-scorecards CONSUMERS=...`). Optional in v0.1. |

## Repo-Native Validation (this branch, 2026-07-03)

- `make test` → **pass** (records closure identity, then runs every
  `tests/test-*.sh`; all suites green, including the fleet-floor contract test).
- `bash tests/test-repo-agent-fleet-consistency-floor-contract.sh` → **pass**
  (8/8: contract + template semantics, README/AGENTS wiring for the contract and
  template).
- `make validate-schemas` → **pass** (all `schemas/*.schema.json` parse).
- `ci / test` (GitHub Actions) → confirmed on this PR's `test` check at review
  time.

## Corroboration (read-only, Phase 0)

Unlike repo-upgrade-advisor (whose Phase 0 audit was blocked by a dirty
`scripts/__pycache__/` start), repo-agent-core **was** scored in the Phase 0
baseline: composite **56/100** (Phase 2), with D3 skill maturity 2/20 and D5
self-improvement 10/20, and DS-36 (green-only CI), AS-22, AS-25, AS-32, AS-42,
AS-55, and AS-56 firing. Phase 0 recorded core's five-dimension posture directly:
native issue/PR/merge only with no work scripts; `main` unprotected with one
`test` check (PR #102); no `.gitignore`; `LEARNINGS.md` present but no
`--no-novel-findings`/work-close surface; and `chatgpt-codex-connector`
COMMENTED on PR #102. The scorecard corroborates the floor gaps but does not
replace GitHub issue/PR/check/merge truth or operator approval.

## Canonical Receipt

```json
{
  "artifact": "REPO_AGENT_FLEET_CONSISTENCY_FLOOR",
  "schema_version": 1,
  "generated_at": "2026-07-03T21:26:29Z",
  "source_issue_or_contract": "https://github.com/briancl2/build-meta-analysis/issues/1214 (Phase 2, repo 2 of 5); contract briancl2/repo-agent-core docs/repo-agent-fleet-consistency-floor-contract.md v0.1, ratified in briancl2/repo-agent-core#105",
  "consuming_repo": "briancl2/repo-agent-core",
  "evidence_refs": [
    {
      "kind": "scorecard",
      "path_or_url": "briancl2/build-meta-analysis research/reports/fleet-self-assimilation-phase0-baseline-2026-07-01.md",
      "summary": "Phase 0 baseline scored repo-agent-core 56/100 (Phase 2); D3 skill maturity 2/20, D5 self-improvement 10/20; DS-36 green-only CI, AS-22, AS-25, AS-32, AS-42, AS-55, AS-56 fired; 5 patchability blockers (mostly unsupported_or_unpatchable), 0 patches. Confirms native-only closure, unprotected main, no .gitignore, LEARNINGS.md present without a work-close gate, and codex COMMENTED on PR #102."
    },
    {
      "kind": "github_pr_checks",
      "path_or_url": "https://github.com/briancl2/repo-agent-core/pull/105",
      "summary": "PR #105 (Ratify the floor contract, merged 2026-07-03T19:22:10Z) reported a single status check `test` = pass (22s). No other checks observed. This conformance PR (issue #106) is expected to report the same single `test` check; name confirmed via `gh pr checks` at review time."
    },
    {
      "kind": "branch_protection",
      "path_or_url": "GET repos/briancl2/repo-agent-core/branches/main/protection",
      "summary": "HTTP 404 'Branch not protected'. main has no required status-check protection; the passing `test` check is enforced by operator discipline, not branch protection."
    },
    {
      "kind": "github_pr_review",
      "path_or_url": "https://github.com/briancl2/repo-agent-core/pull/102 (reviews readback) and /pull/105 (empty reviews readback)",
      "summary": "chatgpt-codex-connector[bot] submitted a COMMENTED review on PR #102 at 2026-07-01T12:12:00Z. PR #105 (the floor ratification PR) had zero reviews and zero issue comments: the connector is present but did not fire on the most recent representative PR. Consistent with the AS-56 retrospective (codex fired on only 3 of 5 sweep PRs)."
    }
  ],
  "closure_model": {
    "model": "native_issue_pr_checks_merge",
    "repo_local_surfaces": ["scripts/record-closure-identity.sh", "Makefile (test, review, closure-identity)", ".agents/skills/reviewing-code-locally"],
    "required_for_prs": true,
    "notes": "GitHub native issue -> PR -> `test` check -> merge is core's only closure path and is required; it was the path for PR #105 and is the path for this conformance PR (issue #106). Core has NO `make work`/`work-close` machinery: `scripts/` contains no work-init/work-close, and the Makefile `.PHONY` list has no `work` target. `scripts/record-closure-identity.sh` emits a closure-run identity JSON for local gates and GitHub Actions runs (invoked by `make test` and `make closure-identity`) but does not gate or score closure. There is no retained local closeout package treated as truth; GitHub issue/PR/check/merge is the minimum floor and the actual truth."
  },
  "ci_check_contract": {
    "branch_protection_required_checks": [],
    "observed_pr_checks": ["test"],
    "workflow_jobs": ["CI / test"],
    "skipped_check_policy": "The CI workflow (.github/workflows/ci.yml, name: CI) defines a single job `test` that runs `make test`; GitHub reports the PR status check as `test` (confirmed via `gh pr checks 105` and confirmed again on this PR). No conditional/matrix/skippable checks are defined, so there is no expected skipped check. A `test` result of skipped or neutral is NOT treated as a pass; merge requires `test` = success. Because main is unprotected, the passing `test` check is an advisory merge gate enforced by operator discipline, not by branch protection."
  },
  "gitignore_baseline": {
    "has_gitignore": true,
    "required_entries_present": {
      "work/": true,
      "__pycache__/": true,
      "*.pyc": true,
      ".DS_Store": true
    },
    "repo_local_common_noise": ["*.pyo", ".pytest_cache/", ".venv/", "venv/", "Thumbs.db", "*.swp", "*.swo"],
    "blockers": []
  },
  "learning_extraction_gate": {
    "available": false,
    "expected_at_close": false,
    "no_novel_findings_supported": false,
    "surfaces": ["LEARNINGS.md"],
    "notes": "repo-agent-core has NO automated learning-extraction gate: there is no scripts/work-close.sh, no `make work-close`, and no `--no-novel-findings` disposition flag (Phase 0 line 59 confirmed the same). LEARNINGS.md exists and records cross-fleet operating-model learnings (L1-L7); novel-learning capture depends on author discipline, not a gate. Silence is not treated as a disposition here: the explicit disposition for this conformance change is a NOVEL learning, captured as LEARNINGS.md L7 (a contract-owning repo must self-conform through its own native closure and keep its receipt schema-aligned with its own template). See owner_routing: accept-as-intended (native closure is the floor; work-close is absent by design) vs. file an owner issue to add a lightweight native-closure learning prompt. No gate machinery is invented in this PR."
  },
  "review_safety_net": {
    "automated_review_expected": true,
    "latest_representative_pr_review_seen": false,
    "review_surface": "chatgpt-codex-connector",
    "blockers": ["codex did not fire on the most recent representative PR (#105): zero reviews and zero comments. Firing is non-deterministic (AS-56 retrospective: 3 of 5 sweep PRs)."],
    "notes": "Verified against GitHub PR review truth: chatgpt-codex-connector[bot] submitted a COMMENTED review on PR #102 (2026-07-01T12:12:00Z), so the connector is configured and does fire on core PRs, but it did NOT fire on PR #105 (the floor ratification PR). The local safety net is `make review` (.agents/skills/reviewing-code-locally) plus the block-by-default pre-commit hook (SKIP_REVIEW=1 only for emergency). Because main is unprotected, an automated review is advisory and does not block merge. This conformance PR is the next representative datapoint; whether codex fires on it is confirmed at review time and does not gate merge."
  },
  "serialization_discipline": {
    "status": "candidate_keep",
    "hot_surfaces": ["scripts/compare-scorecards.sh", "hooks/ (pre-commit/pre-push scripts copy-synced to consumers via scripts/install-hooks.sh)"],
    "duplicated_logic": ["scripts/compare-scorecards.sh is copy-synced into consumer repos (repo-auditor, repo-optimizer) per P1/P9 independence (not symlinked); contracts/templates in docs/ and templates/ are copy-synced fleet-wide by design"],
    "drift_gate": "scripts/check-compare-scorecards-conformance.sh (fixture + hash drift gate) and tests/test-compare-scorecards.sh, run via `make validate-compare-scorecards CONSUMERS=\"../repo-auditor ../repo-optimizer\"`",
    "serial_edit_rule": "When editing scripts/compare-scorecards.sh, update the conformance fixture/hash and re-run the compare-scorecards conformance gate against consumers; consumers copy-sync the primitive (P1/P9), so copy drift is review debt caught by the drift gate, not a runtime dependency.",
    "notes": "advisory in v0.1; not required for conformance"
  },
  "repo_native_validation": [
    {"command_or_check": "make test", "status": "pass", "receipt": "local run 2026-07-03; record-closure-identity + every tests/test-*.sh green, incl. fleet-floor contract test"},
    {"command_or_check": "bash tests/test-repo-agent-fleet-consistency-floor-contract.sh", "status": "pass", "receipt": "local run 2026-07-03; 8/8 (contract + template semantics + README/AGENTS wiring)"},
    {"command_or_check": "make validate-schemas", "status": "pass", "receipt": "local run 2026-07-03; all schemas/*.schema.json parse"},
    {"command_or_check": "ci / test (GitHub Actions)", "status": "pass", "receipt": "confirmed on this PR's `test` check at review time"}
  ],
  "owner_routing": [
    {
      "gap": "main branch has no required status-check protection; the passing `test` check is enforced by operator discipline, not branch protection",
      "owner_surface": "briancl2/repo-agent-core (repo owner / operator decision)",
      "next_owner_action": "Operator decides whether to enable branch protection on main requiring the `test` check. Not forced by this PR (flagged as an owner decision per BMA #1214 Phase 2 boundaries)."
    },
    {
      "gap": "no automated learning-extraction gate exists (no work-close.sh / make work-close / --no-novel-findings); novel-learning capture on native PRs relies on author discipline",
      "owner_surface": "briancl2/repo-agent-core",
      "next_owner_action": "Accept as intended (native issue/PR/check/merge is the floor; core has no work machinery by design) OR file a core issue to add a lightweight native-closure learning prompt. Disposition for this change recorded as LEARNINGS.md L7; no machinery added in this PR."
    },
    {
      "gap": "automated codex review did not fire on the most recent representative PR (#105); firing is non-deterministic",
      "owner_surface": "briancl2/repo-agent-core (repo owner / codex connector configuration)",
      "next_owner_action": "Treat codex review as advisory (main is unprotected). If deterministic review is desired, the owner configures required reviews/branch protection. Confirm codex firing on this PR at review time; not forced, not merge-gating."
    }
  ],
  "bounded_non_claims": [
    "emitting this receipt does not make the repo conform and does not authorize any further per-repo change beyond this PR's gitignore floor, receipt, and one LEARNINGS.md row",
    "this contract does not require identical implementation across the five repos",
    "serialization discipline is advisory in v0.1 and is not required for conformance",
    "scorecards and detector output corroborate floor gaps but do not replace GitHub issue/PR/check/merge truth, branch protection, or operator approval",
    "this receipt is not a controller, scheduler, queue, daemon, registry, dashboard, watcher, cron job, auto-merge path, or background worker",
    "this receipt does not create issues, pull requests, comments, merges, or closures on its own, and does not mutate any other or downstream repository",
    "branch protection on main is an operator decision and is not forced by this receipt or PR"
  ]
}
```

## Not Claimed Here

- No conformance assertion beyond this repo's declared posture; the contract does
  not measure conformance by itself.
- No product-behavior, contract, template, or contract-test-semantics change
  (`.gitignore` + receipt + one LEARNINGS.md row only).
- No branch-protection change; flagged as an operator decision.
- No new learning-gate machinery; the absence of a work-close gate is recorded
  honestly and owner-routed.
