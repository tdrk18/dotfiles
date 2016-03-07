#!/bin/sh
# -*- coding: utf-8 -*-
#---------------------------------#
# File Name     : clean.sh
# Author        : todoroki
# Date Created  : 2016-03-07
#---------------------------------#

for folder in emacs latexmk tmux vim neovim zsh git svn
do
    cd $folder
    sh clean.sh
    cd ..
done

