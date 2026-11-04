#!/usr/bin/env python3
"""Scan staged content, a directory, or all reachable Git history; never print values."""
import argparse
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
DENIED = re.compile(r'(^|/)(\.env(?:\..*)?|auth\.json|hosts\.yml|\.netrc|\.npmrc|\.pypirc|\.git-credentials|credentials[^/]*|id_(?:rsa|ed25519)[^/]*|[^/]+\.(?:pem|key))$', re.I)
# Catch short literal credentials which entropy-based rules can miss.
LISP = re.compile(r'(?i):(?:password|passwd|secret|token)\s*\.\s*"([^"\r\n]+)"')
LITERAL = re.compile(r'''(?ix)(?:["']?\b(?:[\w-]*[_-])?(?:password|passwd|secret|token|api[_-]?key)["']?\s*(?:=|:)\s*)["']([^"'\r\n]+)["']''')


def custom_findings(path, data):
    findings = []
    if DENIED.search(path) and not path.endswith('.env.example'):
        findings.append(f'{path}: prohibited credential filename')
    if data.startswith(b'version https://git-lfs.github.com/spec/v1'):
        findings.append(f'{path}: LFS content needs a separate audit')
    # Compiled Lisp bytecode is not source syntax; Gitleaks still scans it.
    if path.endswith('.elc') or b'\0' in data:
        return findings
    for number, line in enumerate(data.decode('utf-8', errors='replace').splitlines(), 1):
        if line.lstrip().startswith(('#', ';', '//')):
            continue
        for match in [*LITERAL.finditer(line), *LISP.finditer(line)]:
            value = match.group(1)
            if not value.startswith(('$', '${')):
                findings.append(f'{path}:{number}: literal credential (value hidden)')
    return findings


def scan_directory(directory):
    findings = []
    for path in sorted(Path(directory).rglob('*')):
        relative = path.relative_to(directory).as_posix()
        if '.git' in path.relative_to(directory).parts:
            continue
        if path.is_symlink():
            findings.append(f'{relative}: symlink requires manual review')
        elif path.is_file():
            findings.extend(custom_findings(relative, path.read_bytes()))
    result = subprocess.run(['gitleaks', 'dir', str(directory), '--config', str(ROOT / '.gitleaks.toml'), '--redact=100', '--no-banner'], capture_output=True)
    if result.returncode:
        findings.append('Gitleaks rejected this snapshot (details suppressed to protect values).')
    return findings


def scan_history():
    findings = []
    objects = subprocess.check_output(['git', 'rev-list', '--objects', '--all'], cwd=ROOT).decode().splitlines()
    for item in objects:
        oid, _, path = item.partition(' ')
        if not path:
            continue
        kind = subprocess.check_output(['git', 'cat-file', '-t', oid], cwd=ROOT).strip()
        if kind == b'blob':
            findings.extend(custom_findings(path, subprocess.check_output(['git', 'cat-file', 'blob', oid], cwd=ROOT)))
    result = subprocess.run(['gitleaks', 'git', '.', '--log-opts=--all', '--config', str(ROOT / '.gitleaks.toml'), '--redact=100', '--no-banner'], cwd=ROOT, capture_output=True)
    if result.returncode:
        findings.append('Gitleaks rejected Git history (details suppressed to protect values).')
    return findings


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument('--staged', action='store_true')
    mode.add_argument('--directory', type=Path)
    mode.add_argument('--history', action='store_true')
    args = parser.parse_args()
    if not shutil.which('gitleaks'):
        sys.exit('gitleaks is required: brew install gitleaks')
    if args.history:
        findings = scan_history()
    elif args.directory:
        findings = scan_directory(args.directory)
    else:
        with tempfile.TemporaryDirectory(prefix='dotfiles-index-') as directory:
            subprocess.run(['git', 'checkout-index', '--all', '--prefix=' + directory + '/'], cwd=ROOT, check=True)
            findings = scan_directory(Path(directory))
    if findings:
        print('\n'.join(sorted(set(findings))), file=sys.stderr)
        return 1
    print('Secret check passed.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
