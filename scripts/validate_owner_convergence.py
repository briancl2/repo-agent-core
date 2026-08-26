#!/usr/bin/env python3
"""Fail-closed cached-Git validation for the repo-agent-core owner package."""

from __future__ import annotations

import argparse
import fnmatch
import json
import os
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path


INVENTORY_PATH = "docs/live-capability-inventory.md"
ACTIVE_AUTHORITY = ("AGENTS.md", "README.md")
CALLER_LABELS = ("auditor", "advisor", "optimizer")
# Exact-copy exports remain byte-identical to the rollback base. The fleet audit
# is Core-owned behavior and is covered by owner evidence plus focused tests.
PRESERVED_FLOOR_EXPORTS = ("scripts/validate-floor-receipt.sh",)
RETIRED_AUTHORITY_TOKENS = (
    "Issue #164",
    "Hermes",
    "GBrain",
    "Runtime Learning Shadow",
    "Speckit",
    "Spec Kit",
    "sidecar",
    "campaign",
)


class ConvergenceError(RuntimeError):
    """A deterministic validation failure."""


@dataclass(frozen=True)
class IndexEntry:
    mode: str
    sha: str
    path: str


@dataclass(frozen=True)
class Evidence:
    path: str
    token: str


@dataclass(frozen=True)
class ActiveExport:
    pattern: str
    classification: str
    evidence: dict[str, tuple[Evidence, ...]]


def git(repo: Path, *args: str, ok_no_match: bool = False) -> bytes:
    proc = subprocess.run(
        ["git", "--no-replace-objects", "-C", str(repo), *args],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    if proc.returncode == 0:
        return proc.stdout
    if ok_no_match and proc.returncode == 1:
        return b""
    detail = proc.stderr.decode("utf-8", "replace").strip()
    raise ConvergenceError(
        f"git {' '.join(args)} failed with exit {proc.returncode}: {detail}"
    )


def index_entries(repo: Path) -> dict[str, IndexEntry]:
    raw = git(repo, "ls-files", "--stage", "-z")
    result: dict[str, IndexEntry] = {}
    for record in raw.split(b"\0"):
        if not record:
            continue
        try:
            metadata, encoded_path = record.split(b"\t", 1)
            mode, sha, stage = metadata.decode("ascii").split()
            path = encoded_path.decode("utf-8")
        except (ValueError, UnicodeDecodeError) as exc:
            raise ConvergenceError("malformed or non-UTF-8 Git index entry") from exc
        if stage != "0":
            raise ConvergenceError(f"unmerged Git index entry: {path}")
        if path in result:
            raise ConvergenceError(f"duplicate Git index entry: {path}")
        result[path] = IndexEntry(mode=mode, sha=sha, path=path)
    if not result:
        raise ConvergenceError("Git index is empty")
    return result


def blob(repo: Path, sha: str) -> bytes:
    return git(repo, "cat-file", "blob", sha)


def text_blob(repo: Path, sha: str, path: str) -> str:
    try:
        return blob(repo, sha).decode("utf-8")
    except UnicodeDecodeError as exc:
        raise ConvergenceError(f"cached blob is not UTF-8: {path}") from exc


def section_table(text: str, heading: str) -> list[list[str]]:
    lines = text.splitlines()
    try:
        start = lines.index(heading) + 1
    except ValueError as exc:
        raise ConvergenceError(f"inventory missing section: {heading}") from exc
    rows: list[list[str]] = []
    table_started = False
    for line in lines[start:]:
        if line.startswith("## "):
            break
        if not line.startswith("|"):
            if table_started and line.strip():
                break
            continue
        cells = [cell.strip().strip("`") for cell in line.strip().strip("|").split("|")]
        if not table_started:
            table_started = True
            continue
        if all(set(cell) <= {"-", ":"} for cell in cells):
            continue
        rows.append(cells)
    if not rows:
        raise ConvergenceError(f"inventory section has no rows: {heading}")
    return rows


def matching_paths(paths: set[str], pattern: str) -> list[str]:
    return sorted(path for path in paths if fnmatch.fnmatchcase(path, pattern))


def parse_evidence(cell: str, label: str, pattern: str) -> tuple[Evidence, ...]:
    if cell == "-":
        return ()
    result: list[Evidence] = []
    for item in cell.split(","):
        item = item.strip().strip("`")
        if item.count("::") != 1:
            raise ConvergenceError(
                f"{label} evidence must use path::literal-token for {pattern}: {item}"
            )
        path, token = (part.strip() for part in item.split("::", 1))
        if not path or not token:
            raise ConvergenceError(f"empty {label} evidence for active export: {pattern}")
        result.append(Evidence(path=path, token=token))
    return tuple(result)


def parse_inventory(
    repo: Path, index: dict[str, IndexEntry]
) -> tuple[
    list[ActiveExport],
    list[tuple[str, str]],
    list[str],
    list[str],
    dict[str, int],
]:
    if INVENTORY_PATH not in index:
        raise ConvergenceError(f"missing active inventory: {INVENTORY_PATH}")
    inventory = text_blob(
        repo, index[INVENTORY_PATH].sha, INVENTORY_PATH
    )
    active_rows = section_table(inventory, "## Active exports")
    compatibility_rows = section_table(inventory, "## Compatibility-only retained paths")
    removed_rows = section_table(inventory, "## Removed-name successor rules")
    terminal_rows = section_table(inventory, "## Exact terminal retirements")

    active: list[ActiveExport] = []
    claimed_paths: set[str] = set()
    manifest_paths: list[str] = []
    index_paths = set(index)
    evidence_labels = ("owner", *CALLER_LABELS)
    for row in active_rows:
        if len(row) != 6:
            raise ConvergenceError("active export row must have six columns")
        pattern, classification, *evidence_cells = row
        expanded = matching_paths(index_paths, pattern)
        if not expanded:
            raise ConvergenceError(f"active export pattern matches no index path: {pattern}")
        overlap = claimed_paths.intersection(expanded)
        if overlap:
            raise ConvergenceError(
                f"active export path is declared more than once: {sorted(overlap)[0]}"
            )
        claimed_paths.update(expanded)
        evidence = {
            label: parse_evidence(cell, label, pattern)
            for label, cell in zip(evidence_labels, evidence_cells)
        }
        if not evidence["owner"]:
            raise ConvergenceError(f"orphan active export has no owner evidence: {pattern}")
        if classification == "owner-manifest":
            manifest_paths.extend(expanded)
        active.append(
            ActiveExport(
                pattern=pattern,
                classification=classification,
                evidence=evidence,
            )
        )

    if manifest_paths != [INVENTORY_PATH]:
        raise ConvergenceError(
            f"expected one owner-manifest at {INVENTORY_PATH}, got {manifest_paths}"
        )

    compatibility: list[str] = []
    compatibility_paths: set[str] = set()
    for row in compatibility_rows:
        if len(row) != 2:
            raise ConvergenceError("compatibility-only row must have two columns")
        pattern, _ = row
        if pattern in compatibility:
            raise ConvergenceError(f"duplicate compatibility pattern: {pattern}")
        expanded = matching_paths(index_paths, pattern)
        if not expanded:
            raise ConvergenceError(
                f"compatibility pattern matches no cached index path: {pattern}"
            )
        compatibility.append(pattern)
        compatibility_paths.update(expanded)

    schema_paths = {
        path
        for path in index_paths
        if path.startswith("schemas/") and path.endswith(".schema.json")
    }
    classification_overlap = claimed_paths.intersection(compatibility_paths)
    if classification_overlap != schema_paths:
        unexpected = sorted(classification_overlap - schema_paths)
        missing = sorted(schema_paths - classification_overlap)
        raise ConvergenceError(
            "active/compatibility overlap must equal the exported schema set; "
            f"unexpected={unexpected}, missing={missing}"
        )
    classified_paths = claimed_paths.union(compatibility_paths)
    unclassified = sorted(index_paths - classified_paths)
    if unclassified:
        raise ConvergenceError(
            f"unclassified cached index paths ({len(unclassified)}): "
            + ", ".join(unclassified)
        )

    removed_rules: list[tuple[str, str]] = []
    for row in removed_rows:
        if len(row) != 2:
            raise ConvergenceError("removed-name successor rule must have two columns")
        pattern, successor = row
        if any(pattern == existing for existing, _ in removed_rules):
            raise ConvergenceError(f"duplicate removed-name pattern: {pattern}")
        if successor not in index:
            raise ConvergenceError(
                f"removed-name successor is not in cached index: {pattern} -> {successor}"
            )
        removed_rules.append((pattern, successor))

    terminal_retirements: list[str] = []
    for row in terminal_rows:
        if len(row) != 2:
            raise ConvergenceError("terminal-retirement row must have two columns")
        path, disposition = row
        if disposition != "retired-without-successor":
            raise ConvergenceError(
                f"unknown terminal-retirement disposition: {path} -> {disposition}"
            )
        if any(character in path for character in "*?["):
            raise ConvergenceError(
                f"terminal retirement must name one exact path: {path}"
            )
        if path in terminal_retirements:
            raise ConvergenceError(f"duplicate terminal-retirement path: {path}")
        if path in index:
            raise ConvergenceError(
                f"terminal-retirement path remains in cached index: {path}"
            )
        terminal_retirements.append(path)

    return active, removed_rules, terminal_retirements, compatibility, {
        "classified_index_paths": len(classified_paths),
        "classification_overlap_paths": len(classification_overlap),
        "unclassified_index_paths": len(unclassified),
    }


def validate_active_prose(repo: Path, index: dict[str, IndexEntry]) -> None:
    for path in ACTIVE_AUTHORITY:
        if path not in index:
            raise ConvergenceError(f"missing active authority file: {path}")
        text = text_blob(repo, index[path].sha, path)
        for token in RETIRED_AUTHORITY_TOKENS:
            if token.casefold() in text.casefold():
                raise ConvergenceError(
                    f"retired authority token remains active in {path}: {token}"
                )


def validate_active_utf8(
    repo: Path, index: dict[str, IndexEntry], active: list[ActiveExport]
) -> int:
    checked: set[str] = {INVENTORY_PATH, *ACTIVE_AUTHORITY}
    index_paths = set(index)
    for export in active:
        for path in matching_paths(index_paths, export.pattern):
            if path.endswith((".md", ".json", ".py", ".sh", ".yaml", ".yml")):
                checked.add(path)
    for path in sorted(checked):
        text_blob(repo, index[path].sha, path)
    return len(checked)


def tree_entries(repo: Path, ref: str) -> dict[str, str]:
    raw = git(repo, "ls-tree", "-r", "-z", "--full-tree", ref)
    result: dict[str, str] = {}
    for record in raw.split(b"\0"):
        if not record:
            continue
        try:
            metadata, encoded_path = record.split(b"\t", 1)
            _, object_type, sha = metadata.decode("ascii").split()
            path = encoded_path.decode("utf-8")
        except (ValueError, UnicodeDecodeError) as exc:
            raise ConvergenceError(f"malformed tree entry at {ref}") from exc
        if object_type == "blob":
            result[path] = sha
    return result


def tree_paths(repo: Path, ref: str) -> set[str]:
    raw = git(
        repo,
        "ls-tree",
        "-r",
        "-t",
        "-z",
        "--name-only",
        "--full-tree",
        ref,
    )
    try:
        return {
            record.decode("utf-8")
            for record in raw.split(b"\0")
            if record
        }
    except UnicodeDecodeError as exc:
        raise ConvergenceError(f"non-UTF-8 tree path at {ref}") from exc


def validate_evidence(
    repo: Path,
    blobs: dict[str, str],
    item: Evidence,
    label: str,
    export: str,
) -> None:
    sha = blobs.get(item.path)
    if sha is None:
        raise ConvergenceError(
            f"{label} evidence path missing for active export {export}: {item.path}"
        )
    content = text_blob(repo, sha, item.path)
    if item.token not in content:
        raise ConvergenceError(
            f"{label} evidence token missing for active export {export}: "
            f"{item.path}::{item.token}"
        )


def validate_owner_evidence(
    repo: Path, index: dict[str, IndexEntry], active: list[ActiveExport]
) -> int:
    blobs = {path: entry.sha for path, entry in index.items()}
    checks = 0
    for export in active:
        for item in export.evidence["owner"]:
            validate_evidence(repo, blobs, item, "owner", export.pattern)
            checks += 1
    return checks


def validate_base_delta(
    repo: Path,
    index: dict[str, IndexEntry],
    removed_rules: list[tuple[str, str]],
    terminal_retirements: list[str],
    compatibility: list[str],
    base_ref: str,
) -> tuple[list[str], dict[str, int]]:
    base = tree_entries(repo, base_ref)
    base_paths = set(base)
    index_paths = set(index)
    deleted = sorted(base_paths - index_paths)

    assignments: dict[str, list[str]] = {path: [] for path in deleted}
    for pattern, _ in removed_rules:
        base_matches = matching_paths(base_paths, pattern)
        retained = matching_paths(index_paths, pattern)
        if retained:
            raise ConvergenceError(
                f"removed-name rule still matches cached path: {pattern} -> {retained[0]}"
            )
        for path in base_matches:
            if path in assignments:
                assignments[path].append(pattern)

    for path in terminal_retirements:
        if path in assignments:
            assignments[path].append(f"terminal:{path}")

    for path, rules in assignments.items():
        if len(rules) != 1:
            raise ConvergenceError(
                f"deleted path must match exactly one removed-name rule: "
                f"{path} matched {rules}"
            )

    compatibility_paths: set[str] = set()
    for pattern in compatibility:
        before = matching_paths(base_paths, pattern)
        after = matching_paths(index_paths, pattern)
        if not before:
            raise ConvergenceError(
                f"compatibility pattern matches no rollback-base path: {pattern}"
            )
        added = sorted(set(after) - set(before))
        if added:
            raise ConvergenceError(
                f"compatibility pattern gained a path after rollback base: "
                f"{pattern} -> {added[0]}"
            )
        removed = sorted(set(before) - set(after))
        for path in removed:
            if path not in terminal_retirements:
                raise ConvergenceError(
                    f"compatibility path set changed from rollback base: {pattern} -> {path}"
                )
        for path in after:
            if base[path] != index[path].sha:
                raise ConvergenceError(
                    f"compatibility blob changed from rollback base: {path}"
                )
            compatibility_paths.add(path)

    if "CONSTITUTION.md" not in base or "CONSTITUTION.md" not in index:
        raise ConvergenceError("constitution missing from base or cached index")
    if base["CONSTITUTION.md"] != index["CONSTITUTION.md"].sha:
        raise ConvergenceError("CONSTITUTION.md bytes changed from rollback base")

    schemas = [
        path
        for path in index
        if path.startswith("schemas/") and path.endswith(".schema.json")
    ]
    for path in schemas:
        if base.get(path) != index[path].sha:
            raise ConvergenceError(f"exported schema bytes changed from base: {path}")
    for path in PRESERVED_FLOOR_EXPORTS:
        if path not in base or path not in index:
            raise ConvergenceError(
                f"preserved floor export missing from base or cached index: {path}"
            )
        if base[path] != index[path].sha:
            raise ConvergenceError(
                f"preserved floor export bytes changed from base: {path}"
            )
    return deleted, {
        "removed_rules": len(removed_rules),
        "terminal_retirements": len(terminal_retirements),
        "deleted_paths": len(deleted),
        "rollback_paths": len(deleted),
        "compatibility_paths": len(compatibility_paths),
        "unchanged_schema_blobs": len(schemas),
        "unchanged_floor_export_blobs": len(PRESERVED_FLOOR_EXPORTS),
    }


def parse_consumer(value: str) -> tuple[str, Path, str]:
    if "=" not in value or "@" not in value:
        raise ConvergenceError(
            "consumer must use label=/absolute/repository@exact-ref"
        )
    label, location = value.split("=", 1)
    repo_text, ref = location.rsplit("@", 1)
    if label not in CALLER_LABELS:
        raise ConvergenceError(f"unknown consumer label: {label}")
    repo = Path(repo_text).resolve()
    if not repo.is_dir():
        raise ConvergenceError(f"consumer repository is not a directory: {repo}")
    git(repo, "cat-file", "-e", f"{ref}^{{commit}}")
    return label, repo, ref


def grep_ref(repo: Path, ref: str, patterns: tuple[str, ...]) -> int:
    if not patterns:
        return 0
    args = ["grep", "-z", "-I", "-l", "-F"]
    for pattern in patterns:
        args.extend(("-e", pattern))
    args.extend((ref, "--"))
    raw = git(repo, *args, ok_no_match=True)
    return len([record for record in raw.split(b"\0") if record])


def grep_terminal_refs(
    repo: Path,
    ref: str,
    patterns: tuple[str, ...],
) -> tuple[str, ...]:
    if not patterns:
        return ()
    args = ["grep", "-z", "-a", "-l", "-F"]
    for pattern in patterns:
        args.extend(("-e", pattern))
    args.extend((ref, "--"))
    raw = git(repo, *args, ok_no_match=True)
    prefix = f"{ref}:".encode("utf-8")
    try:
        paths: list[str] = []
        for record in raw.split(b"\0"):
            if not record:
                continue
            if not record.startswith(prefix):
                raise ConvergenceError(
                    f"malformed terminal-reference result at {ref}"
                )
            paths.append(record[len(prefix):].decode("utf-8"))
        return tuple(paths)
    except UnicodeDecodeError as exc:
        raise ConvergenceError(
            f"non-UTF-8 terminal-reference path at {ref}"
        ) from exc


def parse_historical_consumer_path(value: str) -> tuple[str, str]:
    if "=" not in value:
        raise ConvergenceError(
            "historical consumer path must use label=exact/repository/path"
        )
    label, path = value.split("=", 1)
    if label not in CALLER_LABELS:
        raise ConvergenceError(f"unknown historical consumer label: {label}")
    if not path or path.startswith("/") or "\0" in path:
        raise ConvergenceError(
            f"historical consumer path must be one exact relative Git path: {value}"
        )
    return label, path


def validate_consumers(
    active: list[ActiveExport],
    deleted_paths: list[str],
    terminal_retirements: list[str],
    values: list[str],
    historical_values: list[str],
) -> dict[str, int]:
    declared_checks = sum(
        len(export.evidence[label])
        for export in active
        for label in CALLER_LABELS
    )
    if not values:
        if historical_values:
            raise ConvergenceError(
                "historical consumer paths require exact consumer snapshots"
            )
        return {
            "consumer_count": 0,
            "declared_caller_checks": declared_checks,
            "caller_checks": 0,
            "removed_reference_files": 0,
            "historical_terminal_reference_files": 0,
        }
    parsed = [parse_consumer(value) for value in values]
    labels = [label for label, _, _ in parsed]
    if len(labels) != len(set(labels)):
        raise ConvergenceError("duplicate consumer label")
    if set(labels) != set(CALLER_LABELS):
        raise ConvergenceError(
            f"exact caller oracle requires {sorted(CALLER_LABELS)}, got {sorted(labels)}"
        )

    historical_paths: dict[str, set[str]] = {label: set() for label in CALLER_LABELS}
    for value in historical_values:
        label, path = parse_historical_consumer_path(value)
        if path in historical_paths[label]:
            raise ConvergenceError(
                f"duplicate historical consumer path: {label}={path}"
            )
        historical_paths[label].add(path)

    caller_checks = 0
    removed_reference_files = 0
    historical_terminal_reference_files = 0
    deleted_patterns = tuple(deleted_paths)
    terminal_patterns = tuple(terminal_retirements)
    for label, repo, ref in parsed:
        tree = tree_entries(repo, ref)
        active_caller_paths = {
            item.path
            for export in active
            for item in export.evidence[label]
        }
        for export in active:
            for item in export.evidence[label]:
                validate_evidence(repo, tree, item, f"{label}@{ref}", export.pattern)
                caller_checks += 1
        removed_reference_files += grep_ref(repo, ref, deleted_patterns)
        # The exact retired path itself is a retained consumer artifact. A
        # textual match is a live reference unless the invocation explicitly
        # classifies that exact existing matching blob as historical evidence.
        terminal_tree_paths = sorted(tree_paths(repo, ref).intersection(terminal_patterns))
        if terminal_tree_paths:
            raise ConvergenceError(
                "terminal-retirement path remains present in "
                f"{label}@{ref}: {len(terminal_tree_paths)} path(s)"
            )
        terminal_reference_paths = set(
            grep_terminal_refs(repo, ref, terminal_patterns)
        )
        declared_historical = historical_paths[label]
        active_historical = sorted(declared_historical.intersection(active_caller_paths))
        if active_historical:
            raise ConvergenceError(
                "declared historical consumer path is active caller evidence in "
                f"{label}@{ref}: {active_historical[0]}"
            )
        missing_historical = sorted(declared_historical - set(tree))
        if missing_historical:
            raise ConvergenceError(
                "declared historical consumer path is absent from "
                f"{label}@{ref}: {missing_historical[0]}"
            )
        stale_historical = sorted(declared_historical - terminal_reference_paths)
        if stale_historical:
            raise ConvergenceError(
                "declared historical consumer path has no terminal reference in "
                f"{label}@{ref}: {stale_historical[0]}"
            )
        live_terminal_references = terminal_reference_paths - declared_historical
        if live_terminal_references:
            raise ConvergenceError(
                "terminal-retirement path remains referenced by "
                f"{label}@{ref}: {len(live_terminal_references)} file(s)"
            )
        historical_terminal_reference_files += len(declared_historical)
    if caller_checks != declared_checks:
        raise ConvergenceError(
            f"caller evidence count mismatch: declared {declared_checks}, checked {caller_checks}"
        )
    return {
        "consumer_count": len(parsed),
        "declared_caller_checks": declared_checks,
        "caller_checks": caller_checks,
        "removed_reference_files": removed_reference_files,
        "historical_terminal_reference_files": historical_terminal_reference_files,
    }


def category_counts_from_paths(paths: list[str]) -> dict[str, int]:
    return {
        "skills": sum(path.endswith("/SKILL.md") or path == "SKILL.md" for path in paths),
        "custom_agents": sum(path.endswith(".agent.md") for path in paths),
        "instructions": sum(Path(path).name == "AGENTS.md" for path in paths),
        "prompts": sum(path.endswith(".prompt.md") for path in paths),
    }


def installed_counts(root: Path | None) -> dict[str, int]:
    if root is None:
        return {"skills": 0, "custom_agents": 0, "instructions": 0, "prompts": 0}
    if not root.is_dir():
        raise ConvergenceError(f"installed discovery root is not a directory: {root}")
    paths: list[str] = []
    for directory, subdirs, files in os.walk(root):
        subdirs[:] = sorted(
            name
            for name in subdirs
            if name not in {".git", "node_modules", "__pycache__"}
        )
        for filename in sorted(files):
            paths.append(str(Path(directory, filename).relative_to(root)))
    return category_counts_from_paths(paths)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo", default=".")
    parser.add_argument("--base-ref")
    parser.add_argument("--require-deletions", action="store_true")
    parser.add_argument("--consumer", action="append", default=[])
    parser.add_argument("--historical-consumer-path", action="append", default=[])
    parser.add_argument("--installed-root")
    args = parser.parse_args()

    repo = Path(args.repo).resolve()
    if not repo.is_dir():
        raise ConvergenceError(f"repository is not a directory: {repo}")
    index = index_entries(repo)
    (
        active,
        removed_rules,
        terminal_retirements,
        compatibility,
        classification,
    ) = parse_inventory(repo, index)
    validate_active_prose(repo, index)
    utf8_count = validate_active_utf8(repo, index, active)
    owner_checks = validate_owner_evidence(repo, index, active)
    if args.base_ref:
        deleted_paths, base_delta = validate_base_delta(
            repo,
            index,
            removed_rules,
            terminal_retirements,
            compatibility,
            args.base_ref,
        )
        if args.require_deletions and not deleted_paths:
            raise ConvergenceError("base-to-index deletion set is unexpectedly empty")
    else:
        if args.require_deletions:
            raise ConvergenceError("--require-deletions requires --base-ref")
        deleted_paths = []
        base_delta = {
            "removed_rules": len(removed_rules),
            "terminal_retirements": len(terminal_retirements),
            "deleted_paths": 0,
            "rollback_paths": 0,
            "compatibility_paths": 0,
            "unchanged_schema_blobs": 0,
            "unchanged_floor_export_blobs": 0,
        }
    consumers = validate_consumers(
        active,
        deleted_paths,
        terminal_retirements,
        args.consumer,
        args.historical_consumer_path,
    )
    result = {
        "verdict": "PASS",
        "inventory": INVENTORY_PATH,
        "index_paths": len(index),
        "active_export_rows": len(active),
        "utf8_cached_blobs": utf8_count,
        "owner_evidence_checks": owner_checks,
        "orphan_active_exports": sum(
            1 for export in active if not any(export.evidence.values())
        ),
        **classification,
        "harness_counts": category_counts_from_paths(sorted(index)),
        "installed_counts": installed_counts(
            Path(args.installed_root).resolve() if args.installed_root else None
        ),
        **base_delta,
        **consumers,
    }
    print(json.dumps(result, sort_keys=True))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except ConvergenceError as exc:
        print(
            json.dumps({"verdict": "FAIL", "error": str(exc)}, sort_keys=True),
            file=sys.stderr,
        )
        raise SystemExit(1)
