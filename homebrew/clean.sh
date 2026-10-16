#!/bin/sh

# 以前の Brewfile のリンクを削除
if [ -L $HOME/.Brewfile ]; then
    rm -f $HOME/.Brewfile
fi
