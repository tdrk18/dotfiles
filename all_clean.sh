#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2016-03-07
#---------------------------------#

for folder in emacs latexmk tmux vim neovim zsh fonts git svn xcode homebrew anyenv ideavim asdf gh
do
    cd $folder
    sh clean.sh
    cd ..
done

