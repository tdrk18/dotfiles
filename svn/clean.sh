#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2016-03-07
#---------------------------------#

# ホームディレクトリに.subversionフォルダがない場合に作成
if [ -e $HOME/.subversion ]; then
    rm -rf $HOME/.subversion
fi

