
# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# colors
eval `dircolors .dircolors/dircolors-solarized/dircolors.256dark`
#source .mintty/mintty-colors-solarized/sol.dark
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
alias lcmd="fc -ln -1 | sed 's/^\s*//'"
alias stripcolors='sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'

# run non-git-managed bashrc
touch "${HOME}/.bashrc2"
source  "${HOME}/.bashrc2"
