"""Regression tests for historical Lisp passwords and pre-publication checks."""
import importlib.util
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class SecurityTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name) / 'repo'
        self.root.mkdir()
        shutil.copytree(ROOT / 'scripts', self.root / 'scripts', ignore=shutil.ignore_patterns('__pycache__'))
        shutil.copy(ROOT / '.gitleaks.toml', self.root)
        self.source = Path(self.temp.name) / 'source'
        self.source.mkdir()

    def scan(self, *args):
        return subprocess.run(['python3', str(self.root / 'scripts/check-secrets.py'), *args], cwd=self.root, capture_output=True, text=True)

    def secret(self):
        return '(:pass' + 'word . "' + 'test-only-short-value' + '")'

    def sync(self):
        spec = importlib.util.spec_from_file_location('sync_test', self.root / 'scripts/sync.py')
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        module.sync(self.source)

    def test_short_lisp_password_rejected_without_value_in_output(self):
        (self.source / 'jabber.el').write_text(self.secret())
        result = self.scan('--directory', str(self.source))
        self.assertNotEqual(result.returncode, 0)
        self.assertNotIn('test-only-short-value', result.stdout + result.stderr)

    def test_sensitive_filename_rejected_even_with_no_token(self):
        (self.source / 'auth.json').write_text('{}')
        self.assertNotEqual(self.scan('--directory', str(self.source)).returncode, 0)

    def test_safe_config_passes(self):
        (self.source / 'config').write_text('theme = "dark"\n')
        self.assertEqual(self.scan('--directory', str(self.source)).returncode, 0)

    def test_staged_secret_cannot_be_hidden_by_working_tree_fix(self):
        subprocess.run(['git', 'init', '-q', str(self.root)], check=True)
        target = self.root / 'config.el'
        target.write_text(self.secret())
        subprocess.run(['git', 'add', 'config.el'], cwd=self.root, check=True)
        target.write_text(';; no secret in working tree\n')
        self.assertNotEqual(self.scan('--staged').returncode, 0)

    def test_sync_failure_preserves_existing_config(self):
        (self.root / 'files.txt').write_text('config.el\n')
        (self.root / 'home').mkdir()
        target = self.root / 'home/config.el'
        target.write_text('original')
        (self.source / 'config.el').write_text(self.secret())
        with self.assertRaises(SystemExit):
            self.sync()
        self.assertEqual(target.read_text(), 'original')

    def test_sync_rejects_directory_and_symlink(self):
        (self.root / 'files.txt').write_text('config\n')
        (self.source / 'config').mkdir()
        with self.assertRaises(SystemExit):
            self.sync()
        (self.source / 'config').rmdir()
        (self.source / 'config').symlink_to(self.root / '.gitleaks.toml')
        with self.assertRaises(SystemExit):
            self.sync()

    def test_sync_only_imports_named_files(self):
        (self.root / 'files.txt').write_text('config\n')
        (self.source / 'config').write_text('theme = "dark"\n')
        (self.source / 'auth.json').write_text('{}')
        self.sync()
        self.assertTrue((self.root / 'home/config').exists())
        self.assertFalse((self.root / 'home/auth.json').exists())


if __name__ == '__main__':
    unittest.main()
