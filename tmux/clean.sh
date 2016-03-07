#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2016-03-07
#---------------------------------#

# ホームディレクトリの.tmux.confを削除
if [ -e $HOME/.tmux.conf ]; then
   rm -f $HOME/.tmux.conf
fi

# ホームディレクトリの.tmux.confを削除
if [ -e $HOME/.tmux-session ]; then
    rm -f $HOME/.tmux-session
fi

