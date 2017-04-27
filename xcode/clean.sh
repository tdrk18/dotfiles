#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2017-04-27
#---------------------------------#

# ホームディレクトリの.xvimrcを削除
if [ -e $HOME/.xvimrc ]; then
    rm -f $HOME/.xvimrc
fi

