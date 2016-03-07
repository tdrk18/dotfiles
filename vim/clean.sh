#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2016-03-07
#---------------------------------#

# ホームディレクトリの.vimrcを削除
if [ -e $HOME/.vimrc ]; then
    rm -f $HOME/.vimrc
fi

# ホームディレクトリの.vimを削除
if [ -e $HOME/.vim ]; then
    rm -f $HOME/.vim
fi

