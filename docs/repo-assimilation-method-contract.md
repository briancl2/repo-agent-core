# Repo Assimilation Method Contract

The repo assimilation method is the canonical narrative for how a repo-agent is
brought into the fleet's operating model before any domain work begins. It
captures the recovered pre-flight carrier sequence — anthropology, assessment,
remediation — as an **11-step candidate skeleton** plus the cross-cutting guards
(maturity-boundary claim separation, seeded hypotheses, finding classification,
anti-patterns, and transfer lessons) that keep the method honest. It is the
umbrella that the individual mechanic contracts cite.

It is **not** a runtime package, a schema mandate, a required ceremony, a
controller, scheduler, queue, daemon, registry, or mutation authority. It does
not adopt itself across repos by fiat. GitHub issue/PR/check/merge truth remains
task truth. The method is an **n=2 observation** (portfolio_advisor +
transcript_processor by-hand campaigns), not proven cross-repo doctrine —
*generalization cannot outrun proof*.

## Related Contracts

The method composes five mechanic contracts; consume each by copy-sync or
citation only, never as a runtime dependency:

- `docs/principle-alignment-anchor-contract.md` — step 0/2: revealed vs defined
  principles reconciled into a constitution anchor.
- `docs/repo-anthropology-contract.md` — step 3: purpose, use cases,
  deliverables, operator interaction model, defined and revealed principles.
- `docs/benchmark-before-repair-contract.md` — step 4: benchmark dimensions
  defined before repair selection ("benchmark changed selection").
- `docs/repair-decision-block-contract.md` — step 8: selection-changing repairs
  admitted through a complete decision block.
- `docs/maturity-boundary-claim-contract.md` — cross-cutting overclaim guard
  separating operating-model progress from repo-agent capability.

Copy this contract and `templates/repo-assimilation-method.md` into a consuming
repo by copy-sync or citation only. Do not import it as a runtime dependency,
GitHub client, memory daemon, scheduler, queue, controller, retry loop, hidden
registry, background process, automatic issue/PR creator, retained closeout
package, or downstream mutation surface.

## Candidate Assimilation Skeleton

A checklist for future experiments, not a required ceremony or adopted cross-repo
contract:

1. Start with GitHub truth and a clean scratch target.
2. Freeze the operator ask and the anti-overclaim boundary.
3. Build repo anthropology (purpose, use cases, deliverables, operator
   interaction model, defined principles, revealed principles).
4. Define benchmark dimensions before selecting repairs.
5. Seed hypotheses before fleet assessment.
6. Run repo-star read-only and classify findings (confirmed, missed, new,
   contradicted, not-assessable).
7. Use critique at boundary points, not as a standing product lane.
8. Admit repairs through a decision block only when it changes selection.
9. Measure the delta and ask whether the metric changed the next decision.
10. Retrospect and route reusable learning to BMA only after target evidence.
11. Rollover long parent issues before they become a new local closeout stack.

## Maturity Boundary

Assimilation work distinguishes four claim classes and never conflates them
(see `docs/maturity-boundary-claim-contract.md` for the full guard):

| Claim class | What it means | Proof required |
| --- | --- | --- |
| Repo-operating-model progress | Work closes through issue, PR, check, merge, readback. | GitHub truth and green required checks. |
| Repo-agent readiness | Purpose, principles, benchmark, owner-surface repair gates, validation legibility. | Benchmark changes repair selection and repairs have before/after deltas. |
| Repo-agent capability | The repo improves its own domain outputs through bounded mechanisms. | A real domain artifact improves against a purpose-aligned rubric. |
| Stack-integrated capability | BMA, Hermes, GBrain, repo-star play bounded roles without exceeding proof. | Receipts, exact readbacks, owner-surface PRs, no false authority transfer. |

GitHub closure and validation legibility can sound like repo-agent maturity:
**that is progress, but it is not autonomy.**

## Seeded Hypotheses (step 5 checklist)

Before fleet assessment, record candidate hypotheses so the read-only sweep can
confirm or refute them rather than rationalize whatever it finds. Each seeded
hypothesis names: the suspected gap, the dimension it maps to, and the
observable that would confirm or refute it. Seeded hypotheses are a process
step, not a detector, unless an n=2 sweep shows they change repair selection.

## Finding Classification (step 6 taxonomy)

The read-only sweep classifies every finding into exactly one bucket. This
taxonomy shapes the sweep output itself:

- **confirmed** — detector/rec fired and the gap is real on the target.
- **missed** — a real gap the tools did not detect.
- **new** — a gap surfaced that was not in the seeded hypotheses.
- **contradicted** — a detector fired but the target does not actually exhibit
  the gap (false positive; detectable because we know the target's hand-built
  state).
- **not-assessable** — the tools cannot see the dimension at all.

## Anti-Patterns

| Anti-pattern | How it appeared | Future guard |
| --- | --- | --- |
| Piecemeal hygiene in principles clothing | Repairs became warning/byte driven after strong pre-flight work. | Require a counterfactual: what would naive cleanup select, and why is this different? |
| Operating-model overclaim | GitHub closure and validation legibility sounded like repo-agent maturity. | Use the maturity boundary table before claiming capability. |
| Parent issue as infinite scroll | A campaign parent issue preserved truth while becoming hard to read. | Set a rollover rule by carrier count, time window, or scan burden. |
| Critique as ceremony | Critique improved the campaign but can become another planning lane. | One critique pass at true gates; only CRITICAL/HIGH blocks. |
| Green-check overclaim | Passing CI proves required checks, not independent review or domain quality. | Say "required checks passed"; do not call it quality proof. |
| Dirty checkout denial | A clean scratch target avoids contamination but not operator-local divergence. | Treat stale/divergent checkout as a first-class friction issue with owner action. |
| Advisory fleet overreach | Repo-star findings helped, but patchability evidence was weak. | Fleet findings stay advisory unless deterministic patch/check proof exists. |

## Transfer Lessons

Candidate transfer patterns — retained only when a future target shows they
change repair selection, reduce operator burden, or improve outcome proof:

- The carrier sequence as a learning scaffold, not a ceremony requirement.
- Principles-first audit before broad repair.
- Benchmark dimensions before repair selection.
- Seeded hypotheses before fleet assessment.
- Scratch-clone non-contact proof.
- Advisory-only fleet classification.
- Pre-repair decision blocks for first-in-family, domain, capability, or
  benchmark-changing work.
- Claim ledgers that separate operating-model progress from repo-agent
  capability.
- Parent-issue rollover guard.

Does **not** transfer: target-specific validators/source names, the exact carrier
count, the assumption every repo needs a long charter before any repair, and the
assumption that warning/byte reductions prove domain outcome progress.

## Required Record

| Field | Meaning |
| --- | --- |
| `artifact` | Must be `REPO_ASSIMILATION_METHOD_RECORD`. |
| `schema_version` | Integer record version. |
| `target_repo` | The repo-agent being assimilated. |
| `skeleton_steps_applied` | Which of the 11 steps were applied. |
| `mechanics_applied` | Which mechanic records exist (anchor, anthropology, benchmark, decision-block, maturity-boundary). |
| `seeded_hypotheses` | Hypotheses recorded before the sweep. |
| `finding_classification` | Counts per bucket (confirmed/missed/new/contradicted/not-assessable). |
| `maturity_claim_class` | Highest claim class the evidence supports. |
| `n_evidence` | Number of repos this method has been observed on (currently 2). |
| `decision_state` | One of `adopt`, `defer`, `owner-route`, `no-op`, `needs-proof`. |
| `bounded_non_claims` | Explicit limits, including the n=2 boundary. |

## Admission Rules

1. `artifact` must equal `REPO_ASSIMILATION_METHOD_RECORD` and `target_repo`
   must be named.
2. The skeleton is a checklist, not a gate: a target may apply a subset of steps
   and record why the others were skipped. Steps are not ceremony.
3. `maturity_claim_class` must not exceed the proof actually held (see the
   maturity-boundary contract). GitHub closure + green checks support only
   operating-model progress.
4. `finding_classification` must use the five buckets exactly; a `contradicted`
   finding is a detector false positive and routes to the owning fleet repo.
5. A mechanic earns its place only by firing usefully on a real sweep; the
   default bias is **cut**, not keep. `decision_state` records `needs-proof` or
   `no-op` for mechanics that did not change a selection.
6. `n_evidence` is a truthful observation count; the method does not claim
   doctrine status until `n_evidence` ≥ 3.

## Maturity And Proof

This method is at **n=2**: portfolio_advisor (n=1 reference) and
transcript_processor (n=2). Both campaigns currently support operating-model
progress and repo-agent readiness more strongly than repo-agent capability or
stack-integrated capability. The method proves *how to assimilate*, not that any
assimilated repo improved its domain outputs.

The n=2 evidence is now **detector-confirmed**, not only by-hand: a report-only
fleet sweep on transcript_processor `main` exercised the landed repo-auditor
detectors. **AS-51 (anchor)** and **AS-52 (anthropology)** fired as verified
true-gaps (graduate); **AS-53 (maturity-boundary)** correctly stayed silent — a
true-negative whose positive *catch* therefore remains n=1 (keep-candidate, not
graduated). The sweep also answered the optimizer question: governance-meta
assimilation gaps are **not optimizer-patchable** (the optimizer has no
deterministic materializer for governance families; such findings route to its
`PATCHABILITY_BLOCKERS` as `unsupported_or_unpatchable_recommendation`). This
confirms the detect+recommend placement and the "advisory fleet overreach" guard
above — the optimizer correctly stays out of governance-narrative authoring.

## Owner Routing

- A missing assimilation surface routes to the target repo's own owner issue.
- Detector gaps (a skeleton element the tools cannot see) route to
  **repo-auditor** via its owner issue/PR path.
- Recommendation gaps route to **repo-upgrade-advisor** via its owner issue/PR
  path.
- Reusable cross-repo learning routes to BMA only after target evidence exists.

## Bounded Non-Claims

This contract does not query GitHub, mutate GitHub, create issues or PRs, merge,
close, run a scheduler, start a daemon, create a queue, controller, or registry,
mutate downstream repos, or replace GitHub issue/PR/check/merge truth. It adds no
background memory and no auto-merge. The method is an n=2 observation, not proven
cross-repo doctrine, and it proves operating-model readiness rather than
repo-agent domain capability.
