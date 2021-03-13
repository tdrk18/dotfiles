#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

type git >/dev/null 2>&1
if [ "$?" -ne 0 ]; then
    brew install gh
fi

# config.ymlを設置
if [ -e $HOME/.config/gh/config.yml ]; then
    mv $HOME/.config/gh/config.yml $HOME/.config/gh/config.yml
fi
ln -s $DIR/config.yml $HOME/.config/gh/config.yml
