#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

if [ -e $HOME/.config/herdr ]; then
    rm -rf $HOME/.config/herdr
fi

if [ ! -e $HOME/.config/herdr ]; then
    mkdir -p $HOME/.config/herdr
fi

ln -s $DIR/config.toml $HOME/.config/herdr/config.toml
