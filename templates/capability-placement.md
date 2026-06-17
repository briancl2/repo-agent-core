# Capability Placement Preview

```json
{
  "artifact": "CAPABILITY_PLACEMENT_PREVIEW",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/build-meta-analysis/issues/834",
  "parent_campaign_url": "https://github.com/briancl2/build-meta-analysis/issues/164",
  "carrier_child_url": "https://github.com/briancl2/repo-agent-core/issues/64",
  "advisory_status": "advisory",
  "best_current_owner": "Codex/BMA foreground coordinator plus the owner repo issue and PR",
  "best_future_owner": "GitHub-native issue/PR/check/merge truth plus repo-star contracts, detectors, advisors, or compactness checks after proof",
  "local_remote": "local foreground implementation, remote GitHub truth",
  "foreground_scheduled": "foreground PR sequence; scheduled readbacks continue separately when present",
  "allowed_reach_now": "owner repo branch and PR mutation only; no downstream mutation; no background write authority",
  "native_signal": "owner issue body, PR Autonomy Preview block, repo-native tests, CI checks, and merge or blocker truth",
  "promotion_gate": "at least two follow-on PRs use placement fields to change route, demote a bad automation idea, or choose a better owner surface",
  "demotion_rejection_trigger": "fields become boilerplate, fail to affect routing, or increase operator burden without owner-surface value",
  "kill_switch": "delete or shrink the contract/detector/advisor through the owning repo PR and record the demotion on the GitHub surface",
  "why_not_alternatives": [
    "labels are too coarse to encode owner, reach, promotion, and demotion",
    "dashboards and registries would become shadow truth",
    "background automation would exceed current authority"
  ],
  "operator_value_hypothesis": "fewer clarification loops, fewer bad autonomy promotions, and faster owner-surface routing for high-priority work",
  "forbidden_mode": [
    "controller",
    "scheduler",
    "queue",
    "daemon",
    "registry",
    "dashboard",
    "central autonomy ledger",
    "hidden state store",
    "background Hermes/GBrain",
    "automatic issue/PR creation",
    "auto-merge",
    "Codex cloud/background write authority",
    "downstream mutation",
    "replacement closure truth"
  ],
  "gbrain_slug_or_no_capture_reason": "no_capture_reason=memory did not change or materially confirm this route",
  "routing_use": "selected the owner repo as the portable contract home and bounded the first wave to advisory foreground PRs",
  "bounded_non_claims": [
    "does not select work by itself",
    "does not create issues or pull requests",
    "does not post comments",
    "does not merge pull requests",
    "does not close issues",
    "does not run Hermes",
    "does not run GBrain",
    "does not create a CI gate",
    "does not create a dashboard, registry, central ledger, scheduler, queue, daemon, controller, hidden state store, or background poller",
    "does not grant Codex cloud or background write authority",
    "does not mutate downstream repos",
    "does not replace GitHub issue/PR/check/merge truth"
  ]
}
```

This template is for copy-sync or citation. It is not a schema mandate,
runtime dependency, dashboard, registry, central ledger, scheduler, queue,
daemon, controller, automatic issue/PR creator, auto-merge path, background
Hermes/GBrain authority, Codex cloud/background write grant, downstream
mutation authority, or closure surface.
