#!/usr/bin/env bash
sed -i 's/bg=light/bg=dark/' .vimrc && gnome-terminal . --window-with-profile=Dark && exit
