# repo-agent-core

Portable shared primitives used by
[repo-auditor](https://github.com/briancl2/repo-auditor),
[repo-upgrade-advisor](https://github.com/briancl2/repo-upgrade-advisor), and
[repo-optimizer](https://github.com/briancl2/repo-optimizer).

The repository exports:

- JSON schemas for scorecards, findings, opportunities, optimization results,
  transfer receipts, and retained compatible artifact formats;
- `scripts/validate-artifacts.sh`;
- the copy-synced `scripts/compare-scorecards.sh` primitive and conformance gate;
- installable review hooks plus the `reviewing-code-locally` and
  `owner-delivery` skills; and
- one deterministic cached-index owner-convergence guard.

`CONSTITUTION.md` is the shared semantic floor. `AGENTS.md` is the compact owner
bootloader. The canonical delivery route is an owner issue, one branch, one pull
request, native checks, review, merge, and live readback.

## Use

```bash
make test
make validate-owner-convergence
make validate-compare-scorecards CONSUMERS="../repo-auditor ../repo-optimizer"
make review
```

Validate an exact caller set without checking out or mutating those revisions:

```bash
python3 scripts/validate_owner_convergence.py \
  --repo . \
  --base-ref <rollback-base> \
  --consumer auditor=/path/to/repo-auditor@<commit> \
  --consumer advisor=/path/to/repo-upgrade-advisor@<commit> \
  --consumer optimizer=/path/to/repo-optimizer@<commit>
```

The guard reads the core Git index and cached blobs. Consumer checks use exact
Git object revisions. Working-tree-only edits therefore cannot hide a staged
failure.

## Active and compatibility surfaces

[`docs/live-capability-inventory.md`](docs/live-capability-inventory.md) is the
single human-readable active-export and retired-name-successor inventory.
Compatibility-only documents, templates, schemas, and samples stay at their
existing paths while exact consumers still cite or consume them. They are not
active owner policy, and this repository does not add a replacement registry,
redirect stack, plan family, or control plane.

Shared scripts are copied into consumers rather than linked at runtime. Each
consumer remains independently runnable and owns its own issue, pull request,
checks, review, merge, and readback.

The portable
[`owner-delivery`](.agents/skills/owner-delivery/SKILL.md) skill keeps route
holds local, admits the requested native object rather than its transport, and
matches settlement to the actual effect. A consumer copies the skill directory
unchanged, adds one owner-local trigger naming route holds, admission,
settlement tier, epoch boundaries, and sparse continuation, then proves it on
one real owner outcome before claiming lower operator burden.
