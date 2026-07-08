# Repo-Health Retrospective Method Record

```json
{
  "artifact": "REPO_HEALTH_RETROSPECTIVE_METHOD",
  "schema_version": 1,
  "repo_identity": "fleet repo or target repo whose operating health is examined",
  "operator_intent": "operator-valued question the retrospective answers and the repo-health outcome it serves",
  "thesis": "single falsifiable thesis, e.g. building a new heavy runtime detector is the highest-return next move",
  "evidence_hierarchy": {
    "primary": [
      "git history",
      "LEARNINGS.md",
      "research/reports/*",
      "AGENTS.md",
      "GitHub issue/PR/check/merge state",
      "signature/anti-pattern scan catalog"
    ],
    "secondary": [
      "session_store / on-disk events (corroborating only)",
      "runtime exhaust logs (corroborating only)"
    ],
    "rule": "no finding rests on secondary evidence alone"
  },
  "operating_surfaces": [
    {
      "surface": "surface 1 name",
      "pass_a_known": "known anti-pattern still exhibited, with primary anchor",
      "pass_b_emerging": "emerging/unnamed anti-pattern",
      "pass_c_verdict": "detection/add-lightness verdict -> register id"
    },
    {
      "surface": "surface 2 name",
      "pass_a_known": "known anti-pattern still exhibited, with primary anchor",
      "pass_b_emerging": "emerging/unnamed anti-pattern",
      "pass_c_verdict": "detection/add-lightness verdict -> register id"
    },
    {
      "surface": "surface 3 name",
      "pass_a_known": "known anti-pattern still exhibited, with primary anchor",
      "pass_b_emerging": "emerging/unnamed anti-pattern",
      "pass_c_verdict": "detection/add-lightness verdict -> register id"
    },
    {
      "surface": "surface 4 name",
      "pass_a_known": "known anti-pattern still exhibited, with primary anchor",
      "pass_b_emerging": "emerging/unnamed anti-pattern",
      "pass_c_verdict": "detection/add-lightness verdict -> register id"
    },
    {
      "surface": "surface 5 name",
      "pass_a_known": "known anti-pattern still exhibited, with primary anchor",
      "pass_b_emerging": "emerging/unnamed anti-pattern",
      "pass_c_verdict": "detection/add-lightness verdict -> register id"
    }
  ],
  "candidate_register": [
    {
      "id": "cut:example-dead-mechanism-retire",
      "verdict": "CUT",
      "anti_pattern": "abandoned measurement instrument still cited as live",
      "evidence": "primary anchor: git log + artifact contents + skill reference",
      "owner_surface": "https://github.com/example/repo/issues/1",
      "acceptance_sketch": "archive the artifact and add one fail-loud staleness guard"
    },
    {
      "id": "new-surface:example-heavy-detector",
      "verdict": "DO-NOT-BUILD",
      "anti_pattern": "runtime-only friction with no structural footprint",
      "evidence": "primary anchor: evidence-tier contract + absent runtime logs",
      "owner_surface": "none",
      "acceptance_sketch": "explicitly do not build; naming it is the add-lightness move"
    }
  ],
  "add_lightness_ranking": {
    "rule": "CUT/SIMPLIFY first, cheap git-observable ADD next, heavy new surface last; ties broken toward deletion",
    "is_preference_not_measurement": true,
    "order": ["cut:example-dead-mechanism-retire", "...", "new-surface:example-heavy-detector"]
  },
  "outcome_proxy_rerank": {
    "proxy": "raw friction frequency (how often each pattern actually bites)",
    "order": ["...independent order that can differ from add_lightness_ranking..."],
    "disagrees_with_add_lightness_ranking": true,
    "can_refute_thesis": true,
    "survives_both_orderings": "the heavy new surface ranks last under both; its rejection is the only non-preference-driven conclusion"
  },
  "thesis_verdict": {
    "verdict": "partially_refuted",
    "decisive_primary_anchor": "the canonical anchor that decides the verdict"
  },
  "cut_simplify_add_tally": {
    "CUT": 0,
    "SIMPLIFY": 0,
    "ADD": 0,
    "BOUNDED-HELPER": 0,
    "DO-NOT-BUILD": 0,
    "CONDITIONAL": 0
  },
  "owner_surface": "https://github.com/example/repo/issues/1270",
  "bounded_non_claims": [
    "does not turn its add-lightness ranking into a measured return",
    "does not rest any verdict on secondary session-log or runtime evidence alone",
    "does not implement detectors, open new issues, or mutate sibling repos; the register is an advisory hand-back",
    "does not authorize background sync/watch, cron, autopilot, jobs worker, MCP serving, queues, daemons, schedulers, hidden registries, generated inventories, automatic updates, automatic issue/PR creation, or downstream mutation",
    "does not create a controller, scheduler, queue, registry, daemon, retry loop, hidden control plane, or retained proof ritual"
  ]
}
```

## Operating surfaces × passes grid

Pass A = known anti-pattern still exhibited · Pass B = emerging/unnamed ·
Pass C = detection/add-lightness verdict.

| Surface | A (known) | B (emerging) | C (verdict → register id) |
|---|---|---|---|
| 1 — <name> | | | |
| 2 — <name> | | | |
| 3 — <name> | | | |
| 4 — <name> | | | |
| 5 — <name> | | | |

## Candidate-detector register

Ranked by add-lightness ROI. Hand back unbuilt — do not implement here.

| Rank | ID | Verdict | Anti-pattern | Evidence (primary anchor) | Owner surface | Acceptance sketch |
|---|---|---|---|---|---|---|
| 1 | | CUT/SIMPLIFY/ADD/BOUNDED-HELPER/DO-NOT-BUILD/CONDITIONAL | | | | |
| 2 | | | | | | |

## Falsifiability re-rank block

- **Add-lightness ranking (preference):** <order by mechanism weight>
- **Independent outcome-proxy re-rank (friction frequency):** <order by raw friction>
- **Do the two orderings disagree?** yes/no — <where and why>
- **What survives both orderings:** <the conclusion that is not preference-driven>

## CUT/SIMPLIFY/ADD tally

| Verdict | Count |
|---|---|
| CUT | |
| SIMPLIFY | |
| ADD | |
| BOUNDED-HELPER | |
| DO-NOT-BUILD | |
| CONDITIONAL | |
