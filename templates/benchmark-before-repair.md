# Benchmark-Before-Repair Record

```json
{
  "artifact": "BENCHMARK_BEFORE_REPAIR_RECORD",
  "schema_version": 1,
  "benchmark_dimensions": [
    "D1 governance",
    "D2 surface health",
    "D3 skill maturity",
    "D4 measurement",
    "D5 self-improvement"
  ],
  "defined_before_selection": true,
  "repair_candidates": [
    "P9 fail-closed work-close",
    "P11 CI concurrency",
    "P12 grounded route-changes",
    "responder-truth"
  ],
  "selected_repair": "P9 fail-closed work-close gate (highest governance/autonomy-safety gap)",
  "rejected_repairs": [
    "P11 CI concurrency deferred; important but lower governance gap than P9",
    "P12 grounded route-changes deferred until fail-closed closure semantics exist",
    "responder-truth deferred; depends on closure and route-change ground truth"
  ],
  "selection_changed": true,
  "before_after_delta": "pending (report-only sweep); composite baseline 65/100",
  "decision_state": "adopt",
  "bounded_non_claims": [
    "n=2 observation (portfolio_advisor + transcript_processor), not proven cross-repo doctrine",
    "benchmark proves repair-selection discipline, not domain-quality improvement",
    "does not query or mutate GitHub",
    "does not create issues or pull requests",
    "does not merge pull requests or close issues",
    "does not start a daemon, scheduler, queue, controller, or hidden registry",
    "does not mutate downstream repos",
    "does not select repairs automatically",
    "does not replace GitHub issue/PR/check/merge truth"
  ]
}
```

This template is for copy-sync or citation. It is not a schema mandate, runtime
dependency, generated inventory, controller, scheduler, queue, daemon, registry,
or closure surface. The values above are grounded in the transcript_processor
system-maturation campaign (the n=2 by-hand campaign); copy-sync consumers
replace them with their own repo's benchmark-before-repair record.
