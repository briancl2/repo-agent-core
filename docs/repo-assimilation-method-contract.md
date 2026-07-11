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
2. Freeze the operator ask and the anti-overclaim boundary, then record the
   actual operator/host/concurrency shape and smallest native architecture.
3. Build repo anthropology (purpose, use cases, deliverables, operator
   interaction model, defined principles, revealed principles).
4. Define benchmark dimensions before selecting repairs.
5. Seed hypotheses before fleet assessment.
6. Run repo-star read-only and classify findings (confirmed, missed, new,
   contradicted, not-assessable).
7. Use critique at boundary points, not as a standing product lane.
8. Admit repairs through a decision block only when it changes selection.
9. Pass the **Domain-Outcome Eval Gate** (below): for any domain enhancement,
   root-cause the true outcome lever (not a proxy), target the correct variable,
   pre-register the intended metric delta, and empirically validate that delta on
   the target's own eval before marking the enhancement done — reporting any
   null/negative result — all within the owner's product contracts. Then ask
   whether the metric changed the next decision.
10. Retrospect and route reusable learning to BMA only after target evidence.
11. Rollover long parent issues before they become a new local closeout stack.

## Solo Operator Native Architecture Check (step 2)

Assimilation decisions must describe the system that actually exists, not an
imagined organization. Record `operator_count`, `host_count`,
`actual_concurrency`, and `unattended_runtime_need` before choosing an
architecture. Then record `smallest_native_architecture`: the least complex
native shape that satisfies the observed need, the larger candidate being
considered, any concrete evidence that requires the larger shape, and the
disposition.

For one operator on one laptop, the default is the smallest foreground or
product-native shape that works. A controller, scheduler, queue, daemon,
registry, dashboard, retry loop, or other enterprise-style coordination layer
is rejected unless a concrete observed need shows why the smaller native shape
cannot satisfy the work. Aspirational scale, possible future collaborators, or
unmeasured unattended-runtime wishes are not evidence. `actual_concurrency`
records measured simultaneous work, not the number of possible lanes in a
plan; `unattended_runtime_need` records the observed task and evidence, or an
explicit `none_observed` state.

The same intake performs a compact stale-native-constraint check. The
`stale_native_constraint_intake` field records the old constraint, the current
native activation rule, proof and authority boundaries, touched validators or
tests, owner-surface evidence, and one disposition:

- `no_change` when the old constraint is still current (the clean control);
- `update_stale_constraint` when executable glue still enforces a superseded
  blanket ban;
- `preserve_valid_authority_boundary` when native activation changed but the
  route, source, review, mutation, or closure boundary remains valid; or
- `owner_route` when evidence or permission is insufficient.

This check updates stale expectations; it does not weaken still-valid authority
constraints or activate a native feature by itself. The feature's current
upstream instructions, owner-approved activation surface, safe native attempt,
and repo-native validation remain the proof boundary. GitHub issue/PR/check/
merge truth remains authoritative.

## Domain-Outcome Eval Gate (step 9)

Governance conformance is not a domain outcome. A **domain enhancement** — any
change whose purpose is to improve the repo's own domain outputs — is **not done**
until all five requirements hold. A green checklist, a passing benchmark dimension,
or a merged PR does **not** substitute for this gate.

1. **Root-cause the true lever.** Identify the outcome lever from grounded
   evaluation evidence, not a convenient proxy. Name the proxy you rejected and why
   it does not move the outcome.
2. **Target the correct variable.** Name the variable the enhancement changes and
   state why *it* — not an adjacent proxy — moves the outcome.
3. **Pre-register the metric delta.** Before building, register the intended metric
   and its expected direction on the target's own eval. Pre-registration makes a
   later null result legible instead of re-narratable.
4. **Empirically validate on the target's own eval.** Measure the pre-registered
   delta on the target's own eval (e.g. transcript_processor's HIGR judge, same
   judge before/after) before marking the enhancement done. A null or negative
   result must be **reported, never hidden or relabeled** as success.
5. **Respect owner/product contracts.** The chosen lever is the highest-ROI move
   *within stated constraints*. A lever that would breach an owner-ring-fenced
   output contract is deferred to an explicit owner decision — never silently
   swapped for a proxy that leaves the contract intact but the outcome unmoved.

The gate reinforces existing steps rather than replacing them: step 4
(benchmark-before-repair) supplies the eval dimensions, step 8
(repair-decision-block) already asks for the `expected_metric`, and this gate binds
step 9's measured delta to the *true* lever and forbids a proxy or a `pending`
delta from closing a domain enhancement. It is recorded in the
`validated_domain_outcome_delta` field of the required record.

### Worked example (i): a proxy metric closed a domain enhancement (TP spec 007)

transcript_processor spec 007 (reconciliation compaction) was marked done while it
(a) targeted a **proxy** — the reconciliation table's *row size* — instead of the
real conciseness lever, table **presence** in the reader body, and (b) never
measured the intended metric (conciseness) at all. Governance conformance was
treated as success and the RCA's top recommendation was downgraded. Under this gate
the enhancement fails requirements 1–4: the lever was a proxy, the metric was never
pre-registered, and no delta was validated. (Health-check finding refs: TP commit
`832cfcd`, gist `89357bee2a6ecc5d531a360338217802`.)

### Worked example (ii): a finding blamed a backstop, not the root cause (D4)

A health-check finding blamed a stray label on a deterministic sanitizer in the
generator. A controlled before/after on the same 9 benchmark samples proved that
was a **proxy backstop**: unmodified D4 = 12 → removing the sanitizer alone
D4 = 11 (barely moved — a redundant backstop) → fixing the actual
**prompt instruction** that told the model to emit the label D4 = 0. The root
cause was distributed across two more coupled prompt sources, not localized.
Same-judge
deltas on the fix (FIX_FINAL − UNMOD, n = 9; the rebuilt judge is **stricter**, so
only same-judge deltas are valid — not absolute vs the historical 4.127):
composite 2.952 → 3.095 (+0.143); faithfulness 2.333 → 2.556 (+0.223, up beyond
±0.2 noise); attribution 3.222 → 3.111 (−0.111, within noise, no regression);
conciseness 1.889 → 2.000 (+0.111, **flat as predicted — not claimed as a gain**);
actions 3.000 → 3.556 (+0.556, grounded synthesis produced better actions despite
fewer); hallucinations 81 → 61 (−20, ~25% down); misattributions 16 → 19 (flat).
Verdict CONFIRMED with the output contract **untouched** (the reconciliation
section stayed owner-ring-fenced per requirement 5); conciseness stayed floored **by
design**, because moving the table out of the reader body is the real conciseness
lever but requires an output-contract decision the owner reserved. Reporting the
flat conciseness result rather than hiding it is requirement 4 working as intended.

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
| Proxy-metric / governance-as-outcome | A domain enhancement closed on a proxy variable or on governance conformance without a validated domain-outcome delta (TP spec 007's row-size proxy; the D4 sanitizer-backstop misdiagnosis). | Domain-Outcome Eval Gate (step 9): root-cause the true lever, pre-register and validate the metric on the target's own eval, report nulls. |
| Dirty checkout denial | A clean scratch target avoids contamination but not operator-local divergence. | Treat stale/divergent checkout as a first-class friction issue with owner action. |
| Advisory fleet overreach | Repo-star findings helped, but patchability evidence was weak. | Fleet findings stay advisory unless deterministic patch/check proof exists. |
| Enterprise architecture by imagination | A solo operator on one laptop was modeled as a future organization, adding coordination machinery without an observed need. | Record operator/host/concurrency/runtime evidence first and admit the smallest native architecture; reject larger coordination layers without concrete need. |
| Stale native blanket ban | A native mode became owner-approved while validators or tests still enforced the old categorical ban. | Compare the old constraint to the current activation rule, preserve valid authority boundaries, and update only named stale executable glue with owner evidence. |

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
| `operator_count` | Count of actual operators responsible for the assimilated system. |
| `host_count` | Count of actual hosts needed by the observed operating shape. |
| `actual_concurrency` | Measured simultaneous work, not planned or aspirational lanes. |
| `unattended_runtime_need` | Observed unattended-runtime task and evidence, or explicit `none_observed`. |
| `smallest_native_architecture` | Least-complex native candidate, larger proposed shape, concrete observed need, and `admit_smallest_native` / `justify_larger_native` / `reject_enterprise_without_observed_need` disposition. |
| `stale_native_constraint_intake` | Compact old-constraint/current-rule/proof-boundary/authority-boundary/touched-validator-or-test/owner-evidence check with `no_change` / `update_stale_constraint` / `preserve_valid_authority_boundary` / `owner_route` disposition. |
| `skeleton_steps_applied` | Which of the 11 steps were applied. |
| `mechanics_applied` | Which mechanic records exist (anchor, anthropology, benchmark, decision-block, maturity-boundary). |
| `seeded_hypotheses` | Hypotheses recorded before the sweep. |
| `finding_classification` | Counts per bucket (confirmed/missed/new/contradicted/not-assessable). |
| `maturity_claim_class` | Highest claim class the evidence supports. |
| `validated_domain_outcome_delta` | The Domain-Outcome Eval Gate result (step 9) for any domain enhancement: the true `outcome_lever`, the `rejected_proxy`, the `target_variable`, the `pre_registered_metric`, the `target_own_eval`, the `measured_delta`, `owner_contract_respected`, and a `result_class` of `confirmed` / `null-reported` / `negative-reported` / `not-applicable`. An assimilation with no domain enhancement uses the justified-null form `{"result_class": "not-applicable", "reason": "…"}`. |
| `n_evidence` | Number of repos this method has been observed on (currently 2). |
| `decision_state` | One of `adopt`, `defer`, `owner-route`, `no-op`, `needs-proof`. |
| `bounded_non_claims` | Explicit limits, including the n=2 boundary. |

## Admission Rules

1. `artifact` must equal `REPO_ASSIMILATION_METHOD_RECORD` and `target_repo`
   must be named.
2. The skeleton is a checklist, not a universal gate: a target may apply a
   subset of steps and record why the others were skipped. Step 9 is the narrow
   exception: it is conditionally mandatory when the work includes a domain
   enhancement, and records `not-applicable` only when no domain enhancement
   exists. Steps are not ceremony.
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
7. `validated_domain_outcome_delta` gates every domain enhancement (step 9,
   Domain-Outcome Eval Gate). A "done" domain enhancement or any repo-agent
   **capability** maturity claim requires `result_class: "confirmed"` measured on
   the target's own eval; a proxy metric or a `pending` delta is inadmissible; a
   null or negative result must be present and reported, not hidden or relabeled;
   and an assimilation carrying no domain enhancement records `not-applicable` with
   a reason.
8. The operating shape must reflect actual evidence. When `operator_count` is
   `1`, `host_count` is `1`, and no concrete need requires a larger shape,
   enterprise-style coordination components must be recorded as
   `reject_enterprise_without_observed_need`; possible future scale is not a
   justification.
9. `stale_native_constraint_intake` must not infer migration friction from the
   mere presence of a constraint. `update_stale_constraint` requires a current
   activation rule, owner-surface evidence, a named touched validator/test, and
   preserved proof and authority boundaries. A current constraint records
   `no_change`; insufficient evidence records `owner_route`.

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
repo-agent domain capability. The Domain-Outcome Eval Gate records a validated
delta on the target's own eval or an explicit justified null; it does not itself
run any eval, mutate the target, or convert governance conformance into a
domain-outcome claim. The solo operating-shape and stale-native-constraint
intakes are advisory evidence fields, not authorization to activate services,
weaken authority boundaries, or add coordination machinery.
