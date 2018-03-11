#!/usr/bin/env bash

dircolors_file() {
    if [[ -f $1 ]] ; then
        eval $(dircolors $1)
    else
        echo "$1 not found.  Consider running 'git submodule update --init'"
    fi
}

darken_common(){

    # vimrc picks this up
    export CONSOLE_THEME="dark"

    # adjust dircolors
    dircolors_file "$HOME/.config/dircolors/dircolors-solarized/dircolors.ansi-dark"
}

lighten_common(){
    export CONSOLE_THEME="light"
    dircolors_file "$HOME/.config/dircolors/dircolors-solarized/dircolors.ansi-light"
}

# behave differently if we're in a GUI
darken(){
    darken_common

    # close and reopen under new theme
    which gnome-terminal &> /dev/null
    if [[ $? -eq 0 ]] ; then
        # the user must create these
        gnome-terminal . --window-with-profile=Dark && exit
    fi
 }

lighten(){
    lighten_common

    which gnome-terminal &> /dev/null
    if [[ $? -eq 0 ]] ; then
        # the user must create these
        gnome-terminal . --window-with-profile=Light && exit
    fi
 }
