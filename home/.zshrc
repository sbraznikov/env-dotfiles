# ---------- History ----------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY


# ---------- Shell behavior ----------

setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt CORRECT


# ---------- Completion ----------

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'


# ---------- Homebrew ----------

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# ---------- Autosuggestions ----------

source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"


# ---------- Syntax highlighting ----------

source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


# ---------- Prompt ----------

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export BAT_PAGER="less -RF"

alias cat='bat'
alias ls='eza'
alias l='eza -l'
alias ll='eza -lah --group-directories-first'
alias lt='eza --tree --level=2'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'
alias md='glow -p'
alias vim='nvim'


# Herdr: tint this Ghostty window's background while herdr runs (OSC 11),
# restore the default on exit (OSC 111). Matches herdr's panel_bg.
herdr() {
  if (( $# == 0 )) || [[ $1 == --session || $1 == --remote ]]; then
    printf '\e]11;#161a2a\a'
    command herdr "$@"
    local rc=$?
    printf '\e]111\a'
    return $rc
  fi
  command herdr "$@"
}

# Native Claude Code installer (self-updating) takes precedence over brew
export PATH="$HOME/.local/bin:$PATH"
