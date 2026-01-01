#!/bin/sh

if [ -e $HOME/.config/mise ]; then
    rm -rf $HOME/.config/mise
fi

# default-gemsを削除
if [ -e $HOME/.default-gems ]; then
    rm -f $HOME/.default-gems
fi
