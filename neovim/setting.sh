#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# neovimの設定ファイルを置く場所を作成
if [ ! -e $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim
fi

# init.vim, dein.toml, dein_lazy.tomlのシンボリックリンクを作成
if [ -e $HOME/.config/nvim/init.vim ]; then
    mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim_old
fi
if [ -e $HOME/.config/nvim/dein.toml ]; then
    mv $HOME/.config/nvim/dein.toml $HOME/.config/nvim/dein.toml_old
fi
if [ -e $HOME/.config/nvim/dein_lazy.toml ]; then
    mv $HOME/.config/nvim/dein_lazy.toml $HOME/.config/nvim/dein_lazy.toml_old
fi
ln -s $DIR/init.vim $HOME/.config/nvim/init.vim
ln -s $DIR/dein.toml $HOME/.config/nvim/dein.toml
ln -s $DIR/dein_lazy.toml $HOME/.config/nvim/dein_lazy.toml

# インデント設定のシンボリックリンクを作成
if [ -e $DIR/../vim/indent ]; then
    if [ -e $HOME/.config/nvim/indent ]; then
        mv $HOME/.config/nvim/indent $HOME/.config/nvim/indent_old
    fi
    ln -s $DIR/../vim/indent $HOME/.config/nvim/indent
fi

