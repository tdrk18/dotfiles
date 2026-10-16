#!/bin/sh

# install
# パッケージは mise の [bootstrap.packages] で管理する（mise/config.toml）
type brew >/dev/null 2>&1
if [ "$?" -ne 0 ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 以前の Brewfile のリンクを削除
if [ -L $HOME/.Brewfile ]; then
    rm -f $HOME/.Brewfile
fi
