#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# 各フォントについてシンボリックリンクを張る
if [ ! -e $HOME/.fonts ]; then
    mkdir $HOME/.fonts
fi
for font in *.ttf *.otf
do
    if [ -e $HOME/.fonts/$font ]; then
        \rm -f $HOME/.fonts/$font
    fi
    ln -s $DIR/$font $HOME/.fonts/$font
done

