# Native Evidence Before Verdict Record

```json
{
  "artifact": "NATIVE_EVIDENCE_BEFORE_VERDICT",
  "schema_version": 1,
  "component_identity": "example upstream tool or native capability",
  "intended_operator_outcome": "working operator-valued outcome the component must help deliver",
  "verdict_class": "adoption/readiness/fallback/production/GA/cutover/architecture/repair/downgrade/replacement",
  "current_upstream_docs_checked": [
    {
      "surface": "README",
      "ref": "https://github.com/example/project/blob/main/README.md",
      "checked_at_utc": "<UTC timestamp>"
    },
    {
      "surface": "root agent instructions",
      "ref": "https://github.com/example/project/blob/main/AGENTS.md",
      "checked_at_utc": "<UTC timestamp>"
    },
    {
      "surface": "install/setup guidance",
      "ref": "https://github.com/example/project/blob/main/INSTALL_FOR_AGENTS.md",
      "checked_at_utc": "<UTC timestamp>"
    }
  ],
  "native_model_mapped": {
    "architecture": "native architecture summary tied to the operator outcome",
    "setup_configuration": "native setup/configuration model",
    "trust_boundaries": "credentials, filesystem, network, remote/local, or safety boundaries",
    "validation_path": "documented native command, workflow, or proof path"
  },
  "native_attempt_or_blocker": {
    "kind": "native_attempt",
    "command_or_workflow": "safe documented native command or workflow",
    "status": "pass/fail/blocked",
    "output_or_blocker": "real command output, native result, or concrete blocker with owner-surface route"
  },
  "verdict_bearing_evidence": {
    "surface": "issue/PR/comment/readout URL",
    "contains_native_output_or_blocker": true,
    "summary": "what evidence or blocker the verdict-bearing surface carries"
  },
  "owner_surface": "https://github.com/example/project/issues/123",
  "validation_scope": [
    "repo-native focused tests",
    "safe documented native setup/use smoke or concrete owner-surface blocker"
  ],
  "advisory_gbrain_ref": {
    "slug": "bma/issue164/native-evidence-before-verdict",
    "status": "advisory_exact_get_readback",
    "fallback_without_memory": "use GitHub issue/PR evidence and this copied contract"
  },
  "bounded_non_claims": [
    "does not make GBrain canonical",
    "does not let GBrain override operator intent, GitHub truth, repo evidence, or repo-local instructions",
    "does not prove production readiness unless the native attempt and validation evidence support that exact verdict",
    "does not authorize background GBrain sync/watch, cron, autopilot, dream, jobs worker, MCP serving, minions, queues, daemons, schedulers, hidden registries, automatic updates, automatic issue/PR creation, or downstream mutation",
    "does not create a controller, scheduler, queue, registry, daemon, retry loop, hidden control plane, or retained proof ritual"
  ]
}
```
