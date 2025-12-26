#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# neovimの設定ファイルを置く場所を作成
if [ ! -e $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim
fi

if [ -e $HOME/.config/nvim/init.lua ]; then
    mv $HOME/.config/nvim/init.lua $HOME/.config/nvim/init.lua_old
fi
ln -s $DIR/init.lua $HOME/.config/nvim/init.lua

# Core
if [ -e $HOME/.config/nvim/lua/core/ ]; then
    mv $HOME/.config/nvim/lua/core/ $HOME/.config/nvim/lua/core_old
fi
ln -s $DIR/lua/core $HOME/.config/nvim/lua/core

# Plugins
if [ -e $HOME/.config/nvim/lua/plugins ]; then
    mv $HOME/.config/nvim/lua/plugins $HOME/.config/nvim/lua/plugins_old
fi
ln -s $DIR/lua/plugins $HOME/.config/nvim/lua/plugins
