#!/usr/bin/env bash
sed -i 's/bg=light/bg=dark/' .vimrc && sed -i 's/ansi-light/ansi-dark/' .bashrc && gnome-terminal . --window-with-profile=Dark && exit
