# pure prompt (https://github.com/sindresorhus/pure)
PROMPT_DIR="$HOME/.zsh/pure"
PROMPT_SETUP_IN="$HOME/.zsh/pure/pure.zsh"
PROMPT_SETUP="$HOME/.zsh/pure/prompt_pure_setup"
PROMPT_ASYNC_IN="$HOME/.zsh/pure/async.zsh"
PROMPT_ASYNC="$HOME/.zsh/pure/async"

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
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# vim stuff
set -o vi
alias vi=vim
export VISUAL=vim
export EDITOR="$VISUAL"

#autoload edit-command-line; zle -N edit-command-line
#bindkey -M vicmd "D" edit-command-line

# custom aliases
alias xc="xclip -sel clip"
alias lcmd="fc -ln -1 | sed 's/^\s*//'"
alias stripcolors='sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'

# hist stuff
HISTSIZE=10000
SAVEHIST=10000
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

export RVM_DIR="$HOME/.rvm"
[ -s "$RVM_DIR/scripts/rvm" ] && source /home/matt/.rvm/scripts/rvm

# create non-git-managed zshrc if it doesn't exist
if [[ ! -f "${HOME}/.zshrc2" ]] ; then
cat > "${HOME}/.zshrc2" <<-EOF
# Unlike .zshrc, this file is not synced by git
# modifications will affect the local system only
EOF
fi

# Cursor shape switch based on mode:
# https://unix.stackexchange.com/questions/547/make-my-zsh-prompt-show-mode-in-vi-mode
KEYTIMEOUT=5

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam shape cursor for each new prompt.
make_beam() {
   echo -ne '\e[5 q'
}

# Do so now
make_beam

# And at the start of each prompt
autoload -U add-zsh-hook
add-zsh-hook preexec make_beam

# https://superuser.com/questions/476532/how-can-i-make-zshs-vi-mode-behave-more-like-bashs-vi-mode
vi-search-fix() {
zle vi-cmd-mode
zle .vi-history-search-backward
}
autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix

# https://superuser.com/questions/516474/escape-not-idempotent-in-zshs-vi-emulation
noop () { }
zle -N noop
bindkey -M vicmd '\e' noop

# https://github.com/denysdovhan/spaceship-prompt/issues/91
bindkey "^?" backward-delete-char

# replace lines like "make me a sandwich bitch"
#          with "sudo make me a sandwich"
bitch() {
if [[ "$BUFFER" == *" bitch" ]]; then
    BUFFER="sudo ${BUFFER% bitch}"
fi
zle .accept-line
}

zle -N accept-line bitch

# zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey -M viins '^[[2~' autosuggest-execute
bindkey -M viins '^[f' vi-forward-blank-word
bindkey -M viins '^[w' vi-forward-word
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(
	end-of-line
	vi-end-of-line
	vi-add-eol
)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
	forward-char
	vi-forward-char
	forward-word
	emacs-forward-word
	vi-forward-word
	vi-forward-word-end
	vi-forward-blank-word
	vi-forward-blank-word-end
	vi-find-next-char
	vi-find-next-char-skip
)

# zsh-history-substring-search
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd '^[[5~' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd '^[[6~' history-substring-search-down

# zsh-syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# auto-cd
setopt auto_cd

# colorshift stuff
alias lighten='source ~/.config/colorshift/lighten.sh'
alias darken='source ~/.config/colorshift/darken.sh'
source $(cat ~/.config/colorshift/target_file.txt) &> /dev/null

# sql stuff
source ~/.tb2j.zsh

# apply non-git-synced modifications
source  "${HOME}/.zshrc2"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
