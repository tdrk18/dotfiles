#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ホームディレクトリに.tmux.confがあった場合、.tmux.conf_oldにリネームして退避
if [ -e $HOME/.tmux.conf ]; then
    mv $HOME/.tmux.conf $HOME/.tmux.conf_old
fi

# ホームディレクトリの.tmux.confに対してシンボリックリンクを張る
ln -s $DIR/tmux.conf $HOME/.tmux.conf

# ホームディレクトリに.tmux.confがあった場合、.tmux.conf_oldにリネームして退避
if [ -e $HOME/.tmux-session ]; then
    mv $HOME/.tmux-session $HOME/.tmux-session_old
fi

# ホームディレクトリの.tmux.confに対してシンボリックリンクを張る
ln -s $DIR/tmux-session $HOME/.tmux-session

# tmux.confに設定を追記(tmux画面下部の設定部分)
echo set-option -g status-left \"\#\($DIR/tmux-powerline/powerline.sh left\)\" >> $DIR/tmux.conf
echo set-option -g status-right \"\#\($DIR/tmux-powerline/powerline.sh right\)\" >> $DIR/tmux.conf
