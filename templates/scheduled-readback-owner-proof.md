# Scheduled Readback Owner Proof

```json
{
  "artifact": "SCHEDULED_READBACK_OWNER_PROOF",
  "schema_version": 1,
  "source_issue_or_pr": "https://github.com/briancl2/build-meta-analysis/issues/943",
  "parent_campaign_url": "https://github.com/briancl2/build-meta-analysis/issues/164",
  "owner_issue_url": "https://github.com/briancl2/build-meta-analysis/issues/943",
  "candidate_id": "runtime_shadow_schedule_readback",
  "schedule_source": {
    "workflow": "Issue #164 Runtime Learning Shadow",
    "workflow_file": ".github/workflows/issue164-runtime-learning-shadow.yml",
    "cron": "17 21 * * *"
  },
  "allowed_event": "schedule",
  "event_filter": {
    "accepted_scheduled_events": [
      "schedule"
    ],
    "workflow_dispatch_counts_as_scheduled": false,
    "non_scheduled_events_are_context_only": true
  },
  "cadence": {
    "expected": "daily",
    "as_of": "2026-06-19T23:51:59Z",
    "latest_scheduled_age_hours": 12.4,
    "stale_after_hours": 30,
    "state": "fresh"
  },
  "evidence_fields": [
    "run_id",
    "event",
    "status",
    "conclusion",
    "created_at",
    "run_url",
    "head_sha"
  ],
  "admission_disposition": {
    "value": "blocked_already_admitted",
    "candidate_run_id": "",
    "reason": "latest completed successful event=schedule run is already admitted"
  },
  "blocker_rule": "No new completed successful event=schedule run outside admitted IDs within the cadence window, or any workflow_dispatch-only proof attempt.",
  "promotion_gate": "A named owner issue/PR proves read-only scheduled evidence with event=schedule filtering, cadence policy, blocker rule, and bounded non-claims.",
  "demotion_trigger": "workflow_dispatch counted as scheduled proof, private/raw capture, hidden scheduler/queue/daemon/controller/registry, background Hermes/GBrain, automatic GitHub mutation, auto-merge, stale live truth, or missing owner issue.",
  "kill_switch": "Stop scheduled-readback promotion and record a GitHub-visible blocker with one exact next owner action.",
  "github_truth": "GitHub issue/PR/check/merge truth remains closure truth; generated comments, artifacts, and proof JSON are evidence only.",
  "bounded_non_claims": [
    "does not create or install a schedule",
    "does not run a workflow",
    "does not treat workflow_dispatch as scheduled proof",
    "does not treat comments, artifacts, or proof JSON as closure truth",
    "does not mutate downstream repos",
    "does not mutate Hermes or GBrain internals",
    "does not make GBrain canonical",
    "does not make Hermes the campaign owner",
    "does not start a daemon, scheduler, queue, controller, retry loop, hidden registry, watcher, cron installer, background sync, or automatic GitHub issue/PR mutation",
    "does not auto-merge pull requests"
  ],
  "next_owner_action": "Route detector coverage to repo-auditor AS-49 or repair the workflow owner issue if the live scheduled evidence is stale or missing."
}
```

This template is for copy-sync or citation. It is not a schema mandate,
runtime dependency, runner, scheduler, queue, daemon, controller, registry,
auto-merge path, or closure surface.
