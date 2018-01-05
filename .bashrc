# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# color stuff
DIRCOLORS=".dircolors/dircolors-solarized/dircolors.ansi-light"
if [[ -f $DIRCOLORS ]] ; then
    eval `dircolors $DIRCOLORS`
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias darken="source ~/.darken.sh"
alias lighten="source ~/.lighten.sh"

# vim stuff
set -o vi
alias vi=vim
export VISUAL=vim
export EDITOR="$VISUAL"

# aliases
alias xc="xclip -sel clip"
alias lcmd="fc -ln -1 | sed 's/^\s*//'"
alias stripcolors='sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'

# run non-git-managed bashrc
touch "${HOME}/.bashrc2"
source  "${HOME}/.bashrc2"
