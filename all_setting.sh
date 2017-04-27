#!/bin/sh

for folder in emacs latexmk tmux vim neovim zsh fonts git svn xcode
do
    cd $folder
    sh setting.sh
    cd ..
done

