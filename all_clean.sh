#!/bin/sh

for folder in tmux vim neovim zsh fonts git xcode homebrew ideavim gh starship rust mise ghostty
do
    cd $folder
    sh clean.sh
    cd ..
done

