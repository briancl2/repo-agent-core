# GBrain Repo-Local Instruction Distribution Contract

> Version: 1.0
> Date: 2026-06-07
> Owner: repo-agent-core

## Purpose

This contract defines the copy-sync shape for distributing advisory GBrain
learning into repo-local instruction surfaces such as `AGENTS.md`, existing
GitHub instructions, and existing issue or pull request templates.

The contract is not a runtime dependency, import framework, scheduler, queue,
controller, daemon, watcher, retry loop, background sync, MCP server, generated
registry, or canonical-memory claim. Consumers cite or copy this guidance when
they want repo-local agents to know how to use GBrain distribution records
without treating GBrain as authority.

## Distribution Shape

A valid repo-local instruction distribution has five foreground phases:

1. Identify the repo-local instruction surfaces that already exist.
2. Cite the source issue, PR, or contract that authorized the distribution.
3. Add compact guidance for advisory GBrain retrieval and citation.
4. Preserve explicit non-claims: GBrain is not canonical and background GBrain
   behavior remains forbidden.
5. Validate with the consuming repo's native checks and route any stale or
   missing guidance to the semantic owner surface.

Consumers should prefer the smallest existing surface that a fresh worker will
actually read. `AGENTS.md` is the default surface when present.
Existing `.github/copilot-instructions.md`, pull request templates, issue templates,
or agent prompts may cite the guidance only when they already carry comparable
repo-local workflow rules. Do not create a broad new instruction system only for symmetry.

## Required Instruction Clauses

Repo-local guidance that references GBrain distribution should include clauses
equivalent to:

- GBrain distribution records are advisory memory and do not override operator intent,
  GitHub issue/PR/check/merge truth, repo files, or repo-native tests.
- Retrieval that affects a decision should cite the GBrain slug or record an
  explicit no-capture/no-hit reason on the GitHub issue or PR surface.
- Source/citation expectation: use source refs, PR/issue links, or contract
  links from the retrieved record when a claim depends on GBrain memory.
- Allowed record states for distribution proof are `draft` and
  `shadow_canonical`; canonical records written must remain `0` unless a later
  human-accepted contract changes that gate.
- Background GBrain behavior is forbidden: no bulk import, `sync --watch`,
  cron, autopilot, dream, jobs worker, MCP serving, minions, daemons, queues,
  schedulers, hidden registries, or automatic downstream mutation.
- If retrieval, citation, freshness, or instruction drift blocks work, route to
  the semantic owner surface instead of creating a local proof hunt.

## Receipt Shape

A distribution receipt should include:

| Field | Required meaning |
|---|---|
| artifact | Literal `GBRAIN_REPO_LOCAL_INSTRUCTION_DISTRIBUTION`. |
| schema_version | Receipt shape version; currently `1`. |
| generated_at | UTC timestamp for the receipt. |
| source_issue_or_contract | Issue, PR, or contract authorizing the distribution. |
| contract_url | Link or path to this contract. |
| repos_updated | Repos whose local instruction surfaces changed. |
| instruction_surfaces_updated | Exact files changed per repo. |
| gbrain_records_referenced | Advisory distribution record slugs cited or relied on. |
| citation_expectation | How future agents should cite GBrain source refs or no-hit reasons. |
| advisory_status | Must state that GBrain remains advisory. |
| canonical_records_written | Count of canonical records written; must be `0`. |
| background_behavior_used | Must be `false`. |
| validation | Repo-native validation commands and outcomes. |
| owner_routing | Next owner-surface action for stale guidance, missing citations, or overclaims. |
| bounded_non_claims | Statements bounding what the distribution does not prove or automate. |

## Validation Rules

A valid distribution proof:

1. Updates only approved repo-local instruction surfaces.
2. Does not create new broad instruction systems merely for symmetry.
3. Uses this contract by copy-sync or citation only.
4. Keeps GBrain advisory and records `canonical_records_written` as `0`.
5. Includes a citation/source-ref expectation for decision-changing GBrain use.
6. Forbids background GBrain commands and any controller, queue, scheduler,
   daemon, watcher, retry loop, registry, MCP server, or automatic updater.
7. Runs the consuming repo's native validation before claiming adoption.
8. Routes missing, stale, or overclaiming guidance to the semantic owner
   surface: repo-agent-core for this shared contract, repo-auditor for drift or
   overclaim detection, repo-upgrade-advisor for recommendation packaging, and
   the consuming repo for local instruction fixes.

## Bounded Non-Claims

Every distribution receipt should include clauses equivalent to:

- This distribution does not make GBrain canonical.
- This distribution does not write canonical records.
- This distribution does not prove long-term retention, human acceptance, or
  distribution completeness beyond the measured repo set.
- This distribution does not bulk-import a corpus.
- This distribution does not run `sync --watch`, cron, autopilot, dream, jobs
  worker, MCP serving, minions, daemons, schedulers, queues, hidden registries,
  or background memory behavior.
- This distribution does not mutate downstream target repos.

## Copy-Sync Boundary

Consumers may copy this contract, copy the template, or cite either artifact in
their own repo-local guidance. Copy drift is repo quality debt. Do not add a
runtime dependency, generated registry, scheduler, queue, controller, daemon,
watcher, retry loop, automatic updater, background sync, MCP server, or import
framework to keep copies aligned.
