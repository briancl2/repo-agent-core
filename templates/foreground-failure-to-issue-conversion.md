# Foreground Failure-To-Issue Conversion

Use this template to convert a bounded foreground failure, including
`HERMES_FOREGROUND_FAILURE_GUIDANCE`, into explicit owner GitHub issue or GitHub
issue comment truth. The conversion output is GitHub issue or GitHub issue
comment truth with dedupe key, evidence path, owner action, and no automatic
retry/repair.

<!-- issue164-foreground-failure-to-issue: <dedupe key> -->

## Conversion Fields

- campaign issue URL: <https://github.com/owner/repo/issues/164 or campaign issue>
- repo: <owner/name>
- command family: <hermes-foreground | codex-goal | repo-star-pilot | other>
- failure code: <normalized-short-code>
- primary object: <repo | branch | PR | issue | prompt | receipt | target | check>
- attempted command: `<exact command>` or `(no command was launched)`
- status: <exit code | timeout | validation failure | API ambiguity | check ambiguity>
- evidence file: <path or durable URL>
- source receipt path: <path to receipt, HERMES_FOREGROUND_FAILURE_GUIDANCE source, or none>
- recommended owner: <human | agent lane | repo | team | issue surface>
- impact: <what is blocked or at risk>
- dedupe key: <stable exact marker key>
- owner action: <create issue | comment on issue | PR/check action requested>
- bounded non-claims: <see below>

## Dedupe

- Exact marker search is authoritative: search for the exact marker above before
  creating a new issue.
- If the exact marker exists, add a GitHub issue comment truth on that owner
  surface instead of creating a duplicate.
- A bounded fallback body scan is only an index-lag guard; use it only across a
  small explicit set of likely issues/comments.
- Broad fallback saturation is not a permanent blocker after clean exact marker
  search. If exact marker search is clean and fallback search is noisy or
  saturated, proceed to the owner action or create/comment a GitHub-visible
  blocker for the ambiguity.

## Conversion Output

- GitHub issue or GitHub issue comment truth: <URL after conversion>
- dedupe key: <stable exact marker key>
- evidence path: <same as evidence file or durable evidence URL>
- owner action: <exact next action now visible on GitHub>
- no automatic retry/repair: this conversion records failure truth only; it does
  not retry the command, repair code, or continue in the background.

## GitHub-Visible Blocker

Use this section when GitHub/API/check state is ambiguous.

- GitHub-visible blocker: <issue/comment/check URL or pending owner-surface route>
- ambiguity: <issue creation | issue comment | search | API state | check result>
- attempted owner action: <what was attempted>
- evidence path: <path or durable URL>
- requested next step: <human/agent action needed>

Unresolved GitHub/API/check ambiguity becomes GitHub-visible blocker truth on the
owner surface, not a local retained package.

## Bounded Non-Claims

This conversion is not task closure, not a repair, not CI proof, not runtime
proof beyond the cited evidence, and not authorization for automatic retry or
background work. It does not create a daemon, scheduler, queue, retry loop,
registry, controller, hidden registry, background GBrain behavior, automatic
background issue creation, auto-merge, downstream mutation, Hermes/GBrain
internals mutation, or runtime dependency behavior.

Forbidden exact terms: automatic background issue creation; Hermes/GBrain internals mutation.
