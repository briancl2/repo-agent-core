# Repair Decision-Block Record

```json
{
  "artifact": "REPAIR_DECISION_BLOCK_RECORD",
  "schema_version": 1,
  "outcome": "autonomous work cannot silently close with an unsatisfied gate",
  "failing_observable": "work-close.sh allowed closure when review/critique/hypothesis attestations were empty or unknown",
  "rejected_alternatives": [
    {
      "alternative": "global SKIP_REVIEW bypass",
      "rejected_because": "waives all three attestations; only review can be externally unavailable"
    },
    {
      "alternative": "documentation-only reminder",
      "rejected_because": "does not change the failing closure observable or make empty attestations fail closed"
    },
    {
      "alternative": "treat unknown work type as routine hygiene",
      "rejected_because": "first-in-family maturation gate needs explicit adoption proof rather than silent pass-through"
    }
  ],
  "expected_metric": "undeclared/empty Work Type is GATED; reasoned per-leg escape recorded; fixture proves both paths",
  "issue_branch_pr_check_path": "transcript_processor #33 -> branch -> PR #39 -> preflight check -> squash-merge afcb5e9",
  "bounded_non_claim": "a fail-closed GATE, not a new closeout/SER/handoff stack; proves operating-model progress, not domain capability",
  "triggers_decision_block": true,
  "decision_state": "adopt",
  "record_bounded_non_claims": [
    "n=2 observation (portfolio_advisor + transcript_processor), not proven cross-repo doctrine",
    "does not query or mutate GitHub",
    "does not replace GitHub issue/PR/check/merge truth",
    "does not create issues or pull requests",
    "does not merge pull requests or close issues",
    "does not start a daemon, run a scheduler, create a queue, create a controller, create a hidden registry, or mutate downstream repos"
  ]
}
```

This template is for copy-sync or citation. It is not a schema mandate, runtime
dependency, generated inventory, controller, scheduler, queue, daemon, registry,
or closure surface. The values above are grounded in the transcript_processor P9
fail-closed work-close gate maturation repair; copy-sync consumers replace them
with their own repair decision-block record.
