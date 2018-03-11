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

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd "V" edit-command-line


# aliases
alias xc="xclip -sel clip"
alias lcmd="fc -ln -1 | sed 's/^\s*//'"
alias stripcolors='sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'

# run non-git-managed bashrc
touch "${HOME}/.zshrc2"
source  "${HOME}/.zshrc2"

HISTSIZE=5000
SAVEHIST=5000
HISTFILE="$HOME/.zsh_history"

setopt sharehistory # Share the same history between all shells

fpath+=('/usr/local/lib/node_modules/pure-prompt/functions')
autoload -U promptinit; promptinit
prompt pure

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
