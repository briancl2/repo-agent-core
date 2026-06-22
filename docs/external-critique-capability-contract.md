# External Critique Capability Contract

> Version: 1.0
> Date: 2026-06-22
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

## Required Semantics

| Field | Required meaning |
|---|---|
| Contract token | `EXTERNAL_CRITIQUE_CAPABILITY`. |
| Authority boundary | Critique is a bounded risk sensor, not authority. GitHub issue/PR/check/merge truth, repo-local instructions, and owner evidence remain authoritative. |
| Default critic count | The default path is one critic. |
| Panel exception | Panel/latest-panel requires named high-stakes context before invocation. |
| Finding quota | No forced finding quota. A valid critique may return no findings. |
| Finding class | Findings must be classified as blocker or advisory. |
| Pass budget | One initial pass plus one follow-up pass unless an owner explicitly approves more. |
| Evidence gate | Effectiveness requires independent owner evidence after critique. Critic text alone is not proof. |
| Local precedence | Target repo principles outrank imported BMA phrasing or external phrasing. |
| BMA provenance | BMA prompt text may be seed evidence only; literal BMA wording is not canonical. |

## Localizable Slots

Consumers must localize these slots before treating the contract as admitted:

| Slot | Local question |
|---|---|
| `authority_refs` | Which local files, issue labels, PR checks, policies, or owner decisions outrank critic output? |
| `risk_vocabulary` | Which local words map to blocker, advisory, high-stakes, privacy, data-loss, user-impact, or release-risk categories? |
| `trigger_examples` | Which local scenarios justify invoking one critic? |
| `when_not_to_invoke` | Which local scenarios should use ordinary owner review, tests, or no critique? |
| `privacy_redaction_boundaries` | Which data, logs, credentials, account details, customer details, private URLs, or internal text must be omitted, summarized, or redacted? |
| `receipt_runtime_expectations` | Which issue, PR, check, artifact, or local receipt records the critique request, response, follow-up, and owner disposition? |
| `target_specific_anti_patterns` | Which imported labels, boilerplate, ceremony, control-plane ideas, or target-specific traps must be rejected? |

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

Do not invoke critique for routine edits, already-proven local fixes, formatting
changes, low-risk documentation copy, or situations where the prompt would ask
the critic to decide authority. Do not invoke critique merely to satisfy a
finding count, create ceremony, or make a local owner decision look externally
validated.

The normal budget is one initial pass plus one follow-up pass. Further passes
require explicit owner approval with the reason, the new evidence needed, and
the stopping condition.

## Result Admission

A critique result is admissible only when the owner records:

1. the subject and scope reviewed;
2. the critic mode used, including named high-stakes context for any panel;
3. the privacy/redaction boundary applied;
4. blocker findings, advisory findings, or explicit no-finding result;
5. owner disposition for each blocker or advisory item;
6. independent owner evidence used to accept, reject, or defer the critique;
7. whether the one-follow-up budget was used or explicitly expanded.

Blockers stop or change owner action only when tied to independent owner
evidence. Advisory findings may inform implementation, tests, docs, or issue
comments, but do not block by themselves. A no-finding result is valid when
scope, privacy boundary, and owner disposition are recorded.

`CRITIQUE_RESULT` may be used as a portable result artifact when a structured
receipt is useful. This contract controls invocation and admission semantics;
the schema alone does not grant authority or require critique.

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

## Bounded Non-Claims

This contract does not run external critique, select work, create issues, create
PRs, post comments, merge PRs, close issues, approve changes, replace local
tests, replace GitHub issue/PR/check/merge truth, authorize live probes, start a
standing review program, mutate downstream repos, make BMA phrasing canonical,
or turn external output into authority.
