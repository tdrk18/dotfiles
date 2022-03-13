#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

type starship >/dev/null 2>&1
if [ "$?" -ne 0 ]; then
    brew install starship
fi

# config.ymlを設置
ln -s $DIR/starship.toml $HOME/.config/starship.toml
