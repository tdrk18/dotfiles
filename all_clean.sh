#!/bin/sh

for folder in emacs latexmk tmux vim neovim zsh fonts git svn xcode homebrew anyenv ideavim asdf gh alacritty starship rust mise
do
    cd $folder
    sh clean.sh
    cd ..
done

