# LEARNINGS — repo-agent-core

Durable, generalized operating-model learnings for the repo-agent fleet's
shared-contract core. Unlike the operational tool repos (repo-auditor,
repo-upgrade-advisor, repo-optimizer), repo-agent-core has no runtime that
accumulates per-run lessons; this file therefore records **cross-fleet
operating-model learnings** that belong with the shared contracts, templates,
and schemas the fleet depends on.

| # | Learning | Source |
|---|---|---|
| L1 | Fix tooling false-positives at the detector rule, not by contorting product code. Anti-pattern/lint substring and regex detectors recur and false-match legitimate identifiers and idioms (e.g. the stdlib kwarg `start_new_session=True`, a guarded size ternary). The repair is to harden the rule (anchor/word-boundary/`grep --`/`-F`), never to bend correct code; recurring fleet false-positives get fixed once in the shared detector template (owned by repo-auditor), which makes detector-rule discipline a shared-contract concern this core repo is the natural home for. The anti-pattern gate can also be CI-only, so run the CI preflight locally to replicate. | Propagated 2026-06-28 from BMA transcript_processor system-maturation campaign (BMA LEARNINGS.md L945; transcript #38 rule-[5] anchor, #42 rule-[1] `os.setsid` workaround, #43 word-boundary fix). Generalized fleet learning. |
| L2 | A founding/governance PR that ratifies a green-gate principle must itself land on a genuinely green board. Clear any pre-existing red (even a false-positive) before merging the PR that establishes 'a red gate is not closure / CI state is truth,' so the founding change proves its own principle rather than contradicting it on day one. | Propagated 2026-06-28 from BMA transcript_processor system-maturation campaign (BMA LEARNINGS.md L946; transcript G0 #36 required clearing red false-positive #38 first). Generalized fleet learning. |
| L3 | Autonomy escape hatches must be per-leg named and two-factor, never a single global bypass. Scope each gate-skip to ONE leg (the others stay non-escapable) and require two factors — an env flag plus a written reason, rejecting whitespace-only — and give a new outage class its own named escape instead of widening an existing one. | Propagated 2026-06-28 from BMA transcript_processor system-maturation campaign (BMA LEARNINGS.md L947; transcript #33/#39 P9 work-close scoped `SKIP_REVIEW` to the review leg only, critique+hypothesis non-escapable). Generalized fleet learning. |
