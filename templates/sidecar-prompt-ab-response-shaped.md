# Sidecar Prompt A/B Response-Shaped Protocol

> Based on repo-agent-core `docs/sidecar-prompt-ab-response-shaped-contract.md`.
> Copy this template into a prompt bundle or cite the source contract.

| Field | Value |
|---|---|
| Sidecar surface |  |
| Prompt A objective | Assumption-gap first:  |
| Prompt A response evidence |  |
| Prompt A acceptance check |  |
| Prompt B mode | `response-shaped` / `hypothetical-draft` |
| Prompt B inputs | Prompt A response sections; live GitHub/repo truth; boundaries; operator corrections:  |
| Prompt B reconciliation task | Reconcile actual Prompt A answer against current GitHub/repo truth before recommending owner action. |
| Current-truth check |  |
| Output shape | One exact owner-surface action; first deliverable/PR shape; validation; stop rules; bounded non-claims. |
| Regrowth boundary | No automation, retained closure package, controller, queue, scheduler, registry, daemon, retry loop, sidecar runner, or background memory behavior added. |

## Prompt A

Ask for:

- assumption gaps;
- missing evidence;
- stale claims;
- contradictions;
- operator-intent conflicts;
- source/provenance questions;
- evidence needed before Prompt B can safely plan.

## Prompt B

Prompt B mode: `response-shaped`

Use only after the actual Prompt A response exists. Reconcile:

- Prompt A accepted claims:
- Prompt A rejected claims:
- Prompt A stale claims:
- Prompt A unsupported claims:
- Prompt A blocked claims:

Then return:

- Executive verdict:
- Current GitHub/repo truth:
- One exact owner-surface action:
- First deliverable or PR shape:
- Validation scope:
- Stop rules:
- Bounded non-claims:

## Hypothetical Draft Boundary

If Prompt B is drafted before the actual Prompt A response exists, label it
`hypothetical-draft` and include:

- This draft cannot claim Prompt A reconciliation.
- This draft must not be treated as campaign direction.
- Regenerate Prompt B after the actual Prompt A response exists.
