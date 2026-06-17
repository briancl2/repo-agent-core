# Foreground Learning And Recovery Contract

This contract defines the shared copy-sync record for claiming that an
agentic episode learned, self-healed, or improved itself during foreground work.
It is intentionally small: the point is to anchor learning in GitHub issue/PR
truth and bounded evidence without adding a memory daemon, controller,
scheduler, queue, registry, or background sync loop.

Use it when a blocker, validation result, operator correction, Hermes attempt,
GBrain lookup, CI failure, or owner-surface issue changes the implementation
route. Do not use it for routine validation success, null memory searches, or
generic "we learned" narration that did not change a decision.

## Required Fields

| Field | Meaning |
|---|---|
| Decision changed | The concrete decision that changed because of the learning or recovery event. Use `none` only when the block is present to document why no learning capture happened. |
| GitHub surface | Issue, PR, check run, review thread, or comment that now owns the learning or blocker truth. |
| Raw evidence | Session log, command receipt, CI/check link, validator output, or retained owner-repo artifact that supports the claim. |
| Optional GBrain slug | GBrain learning slug only when a bounded foreground capture occurred because the learning is reusable and decision-changing. |
| No-capture reason | Required when no GBrain slug is present; explain why the event was routine, duplicate, local-only, or not reusable. |
| Fallback without memory | The owner route that would have been chosen without advisory GBrain evidence. |
| Reusable learning text | One concise sentence that can guide a future agent decision. Use `none` when no reusable learning exists. |
| Owner action | Exact owner surface issue, PR, or patch route created or changed by the learning. |
| Bounded non-claims | What this record does not prove or authorize. |

## Rules

1. Foreground learning must be tied to a GitHub surface or explicit raw
   evidence. A self-learning claim with neither is unanchored.
2. Capture to GBrain only when the learning is reusable and decision-changing.
   Capture is natural-only foreground capture, not a launch ritual or forced
   dogfood card. Routine "no learning" notes, null searches, and validation
   success should use `No-capture reason`.
3. GBrain is advisory memory, not closure truth. GitHub issue/PR/check/merge
   state remains the owner surface for campaign and delivery truth. GitHub issue/PR/check/merge state remains the owner surface.
4. When foreground GBrain capture occurs, exact-read the slug back with
   `gbrain get` and record the slug before relying on it. Broad search miss is
   not proof that an exact handle is absent.
5. Self-healing is not a retrospective request by default. If the owner blocker
   is known, route to owner action first.
6. The contract does not authorize `gbrain sync --watch`, cron, jobs, minions,
   MCP serving, autopilot, background memory behavior, daemon behavior, queues,
   schedulers, controllers, or automatic target-repo mutation.

## Completion Check

A foreground learning/recovery block is complete when it names either a
decision-changing GBrain slug or a no-capture reason, links the GitHub surface
that owns the truth, names the fallback without memory, and names the owner
action or explicitly says why no owner action exists.
