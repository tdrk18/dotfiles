#!/bin/sh

# ホームディレクトリの.anyenvを削除
if [ -e $HOME/.anyenv ]; then
    rm -rf $HOME/.anyenv
fi

