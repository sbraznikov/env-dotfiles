# dotfiles

macOS setup: zsh + starship, Ghostty + herdr (agent multiplexer), tmux, LazyVim, Zed, Claude Code, Codex.

## Why this setup

I keep the environment reproducible across Macs and keep configuration changes reviewable in Git.

- Ghostty and herdr organize terminal work and coding-agent sessions; hooks expose session state, and keyboard shortcuts jump to agents needing attention.
- LazyVim and Zed cover terminal and graphical editing. Neovim plugin versions are pinned in `lazy-lock.json`.
- zsh, starship, fzf and zoxide provide navigation and a consistent shell environment.
- `install.sh` backs up differing files before installation. `sync.sh` validates a temporary snapshot before copying changes into this repository.

`legacy/` preserves earlier fish, Emacs and terminal configurations as an archive; the active macOS setup is in `home/`.

## New machine

```sh
xcode-select --install
git clone https://github.com/sbraznikov/dotfiles.git ~/Development/dotfiles
cd ~/Development/dotfiles
./install.sh          # add --apps to also install GUI apps from Brewfile.apps
```

`install.sh` installs Homebrew + `Brewfile`, copies everything from `home/` into `$HOME`
(differing files are moved to `~/.dotfiles-backup/<timestamp>/`), installs Claude Code
(native installer) and the herdr plugins.

Then by hand:

- Set your preferred Git author identity in `~/.gitconfig` (the template uses GitHub noreply).
- `gh auth login`; create or copy an SSH key (`~/.ssh/id_ed25519`) and add it to GitHub
- `claude` and `codex` — log in
- `nvim` — LazyVim installs plugins pinned in `lazy-lock.json`
- Apps not in Homebrew: Superconductor, Amphetamine, djay Pro, Scapple, Mole (App Store / vendor sites).
  Superconductor re-creates its own hooks for Cursor, Grok and Qwen.

## Updating the repo

```sh
brew install gitleaks python  # also included in Brewfile
git config core.hooksPath .githooks
./sync.sh                    # validates explicit paths from files.txt
git diff
git add -p
git commit -m "sync"
git push
```

To sync a new file, add its exact `$HOME`-relative path to `files.txt`. Directories and symlinks are rejected, so new caches or nested files cannot be silently imported. Machine-specific home paths must be generalized manually using syntax appropriate to the configuration format.

Git identity, SSH config, Claude settings, Codex hooks and Zed settings are reviewed templates maintained directly in `home/`; they are never copied from live account configuration. `Brewfile` is curated manually.

The pre-commit hook scans the complete **staged snapshot**, including short literal passwords, and refuses commits when Gitleaks is missing. GitHub Actions also scans history and the tracked snapshot. CI is a second check; it cannot prevent a secret from reaching GitHub in the first place.

```sh
python3 scripts/check-secrets.py --staged
python3 scripts/check-secrets.py --history
```

After the publication cleanup, use a fresh clone on other machines. Do not merge or push branches from an older clone: they can restore the removed history.

## Deliberately not tracked

Credentials (`~/.codex/auth.json`, `~/.config/gh/hosts.yml`, SSH keys), `~/.codex/config.toml`, `~/.claude.json`, project-specific agent settings, rules/automations, history, logs and caches are not tracked. Keep local credentials outside these templates. `.gitignore`, explicit sync paths and secret checks provide complementary protection; review every diff before publishing.
