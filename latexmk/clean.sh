#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2016-03-07
#---------------------------------#

# ホームディレクトリの.latexmkrcを削除
if [ -e $HOME/.latexmkrc ]; then
    rm -f $HOME/.latexmkrc
fi



