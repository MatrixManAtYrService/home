# source the user's bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# run non-git-managed .bash_profile
touch "${HOME}/.bash_profile2"
source  "${HOME}/.bash_profile2"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
