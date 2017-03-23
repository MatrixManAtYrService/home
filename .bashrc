# run non-git-managed bashrc
touch "${HOME}/.bashrc2"
source  "${HOME}/.bashrc2"

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return
