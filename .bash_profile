# source the user's bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# colors
eval `dircolors .dircolors/dircolors-solarized/dircolors.256dark`
source .mintty/mintty-colors-solarized/sol.dark
alias ls='ls --color=auto'

# vim stuff
set -o vi
alias vi=vim

# prints the last command, useful for appending to in-progress scripts
alias lcmd="fc -ln -1 | sed 's/^\s*//'"

# run non-git-managed .bash_profile
touch "${HOME}/.bash_profile2"
source  "${HOME}/.bash_profile2"
