# Foreground Failure-To-Issue Conversion Contract

> Version: 1.0
> Date: 2026-06-13
> Owner: repo-agent-core

## Purpose

This contract defines the portable Issue #164 foreground failure-to-issue
conversion record. It exists so a failed bounded foreground attempt can be
converted into owner GitHub issue truth without adding a new control plane.

It composes these existing repo-agent-core surfaces:

- `docs/foreground-recovery-runtime-contract.md`
- `docs/hermes-foreground-launcher-contract.md`
- `docs/interruption-recovery-and-batch-reconstitution-contract.md`
- `docs/foreground-learning-and-recovery-contract.md`

Use this contract after a foreground launcher, validation, or check path produces
a concrete failure that should become explicit owner-surface action. The contract
is copy-sync or citation guidance plus a compact template. It is not a schema
mandate unless a consuming repo separately chooses to machine-validate its own
copy.

## Accepted Guidance Inputs

Accepted guidance input may be a human-authored failure note, a foreground run
receipt, a check log, a command transcript, or `HERMES_FOREGROUND_FAILURE_GUIDANCE`.
When `HERMES_FOREGROUND_FAILURE_GUIDANCE` is present, its values should seed the
conversion fields below, especially campaign issue URL, repo, command family,
failure code, primary object, attempted command, status, evidence file, source
receipt path, recommended owner, impact, and bounded non-claims.

The guidance input is advisory. It does not invoke GitHub, retry the failed work,
repair code, or create issues in the background. An operator or foreground agent
must explicitly convert it into a GitHub issue or issue comment on the owner
surface.

## Required Owner-Surface Conversion Fields

A complete conversion record must include these fields:

| Field | Required meaning |
|---|---|
| campaign issue URL | Parent campaign issue, usually the Issue #164 steering issue that explains why this failure matters. |
| repo | Owner repository in `owner/name` form where the issue or issue comment truth belongs. |
| command family | Stable family name for the failed foreground path, such as `hermes-foreground`, `codex-goal`, `repo-star-pilot`, or another repo-local family. |
| failure code | Normalized short code for dedupe and triage. |
| primary object | Primary object that failed, such as repo, branch, PR, issue, prompt, receipt, target path, or check. |
| attempted command | Exact command attempted, or `(no command was launched)` when the failure happened before launch. |
| status | Observed status, exit code, timeout, validation failure, API ambiguity, or check ambiguity. |
| evidence file | Retained path or durable link containing the failure evidence. |
| source receipt path | Source receipt path when the evidence came from a foreground receipt or `HERMES_FOREGROUND_FAILURE_GUIDANCE`; use `none` only when no receipt exists. |
| recommended owner | Human, agent lane, repo, team, or owner issue surface expected to act. |
| impact | Compact statement of what the failure blocks or risks. |
| dedupe key | Stable marker used to find an existing issue/comment before creating a new one. |
| owner action | Exact next GitHub issue, GitHub issue comment, PR, or check action. |
| bounded non-claims | Explicit no-regrowth and no-closure claims for this conversion. |

## Dedupe Semantics

Exact marker search is authoritative. The conversion body or comment must include
a stable dedupe marker derived from the dedupe key, for example:

```text
<!-- issue164-foreground-failure-to-issue: <dedupe key> -->
```

Before creating a new issue, search for that exact marker on the intended owner
surface. If a matching open issue or suitable existing issue exists, add a GitHub
issue comment truth there instead of creating a duplicate.

A bounded fallback body scan is only an index-lag guard. It may search a small,
explicit set of likely issue bodies or comments for the failure code, primary
object, and evidence path when GitHub search indexing may be stale. Broad search
noise is not durable authority.
Broad fallback saturation is not a permanent blocker after clean exact marker search.
If exact marker search is clean and the bounded index-lag guard is saturated,
proceed to the explicit owner action or convert the API/search ambiguity into a
GitHub-visible blocker on the owner surface.

Do not let broad search noise, stale retained artifacts, or non-exact body
matches suppress a clean conversion forever.

## Conversion Output Semantics

The conversion output is GitHub issue or GitHub issue comment truth with dedupe
key, evidence path, owner action, and no automatic retry/repair.

A valid conversion output:

1. Creates a new owner GitHub issue, or comments on an existing owner GitHub
   issue, using the exact dedupe marker.
2. Names the evidence path and source receipt path, if any.
3. Names the owner action that should happen next.
4. Carries bounded non-claims that the conversion is not closure, not a repair,
   not CI proof, and not runtime proof beyond the cited evidence.
5. Does not retry the failed command, repair the repo, merge a PR, mutate a
   downstream target, or mutate Hermes/GBrain internals.

## Failure Handling

If conversion cannot prove whether GitHub issue creation, issue commenting,
search, API state, or a check result succeeded, the ambiguity must move to the
owner surface. In short: unresolved GitHub/API/check ambiguity becomes
GitHub-visible blocker truth; the disposition is not a local retained package.
Required disposition phrase: unresolved GitHub/API/check ambiguity becomes GitHub-visible blocker truth.

The fallback is still owner-surface truth: a visible issue, issue comment, PR
comment, or check annotation that states the ambiguity, dedupe key, evidence
path, attempted owner action, and requested human/agent next step. Do not keep
rerunning searches or preserving local-only packages as the disposition.

## Forbidden Boundary

This contract and its template forbid daemon, scheduler, queue, retry loop,
registry, controller, hidden registry, background GBrain behavior, automatic
background issue creation, auto-merge, downstream mutation, Hermes/GBrain
internals mutation, and runtime dependency behavior.

It does not authorize automatic GitHub issue creation in a background process,
automatic retry, automatic repair, downstream PR creation, patch application,
fleet adoption, model-spend changes, live Hermes/GBrain configuration changes,
or any replacement for explicit foreground owner action.

## Copy-Sync Boundary

Consumers may copy this contract and
`templates/foreground-failure-to-issue-conversion.md` or cite them from
repository docs. Copy drift is a repo-quality issue. Keep alignment by normal
review, copy-sync, or citation only; do not introduce a runtime dependency,
daemon, scheduler, queue, retry loop, registry, controller, hidden registry,
background GBrain behavior, automatic background issue creation, auto-merge,
downstream mutation, Hermes/GBrain internals mutation, or runtime dependency
behavior to keep copies aligned.
