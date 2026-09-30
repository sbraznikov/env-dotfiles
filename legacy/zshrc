export PATH=$PATH:/opt/homebrew/bin:/opt/homebrew/anaconda3/bin:/opt/homebrew/opt/coreutils/libexec/gnubin
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

# thefuck alias
eval $(thefuck --alias)

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias fzf="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias paravim="cd ~/PARA && vim \$(fzf)"
alias cat="bat"
alias ll="ls -1"
alias ls="eza --icons=always"
