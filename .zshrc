# pure prompt (https://github.com/sindresorhus/pure)
PROMPT_DIR="$HOME/.zsh/pure"
PROMPT_SETUP_IN="$HOME/.zsh/pure/pure.zsh"
PROMPT_SETUP="$HOME/.zsh/pure/prompt_pure_setup"
PROMPT_ASYNC_IN="$HOME/.zsh/pure/async.zsh"
PROMPT_ASYNC="$HOME/.zsh/pure/async"

source ~/.common

if [ -d "$PROMPT_DIR" ] ; then
    # If the pure submodule has been fetched
    # align the setup files with pure's expectations
    if [ ! -f "$PROMPT_SETUP" ] ; then
        cp -v "$PROMPT_SETUP_IN" "$PROMPT_SETUP"
    fi
    if [ ! -f "$PROMPT_ASYNC" ] ; then
        cp -v "$PROMPT_ASYNC_IN" "$PROMPT_ASYNC"
    fi

    # the set the path to pure
    fpath+=("$HOME/.zsh/pure")
    autoload -U promptinit; promptinit
    prompt pure
else
    echo "$PROMPT_DIR does not exists, consider running: git submodule update --init"
fi

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

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd "D" edit-command-line

# custom aliases
alias xc="xclip -sel clip"
alias lcmd="fc -ln -1 | sed 's/^\s*//'"
alias stripcolors='sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'

# hist stuff
HISTSIZE=2000
SAVEHIST=2000
HISTFILE="$HOME/.zsh_history"

setopt sharehistory # Share the same history between all shells
setopt appendhistory

fpath+=("$HOME/.zsh/pure/")
autoload -U promptinit; promptinit
prompt pure

# app vars
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# create non-git-managed zshrc if it doesn't exist
if [[ ! -f "${HOME}/.zshrc2" ]] ; then
cat > "${HOME}/.zshrc2" <<-EOF
# Unlike .zshrc, this file is not synced by git
# modifications will affect the local system only

lighten_common  # lighten, but don't restart terminal
#darken_common # darken, but don't restart terminal
EOF
fi

source  "${HOME}/.zshrc2"

