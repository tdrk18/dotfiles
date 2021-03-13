#!/bin/sh

# config.ymlを削除
if [ -e $HOME/.config/gh/config.yml ]; then
    rm -f $HOME/.config/gh/config.yml
fi

