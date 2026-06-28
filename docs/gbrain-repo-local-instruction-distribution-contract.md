# GBrain Repo-Local Instruction Distribution Contract

> Version: 1.0
> Date: 2026-06-07
> Owner: repo-agent-core

## Purpose

This contract defines how advisory GBrain records may be distributed into
repo-local instruction surfaces such as `AGENTS.md`, repository agent
instructions, pull request templates, and issue templates.

Distribution means copy-sync or citation only. It is not a runtime dependency,
scheduler, controller, queue, daemon, background sync, MCP server, import
framework, canonical memory promotion, or automatic updater.

The first adopter is BMA Issue #164 child Issue #515, which tests whether
bounded advisory GBrain records can improve repo-local instruction surfaces
across the core-five repos while keeping GitHub, the operator, and repo evidence
as the owner truth.

Consumers use this contract by copy-sync or citation only.

Related contract: `docs/native-evidence-before-verdict-contract.md`.

## Distribution Shape

A valid distribution has six foreground phases:

1. Identify the repo-local instruction surfaces that already exist.
2. Retrieve the relevant advisory GBrain records with bounded foreground reads.
3. Check that every record used has source or citation references.
4. Copy or cite only decision-relevant guidance into the repo-local surfaces.
5. Validate the resulting repo-local surfaces with repo-native checks.
6. Route stale, missing, uncited, or overclaiming guidance to the owner surface
   that can repair it.

Allowed native GBrain commands are foreground `gbrain stats`, `gbrain search`,
`gbrain query`, `gbrain get`, `gbrain graph`, `gbrain backlinks`, and
`gbrain timeline` for retrieval. A consuming proof may also use bounded
foreground `gbrain put`, `gbrain link`, `gbrain timeline-add`, and
`gbrain embed` only when the work issue explicitly approves small advisory
GBrain writes.

Forbidden commands and modes include bulk import, `sync --watch`,
`sync --install-cron`, `autopilot`, `dream`, `jobs work`, MCP serving,
minions, daemons, watchers, schedulers, queues, hidden registries, background
memory behavior, and automatic downstream mutation.

## Receipt Shape

A distribution receipt should include:

| Field | Required meaning |
|---|---|
| artifact | Literal `GBRAIN_REPO_LOCAL_INSTRUCTION_DISTRIBUTION`. |
| schema_version | Receipt shape version; currently `1`. |
| generated_at | UTC timestamp for the receipt. |
| source_issue_or_contract | Work issue, PR, or contract that authorized distribution. |
| consuming_repo | Repo receiving copied or cited guidance. |
| instruction_surfaces | Repo-local surfaces reviewed or changed. |
| gbrain_records_used | Advisory GBrain slugs copied or cited. |
| source_refs_checked | Source, citation, or provenance references checked for each record. |
| advisory_status | Must state that GBrain remains advisory. |
| canonical_override_allowed | Must be `false`. |
| background_gbrain_behavior_used | Must be `false`. |
| repo_native_validation | Commands and check results from the consuming repo. |
| native_evidence_before_verdict | How the consuming instruction surface preserves the rule that docs readback is necessary but not sufficient before adoption/readiness/fallback verdicts. |
| owner_routing | Next owner-surface action for stale, missing, uncited, or overclaiming guidance. |
| bounded_non_claims | Statements bounding what the distribution does not claim or automate. |

## Validation Rules

A valid distribution:

1. Names the existing repo-local instruction surfaces it touched or deliberately
   skipped.
2. Uses GBrain only as advisory memory. GBrain output does not override
   operator intent, GitHub issue/PR/check/merge truth, local repo evidence, or
   the consuming repo's existing instructions.
3. Requires source, citation, provenance, or GitHub surface references before a
   GBrain record can influence a repo-local instruction.
4. Preserves advisory boundary language wherever GBrain is referenced.
5. Forbids canonicality-promoting claims such as "GBrain is canonical",
   "GBrain is source of truth", or "GBrain overrides local instructions".
6. Forbids background GBrain behavior, bulk import, sync/watch, cron, autopilot,
   dream, jobs worker, MCP serving, minions, daemons, schedulers, queues, hidden
   registries, and automatic updater behavior.
7. Validates through the consuming repo's native checks, tests, review surface,
   or documented no-check reason.
8. Routes failed or ambiguous guidance to the semantic owner surface instead of
   creating a local proof hunt or hidden control plane.
9. Preserves native evidence before verdict guidance when the distributed
   learning concerns an external system, upstream tool, library, product, or
   native capability: current upstream docs/root instructions are necessary but
   not sufficient; adoption/readiness/fallback verdicts require a safe
   documented native attempt or concrete owner-surface blocker carried on the
   verdict-bearing surface.

## Bounded Non-Claims

Every distribution should include clauses equivalent to:

- This distribution does not make GBrain canonical.
- This distribution does not let GBrain override operator intent, GitHub truth,
  repo evidence, or repo-local instructions.
- This distribution does not prove human acceptance.
- This distribution does not bulk-import a corpus.
- This distribution does not run `sync --watch`, cron, autopilot, dream, jobs
  worker, MCP serving, minions, daemons, schedulers, queues, hidden registries,
  or background memory behavior.
- This distribution does not mutate downstream target repos.
- This distribution does not add a runtime dependency, scheduler, controller,
  queue, daemon, MCP server, generated registry, or background sync mechanism.
- This distribution does not let docs readback, local doctor output, retained
  reports, or model summaries substitute for native evidence before verdict.

## Owner Routing

Use the semantic owner surface for failed distribution lanes:

- Advisory record missing, stale, uncited, or overclaiming: GBrain record owner
  or the GitHub issue/PR that needs to repair the source claim.
- Consuming repo instruction surface gap: the consuming repo.
- Shared distribution contract gap: repo-agent-core.
- Overclaim detection gap: repo-auditor.
- Adoption recommendation packaging gap: repo-upgrade-advisor.
- Patch/materialization or optimization proof gap: repo-optimizer.

## Copy-Sync Boundary

Consumers may copy this contract, copy the template, or cite either artifact in
their own instruction surfaces and receipts. Copy drift is repo quality debt.
Do not add a runtime dependency, generated registry, scheduler, queue,
controller, daemon, watcher, retry loop, automatic updater, background sync,
MCP server, or import framework to keep copies aligned.
