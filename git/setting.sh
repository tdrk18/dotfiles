#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ホームディレクトリに.gitconfigがあった場合、.gitconfig_oldにリネームして退避
if [ -e $HOME/.gitconfig ]; then
    mv $HOME/.gitconfig $HOME/.gitconfig_old
fi

# ホームディレクトリの.gitconfigに対してシンボリックリンクを張る
ln -s $DIR/gitconfig $HOME/.gitconfig

# ホームディレクトリに.gitignore_globalがあった場合、.gitignore_global_oldにリネームして退避
if [ -e $HOME/.gitignore_global ]; then
    mv $HOME/.gitignore_global $HOME/.gitignore_global_old
fi

# ホームディレクトリの.gitconfigに対してシンボリックリンクを張る
ln -s $DIR/gitignore $HOME/.gitignore_global

# commitメッセージのテンプレートを設定
if [ -e $HOME/.gitmessage ]; then
    mv $HOME/.gitmessage $HOME/.gitmessage_old
fi
ln -s $DIR/gitmessage $HOME/.gitmessage
git config --global commit.template $HOME/.gitmessage

# tigの設定ファイルを設置
if [ -e $HOME/.tigrc ]; then
    mv $HOME/.tigrc $HOME/.tigrc_old
fi
ln -s $DIR/tigrc $HOME/.tigrc

