# Core-Five Owner-Surface Contract

> Version: 1.0
> Date: 2026-05-30
> Owner: repo-agent-core

## Purpose

This contract defines the Issue #164 core-five repo-agent operating model. It is
shared guidance for copy-sync distribution, not a runtime package, symlink,
service, scheduler, queue, controller, or dependency.

The core five are reciprocal proving grounds:

- build-meta-analysis
- repo-agent-core
- repo-auditor
- repo-upgrade-advisor
- repo-optimizer

Any core-five repo may be used as a read-only validation target by another
core-five repo. Mutation is allowed only when that repo is the named owner
surface and the work lands through its own issue, branch, PR, checks, and merge.

## Capability Homes

| Capability family | Owner surface | First deliverable shape |
|---|---|---|
| Outer-loop campaign console | build-meta-analysis | Issue #164 child issue and GitHub-native PR |
| Shared repo-agent contracts | repo-agent-core | Copy-synced contract, schema, template, or hook with repo-native tests |
| Audit and signature detection | repo-auditor | Detector signature, fixture, registration, and repo-native test |
| Recommendation packaging | repo-upgrade-advisor | Recommendation template, scorer rule, prompt/schema update, and packaging fixture |
| Patch-pack materialization | repo-optimizer | Deterministic patch materializer plus `git apply --check` fixture |

## Selection Rule

When a recommendation or Goal episode names core-five work, it must name:

1. the exact owner surface
2. the first deliverable or PR shape
3. why that owner surface advances the campaign
4. what is out of scope
5. the fallback if blocked
6. the repo-native validation scope

Category-only recommendations such as "work on repo-star", "do real delivery",
or "choose an owner repo" are incomplete until they name the owner surface and
first deliverable.

## Proving-Ground Rule

Read-only reciprocal validation can use any core-five target to test detection,
recommendation, and patch-pack behavior. A validation target is not a downstream
adoption target. A patch file, recommendation, or detector finding does not
authorize direct mutation of the target repo.

## Distribution Rule

Consumer repos may copy-sync this contract or cite it from docs. Copy-sync drift
is a repository quality issue, not a runtime dependency failure. Do not introduce
an import, generated registry, background sync, or controller to keep copies in
lockstep.
