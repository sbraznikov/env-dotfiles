#!/usr/bin/env python3
"""Copy only explicit, reviewed paths, validating a snapshot before publishing it."""
from pathlib import Path
import importlib.util
import os
import shutil
import tempfile

ROOT = Path(__file__).resolve().parents[1]
MANUAL = {'.gitconfig', '.ssh/config', '.claude/settings.json', '.codex/hooks.json', '.config/zed/settings.json'}


def sync(source_home):
    if not shutil.which('gitleaks'):
        raise SystemExit('gitleaks is required: brew install gitleaks')
    paths = [line.strip() for line in (ROOT / 'files.txt').read_text().splitlines() if line.strip() and not line.lstrip().startswith('#')]
    spec = importlib.util.spec_from_file_location('secret_check', ROOT / 'scripts/check-secrets.py')
    checker = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(checker)
    with tempfile.TemporaryDirectory(prefix='dotfiles-sync-') as directory:
        snapshot = Path(directory)
        copied = []
        for relative in paths:
            path = Path(relative)
            if path.is_absolute() or '..' in path.parts or relative in MANUAL:
                raise SystemExit(f'Path is not eligible for automatic sync: {relative}')
            source = source_home / path
            if any((source_home / Path(*path.parts[:i])).is_symlink() for i in range(1, len(path.parts) + 1)):
                raise SystemExit(f'Symlink requires manual review: {relative}')
            if not source.exists():
                print(f'skip (missing): {relative}')
                continue
            if not source.is_file():
                raise SystemExit(f'Only explicit files can be synced: {relative}')
            target = snapshot / 'home' / path
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source, target)
            if os.fsencode(source_home) + b'/' in target.read_bytes():
                raise SystemExit(f'Machine-specific home path needs manual cleanup: {relative}')
            copied.append(relative)
        findings = checker.scan_directory(snapshot)
        if findings:
            raise SystemExit('\n'.join(findings) + '\nSync aborted; repository files were not changed.')
        for relative in copied:
            destination = ROOT / 'home' / relative
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(snapshot / 'home' / relative, destination)
            print(f'synced: {relative}')
    print('Done. Review git diff before committing. Brewfile is maintained manually.')


if __name__ == '__main__':
    sync(Path.home())
