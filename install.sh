#!/usr/bin/env bash
# Set up a fresh Mac from this repo. Safe to re-run; existing files are backed up.
set -euo pipefail
cd "$(dirname "$0")"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# 1. Homebrew
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
brew bundle --file=Brewfile
[[ "${1:-}" == "--apps" ]] && brew bundle --file=Brewfile.apps || true

# 2. Configs (repo -> home), backing up anything that differs
grep -vE '^\s*(#|$)' files.txt | while IFS= read -r p; do
  src="home/$p"; dst="$HOME/$p"
  [[ -e "$src" ]] || continue
  if [[ -e "$dst" ]] && ! diff -rq "$src" "$dst" >/dev/null 2>&1; then
    mkdir -p "$BACKUP/$(dirname "$p")"; mv "$dst" "$BACKUP/$p"
    echo "backed up: $p"
  fi
  mkdir -p "$(dirname "$dst")"; rm -rf "$dst"; cp -R "$src" "$dst"
  echo "installed: $p"
done
chmod 700 "$HOME/.ssh" 2>/dev/null || true
chmod +x "$HOME/.config/herdr/bin/pane-fit-80" "$HOME/.claude/hooks/"*.sh "$HOME/.codex/"*.sh 2>/dev/null || true

# 3. Claude Code (native, self-updating installer -> ~/.local/bin/claude)
command -v claude >/dev/null || curl -fsSL https://claude.ai/install.sh | bash

# 4. Herdr plugins
for repo in plannotator/herdr-annotate kryptamine/herdr-auto-title thanhdat77/herdr-navigator smarzban/herdr-file-viewer; do
  herdr plugin install "$repo" || echo "WARN: herdr plugin $repo failed, install manually"
done

cat <<'MSG'

Done. Manual steps left (see README):
  - gh auth login; ssh-keygen -t ed25519 (or copy key) and add to GitHub
  - claude  (log in),  codex  (log in)
  - open nvim once so LazyVim installs plugins from lazy-lock.json
MSG
