#!/bin/sh

for folder in tmux vim neovim zsh fonts git homebrew ideavim asdf gh starship rust
do
    cd $folder
    sh setting.sh
    cd ..
done

