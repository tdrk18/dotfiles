#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ホームディレクトリに.xvimrcがあった場合、.xvimrc_oldとリネームして退避
if [ -e $HOME/.xvimrc ]; then
    mv $HOME/.xvimrc $HOME/.xvimrc_old
fi
# ホームフォルダの.vimrcに対してシンボリックリンクを張る
ln -s $DIR/xvimrc $HOME/.xvimrc

