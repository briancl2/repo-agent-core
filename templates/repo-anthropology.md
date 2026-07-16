# Repo Anthropology Record

```json
{
  "artifact": "REPO_ANTHROPOLOGY_RECORD",
  "schema_version": 1,
  "purpose": "Transform meeting and call transcripts into structured notes.",
  "use_cases": [
    "convert raw transcript to structured meeting note",
    "extract action items and owners",
    "critic-checked note quality"
  ],
  "deliverables": [
    "structured note markdown",
    "action-item list",
    "quality critic verdict"
  ],
  "operator_interaction_model": "single operator, foreground execution, issue -> PR -> merge",
  "defined_principles": {
    "surface": "CONSTITUTION.md plus subordinate AGENTS.md and repo-local policy",
    "principles": "shared constitutional floor plus owner-local specialization"
  },
  "revealed_principles": [
    {
      "principle": "Fix detector false-positives at the rule, not product code",
      "evidence": "anti-pattern rule-5 and start_new_session->preexec_fn fixes"
    },
    {
      "principle": "Keep transcript transformation foreground and operator-visible",
      "evidence": "AGENTS.md foreground workflow plus CI-backed issue -> PR -> merge path"
    }
  ],
  "evidence_refs": [
    "AGENTS.md",
    "LEARNINGS.md",
    "CONSTITUTION.md",
    ".github/workflows/ci.yml",
    "applicable owner-local contracts/specs",
    "anti-pattern rule-5 + start_new_session->preexec_fn repair history"
  ],
  "decision_state": "adopt",
  "bounded_non_claims": [
    "n=2 observation (portfolio_advisor + transcript_processor), not proven cross-repo doctrine",
    "proves operating-model readiness, not repo-agent domain capability",
    "does not query or mutate GitHub",
    "does not create issues or pull requests",
    "does not merge pull requests or close issues",
    "does not start a daemon, scheduler, queue, controller, or hidden registry",
    "does not mutate downstream repos",
    "does not replace GitHub issue/PR/check/merge truth"
  ]
}
```

This template is for copy-sync or citation. It is not a schema mandate, runtime
dependency, generated inventory, controller, scheduler, queue, daemon, registry,
or closure surface. The values above are grounded in transcript_processor (the
n=2 by-hand campaign); copy-sync consumers replace them with their own repo's
anthropology record.
