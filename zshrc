source /etc/profile

# =============================================================================
# path settings
# =============================================================================
cdpath=(~ ..)
fpath=($fpath ~/.zfunc)
path=(~/.bin /usr/local/bin /usr/local/sbin /usr/local/git/bin /Applications/XAMPP/xamppfiles/bin /bin /sbin /usr/bin /usr/sbin /home/cubique/bin /usr/local/zend/bin /usr/local/zend/mysql/bin/ .)
manpath=(/usr/local/man /usr/share/man)

# =============================================================================
# zsh settings
# =============================================================================
unlimit
limit stack 8192
limit core 0
limit -s
umask 022

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

autoload colors && colors

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh/history
setopt append_history
setopt inc_append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_no_store
setopt hist_no_functions
setopt no_hist_beep
setopt hist_save_no_dups

setopt correct_all
setopt No_Beep
setopt IGNORE_EOF
setopt notify
setopt globdots
setopt correct
setopt pushdtohome
setopt cdablevars
setopt autolist
setopt correctall
setopt autocd
setopt recexact
setopt longlistjobs
setopt autoresume
setopt pushdsilent
setopt noclobber
setopt autopushd
setopt pushdminus
setopt extendedglob
setopt rcquotes
setopt mailwarning
setopt autoparamslash
unsetopt bgnice

typeset -U path cdpath fpath manpath
autoload colors ; colors

PROMPT='%m # '
RPROMPT=' %~'
PROMPT=$'%{\e[1;31m%}> %{\e[0m%}'

# =============================================================================
# var settings
# =============================================================================
export EDITOR="vim"
export CVSEDITOR="vim"
export SVN_EDITOR="vim"
export PYTHONPATH=~/Sites/projectrepo/:~/Sites/saasrepo/
export GREP_COLOR="1;33"

# development
export SYMMETRICS_DEVELOPER_ID="sb@symmetrics.de"
export ZEND_TOOL_INCLUDE_PATH_PREPEND="~/Sites/library/php"
export ZEND_TOOL_INCLUDE_PATH="~/Sites/library/php"

# =============================================================================
# alias settings
# =============================================================================
alias h='history 100'
alias ..='cd ..'
alias ll='ls --color=auto -al -F'
alias l='ls --color=auto -al -F'
alias cc='clear'
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias df='df -m'
alias grep='/usr/bin/grep'
alias grep='grep --color=auto'
alias whatsize='find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn'
alias rm='rm -i'
alias ftoday='find ~ -type f -mtime 0'
alias em='open -a Emacs.app'
alias mu='open -a Murky.app'

# =============================================================================
# advanced aliases
# =============================================================================
alias -s {pdf,png,jpg,jpeg,gif}="open -a Preview.app"

# =============================================================================
# misc settings
# =============================================================================
# if [[ -f ~/.dir_colors ]] ; then
#     eval $(dircolors ~/.dir_colors)
# elif [[ -f /etc/DIR_COLORS ]] ; then
#     eval $(dircolors -b /etc/DIR_COLORS)
# fi

set -o vi

# =============================================================================
# clojure
# =============================================================================
export CLOJURE_EXT=~/Library/Clojure/lib
alias clj=~/Library/Clojure/clj-env-dir
