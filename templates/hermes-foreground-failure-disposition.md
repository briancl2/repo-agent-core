# Hermes Foreground Failure Disposition

Use this template after a foreground Hermes failure has already been converted
to GitHub issue truth. The disposition decides close, keep-open, or blocker
state; it does not create issues, close issues, retry Hermes, or repair code by
itself.

## Disposition Fields

- failure issue: <GitHub issue URL/number/state>
- primary object: <failed PR | issue | command | prompt | receipt | target | check>
- related repair PRs: <PR URLs/numbers/states/merge commits>
- command family: <usually hermes-foreground>
- failure code: <normalized failure code>
- classification: <resolved_by_merged_repair | still_blocked | superseded_by_provider_policy | invalid_for_closure>
- close allowance: <true | false>
- recommended action: <close with merged repair evidence | keep open with blocker | refuse closure>
- blocker evidence: <specific blocker items or none>
- provider-policy evidence: <current provider/model policy evidence plus explicit superseded signal, or none>
- GitHub truth: <issue/PR/comment/check URLs carrying the disposition>
- promotion trigger: <evidence that makes this reusable>
- demotion trigger: <false-close path, ambiguity, stale policy, or control-plane drift>
- kill switch: <condition that disables this disposition until repaired>
- bounded non-claims: <see below>

## Closure Rules

- A merged related PR may close the failure only when exactly one merged PR
  references the failure issue itself.
- Primary-object URL equality alone is not repair evidence.
- Missing PR evidence, unmerged PR evidence, ambiguous merged PR evidence, and
  merged PRs that do not reference the failure issue are non-close evidence.
- Partial provider-policy residue remains blocker evidence even when merged
  repair-looking PR evidence is present.
- Provider-policy supersession requires both an explicit superseded-provider signal
  and current provider/model policy evidence.

## Bounded Non-Claims

This disposition is not Hermes promotion, not `hermes -z` adoption, not
automatic closure, not a retry loop, not background repair, not CI proof beyond
cited checks, and not downstream mutation authority. It forbids controller,
scheduler, queue, daemon, registry, hidden registry, auto-close, auto-merge,
automatic issue/PR creation, background Hermes/GBrain behavior,
Hermes-primary authority, upstream Hermes mutation, downstream mutation,
target mutation, and runtime dependency behavior.
