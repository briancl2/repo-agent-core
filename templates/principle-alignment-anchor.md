# Principle-Alignment Anchor Record

```json
{
  "artifact": "PRINCIPLE_ALIGNMENT_ANCHOR_RECORD",
  "schema_version": 1,
  "repo_identity": {
    "repo": "transcript_processor",
    "constitution_surface": "CONSTITUTION.md",
    "existing_principles": "shared constitutional floor plus subordinate AGENTS.md and repo-local policy"
  },
  "imported_canon": {
    "canon": "BMA operating-model principle canon",
    "authority": "advisory owner-policy assessment criteria only",
    "criteria": [
      "P9 a red gate is not closure",
      "P10 CI/issue/PR state is truth",
      "P11 automation earns authority gradually",
      "P12 route-changes are grounded with fallback + runtime ref"
    ],
    "source": "https://github.com/briancl2/build-meta-analysis/issues/164"
  },
  "reconciliation_table": [
    {"criterion": "P9 red gate is not closure", "nearest_existing": "Article 5 plus owner closeout policy", "verdict": "present-but-scattered"},
    {"criterion": "P10 CI/issue/PR state is truth", "nearest_existing": "Article 3 plus CI owner policy", "verdict": "partial"},
    {"criterion": "P11 automation earns authority gradually", "nearest_existing": "Article 2; local operating policy gap", "verdict": "gap"},
    {"criterion": "P12 grounded route-changes", "nearest_existing": "Articles 4 and 6 plus LEARNINGS.md", "verdict": "gap"}
  ],
  "revealed_principles": [
    {
      "principle": "Fix detector false-positives at the rule, not by contorting product code",
      "evidence": "anti-pattern rule-5 statement-level fix and start_new_session->preexec_fn fix"
    }
  ],
  "principle_gap_matrix": [
    {"gap": "P9 fail-closed work-close gate", "severity": "high", "autonomy_merge_safety": "high", "owner_route": "transcript_processor #33"},
    {"gap": "P11 CI concurrency control", "severity": "medium", "autonomy_merge_safety": "high", "owner_route": "transcript_processor #31"},
    {"gap": "P12 grounded route-changing learnings", "severity": "medium", "autonomy_merge_safety": "medium", "owner_route": "transcript_processor #34"}
  ],
  "codification_target": {
    "target": "subordinate owner policy/spec for P9-P12; shared root remains unchanged",
    "native_before_custom": true,
    "reason_if_custom": "not applicable; existing owner-policy surfaces host the local specialization"
  },
  "selection_gate": {
    "first_repair": "P9 fail-closed work-close gate (highest gap severity)",
    "chosen_by": "gap severity, not issue order",
    "benchmark_vector": "maturation lane order G0 -> P9 -> P11 -> P12 -> responder-truth",
    "outcome_lever": "governance-readiness gaps this wave (no domain enhancement); a domain outcome lever is validated separately via the Domain-Outcome Eval Gate"
  },
  "right_sizing_basis": {
    "complexity": "Phase 3 Systematization repo: ~10 agents, 6 skills, 34 scoring tools",
    "use_case": "single-operator transcript-to-note repo-agent",
    "revealed_usage": "reconstructed from git history",
    "bounded_non_claim": "revealed usage is reconstructed from commit history, not instrumented telemetry"
  },
  "validation": "make check, make test, anti-pattern scan 0 violations, CI preflight green before any production-guidance change",
  "decision_state": "adopt",
  "bounded_non_claims": [
    "method capability only; not a controller, registry, or closure-truth surface",
    "proves operating-model readiness, not repo-agent domain capability",
    "anchoring is not a validated domain outcome, which requires the Domain-Outcome Eval Gate confirmed delta on the target's own eval",
    "n=2 observation (portfolio_advisor + transcript_processor), not proven cross-repo doctrine",
    "does not query or mutate GitHub",
    "does not create issues or pull requests",
    "does not merge pull requests or close issues",
    "does not start a daemon, scheduler, queue, controller, or hidden registry",
    "does not mutate downstream repos",
    "does not adopt principles automatically",
    "does not amend or extend root CONSTITUTION.md",
    "does not replace GitHub issue/PR/check/merge truth"
  ]
}
```

This template is for copy-sync or citation. It is not a schema mandate, runtime
dependency, generated inventory, controller, scheduler, queue, daemon, registry,
or closure surface. The values above are grounded in the transcript_processor
operating-model charter (the n=2 by-hand campaign); copy-sync consumers replace
them with their own repo's anchor record.
