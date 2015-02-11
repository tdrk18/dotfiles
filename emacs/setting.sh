#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ホームディレクトリに.emacsがあった場合、.emacs_oldにリネームして退避
if [ -e $HOME/.emacs ]; then
    mv $HOME/.emacs $HOME/.emacs_old
fi
# ホームディレクトリに.emacs.dがあった場合、.emacs.d_oldにリネームして退避
if [ -e $HOME/.emacs.d ]; then
    mv $HOME/.emacs.d $HOME/.emacs.d_old
fi

# ホームディレクトリの.emacsに対してシンボリックリンクを張る
ln -s $DIR/emacs $HOME/.emacs
# ホームディレクトリの.emacs.dに対してシンボリックリンクを張る
ln -s $DIR/emacs.d $HOME/.emacs.d


