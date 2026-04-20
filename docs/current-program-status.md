# Current Program Status

> Date: 2026-04-20
> Repo role: shared-core contract host for the external-critique calibration tranche
> Canonical cross-repo authority (local sibling-repo path): [exact-shape-hunt-wheel-spinning-and-external-critique-calibration-2026-04-20.md](../../build-meta-analysis/research/reports/exact-shape-hunt-wheel-spinning-and-external-critique-calibration-2026-04-20.md)
> Local-path note: these links assume the shared `~/repos` workspace layout.

## Current Local State

`repo-agent-core` is the shared primitive layer for the current fleet tranche.
Local `main` now documents the shared calibration fields carried on the shared
receipt-plus-critique pair:

- [`TRANSFER_ORACLE_RECEIPT`](../schemas/TRANSFER_ORACLE_RECEIPT.schema.json)
- [`CRITIQUE_RESULT`](../schemas/CRITIQUE_RESULT.schema.json)

The other shared schemas remain unchanged in this batch. This tranche only
needed the calibration fields on the transfer and critique surfaces that cross
between advisor, optimizer, and the newsletter proving ground.

In plain language: the shared fleet now has one documented way to say whether a
capability is helper-only, bounded-calibrated, or reusable, and whether
downstream admission is blocked, bounded, or ready.

## Shared Batch Truth

The live decomposition batch is no longer the publication-authority search
lane. The current shared result is:

- the speculative exact-shape hunt is memorialized and guarded on BMA
- external-critique calibration metadata now lands through advisor and
  optimizer surfaces
- the newsletter repo now has one bounded downstream proving-ground test for
  the mixed helper-only plus bounded non-helper gate
- helper-only critique evidence still stays blocked
- bounded non-helper critique evidence stays bounded and non-remediating

## Current Blocker

There is no shared-core blocker on the contract shape itself. The remaining
limit is semantic, not structural: the current calibration path is still
fail-closed and does not admit remediation or publication from shared-core
state alone.

## Next Candidate Move

Hold this shared contract steady unless a later batch needs to widen the same
mixed calibration gate to another downstream consumer. Do not reopen the
publication-authority search from this repo alone.

## Validation Expectations

- `make review` before commit
- `make test` for schema or template changes
- no publication-ready or remediation-ready claims from this repo alone
