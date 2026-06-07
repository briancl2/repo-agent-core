# GBrain Retrieval/Citation Lifecycle Contract

> Version: 1.0
> Date: 2026-06-07
> Owner: repo-agent-core

## Purpose

This contract defines the shared proof shape for adopting GBrain as an
advisory semantic-memory surface before any repo or agent treats GBrain output
as canonical authority. It is a receipt and evaluation contract, not a runner,
scheduler, controller, queue, daemon, background sync, MCP server, or import
framework.

The first adopter was BMA Issue #164 child Issue #512, which proved that a
small curated spine can improve seed retrieval and citation from a weak
baseline while still preserving GBrain advisory status.

Consumers use this contract by copy-sync or citation only.

## Lifecycle Shape

A valid lifecycle proof has five foreground phases:

1. Baseline native GBrain read state.
2. Curate a small bounded record set.
3. Write/update only approved draft or shadow-canonical records.
4. Add only needed typed links and timeline entries, then refresh embeddings.
5. Re-run seed-question retrieval/citation evaluation and compare before/after.

Allowed native commands are foreground `gbrain stats`, `gbrain search`,
`gbrain query`, `gbrain get`, `gbrain put`, `gbrain link`,
`gbrain timeline-add`, `gbrain timeline`, `gbrain graph`, `gbrain backlinks`,
and `gbrain embed`.

Forbidden commands and modes include bulk import, `sync --watch`,
`sync --install-cron`, `autopilot`, `dream`, `jobs work`, MCP serving,
minions, daemons, watchers, schedulers, queues, hidden registries, background
memory behavior, and automatic downstream mutation.

## Receipt Shape

A lifecycle receipt should include:

| Field | Required meaning |
|---|---|
| artifact | Literal `GBRAIN_RETRIEVAL_CITATION_LIFECYCLE`. |
| schema_version | Receipt shape version; currently `1`. |
| generated_at | UTC timestamp for the receipt. |
| proof_root | Scratch receipt root, usually under `/tmp`. |
| source_issue_or_contract | Work issue, PR, or contract that authorized the lifecycle. |
| gbrain_version | Native `gbrain` version or stats receipt identifying the runtime. |
| advisory_status | Must state that GBrain remains advisory. |
| allowed_record_states | Only `draft` and `shadow_canonical` unless a later human-accepted contract changes this. |
| canonical_records_written | Count of canonical records written; must be `0`. |
| records_written | Slugs written or updated. |
| typed_links_written | Typed links added, including from, to, type, and context. |
| timeline_entries_written | Timeline entries added, including slug, date, summary, source, and detail. |
| baseline_stats | Before-write native GBrain stats. |
| postwrite_stats | After-write native GBrain stats. |
| seed_question_count | Number of retrieval/citation seed questions evaluated. |
| baseline_expected_record_hits | Before-write expected-record hit count. |
| postwrite_expected_record_hits | After-write expected-record hit count. |
| baseline_citation_hits | Before-write citation/source-ref hit count. |
| postwrite_citation_hits | After-write citation/source-ref hit count. |
| retrieval_pass_threshold | Explicit threshold for expected-record hits. |
| citation_pass_threshold | Explicit threshold for citation/source-ref hits. |
| pass | Boolean result for the lifecycle proof. |
| command_receipts | Paths to foreground command receipts. |
| no_background_commands_used | Boolean proof boundary. |
| owner_routing | Next owner-surface action when retrieval, citation, canonicality, or command-boundary proof fails. |
| bounded_non_claims | Statements bounding what the proof does not claim or automate. |

## Validation Rules

A valid lifecycle proof:

1. Starts with a before-write native stats and seed-evaluation baseline.
2. Writes only a small approved record set; the first BMA proof used at most
   twelve `bma/issue164/spine/...` records.
3. Writes no `canonical` records and does not use frontmatter that promotes
   canonical authority.
4. Adds typed links and timeline entries only when they support retrieval,
   citation, provenance, or decision traceability.
5. Refreshes embeddings only for written slugs or another explicitly bounded
   foreground set.
6. Re-runs the same seed questions after writes and compares measured hit
   counts; do not claim savings or adoption quality without before/after
   numbers.
7. Treats GBrain as advisory until retrieval quality, citation quality, typed
   links, timeline, write parity, distribution, and human acceptance gates are
   proven.
8. Records failed, partial, or threshold-only outcomes without promoting
   canonicality or expanding into a broad import.

## Bounded Non-Claims

Every receipt should include clauses equivalent to:

- This receipt does not make GBrain canonical.
- This receipt does not write canonical records.
- This receipt does not bulk-import a corpus.
- This receipt does not run `sync --watch`, cron, autopilot, dream, jobs worker,
  MCP serving, minions, daemons, schedulers, queues, hidden registries, or
  background memory behavior.
- This receipt does not mutate downstream target repos.
- This receipt does not prove long-term retention, cross-repo distribution, or
  human acceptance unless those gates have separate receipts.

## Owner Routing

Use the semantic owner surface for failed proof lanes:

- GBrain runtime or CLI failure: GBrain owner surface.
- Seed-evaluator or local issue/PR closure proof failure: BMA or the consuming
  repo that owns the evaluator.
- Shared lifecycle contract gap: repo-agent-core.
- Overclaim detection gap: repo-auditor.
- Adoption recommendation packaging gap: repo-upgrade-advisor.
- Patch/materialization or optimization proof gap: repo-optimizer.

## Copy-Sync Boundary

Consumers may copy this contract, copy the template, or cite either artifact in
their own proof receipts. Copy drift is repo quality debt. Do not add a runtime
dependency, generated registry, scheduler, queue, controller, daemon, watcher,
retry loop, automatic updater, background sync, MCP server, or import framework
to keep copies aligned.
