# repo-agent-core

Shared primitives for the **repo-agent fleet** — schemas, templates, hooks, and scoring infrastructure used by [repo-auditor](https://github.com/briancl2/repo-auditor), [repo-upgrade-advisor](https://github.com/briancl2/repo-upgrade-advisor), and [repo-optimizer](https://github.com/briancl2/repo-optimizer).

## Quick Start

```bash
# Review staged changes before committing
make review

# Validate schemas
make test

# Validate compare-scorecards copy-sync drift gate
make validate-compare-scorecards CONSUMERS="../repo-auditor ../repo-optimizer"
```

## Structure

```
schemas/                    # Machine-readable inter-agent contracts
  SCORECARD.schema.json     # Audit health scorecard (5 dimensions, 0-100)
  OPPORTUNITIES.schema.json # Advisor recommendation format
  OPTIMIZATION_SCORECARD.schema.json # Optimization result format
  COMMAND_OUTPUT_ROI_RECEIPT.schema.json # Command-output summarization receipt
  TOKEN_MEASUREMENT_SUMMARY.schema.json # Additive token-efficiency summary
  HOTSPOT_EVIDENCE_PACKETS.schema.json  # Additive hotspot evidence packets
  AGENTIC_ROOT_CAUSE_BRIEFS.schema.json # Additive bounded brief handoff
  TRANSFER_ORACLE_RECEIPT.schema.json # Shared transfer-readiness receipt + calibration metadata
  CRITIQUE_RESULT.schema.json # Shared critique result + calibration metadata
  PLAYBOOK_MANIFEST_AUTHORITY.schema.json # Shared playbook/manifest authority
  ADAPTER_AUDIT_SUMMARY.schema.json # Shared adapter audit summary
  SOURCE_INSIGHT_PACKET.schema.json # Shared source-intelligence intake packet
templates/                  # Shared templates
  v3.1-markdown-handoff.md  # Subagent handoff template
  optimizer_policy.yaml     # Token budget ratchet policy
  findings-table.md         # Findings table format (renamed from findings.schema.md in the historical BMA planning corpus)
  transfer-readiness.md     # Transfer oracle receipt template
  playbook-manifest-authority.md # Authority declaration template
  adapter-audit-summary.md  # Adapter audit summary template
  bounded-non-claims.md     # Bounded non-claims template
scripts/                    # Hook scripts
  pre-commit-hook.sh        # v2 hard-default review (blocks by default)
  pre-push-hook.sh          # Push review warning
  compare-scorecards.sh     # Shared scorecard comparison primitive
  check-compare-scorecards-conformance.sh # Fixture + hash drift gate for consumer copies
docs/
  compare-scorecards-distribution.md # Supported copy-sync distribution model
.agents/skills/             # Shared skills
  reviewing-code-locally/   # Pre-commit code review skill
detection-signatures/       # DS-1 through DS-21
```

## Dependency Graph

```
                 repo-agent-core  ← you are here
                /       |        \
               v        v         v
       repo-auditor  repo-upgrade-advisor  repo-optimizer
```

Each agent depends only on `repo-agent-core`. Agents copy primitives (not symlink) — each is independently runnable. The supported `compare-scorecards` distribution model is [copy-sync with a drift gate](docs/compare-scorecards-distribution.md).

## Source Insight Contract

`SOURCE_INSIGHT_PACKET` is the shared primitive for source-intelligence work.
It gives operator-provided links, field reports, official docs, local artifacts,
session logs, and historical commits equal first-pass insight treatment before
claims are ranked by proof strength. It is intentionally a foreground artifact
contract, not a crawler, scheduler, queue, memory daemon, or controller.

The first consumers are:

- `repo-auditor`: detect source bundles that omit insight/no-insight coverage
  or owner/no-action routing.
- `repo-upgrade-advisor`: render source-driven recommendations while preserving
  source IDs, claim IDs, evidence tiers, and bounded non-claims.

## License

MIT
