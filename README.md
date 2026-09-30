# dotfiles

macOS setup: zsh + starship, Ghostty + herdr (agent multiplexer), tmux, LazyVim, Zed, Claude Code, Codex.

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

- `gh auth login`; create or copy an SSH key (`~/.ssh/id_ed25519`) and add it to GitHub
- `claude` and `codex` — log in
- `nvim` — LazyVim installs plugins pinned in `lazy-lock.json`
- Apps not in Homebrew: Superconductor, Amphetamine, djay Pro, Scapple, Mole (App Store / vendor sites).
  Superconductor re-creates its own hooks for Cursor, Grok and Qwen.

## Updating the repo

```sh
./sync.sh             # copies paths from files.txt out of $HOME, refreshes Brewfile
git diff && git commit -am "sync" && git push
```

To track a new file, add its `$HOME`-relative path to `files.txt`.

## Deliberately not tracked

This repo is public. Left out: credentials (`~/.codex/auth.json`, `~/.config/gh/hosts.yml`, SSH keys),
`~/.codex/config.toml` (may hold tokens — copy manually), `autoMode` in `~/.claude/settings.json`
(project-specific, stripped by `sync.sh`), `~/.claude.json`, Codex rules/automations, history, logs, caches.

`legacy/` holds the old fish / emacs / alacritty setup.
