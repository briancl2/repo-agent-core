# Compare-Scorecards Distribution Model

Supported model: copy-sync with drift gate.

`repo-agent-core` is the source of truth for `scripts/compare-scorecards.sh`.
Consumers keep repo-local copies so each repo remains independently runnable.
The contract is not a runtime import, symlink, package dependency, or generated
copy workflow.

## Why this model

- It matches the existing fleet convention that primitives are copied, not
  imported at runtime.
- It keeps consumers usable without `repo-agent-core` on disk.
- It is already testable with a hash gate and behavior fixtures.
- It avoids mutating consumers until a specific consumer migration PR is opened.

## Required gate

Run the conformance gate against every consumer copy before claiming the shared
primitive is synchronized:

```bash
bash scripts/check-compare-scorecards-conformance.sh ../repo-auditor ../repo-optimizer
```

Or use the make target:

```bash
make validate-compare-scorecards CONSUMERS="../repo-auditor ../repo-optimizer"
```

The gate must verify both:

1. the consumer `scripts/compare-scorecards.sh` hash matches the core copy
2. stable, pass, regression, and missing-input fixtures match core behavior

Any hash or behavior drift is a fail-closed result. Updating a consumer copy is
a separate consumer PR, not part of this core validation by itself.

## Unsupported alternatives

Runtime wrapper is not supported. It would make consumer behavior depend on a
runtime path or package relationship that the fleet does not currently require
or validate.

Generated consumer copies are not supported yet. A generator may be added later,
but it would need its own tests, consumer adoption plan, and PRs proving that
generated output is identical to the core primitive.

## Non-claims

- This document validates the distribution model only; it does not migrate any
  consumer.
- Passing the synthetic tests proves the gate catches drift shapes, not that a
  consumer PR has landed.
- Passing the explicit consumer gate proves the checked copies match the current
  core script at that moment only.
