#!/usr/bin/zsh

for folder in emacs latexmk tmux vim zsh fonts git
do
    cd $folder
    sh setting.sh
    cd ..
done

