#!/usr/bin/zsh

for folder in emacs latexmk tmux vim zsh
do
    cd $folder
    sh setting.sh
    cd ..
done

