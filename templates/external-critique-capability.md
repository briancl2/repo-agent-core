# External Critique Capability

Use this template when a repo wants a local, bounded external-critique rule.
The completed record defines when critique may be invoked, how findings are
admitted, and which local authority outranks the critic.

## Contract Identity

- artifact: EXTERNAL_CRITIQUE_CAPABILITY
- owner surface: <repo or team that owns the local rule>
- subject: <capability, PR, issue, contract, prompt, or release surface>
- owner issue or PR: <GitHub URL carrying local authority>
- parent campaign, if any: <GitHub URL or none>
- BMA seed evidence, if any: <non-canonical provenance only, or none>
- capability surface: <repo-local skill or capability convention for reusable repo-agent mechanisms, or why none exists>
- prompt artifact role: <request artifact, sidecar artifact, provenance, or none; not the primary capability surface when a repo-local skill or capability convention exists>

## Local Authority

- authority refs: <repo instructions, issue, PR, checks, docs, policies, or owner decisions that outrank critic output>
- target principles precedence: target repo principles outrank imported BMA phrasing and external phrasing
- independent owner evidence: <tests, checks, diffs, issue comments, logs, docs, or other owner evidence required after critique>

## Localized Slots

- risk vocabulary: <local blocker/advisory/high-stakes/privacy/release-risk terms>
- trigger examples: <local cases where one critic is useful>
- when-not-to-invoke rule: <local cases that should use ordinary review, tests, or no critique>
- privacy/redaction boundaries: <data, logs, URLs, account details, credentials, private text, or customer details to omit or summarize>
- receipt/runtime expectations: <issue/PR/check/artifact/receipt fields that record request, response, follow-up, and disposition>
- model runtime truth fields: <receipt/output fields for observed requested path/model, actual responding path/model when known, and unavailable disposition; no model probe>
- target-specific anti-patterns: <imported boilerplate, control-plane ideas, labels, or local traps to reject>

## Invocation Rule

- critic mode: <one_critic_default | named_high_stakes_panel | latest_panel>
- named high-stakes context: <required for panel/latest-panel; otherwise none>
- pass budget: one initial pass plus one follow-up pass unless explicitly approved
- finding quota: none; no-finding results are valid
- blocker/advisory rule: blockers require independent owner evidence; advisory findings do not block by themselves

## Critic Request Shape

Ask the critic to return:

- verdict: <pass | fail | partial | no_findings>
- blocker findings: <items with evidence needed, or none>
- advisory findings: <items with suggested owner action, or none>
- evidence gaps: <missing local evidence, or none>
- privacy/redaction concerns: <concerns, or none>
- confidence and assumptions: <short statement>
- non-authority statement: critique is a bounded risk sensor, not authority

Do not ask for a forced finding count. Do not ask the critic to decide target
authority. Do not include private data outside the privacy/redaction boundary.
For reusable repo-agent mechanisms in repos with a skill system or capability
convention, do not make prompt-only external critique the capability surface;
localize the reusable mechanism into the repo-local skill or capability first.

## Owner Disposition

- initial pass recorded at: <issue/PR/comment/artifact URL or path>
- follow-up pass recorded at: <URL/path or none>
- blocker dispositions: <accepted/rejected/deferred with independent owner evidence>
- advisory dispositions: <accepted/rejected/deferred with owner rationale>
- no-finding disposition, if applicable: <why no action is needed>
- budget expansion, if any: <explicit approval, reason, new evidence needed, and stopping condition>
- requested path/model: <observed requested external critique path/model>
- actual responding path/model: <observed responding path/model when known, or unknown>
- unavailable disposition: <fallback/blocker/skip reason when a requested model path is unavailable>

## Bounded Non-Claims

This record does not create a controller, scheduler, queue, daemon, registry,
dashboard, retry loop, background memory process, automatic issue/PR system,
standing paired-probe program, central service, sidecar runner, auto-merge path,
runtime dependency, live external probe authorization, downstream mutation path,
BMA canonical wording, or replacement authority for local GitHub issue/PR/check/
merge truth. It does not promise model routing, require a model probe, introduce
a probe program, or create a universal prompt-file policy.
