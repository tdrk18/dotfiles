#!/bin/sh

# GitHubからclone
if [ ! -e $HOME/.anyenv ]; then
    git clone https://github.com/riywo/anyenv $HOME/.anyenv
fi

# PATHなど設定し、SHELLを更新
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
exec $SHELL -l

# pluginの設定
if [ ! -e $(anyenv root)/plugins ]; then
    mkdir -p $(anyenv root)/plugins
    git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
fi

