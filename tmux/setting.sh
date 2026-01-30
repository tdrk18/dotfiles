#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

if [ -e $HOME/.tmux.conf ]; then
    rm -f $HOME/.tmux.conf
fi

if [ ! -e $HOME/.tmux/plugin/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

# ホームディレクトリの.tmux.confに対してシンボリックリンクを張る
ln -s $DIR/tmux.conf $HOME/.tmux.conf

if [ -e $HOME/.tmux-session ]; then
    rm -f $HOME/.tmux-session
fi

# ホームディレクトリの.tmux.confに対してシンボリックリンクを張る
ln -s $DIR/tmux-session $HOME/.tmux-session

