# External Critique Capability Contract

> Version: 1.2
> Date: 2026-07-10
> Owner: repo-agent-core
> Token: `EXTERNAL_CRITIQUE_CAPABILITY`

## Purpose

This contract defines a portable invocation and admission shape for external
critique in repo-agent work. External critique is a bounded risk sensor. It is
not authority, not closure truth, not a replacement for local tests, and not a
source of target-repo principles.

The contract is localizable by each consuming owner surface. Consumers should
copy or cite this contract and adapt the slots in
`templates/external-critique-capability.md` to their local authority refs, risk
language, privacy rules, and anti-patterns.

This is capability assimilation, not build-meta-analysis prompt copy-sync.
Literal BMA wording is rejected as canonical target text. BMA prompt text may
be seed evidence or provenance only when the target repo rewrites it through
local principles.

This is not a controller, scheduler, queue, daemon, registry, dashboard, retry
loop, background memory process, automatic issue/PR system, standing paired-
probe program, central service, sidecar runner, runtime dependency, or auto-
merge path. It does not authorize new live external critique probes by itself.
The forbidden expansion includes any standing paired-probe program.

When a consumer repo has a skill system or repo-agent capability convention,
reusable external-critique mechanisms belong on that local skill or capability
surface first. Prompt files can still carry a one-off request, sidecar exchange,
or provenance, but prompt-only packaging is drift for reusable repo-agent
capabilities in those repos.

## Required Semantics

| Field | Required meaning |
|---|---|
| Contract token | `EXTERNAL_CRITIQUE_CAPABILITY`. |
| Stable profile pointer | `external-critique-profile`. The pointer has no date, version, or revision identity. |
| Default configured model-effort slot | The default single-critic profile contains `claude-opus-4.8|max`. |
| Latest-panel configured model-effort slots | The latest-panel profile contains `claude-opus-4.8|max`, `gemini-3.1-pro-preview|high`, and `gpt-5.6-sol|max`. |
| Configured-profile conformance | Conformance means the localized profile pointer and configured model-effort slots match this contract. It is configuration truth, not a claim that any configured path was available or responded at runtime. |
| Authority boundary | Critique is a bounded risk sensor, not authority. GitHub issue/PR/check/merge truth, repo-local instructions, and owner evidence remain authoritative. |
| Default critic count | The default path is one critic. |
| Panel exception | Panel/latest-panel requires named high-stakes context before invocation. |
| Finding quota | No forced finding quota. A valid critique may return no findings. |
| Finding class | Findings must be classified as blocker or advisory. |
| Pass budget | One initial pass plus one follow-up pass unless an owner explicitly approves more. |
| Evidence gate | Effectiveness requires independent owner evidence after critique. Critic text alone is not proof. |
| Local precedence | Target repo principles outrank imported BMA phrasing or external phrasing. |
| BMA provenance | BMA prompt text may be seed evidence only; literal BMA wording is not canonical. |
| Capability surface | Prefer repo-local skill or capability surfaces over prompt files for reusable repo-agent mechanisms when the target repo has a skill system or repo-agent capability convention. Prompt-only external critique is drift in those repos. |
| Prompt artifact role | Prompts may be request artifacts, sidecar artifacts, or provenance, but they are not the primary capability surface for reusable repo-agent mechanisms in repos with a skill system or capability convention. |
| Model runtime truth | Receipts or outputs record observed requested profile slot and path/model, actual responding path/model when known, and unavailable disposition. This observed runtime availability/receipt truth is separate from configured-profile conformance and does not promise routing. No model probe is required or authorized. |
| Historical evidence | Historical receipts and archived outputs are immutable evidence. A configured-profile change is not drift that authorizes rewriting them. |

## Portable Profile

The one stable profile pointer is `external-critique-profile`. Consumers must not
append a date, contract version, profile revision, model generation, or other
rotating identity to this pointer.

| Mode | Slot | Configured model | Configured effort |
|---|---:|---|---|
| Default single | 1 | `claude-opus-4.8` | `max` |
| Latest-panel | 1 | `claude-opus-4.8` | `max` |
| Latest-panel | 2 | `gemini-3.1-pro-preview` | `high` |
| Latest-panel | 3 | `gpt-5.6-sol` | `max` |

The pointer and matrix define configured-profile conformance on the consumer's
local capability surface. They do not prove that a configured model path was
available, accepted the configured effort, or produced the response. That is
observed runtime availability/receipt truth and belongs in the invocation
receipt or archived output.

Profile changes proceed through ordinary owner contract and copy-sync PRs behind
the same stable pointer. Historical receipts and archived outputs remain
immutable evidence of what was requested, available, and observed at their
recorded time; they are not profile drift to rewrite.

## Localizable Slots

Consumers must localize these slots before treating the contract as admitted:

| Slot | Local question |
|---|---|
| `external_critique_profile_pointer` | Where does the local capability surface expose the stable `external-critique-profile` pointer without adding a date or revision identity? |
| `configured_model_effort_slots` | Where does the local capability surface configure the default single slot and all three latest-panel model-effort slots exactly as specified by the portable profile? |
| `authority_refs` | Which local files, issue labels, PR checks, policies, or owner decisions outrank critic output? |
| `risk_vocabulary` | Which local words map to blocker, advisory, high-stakes, privacy, data-loss, user-impact, or release-risk categories? |
| `trigger_examples` | Which local scenarios justify invoking one critic? |
| `when_not_to_invoke` | Which local scenarios should use ordinary owner review, tests, or no critique? |
| `privacy_redaction_boundaries` | Which data, logs, credentials, account details, customer details, private URLs, or internal text must be omitted, summarized, or redacted? |
| `receipt_runtime_expectations` | Which issue, PR, check, artifact, or local receipt records the critique request, response, follow-up, and owner disposition? |
| `target_specific_anti_patterns` | Which imported labels, boilerplate, ceremony, control-plane ideas, or target-specific traps must be rejected? |
| `capability_surface_expectations` | Which repo-local skill, capability, instruction, or other convention is the primary surface for reusable repo-agent mechanisms, and when are prompt files only request artifacts, sidecar artifacts, or provenance? |
| `model_runtime_truth_fields` | Which receipt or output fields record the observed requested profile slot and path/model, actual responding path/model when known, and unavailable disposition without adding a probe program or treating availability as configured-profile conformance? |

## Invocation Rules

Use one critic by default when a bounded external risk read is materially likely
to change the owner action. Example triggers include architectural ambiguity,
public-interface risk, non-obvious regression risk, privacy/redaction risk,
security-sensitive behavior, release-blocking uncertainty, or cross-repo
contract wording that downstream repos will consume.

Use a panel or latest-panel only when the owner names the high-stakes context
before invocation. High-stakes context must be concrete, such as irreversible
data migration, credential or privacy exposure, broad downstream contract
breakage, legal/compliance risk, public release risk, or a costly rollback path.
When latest-panel is justified, request the three configured slots from
`external-critique-profile`; do not silently substitute a different configured
profile under that pointer.

Do not invoke critique for routine edits, already-proven local fixes, formatting
changes, low-risk documentation copy, or situations where the prompt would ask
the critic to decide authority. Do not invoke critique merely to satisfy a
finding count, create ceremony, or make a local owner decision look externally
validated.

For reusable repo-agent mechanisms, do not treat a prompt file as the primary
capability surface when the target repo has a skill system or repo-agent
capability convention. Localize the mechanism into the repo-local skill or
capability surface first; keep prompts as request artifacts, sidecar artifacts,
or provenance when useful.

The normal budget is one initial pass plus one follow-up pass. Further passes
require explicit owner approval with the reason, the new evidence needed, and
the stopping condition.

If a configured path is unavailable, rejects the configured effort, or responds
through a different known path/model, preserve the configured profile and record
the observed result in the receipt. Runtime unavailability is not configured-
profile drift and does not authorize a probe program, profile rewrite, or
historical evidence rewrite.

## Result Admission

A critique result is admissible only when the owner records:

1. the subject and scope reviewed;
2. the critic mode used, including named high-stakes context for any panel;
3. the privacy/redaction boundary applied;
4. blocker findings, advisory findings, or explicit no-finding result;
5. owner disposition for each blocker or advisory item;
6. independent owner evidence used to accept, reject, or defer the critique;
7. whether the one-follow-up budget was used or explicitly expanded;
8. the stable profile pointer and configured model-effort slot requested; and
9. observed requested path/model, actual responding path/model when known, and
   unavailable disposition for the external model path used.

Blockers stop or change owner action only when tied to independent owner
evidence. Advisory findings may inform implementation, tests, docs, or issue
comments, but do not block by themselves. A no-finding result is valid when
scope, privacy boundary, and owner disposition are recorded.

`CRITIQUE_RESULT` may be used as a portable result artifact when a structured
receipt is useful. This contract controls invocation and admission semantics;
the schema alone does not grant authority or require critique. These v1.2
profile fields apply to new or intentionally superseding local records; do not
retroactively edit historical receipts or archived outputs to add them.

## Owner Routing

- `repo-agent-core` owns this portable contract and template.
- `repo-auditor` may detect missing localization, forced quotas, panel use
  without high-stakes context, authority overclaims, and forbidden control-plane
  regrowth.
- `repo-upgrade-advisor` may recommend localizable slot completion, blocker/
  advisory separation, and independent-evidence requirements.
- `repo-optimizer` may reduce critique boilerplate only after detector or
  advisor evidence proves repetition or ceremony regrowth.
- BMA or another owner repo may cite or copy this contract, but target-repo
  principles and owner evidence outrank imported wording.

## Copy-Sync Boundary

Consumers may copy this contract, copy
`templates/external-critique-capability.md`, or cite either artifact in local
docs, issues, PRs, or prompt bundles. Copy drift is repo-quality debt handled
through ordinary owner PRs.

Do not add a runtime dependency, generated inventory, scheduler, queue,
controller, watcher, daemon, registry, dashboard, retry loop, standing paired-
probe program, automatic updater, automatic issue/PR creator, auto-merge path,
background memory behavior, or background sync to keep copies aligned.

Copy-sync may cite local skill or capability surfaces and prompts as provenance,
but it must not introduce a universal prompt-file policy. Repos with their own
skill systems or capability conventions should copy-sync the reusable mechanism
into that local capability surface.

## Bounded Non-Claims

This contract does not run external critique, select work, create issues, create
PRs, post comments, merge PRs, close issues, approve changes, replace local
tests, replace GitHub issue/PR/check/merge truth, authorize live probes, start a
standing review program, mutate downstream repos, make BMA phrasing canonical,
turn external output into authority, promise model routing, require a model
probe, introduce a probe program, treat observed availability as configured-
profile conformance, rotate the stable profile pointer, or rewrite historical
receipts and archived outputs.
