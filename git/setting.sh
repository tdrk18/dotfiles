#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# gitconfigを設置
if [ -e $HOME/.gitconfig ]; then
    mv $HOME/.gitconfig $HOME/.gitconfig_old
fi
ln -s $DIR/gitconfig $HOME/.gitconfig

# gitignore_globalを設置
if [ -e $HOME/.gitignore_global ]; then
    mv $HOME/.gitignore_global $HOME/.gitignore_global_old
fi
ln -s $DIR/gitignore $HOME/.gitignore_global

# commitメッセージのテンプレートを設定
if [ -e $HOME/.gitmessage ]; then
    mv $HOME/.gitmessage $HOME/.gitmessage_old
fi
ln -s $DIR/gitmessage $HOME/.gitmessage
git config --global commit.template $HOME/.gitmessage

# gitattributesを設置
if [ -e $HOME/.gitattributes ]; then
    mv $HOME/.gitattributes $HOME/.gitattributes_old
fi
ln -s $DIR/gitattributes $HOME/.gitattributes
git config --global core.attributesfile $HOME/.gitattributes

# tigの設定ファイルを設置
if [ -e $HOME/.tigrc ]; then
    mv $HOME/.tigrc $HOME/.tigrc_old
fi
ln -s $DIR/tigrc $HOME/.tigrc

