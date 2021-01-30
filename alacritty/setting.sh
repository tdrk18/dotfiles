#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

if [ ! -e $HOME/.config ]; then
    mkdir -p $HOME/.config
fi

if [ -e $HOME/.config/alacritty.yml ]; then
    mv $HOME/.config/alacritty.yml $HOME/.config/alacritty_old.yml
fi

ln -s $DIR/alacritty.yml $HOME/.config/alacritty.yml

