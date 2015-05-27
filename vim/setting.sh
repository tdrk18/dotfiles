#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ホームディレクトリに.vimrcがあった場合、.vimrc_oldとリネームして退避
if [ -e $HOME/.vimrc ]; then
    mv .vimrc .vimrc_old
fi

# ホームフォルダの.vimrcに対してシンボリックリンクを張る
ln -s $DIR/vimrc $HOME/.vimrc

# カラーテーマについてシンボリックリンクを張る
if [ ! -e $HOME/.vim/colors ]; then
    mkdir -p $HOME/.vim/colors
fi
cd colors
for color in *.vim
do
    if [ -e $HOME/.vim/colors/$color ]; then
        \rm -f $HOME/.vim/colors/$color
    fi
    ln -s $DIR/colors/$color $HOME/.vim/colors/$color
done
cd ..

# NeoBundleのダウンロード
if [ ! -e $HOME/.vim/bundle ]; then
    mkdir -p $HOME/.vim/bundle
fi
if [ ! -e $HOME/.vim/bundle/neobundle.vim ]; then
    git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
fi
if [ ! -e $HOME/.vim/bundle/vimproc ]; then
    git clone https://github.com/Shougo/vimproc ~/.vim/bundle/vimproc
fi

