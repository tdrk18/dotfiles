#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2016-03-07
#---------------------------------#

# gitconfigを削除
if [ -e $HOME/.gitconfig ]; then
    rm -f $HOME/.gitconfig
fi

# gitconfig_tdrk18を削除
if [ -e $HOME/.gitconfig_tdrk18 ]; then
    rm -f $HOME/.gitconfig_tdrk18
fi

# gitconfig_mixiを削除
if [ -e $HOME/.gitconfig_mixi ]; then
    rm -f $HOME/.gitconfig_mixi
fi

# gitignore_globalを削除
if [ -e $HOME/.gitignore_global ]; then
    rm -f $HOME/.gitignore_global
fi

# commitメッセージのテンプレートを削除
if [ -e $HOME/.gitmessage ]; then
    rm -f $HOME/.gitmessage
fi

# gitattributesを削除
if [ -e $HOME/.gitattributes ]; then
    rm -f $HOME/.gitattributes
fi

# tigの設定ファイルを削除
if [ -e $HOME/.tigrc ]; then
    rm -f $HOME/.tigrc
fi

