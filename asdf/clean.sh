#!/bin/sh

# asdfrcを削除
if [ -e $HOME/.asdfrc ]; then
    rm -f $HOME/.asdfrc
fi

# default-gemsを削除
if [ -e $HOME/.default-gems ]; then
    rm -f $HOME/.default-gems
fi
