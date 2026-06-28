# Upstream Capability Intake Contract

> Version: 1.0
> Date: 2026-06-06
> Owner: repo-agent-core

## Purpose

This contract defines the shared copy-sync language for compact upstream
capability intake records across the repo-agent fleet. Use it when a repo needs
to decide whether a newer upstream, platform, or owner-repo capability should be
adopted, deferred, quarantined, routed to another owner surface, or used to
delete/sunset local custom tooling.

It is guidance for issue bodies, PR bodies, docs, templates, fixtures, and
retained evaluation records. It is not a runtime package, schema mandate,
generated inventory, scheduler, queue, controller, watcher, daemon, background
sync, automatic updater, or mutation authority.

Related contract: `docs/native-evidence-before-verdict-contract.md`.

## Required Record

| Field | Required meaning |
|---|---|
| Component identity | Named component, repo, package, tool, skill, model, or platform surface being evaluated. |
| Local version | Current local version, commit, branch, config, command path, or installed release that the repo actually uses. |
| Upstream reference | Upstream repo, release, issue, PR, commit, docs page, or vendor/source artifact used as comparison truth. |
| Behindness signal | Exact reason the local surface may be behind, divergent, duplicated, stale, unsafe, or already covered by a native capability. |
| Source refs | Bounded references used for the decision, with enough detail for a later reviewer to distinguish official/source evidence from local inference. |
| Current upstream docs/root instructions checked | README, root agent instructions, install/setup guidance, official docs, upstream issue/PR/release refs, or documented no-surface reason checked before a verdict. |
| Native evidence before verdict | Safe documented native setup/use attempt, native command/workflow, or concrete owner-surface blocker required before adoption/readiness/fallback/production/GA/cutover/architecture judgment. |
| Delta clusters | Grouped capability differences, not a raw exhaustive changelog. Each cluster should say why it matters to the owner repo. |
| Capability decisions | Per-cluster decision: adopt, defer, quarantine, owner-route, delete/sunset, no-op, or needs proof. |
| Update action | Exact next action: update, pin, leave unchanged, delete/sunset local surface, open owner issue, open PR, or record blocked. |
| Validation | Repo-native checks, foreground smoke, fixture, replay, or proof receipt required before the decision changes production guidance. |
| Adoption-plan refs | Issue, PR, docs, package, retained report, or owner-route reference that carries the resulting action. |
| Owner routes | Semantic owner surface for each action that does not belong in the intake repo. |
| Non-claims | Explicit boundaries for what the intake did not prove, mutate, adopt, delete, automate, or authorize. |
| Out-of-bounds surfaces | Surfaces intentionally excluded from the intake, such as downstream repos, private data, background jobs, broad package upgrades, or unauthenticated sources. |

## Decision States

| State | Meaning |
|---|---|
| Adopt | The upstream capability is decision-grade for the named owner use after required validation. |
| Defer | The capability is plausible but not worth or ready for this owner batch. |
| Quarantine | The upstream capability or local path is unsafe, failing, ambiguous, blocked, or not production-grade. |
| Owner-route | The next action belongs on another repo, upstream project, issue, PR, or operator surface. |
| Delete/sunset | A native or owner capability makes a local custom surface removable, wrappable, or explicitly deprecated after validation. |
| No-op | Current local behavior remains correct for the named scope. |
| Needs proof | The intake found a candidate but not enough evidence to change guidance. |

## Proof Rules

An intake record is not proof by itself. A decision that changes production
guidance needs current local validation on the owner repo or an explicit
owner-route that names where proof must happen.

For external-system, upstream-tool, library, product, or native-capability
verdicts, upstream docs/root instructions are necessary but not sufficient.
Adoption, readiness, fallback, production, GA, cutover, architecture, repair,
downgrade, or replacement verdicts require a safe documented native attempt or
a concrete owner-surface blocker, and the verdict-bearing surface must carry
real command output, native result evidence, or the blocker. Negative claims
such as not-production-ready, not-GA, or fallback-required are verdicts too.

Behindness may be discovered from search, source docs, upstream issues, local
versions, or retained evidence, but the record must distinguish verified source
facts from local inference. Do not treat a raw changelog, generated inventory,
or model summary as sufficient by itself.

If the intake finds a known owner surface for a blocker, route the blocker
there. Do not build a new local controller, scheduler, queue, watcher, daemon,
background sync, hidden registry, retry loop, automatic updater, or generated
inventory just to preserve the intake.

## Copy-Sync Boundary

Consumers may copy this contract, copy the template, or cite either artifact
from repository docs. Copy drift is repo-quality debt. Do not introduce a
runtime import, schema lock, generated registry, crawler, watcher, scheduler,
queue, controller, cron job, automatic GitHub mutation, or background sync to
keep copies aligned.
