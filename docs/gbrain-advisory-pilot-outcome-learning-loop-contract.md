# GBrain Advisory Pilot Outcome Learning Loop Contract

> Version: 2.0
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

A valid pilot-outcome learning loop has seven foreground phases:

1. Identify the pilot outcomes being replayed, including GitHub issue/PR truth
   and any run-root receipts.
2. Run bounded sequential advisory GBrain reads only when memory could change a
   route, recommendation, or capture decision.
3. Record semantic search/query disposition before relying on exact handles:
   query text, status, matched or missed slugs, weakness reason, and whether the
   fallback without memory would still choose the same owner action.
4. Replay admitted exact handles one at a time with `gbrain get`, checking each
   slug's advisory state, source/citation/provenance references, decision
   impact, and fallback without memory.
5. Classify each pilot outcome as decision-changing, no-capture, stale,
   contradictory, failed lookup, or capture-candidate evidence.
6. If capture is approved by the work issue, use natural-only foreground
   capture: write at most the bounded advisory records allowed by that issue
   using `draft` or `shadow_canonical` state only, then exact-read each written
   slug back with `gbrain get` before relying on it.
7. Record citation/source-ref quality, owner routing, canonicality checks,
   forbidden background command non-use, and bounded non-claims on
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
| schema_version | Receipt shape version; currently `2` for exact-handle replay fields. |
| generated_at | UTC timestamp for the receipt. |
| source_issue_or_pr | GitHub issue, PR, or contract that authorized the replay. |
| proof_root | Scratch receipt root, usually under `/tmp`. |
| advisory_status | Must state that GBrain remains advisory. |
| related_contracts | Contract files or URLs consumed by citation/copy-sync. |
| capture_posture | Natural-only foreground capture; no forced launch card, canonical record, broad-search-as-absence claim, or background GBrain behavior. |
| pilot_outcomes | Issue/PR/run-root outcomes replayed, with raw evidence and decision impact. |
| semantic_search_disposition | Search/query attempts, status, missed or weak retrieval, and no-memory fallback. |
| exact_handle_replay | Exact `gbrain get` rows with slug, advisory state, source/citation/provenance checks, decision impact, and fallback without memory. |
| gbrain_read_commands | Sequential foreground read commands and receipts. |
| gbrain_capture_candidates | Candidate slugs with state, source refs, and admission decision. |
| capture_summary | Counts for candidate, written, rejected, and canonical records. |
| frontmatter_readback_check | Foreground capture exact-readback proof for YAML/frontmatter scalar preservation, especially required provenance fields containing GitHub issue references or `#` characters. |
| citation_summary | Citation/source-ref quality for replayed outcomes and capture candidates. |
| canonicality_check | Explicit proof that records stayed advisory and `canonical_records_written` stayed `0`. |
| forbidden_background_commands | Forbidden command tokens/classes checked and whether any were used. |
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
4. Records semantic search/query weakness separately from exact-handle replay
   success; exact handles may inform launch decisions only when fallback without
   memory is stated.
5. Requires each exact-handle replay row to include `slug`, `get_status`,
   `decision_impact`, and `fallback_without_memory`; successful `get_status=ok`
   rows must also include `advisory_state`, `source_refs_checked`,
   `citation_refs_checked`, and `provenance_refs_checked`, while failed or
   missing rows may truthfully report unknown state and empty refs.
6. Requires natural-only foreground capture when capture is admitted; exact-read
   each written slug back with `gbrain get` and record the readback before
   relying on it.
7. Writes no canonical records; `canonical_records_written` must be `0`.
8. Allows only `draft` and `shadow_canonical` capture states.
9. Requires source/citation/provenance or GitHub surface references for any
   capture candidate that can affect future repo-local guidance.
10. Requires foreground advisory capture to protect YAML/frontmatter scalar values
   containing GitHub issue references or `#` characters: quote those values or
   keep issue-heavy provenance in body/JSON fields. The guarded failure mode is
   an unquoted value such as `source_batch: Issue #164 ...` exact-reading back
   as `source_batch: Issue` because the `#` begins a YAML comment.
11. Requires exact readback checks for required provenance fields before a
    receipt or card claims capture preserved the data; the receipt should record
    `frontmatter_readback_check.status=preserved` only after comparing the
    captured card/readback against the intended values.
12. Routes stale, contradictory, missing, uncited, failed GBrain evidence, or
    failed frontmatter readback preservation to the semantic owner surface instead
    of making GBrain authoritative.
13. Keeps downstream targets read-only and writes run artifacts outside targets.
14. Does not claim long-term retention, broad downstream adoption, human
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
