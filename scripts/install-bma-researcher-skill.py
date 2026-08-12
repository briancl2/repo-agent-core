#!/usr/bin/env python3
"""Install or verify one byte-identical using-bma-researcher skill tree."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import shutil
import sys
import tempfile
from datetime import datetime, timezone
from pathlib import Path


SKILL_NAME = "using-bma-researcher"


class InstallError(RuntimeError):
    """A fail-closed installation or drift-validation failure."""


def skill_files(root: Path) -> list[Path]:
    if not root.is_dir() or root.is_symlink():
        raise InstallError(f"skill source must be a real directory: {root}")
    files: list[Path] = []
    for candidate in sorted(root.rglob("*")):
        if candidate.is_symlink():
            raise InstallError(f"skill tree contains a symlink: {candidate}")
        if candidate.is_dir():
            continue
        if not candidate.is_file():
            raise InstallError(f"skill tree contains a non-file: {candidate}")
        files.append(candidate)
    if not files:
        raise InstallError(f"skill tree is empty: {root}")
    if root.joinpath("SKILL.md") not in files:
        raise InstallError(f"skill tree has no SKILL.md: {root}")
    return files


def tree_hash(root: Path) -> tuple[str, int, int]:
    digest = hashlib.sha256()
    total = 0
    files = skill_files(root)
    for candidate in files:
        relative = candidate.relative_to(root).as_posix().encode("utf-8")
        payload = candidate.read_bytes()
        digest.update(len(relative).to_bytes(8, "big"))
        digest.update(relative)
        digest.update(len(payload).to_bytes(8, "big"))
        digest.update(payload)
        total += len(payload)
    return digest.hexdigest(), len(files), total


def paths_overlap(first: Path, second: Path) -> bool:
    return first == second or first in second.parents or second in first.parents


def reject_overlap(source: Path, target: Path, backup_root: Path | None = None) -> None:
    if paths_overlap(source, target):
        raise InstallError(f"source and target paths overlap: {source} {target}")
    if backup_root is not None:
        for label, candidate in (("source", source), ("target", target)):
            if paths_overlap(candidate, backup_root):
                raise InstallError(
                    f"{label} and backup-root paths overlap: "
                    f"{candidate} {backup_root}"
                )


def emit(status: str, source: Path, target: Path, backup: Path | None = None) -> None:
    source_hash, file_count, byte_count = tree_hash(source)
    result: dict[str, object] = {
        "byte_count": byte_count,
        "file_count": file_count,
        "skill": SKILL_NAME,
        "source": str(source),
        "source_sha256": source_hash,
        "status": status,
        "target": str(target),
        "target_sha256": tree_hash(target)[0],
    }
    if backup is not None:
        result["backup"] = str(backup)
        result["backup_sha256"] = tree_hash(backup)[0]
    print(json.dumps(result, sort_keys=True))


def checked_source(value: str) -> Path:
    raw_source = Path(value).expanduser()
    if raw_source.is_symlink():
        raise InstallError(f"skill source must not be a symlink: {raw_source}")
    source = raw_source.resolve()
    tree_hash(source)
    return source


def target_path(root_value: str) -> Path:
    root = Path(root_value).expanduser()
    if root.is_symlink():
        raise InstallError(f"target root must not be a symlink: {root}")
    if root.exists() and not root.is_dir():
        raise InstallError(f"target root must be a real directory: {root}")
    target = root.resolve().joinpath(SKILL_NAME)
    if target.is_symlink():
        raise InstallError(f"installed skill must not be a symlink: {target}")
    return target


def verify(source: Path, target: Path) -> None:
    if not target.exists():
        raise InstallError(f"installed skill is missing: {target}")
    if target.is_symlink() or not target.is_dir():
        raise InstallError(f"installed skill must be a real directory: {target}")
    source_hash, source_count, source_bytes = tree_hash(source)
    target_hash, target_count, target_bytes = tree_hash(target)
    if (target_hash, target_count, target_bytes) != (
        source_hash,
        source_count,
        source_bytes,
    ):
        raise InstallError(
            "installed skill differs from source: "
            f"source={source_hash} target={target_hash}"
        )


def install(
    source: Path,
    target: Path,
    replace_with_backup: bool,
    backup_root_value: str | None,
) -> None:
    backup_root = None
    if backup_root_value:
        raw_backup_root = Path(backup_root_value).expanduser()
        if raw_backup_root.is_symlink():
            raise InstallError(
                f"backup root must not be a symlink: {raw_backup_root}"
            )
        backup_root = raw_backup_root.resolve()
    reject_overlap(source, target, backup_root)
    target.parent.mkdir(parents=True, exist_ok=True)
    if target.exists():
        try:
            verify(source, target)
        except InstallError:
            if not replace_with_backup:
                raise InstallError(
                    f"non-identical install blocks replacement: {target}"
                )
        else:
            emit("already-identical", source, target)
            return

    staging = Path(tempfile.mkdtemp(prefix=f".{SKILL_NAME}-", dir=target.parent))
    backup: Path | None = None
    original_moved = False
    swapped = False
    try:
        shutil.copytree(source, staging, dirs_exist_ok=True, copy_function=shutil.copy2)
        verify(source, staging)
        if target.exists():
            if not backup_root_value:
                raise InstallError("--backup-root is required for replacement")
            assert backup_root is not None
            backup_root.mkdir(parents=True, exist_ok=True)
            current_hash = tree_hash(target)[0]
            stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
            backup = backup_root.joinpath(
                f"{SKILL_NAME}-{stamp}-{current_hash[:12]}"
            )
            if backup.exists():
                raise InstallError(f"backup destination already exists: {backup}")
            if os.stat(target).st_dev != os.stat(backup_root).st_dev:
                raise InstallError(
                    "target and backup root must share a filesystem for "
                    "recoverable replacement"
                )
            original_fingerprint = tree_hash(target)
            target.rename(backup)
            original_moved = True
            if tree_hash(backup) != original_fingerprint:
                raise InstallError(f"backup verification failed: {backup}")
        staging.rename(target)
        swapped = True
        verify(source, target)
        emit("replaced-with-backup" if backup else "installed", source, target, backup)
    except Exception:
        if swapped and target.exists():
            shutil.rmtree(target)
        if original_moved and backup is not None and backup.exists():
            if target.exists():
                raise InstallError(
                    f"failed install could not restore backup: {backup}"
                )
            backup.rename(target)
        raise
    finally:
        if staging.exists():
            shutil.rmtree(staging)


def parser() -> argparse.ArgumentParser:
    result = argparse.ArgumentParser(description=__doc__)
    subparsers = result.add_subparsers(dest="command", required=True)
    for command in ("check", "install"):
        child = subparsers.add_parser(command)
        child.add_argument("--source", required=True)
        child.add_argument("--target-root", required=True)
        if command == "install":
            child.add_argument("--replace-with-backup", action="store_true")
            child.add_argument("--backup-root")
    return result


def main() -> int:
    args = parser().parse_args()
    try:
        source = checked_source(args.source)
        target = target_path(args.target_root)
        if args.command == "check":
            verify(source, target)
            emit("identical", source, target)
        else:
            install(
                source,
                target,
                args.replace_with_backup,
                args.backup_root,
            )
    except InstallError as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
