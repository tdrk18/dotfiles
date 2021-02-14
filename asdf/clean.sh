#!/bin/sh

# asdfrcを削除
if [ -e $HOME/.asdfrc ]; then
    rm -f $HOME/.asdfrc
fi
