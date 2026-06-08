# GBrain Advisory Pilot Outcome Learning Loop Contract

> Version: 1.0
> Date: 2026-06-08
> Owner: repo-agent-core

## Purpose

This contract defines the shared receipt shape for replaying and, only when
justified, capturing advisory GBrain learning from bounded Issue #164 pilot
outcomes. It composes these existing primitives:

- `docs/foreground-learning-and-recovery-contract.md`
- `docs/gbrain-retrieval-citation-lifecycle-contract.md`
- `docs/downstream-read-only-recovery-runtime-pilot-contract.md`
- `docs/hermes-foreground-repo-star-pilot-reliability-contract.md`

The contract is a receipt and owner-routing surface, not a runner, scheduler,
controller, queue, daemon, hidden registry, background sync, MCP server, memory
daemon, import framework, or automatic updater. Consumers may copy-sync or cite
this contract, schema, or template.

## Learning Loop Shape

A valid pilot-outcome learning loop has five foreground phases:

1. Identify the pilot outcomes being replayed, including GitHub issue/PR truth
   and any run-root receipts.
2. Run bounded sequential advisory GBrain reads only when memory could change a
   route, recommendation, or capture decision.
3. Classify each pilot outcome as decision-changing, no-capture, stale,
   contradictory, failed lookup, or capture-candidate evidence.
4. If capture is approved by the work issue, write at most the bounded advisory
   records allowed by that issue using `draft` or `shadow_canonical` state only.
5. Record citation/source-ref quality, owner routing, and bounded non-claims on
   the GitHub issue or PR surface that owns the work.

Allowed native GBrain commands for read-only replay are foreground `gbrain stats`,
`gbrain search`, `gbrain query`, and `gbrain get`. When the work issue
explicitly approves small advisory capture, a consuming proof may also use
bounded foreground `gbrain put`, `gbrain link`, `gbrain timeline-add`, and
`gbrain embed` for the admitted slugs only.

Forbidden commands and modes include bulk import, `sync --watch`,
`sync --install-cron`, autopilot, dream, `jobs work`, MCP serving, minions,
daemons, watchers, schedulers, queues, hidden registries, background memory
behavior, automatic GitHub issue creation, downstream mutation, and automatic
patch application.

## Receipt Shape

A pilot outcome learning-loop receipt should include:

| Field | Required meaning |
|---|---|
| artifact | Literal `GBRAIN_ADVISORY_PILOT_OUTCOME_LEARNING_LOOP_RECEIPT`. |
| schema_version | Receipt shape version; currently `1`. |
| generated_at | UTC timestamp for the receipt. |
| source_issue_or_pr | GitHub issue, PR, or contract that authorized the replay. |
| proof_root | Scratch receipt root, usually under `/tmp`. |
| advisory_status | Must state that GBrain remains advisory. |
| related_contracts | Contract files or URLs consumed by citation/copy-sync. |
| pilot_outcomes | Issue/PR/run-root outcomes replayed, with raw evidence and decision impact. |
| gbrain_read_commands | Sequential foreground read commands and receipts. |
| gbrain_capture_candidates | Candidate slugs with state, source refs, and admission decision. |
| capture_summary | Counts for candidate, written, rejected, and canonical records. |
| citation_summary | Citation/source-ref quality for replayed outcomes and capture candidates. |
| learning_recovery_blocks | GitHub-surface Learning / Recovery blocks or no-capture reasons. |
| owner_routing | Next owner-surface action for stale memory, failed lookup, contract, detector, advisor, or materializer gaps. |
| no_background_commands_used | Boolean proof boundary. |
| bounded_non_claims | What this receipt does not prove or authorize. |

## Validation Rules

A valid pilot-outcome learning-loop receipt:

1. Anchors every learning claim to a GitHub surface and raw evidence.
2. Records a GBrain slug only for reusable decision-changing learning; routine
   validation, null lookup, or duplicate learning uses an explicit no-capture reason.
3. Runs GBrain lookup sequentially and records command status instead of
   parallelizing GBrain access.
4. Writes no canonical records; `canonical_records_written` must be `0`.
5. Allows only `draft` and `shadow_canonical` capture states.
6. Requires source/citation/provenance or GitHub surface references for any
   capture candidate that can affect future repo-local guidance.
7. Routes stale, contradictory, missing, uncited, or failed GBrain evidence to
   the semantic owner surface instead of making GBrain authoritative.
8. Keeps downstream targets read-only and writes run artifacts outside targets.
9. Does not claim long-term retention, broad downstream adoption, human
   acceptance, savings, or fleet quality without separate proof.

## Owner Routing

Use the semantic owner surface for failed or partial proof lanes:

- GBrain runtime, lookup, write, or citation failure: GBrain owner surface or
  the consuming repo's GitHub issue.
- Shared learning-loop contract gap: repo-agent-core.
- BMA Issue #164 campaign replay, run-root, or validator gap:
  build-meta-analysis.
- Unanchored self-learning or GBrain overclaim detection gap: repo-auditor.
- Recommendation packaging gap for AS-32, GBrain learning, no-capture, or owner
  routing: repo-upgrade-advisor.
- LR-01 foreground Learning / Recovery patch-pack or dry-run apply gap:
  repo-optimizer.

## Bounded Non-Claims

Every receipt should include clauses equivalent to:

- This receipt does not make GBrain canonical.
- This receipt does not write canonical records.
- This receipt does not bulk-import a corpus.
- This receipt does not start or require sync/watch, cron, autopilot, dream,
  jobs worker, MCP serving, minions, daemons, schedulers, queues, hidden
  registries, or background memory behavior.
- This receipt does not mutate downstream target repos.
- This receipt does not authorize automatic GitHub issue creation, automatic
  patch application, auto-merge, or downstream PRs/issues.
- This receipt does not prove long-term retention, broad downstream adoption,
  human acceptance, cost savings, or fleet-wide quality.

## Copy-Sync Boundary

Consumers may copy this contract, copy the template, validate the schema, or
cite the artifacts in their own proof receipts. Copy drift is repo quality debt.
Do not add a runtime dependency, generated registry, scheduler, queue,
controller, daemon, watcher, retry loop, automatic updater, background sync,
MCP server, or import framework to keep copies aligned.
