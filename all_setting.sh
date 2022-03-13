#!/bin/sh

for folder in emacs latexmk tmux vim neovim zsh fonts git svn xcode homebrew anyenv ideavim asdf gh alacritty
do
    cd $folder
    sh setting.sh
    cd ..
done

