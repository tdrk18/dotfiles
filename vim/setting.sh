#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ホームディレクトリに.vimrcがあった場合、.vimrc_oldとリネームして退避
if [ -e $HOME/.vimrc ]; then
    mv .vimrc .vimrc_old
fi

# ホームフォルダの.vimrcに対してシンボリックリンクを張る
ln -s $DIR/vimrc $HOME/.vimrc

# カラーテーマを.vim/colorsにコピー
if [ ! -e $HOME/.vim/colors ]; then
    mkdir -p $HOME/.vim/colors
fi
\cp -f colors/*.vim $HOME/.vim/colors

# NeoBundleのダウンロード
if [ ! -e $HOME/.vim/bundle ]; then
    mkdir -p $HOME/.vim/bundle
fi
git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim

