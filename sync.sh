#!/usr/bin/env bash
# Collect current configs from $HOME into home/ (run on the source machine, then commit).
set -euo pipefail
cd "$(dirname "$0")"

grep -vE '^\s*(#|$)' files.txt | while IFS= read -r p; do
  src="$HOME/$p"
  dst="home/$p"
  if [[ ! -e "$src" ]]; then echo "skip (missing): $p"; continue; fi
  rm -rf "$dst"; mkdir -p "$(dirname "$dst")"
  cp -R "$src" "$dst"
  echo "synced: $p"
done

# Machine/project-specific or private data must not land in this public repo.
jq 'del(.autoMode)' "$HOME/.claude/settings.json" > home/.claude/settings.json
rm -rf home/.config/nvim/.git

brew bundle dump --force --file=Brewfile
echo "Done. Review with: git status && git diff"
