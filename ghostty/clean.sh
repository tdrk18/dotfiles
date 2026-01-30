#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

if [ -e $HOME/.config/ghostty ]; then
    rm -f $HOME/.config/ghostty
fi

