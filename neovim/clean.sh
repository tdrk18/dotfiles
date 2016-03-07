#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2016-03-07
#---------------------------------#

# neovimの設定ファイルを削除
if [ -e $HOME/.config/nvim ]; then
    rm -rf $HOME/.config/nvim
fi

