#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ideavimrcを設置
if [ -e $HOME/.ideavimrc ]; then
    mv $HOME/.ideavimrc $HOME/.ideavim_old
fi
ln -s $DIR/ideavimrc $HOME/.ideavimrc

