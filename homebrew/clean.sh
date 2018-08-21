#!/bin/sh

# Brewfileを削除
if [ -e $HOME/.config/brewfile/Brewfile ]; then
    rm -f $HOME/.config/brewfile/Brewfile
fi

