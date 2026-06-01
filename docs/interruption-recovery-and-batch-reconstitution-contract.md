# Interruption Recovery And Batch Reconstitution Contract

> Version: 1.0
> Date: 2026-06-01
> Owner: repo-agent-core

## Purpose

This contract defines the shared record shape for preserving a Goal-mode or
multi-PR episode when an upstream, tool, CI, permission, or owner-surface
blocker interrupts the original route. It is copy-sync guidance for GitHub
issues, PR bodies, issue comments, and repo-local docs. It is not a runtime
package, service, scheduler, queue, controller, background job, retry loop, or
mandatory dependency.

Use it when an episode cannot continue on its original path but the authorized
scope still contains a concrete owner-surface alternative. The recovery record
must keep the batch coherent: one blocker, one replacement objective, one first
owner PR, and one validation plan.

## Required Record

| Field | Required meaning |
|---|---|
| Original objective | Exact Goal objective, issue objective, or PR sequence that was interrupted. |
| Blocker class | One of `upstream_blocker`, `tool_runtime_failure`, `ci_failure`, `permission_boundary`, `owner_surface_blocker`, `validation_blocker`, or `unknown_blocker`. |
| Goal state | Whether the Goal stayed active, was completed, was blocked, or was unavailable. |
| Replacement objective | The concrete objective that keeps the batch moving inside the approved scope. |
| First owner PR | The next owner-repo PR or issue shape; not a category or request for operator selection. |
| Intentional serial/parallel plan | Whether the remaining work is intentionally serial, intentionally parallel, or stopped. |
| Learning trigger | The event that makes this reusable learning rather than routine validation noise. |
| Fallback | The exact stop/convert action if the replacement route fails. |
| Validation | Repo-native checks, CI, and campaign sync expected before the episode is considered recovered. |

## Recovery Rules

1. Preserve GitHub issue/PR/check/merge truth as the active state.
2. Convert the concrete blocker to owner GitHub issue truth before fallback work
   finishes when the blocker changes the route.
3. Do not silently shrink a multi-PR episode into ad hoc single-PR continuation.
4. Do not ask the operator to pick a category when the owner surface and first
   deliverable are known.
5. Keep recovery inside the approved mutation boundary. A fresh permission boundary stops the affected episode.
6. A retrospective may evaluate the recovery later, but it is not the primary
   repair when a direct owner-surface action is known.

## Blocker Classes

| Blocker class | Use |
|---|---|
| `upstream_blocker` | Required upstream fix, release, merge, or version proof is unavailable. |
| `tool_runtime_failure` | Foreground tool cannot launch, hangs, returns no usable output, or lacks required executable/runtime. |
| `ci_failure` | Owner PR CI fails and needs a repo-local repair. |
| `permission_boundary` | The next useful mutation is outside current approval. |
| `owner_surface_blocker` | The semantic owner repo or issue is blocked by missing contract, fixture, or artifact. |
| `validation_blocker` | Local or deterministic gate fails and blocks merge readiness. |
| `unknown_blocker` | The blocker is real but not yet classifiable; use only until triaged. |

## Copy-Sync Boundary

Consumers may copy this contract or cite it from repository docs. Drift is a
repo-quality issue. Do not introduce a runtime import, generated registry,
watcher, scheduler, queue, controller, cron job, retry loop, daemon, or
background sync to keep copies aligned.
