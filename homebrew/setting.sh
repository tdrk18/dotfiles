#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# Brewfileを設置
if [ -e $HOME/.config/brewfile/Brewfile ]; then
    mv $HOME/.config/brewfile/Brewfile $HOME/.config/brewfile/Brewfile_old
fi
ln -s $DIR/Brewfile $HOME/.config/brewfile/Brewfile

