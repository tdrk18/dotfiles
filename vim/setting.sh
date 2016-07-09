#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ホームディレクトリに.vimrcがあった場合、.vimrc_oldとリネームして退避
if [ -e $HOME/.vimrc ]; then
    mv $HOME/.vimrc $HOME/.vimrc_old
fi
# ホームフォルダの.vimrcに対してシンボリックリンクを張る
ln -s $DIR/vimrc $HOME/.vimrc

# ホームディレクトリに.vimディレクトリを作成
if [ ! -e $HOME/.vim ]; then
    mkdir $HOME/.vim
fi

# インデント設定についてシンボリックリンクを張る
if [ -e $HOME/.vim/indent ]; then
    mv $HOME/.vim/indent $HOME/.vim/indent_old
fi
ln -s $DIR/indent $HOME/.vim/indent

# カラーテーマについてシンボリックリンクを張る
if [ -e $HOME/.vim/colors ]; then
    mv $HOME/.vim/colors $HOME/.vim/colors_old
fi
ln -s $DIR/colors $HOME/.vim/colors

# テンプレートについてシンボリックリンクを張る
if [ -e $HOME/.vim/template ]; then
    mv $HOME/.vim/template $HOME/.vim/template_old
fi
ln -s $DIR/template $HOME/.vim/template

# NeoBundleのダウンロード
if [ ! -e $HOME/.vim/bundle ]; then
    mkdir -p $HOME/.vim/bundle
fi
if [ ! -e $HOME/.vim/bundle/neobundle.vim ]; then
    git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
fi
if [ ! -e $HOME/.vim/bundle/vimproc ]; then
    git clone https://github.com/Shougo/vimproc $HOME/.vim/bundle/vimproc
    cd $HOME/.vim/bundle/vimproc
    make
fi

echo "\033[0;32mvimを起動し、':NeoBundleInstall'を実行してください\033[0;39m"

