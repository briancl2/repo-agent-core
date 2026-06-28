# Maturity-Boundary Claim Contract

This contract defines a portable overclaim guard for separating four
assimilation claim classes: repo-operating-model progress, repo-agent readiness,
repo-agent capability, and stack-integrated repo-agent capability. It keeps
GitHub closure and validation legibility from being mistaken for domain
autonomy.

This is guidance for issue bodies, PR bodies, docs, templates, and retained
evaluation records. It is not a runtime package, schema mandate, generated
inventory, controller, scheduler, queue, watcher, daemon, background sync,
automatic updater, registry, or mutation authority. GitHub issue/PR/check/merge
truth remains task truth.

## Related Contracts

- `docs/repo-assimilation-method-contract.md` (the umbrella method this guards)
- `docs/principle-alignment-anchor-contract.md`
- `docs/benchmark-before-repair-contract.md`

Consumers may copy-sync or cite this contract and
`templates/maturity-boundary-claim.md`. Do not turn either file into a runtime
dependency, import framework, generated registry, controller, queue, scheduler,
daemon, retry loop, watcher, background poller, automatic updater, or
task-closure authority.

## Claim Classes

| Claim class | What it means | Proof required |
| --- | --- | --- |
| Repo-operating-model progress (`operating-model-progress`) | Work closes through issue, PR, check, merge, and readback. | GitHub truth plus green required checks. |
| Repo-agent readiness (`repo-agent-readiness`) | The repo has purpose, principles, benchmark, owner-surface repair gates, and validation legibility. | Benchmark changes repair selection and repairs have before/after deltas. |
| Repo-agent capability (`repo-agent-capability`) | The repo can improve its own DOMAIN outputs through bounded foreground or automated mechanisms. | A real domain artifact improves against a purpose-aligned rubric. |
| Stack-integrated repo-agent capability (`stack-integrated-capability`) | BMA, Hermes, GBrain, and repo-star each play bounded roles without exceeding proof. | Receipts, exact readbacks, owner-surface PRs, and no false authority transfer. |

## Required Record

| Field | Required meaning |
| --- | --- |
| `artifact` | Must be `MATURITY_BOUNDARY_CLAIM_RECORD`. |
| `schema_version` | Contract version for the record shape. |
| `claim_class` | One of `operating-model-progress` / `repo-agent-readiness` / `repo-agent-capability` / `stack-integrated-capability`. |
| `claim_text` | The actual claim being made. |
| `proof_provided` | The evidence actually held. |
| `proof_required` | The evidence the claim class demands. |
| `overclaim_guard` | Boolean/verdict: does the claim stay within the class its proof supports? |
| `decision_state` | One of `adopt` / `defer` / `owner-route` / `no-op` / `needs-proof`. |
| `bounded_non_claims` | What the record did not prove, mutate, adopt, or authorize. |

## Admission Rules

A maturity-boundary claim record is admissible only when:

1. `claim_class` is one of `operating-model-progress`,
   `repo-agent-readiness`, `repo-agent-capability`, or
   `stack-integrated-capability`.
2. `proof_provided` satisfies `proof_required` for that class, or the record
   downgrades `claim_class` to the class the proof actually supports.
3. A claim of `repo-agent-capability` or `stack-integrated-capability` requires
   DOMAIN-artifact or receipt proof. GitHub closure plus green checks prove only
   `operating-model-progress`.
4. `overclaim_guard` blocks adoption (`decision_state: needs-proof`) when
   `proof_provided` supports a lower class than `claim_text` asserts.
5. Passing CI, fewer warnings, or fewer bytes is operating-model-progress
   evidence, not capability proof.

## Maturity And Proof

Evidence is currently **n=2**: portfolio_advisor and transcript_processor. Both
campaigns currently support classes 1-2 more strongly than classes 3-4. That is
progress, but it is not autonomy. This contract is the guard that keeps that
distinction honest.

A precision note on the **detector** (repo-auditor AS-53): on the
transcript_processor `main` sweep it correctly stayed **silent** (the repo's
maturity claims are class-qualified or absent) — a true-negative with zero false
positives. That hardens confidence the detector does not over-fire, but its
positive **catch** remains **n=1** (the portfolio_advisor overreach, caught by
hand). The detector is therefore **keep-candidate**, not graduated: it needs a
future repo that genuinely overreaches to confirm the catch at n=2.

## Owner Routing

- An overclaim routes back to the asserting issue/PR for correction.
- Detector or advisor gaps route to repo-auditor or repo-upgrade-advisor through
  their owner issue/branch/PR/check/merge paths.

## Bounded Non-Claims

This contract does not query GitHub, mutate GitHub, create issues, create PRs,
merge PRs, close issues, run a scheduler, start a daemon, create a queue, create
a controller, create a hidden registry, mutate downstream repos, adopt maturity
claims automatically, or replace GitHub issue/PR/check/merge truth. n=2 is an
observation, not proven doctrine.
