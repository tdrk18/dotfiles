#!/bin/sh

brew install asdf

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# asdfrcを設置
if [ -e $HOME/.asdfrc ]; then
    mv $HOME/.asdfrc $HOME/.asdfrc_old
fi
ln -s $DIR/asdfrc $HOME/.asdfrc
