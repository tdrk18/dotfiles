#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2016-03-07
#---------------------------------#

for file in zshrc zshenv zlogout zlogin zsh_alias zsh_function zsh_keybind zsh_plugin zsh_abbreviations
do
    # ホームディレクトリの.$fileを削除
    if [ -e $HOME/.$file ]; then
        rm -f $HOME/.$file
    fi
done

