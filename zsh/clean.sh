#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2016-03-07
#---------------------------------#

# zplug削除
if [ -e $HOME/.zplug ]; then
    rm -rf $HOME/.zplug
fi

for file in zshrc zshenv zprofile zpreztorc zprezto zlogout zlogin zsh_alias zsh_function zsh_keybind zsh_plugin
do
    # ホームディレクトリの.$fileを削除
    if [ -e $HOME/.$file ]; then
        rm -f $HOME/.$file
    fi
done



