# AGENTS.md — repo-agent-core

Read `CONSTITUTION.md` first. It is the exact shared semantic floor. This
bootloader is subordinate owner policy and cannot change constitutional
meaning.

## Owner route

`repo-agent-core` owns a small portable package of schemas, deterministic
validation and scorecard tools, installable review hooks, and the
`reviewing-code-locally`, `owner-delivery`, and `using-bma-researcher` skills.

For every change:

1. Name one owner issue.
2. Use one branch and one pull request.
3. Run the smallest focused check, then `make test`.
4. Run `make review` before committing. Never use `--no-verify`.
5. Require the applicable GitHub checks and review.
6. Merge only with owner authority, then verify merge and issue readback.

Current state comes from cached Git bytes and live GitHub issue, pull request,
check, review, merge, and readback evidence. Plans, retained contracts,
historical reports, and compatibility material are not active authority.

## Package boundary

The active package and every retired-name successor are listed in
`docs/live-capability-inventory.md`. `scripts/validate_owner_convergence.py`
validates that inventory from the Git index and cached blobs.

Schemas are exported bytes. Do not change schema semantics in a cleanup or
convergence change. Copy-synced tools remain independently runnable in each
consumer. Do not add a controller, registry, dashboard, scheduler, queue,
daemon, background sync, or sibling-repository mutation path.

Files retained under compatibility-only paths preserve current caller evidence
and history. They do not create active policy. Their eventual removal requires
an exact cached caller scan and an explicit successor, rollback route, or exact
operator-authorized terminal retirement.

## Reporting and continuation

Keep reporting proportional to the work and evidence. Material progress uses
`Delta / Next`. Terminal reporting uses `Outcome / Residual / Next`; a
coordinator terminal adds one `Zoom-out` line connecting the owner-local result
to the governing outcome. Preserve evidence classes, authority continuity, one
writer, current issue/PR/check/review/merge/readback truth, and claim ceilings;
wording never substitutes for delivery.

For a sparse `continue` instruction or a pasted or followed recommendation,
reload the governing parent or owner outcome, then select the largest unclosed
outcome inside the current authority boundary. Do not default to the last local
recommendation.

## Native commands

```bash
make review
make test
make validate-owner-convergence
make validate-compare-scorecards CONSUMERS="../repo-auditor ../repo-optimizer"
make validate-bma-researcher-skill
```
