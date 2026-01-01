#!/bin/sh

if ! (type mise > /dev/null 2>&1); then 
    brew install mise
fi

# setting.shがあるパスを取得
DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -e "$HOME/.config/mise" ]; then
    rm -rf "$HOME/.config/mise"
fi
if [ ! -e "$HOME/.config/mise" ]; then
    mkdir -p "$HOME/.config/mise"
fi
ln -s "$DIR/config.toml" "$HOME/.config/mise/config.toml"

# default-gemsを設置
if [ -e "$HOME/.default-gems" ]; then
    rm -rf "$HOME/.default-gems"
fi
ln -s "$DIR/ruby/default-gems" "$HOME/.default-gems"
