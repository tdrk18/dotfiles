#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ホームディレクトリに.vimrcがあった場合、.vimrc_oldとリネームして退避
if [ -e $HOME/.vimrc ]; then
    mv .vimrc .vimrc_old
fi

# ホームフォルダの.vimrcに対してシンボリックリンクを張る
ln -s $DIR/vimrc $HOME/.vimrc

