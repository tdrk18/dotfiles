#!/bin/sh

for folder in emacs latexmk tmux vim neovim zsh git svn
do
    cd $folder
    sh setting.sh
    cd ..
done

