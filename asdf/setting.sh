#!/bin/sh

brew install asdf

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# asdfrcを設置
if [ -e $HOME/.asdfrc ]; then
    mv $HOME/.asdfrc $HOME/.asdfrc_old
fi
ln -s $DIR/asdfrc $HOME/.asdfrc

# default-gemsを設置
if [ -e $HOME/.default-gems ]; then
    mv $HOME/.default-gems $HOME/.default-gems_old
fi
ln -s $DIR/ruby/default-gems $HOME/.default-gems
