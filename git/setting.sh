#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ホームディレクトリに.gitconfigがあった場合、.gitconfig_oldにリネームして退避
if [ -e $HOME/.gitconfig ]; then
    mv $HOME/.gitconfig $HOME/.gitconfig_old
fi

# ホームディレクトリの.gitconfigに対してシンボリックリンクを張る
ln -s $DIR/gitconfig $HOME/.gitconfig

