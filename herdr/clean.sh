#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

if [ -e $HOME/.config/herdr ]; then
    rm -f $HOME/.config/herdr
fi
