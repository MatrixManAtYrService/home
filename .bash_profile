# source the users bashrc if it exists
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

# run non-git-managed .bash_profile
touch "${HOME}/.bash_profile2"
source  "${HOME}/.bash_profile2"
