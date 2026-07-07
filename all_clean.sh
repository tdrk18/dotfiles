#!/bin/sh

for folder in tmux vim neovim zsh fonts git xcode homebrew ideavim gh starship rust mise ghostty claude codex herdr
do
    cd $folder
    sh clean.sh
    cd ..
done

