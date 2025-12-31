#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# neovimの設定ファイルを置く場所を作成
if [ ! -e $HOME/.config/nvim/lua ]; then
    mkdir -p $HOME/.config/nvim/lua
fi
if [ -e $HOME/.config/nvim/init.lua ]; then
    rm -rf $HOME/.config/nvim/init.lua
fi
ln -s $DIR/init.lua $HOME/.config/nvim/init.lua

# Core
if [ -e $HOME/.config/nvim/lua/core ]; then
    rm -rf $HOME/.config/nvim/lua/core
fi
ln -s $DIR/lua/core $HOME/.config/nvim/lua/core

# Plugins
if [ -e $HOME/.config/nvim/lua/plugins ]; then
    rm -rf $HOME/.config/nvim/lua/plugins
fi
ln -s $DIR/lua/plugins $HOME/.config/nvim/lua/plugins

# After
if [ -e $HOME/.config/nvim/after ]; then
    rm -rf $HOME/.config/nvim/after
fi
ln -s $DIR/after $HOME/.config/nvim/after
