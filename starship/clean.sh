#!/bin/sh

# config.ymlを削除
if [ -e $HOME/.config/starship.toml ]; then
    rm -f $HOME/.config/starship.toml
fi
