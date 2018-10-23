# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# color stuff
source "$HOME/.config/colorshift.sh"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# vim stuff
set -o vi
alias vi=vim
export VISUAL=vim
export EDITOR="$VISUAL"
CONSOLE_THEME="dark" # override this in .zshrc2

# custom aliases
alias xc="xclip -sel clip"
alias lcmd="fc -ln -1 | sed 's/^\s*//'"
alias stripcolors='sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'

# app vars
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# create non-git-managed bashrc if it doesn't exist
if [[ ! -f "${HOME}/.bashrc2" ]] ; then
cat > ${HOME}/.bashrc2 <<-EOF
# Unlike .bashrc, this file is not synced by git
# modifications will affect the local system only

lighten
EOF
fi

source "${HOME}/.bashrc2"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
