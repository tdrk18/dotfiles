#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2016-03-07
#---------------------------------#

# ホームディレクトリの.emacsを削除
if [ -e $HOME/.emacs ]; then
    rm -f $HOME/.emacs
fi
# ホームディレクトリの.emacs.dを削除
if [ -e $HOME/.emacs.d ]; then
    rm -rf $HOME/.emacs.d
fi

