#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# install
type brew >/dev/null 2>&1
if [ "$?" -ne 0 ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Brewfileを設置
if [ -e $HOME/.config/brewfile/Brewfile ]; then
    mv $HOME/.config/brewfile/Brewfile $HOME/.config/brewfile/Brewfile_old
fi
mkdir -p $HOME/.config/brewfile
ln -s $DIR/Brewfile $HOME/.config/brewfile/Brewfile

