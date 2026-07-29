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
CALLER_REQUIREMENTS = {
    "auditor": (
        "schemas/SCORECARD.schema.json",
        "schemas/FINDINGS.schema.json",
        ".agents/skills/reviewing-code-locally",
        "scripts/compare-scorecards.sh",
    ),
    "advisor": (
        "schemas/OPPORTUNITIES.schema.json",
        ".agents/skills/reviewing-code-locally",
    ),
    "optimizer": (
        "OPTIMIZATION_SCORECARD.json",
        "schemas/TRANSFER_ORACLE_RECEIPT.schema.json",
        "scripts/validate-artifacts.sh",
        ".agents/skills/reviewing-code-locally",
        "scripts/compare-scorecards.sh",
    ),
}
EXPORT_FOR_TOKEN = {
    "schemas/SCORECARD.schema.json": "schemas/SCORECARD.schema.json",
    "schemas/FINDINGS.schema.json": "schemas/FINDINGS.schema.json",
    "schemas/OPPORTUNITIES.schema.json": "schemas/OPPORTUNITIES.schema.json",
    "OPTIMIZATION_SCORECARD.json": "schemas/OPTIMIZATION_SCORECARD.schema.json",
    "schemas/TRANSFER_ORACLE_RECEIPT.schema.json": "schemas/TRANSFER_ORACLE_RECEIPT.schema.json",
    "scripts/validate-artifacts.sh": "scripts/validate-artifacts.sh",
    ".agents/skills/reviewing-code-locally": ".agents/skills/reviewing-code-locally/SKILL.md",
    "scripts/compare-scorecards.sh": "scripts/compare-scorecards.sh",
}


class ConvergenceError(RuntimeError):
    """A deterministic validation failure."""


@dataclass(frozen=True)
class IndexEntry:
    mode: str
    sha: str
    path: str


def git(repo: Path, *args: str, ok_no_match: bool = False) -> bytes:
    proc = subprocess.run(
        ["git", "-C", str(repo), *args],
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


def blob(repo: Path, entry: IndexEntry) -> bytes:
    return git(repo, "cat-file", "blob", entry.sha)


def text_blob(repo: Path, entry: IndexEntry) -> str:
    try:
        return blob(repo, entry).decode("utf-8")
    except UnicodeDecodeError as exc:
        raise ConvergenceError(f"cached blob is not UTF-8: {entry.path}") from exc


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


def matches(index: dict[str, IndexEntry], pattern: str) -> list[str]:
    return sorted(path for path in index if fnmatch.fnmatchcase(path, pattern))


def validate_inventory(
    repo: Path, index: dict[str, IndexEntry]
) -> tuple[list[tuple[str, str, tuple[str, ...]]], list[tuple[str, str]]]:
    if INVENTORY_PATH not in index:
        raise ConvergenceError(f"missing active inventory: {INVENTORY_PATH}")
    inventory = text_blob(repo, index[INVENTORY_PATH])
    active_rows = section_table(inventory, "## Active exports")
    removed_rows = section_table(inventory, "## Removed-name successors")

    active: list[tuple[str, str, tuple[str, ...]]] = []
    manifest_paths: list[str] = []
    for row in active_rows:
        if len(row) != 3:
            raise ConvergenceError("active export row must have three columns")
        pattern, classification, caller_cell = row
        callers = tuple(item.strip() for item in caller_cell.split(",") if item.strip())
        if not callers:
            raise ConvergenceError(f"orphan active export has no callers: {pattern}")
        invalid = sorted(set(callers) - {"owner", "auditor", "advisor", "optimizer"})
        if invalid:
            raise ConvergenceError(
                f"active export has unknown caller class {invalid}: {pattern}"
            )
        if not matches(index, pattern):
            raise ConvergenceError(f"active export pattern matches no index path: {pattern}")
        if classification == "owner-manifest":
            manifest_paths.append(pattern)
        active.append((pattern, classification, callers))

    if manifest_paths != [INVENTORY_PATH]:
        raise ConvergenceError(
            f"expected one owner-manifest at {INVENTORY_PATH}, got {manifest_paths}"
        )

    removed: list[tuple[str, str]] = []
    seen_removed: set[str] = set()
    for row in removed_rows:
        if len(row) != 2:
            raise ConvergenceError("removed-name row must have two columns")
        removed_path, successor = row
        if removed_path in seen_removed:
            raise ConvergenceError(f"duplicate removed-name row: {removed_path}")
        seen_removed.add(removed_path)
        if removed_path in index:
            raise ConvergenceError(f"retired path remains in cached index: {removed_path}")
        if successor not in index:
            raise ConvergenceError(
                f"removed-name successor is not in cached index: {removed_path} -> {successor}"
            )
        removed.append((removed_path, successor))
    return active, removed


def validate_active_prose(repo: Path, index: dict[str, IndexEntry]) -> None:
    for path in ACTIVE_AUTHORITY:
        if path not in index:
            raise ConvergenceError(f"missing active authority file: {path}")
        text = text_blob(repo, index[path])
        for token in RETIRED_AUTHORITY_TOKENS:
            if token.casefold() in text.casefold():
                raise ConvergenceError(
                    f"retired authority token remains active in {path}: {token}"
                )


def validate_active_utf8(
    repo: Path,
    index: dict[str, IndexEntry],
    active: list[tuple[str, str, tuple[str, ...]]],
) -> int:
    checked: set[str] = {INVENTORY_PATH, *ACTIVE_AUTHORITY}
    for pattern, _, _ in active:
        for path in matches(index, pattern):
            if path.endswith((".md", ".json", ".py", ".sh", ".yaml", ".yml")):
                checked.add(path)
    for path in sorted(checked):
        text_blob(repo, index[path])
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


def validate_rollback(
    repo: Path,
    index: dict[str, IndexEntry],
    removed: list[tuple[str, str]],
    base_ref: str,
) -> dict[str, int]:
    base = tree_entries(repo, base_ref)
    missing = [path for path, _ in removed if path not in base]
    if missing:
        raise ConvergenceError(
            f"rollback base lacks {len(missing)} removed paths; first: {missing[0]}"
        )
    if "CONSTITUTION.md" not in base or "CONSTITUTION.md" not in index:
        raise ConvergenceError("constitution missing from base or cached index")
    if base["CONSTITUTION.md"] != index["CONSTITUTION.md"].sha:
        raise ConvergenceError("CONSTITUTION.md bytes changed from rollback base")
    schema_count = 0
    for path, entry in index.items():
        if path.startswith("schemas/") and path.endswith(".schema.json"):
            if base.get(path) != entry.sha:
                raise ConvergenceError(f"exported schema bytes changed from base: {path}")
            schema_count += 1
    return {"rollback_paths": len(removed), "unchanged_schema_blobs": schema_count}


def parse_consumer(value: str) -> tuple[str, Path, str]:
    if "=" not in value or "@" not in value:
        raise ConvergenceError(
            "consumer must use label=/absolute/repository@exact-ref"
        )
    label, location = value.split("=", 1)
    repo_text, ref = location.rsplit("@", 1)
    if label not in CALLER_REQUIREMENTS:
        raise ConvergenceError(f"unknown consumer label: {label}")
    repo = Path(repo_text).resolve()
    if not repo.is_dir():
        raise ConvergenceError(f"consumer repository is not a directory: {repo}")
    git(repo, "cat-file", "-e", f"{ref}^{{commit}}")
    return label, repo, ref


def grep_ref(repo: Path, ref: str, patterns: tuple[str, ...]) -> int:
    args = ["grep", "-I", "-l", "-F"]
    for pattern in patterns:
        args.extend(("-e", pattern))
    args.extend((ref, "--"))
    raw = git(repo, *args, ok_no_match=True)
    return len([line for line in raw.splitlines() if line])


def validate_consumers(
    index: dict[str, IndexEntry],
    removed: list[tuple[str, str]],
    values: list[str],
) -> dict[str, object]:
    if not values:
        return {"consumer_count": 0, "caller_checks": 0, "removed_reference_files": 0}
    parsed = [parse_consumer(value) for value in values]
    labels = [label for label, _, _ in parsed]
    if len(labels) != len(set(labels)):
        raise ConvergenceError("duplicate consumer label")
    if set(labels) != set(CALLER_REQUIREMENTS):
        raise ConvergenceError(
            f"exact caller oracle requires {sorted(CALLER_REQUIREMENTS)}, got {sorted(labels)}"
        )

    caller_checks = 0
    removed_reference_files = 0
    removed_patterns = tuple(path for path, _ in removed)
    for label, repo, ref in parsed:
        for token in CALLER_REQUIREMENTS[label]:
            if EXPORT_FOR_TOKEN[token] not in index:
                raise ConvergenceError(
                    f"required core export missing for caller token {token}"
                )
            if grep_ref(repo, ref, (token,)) == 0:
                raise ConvergenceError(
                    f"{label}@{ref} has no cached caller evidence for {token}"
                )
            caller_checks += 1
        removed_reference_files += grep_ref(repo, ref, removed_patterns)
    return {
        "consumer_count": len(parsed),
        "caller_checks": caller_checks,
        "removed_reference_files": removed_reference_files,
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
    parser.add_argument("--consumer", action="append", default=[])
    parser.add_argument("--installed-root")
    args = parser.parse_args()

    repo = Path(args.repo).resolve()
    if not repo.is_dir():
        raise ConvergenceError(f"repository is not a directory: {repo}")
    index = index_entries(repo)
    active, removed = validate_inventory(repo, index)
    validate_active_prose(repo, index)
    utf8_count = validate_active_utf8(repo, index, active)
    rollback = (
        validate_rollback(repo, index, removed, args.base_ref)
        if args.base_ref
        else {"rollback_paths": 0, "unchanged_schema_blobs": 0}
    )
    consumers = validate_consumers(index, removed, args.consumer)
    result = {
        "verdict": "PASS",
        "inventory": INVENTORY_PATH,
        "index_paths": len(index),
        "active_export_rows": len(active),
        "removed_names": len(removed),
        "utf8_cached_blobs": utf8_count,
        "orphan_active_exports": 0,
        "harness_counts": category_counts_from_paths(sorted(index)),
        "installed_counts": installed_counts(
            Path(args.installed_root).resolve() if args.installed_root else None
        ),
        **rollback,
        **consumers,
    }
    print(json.dumps(result, sort_keys=True))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except ConvergenceError as exc:
        print(json.dumps({"verdict": "FAIL", "error": str(exc)}, sort_keys=True), file=sys.stderr)
        raise SystemExit(1)
