#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ホームディレクトリに.latexmkrcがあった場合、.latexmkrc_oldにリネームして退避
if [ -e $HOME/.latexmkrc ]; then
    mv $HOME/.latexmkrc $HOME/.latexmkrc_old
fi

# ホームディレクトリの.latexmkrcに対してシンボリックリンクを張る
ln -s $DIR/latexmkrc $HOME/.latexmkrc


