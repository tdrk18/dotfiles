#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

if [ ! -e $HOME/.config/alacritty ]; then
    mkdir -p $HOME/.config/alacritty
fi

if [ -e $HOME/.config/alacritty/alacritty.yml ]; then
    mv $HOME/.config/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty_old.yml
fi

ln -s $DIR/alacritty.yml $HOME/.config/alacritty/alacritty.yml

