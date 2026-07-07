#!/bin/sh

for folder in tmux vim neovim zsh fonts git homebrew ideavim gh starship rust mise ghostty claude codex herdr
do
    cd $folder
    sh setting.sh
    cd ..
done

