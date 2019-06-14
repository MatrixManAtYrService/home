# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# if nix is installed, use it
if [ -e /home/user/.nix-profile/etc/profile.d/nix.sh ]
then
    . /home/user/.nix-profile/etc/profile.d/nix.sh;
fi
