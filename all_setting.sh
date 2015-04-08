#!/usr/bin/zsh

for folder in emacs latexmk tmux vim zsh fonts
do
    cd $folder
    sh setting.sh
    cd ..
done

