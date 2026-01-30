#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

if [ -e $HOME/.config/ghostty ]; then
    rm -f $HOME/.config/ghostty
fi

if [ ! -e $HOME/.config/ghostty ]; then
    mkdir -p $HOME/.config/ghostty
fi

ln -s $DIR/config $HOME/.config/ghostty/config

