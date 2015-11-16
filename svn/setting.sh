#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# ホームディレクトリに.subversionフォルダがない場合に作成
if [ ! -e $HOME/.subversion ]; then
    mkdir $HOME/.subversion
fi

# .subversion/configがあった場合、.subversion/config_oldにリネームして退避
if [ -e $HOME/.subversion/config ]; then
    mv $HOME/.subversion/config $HOME/.subversion/config_old
fi

# ホームディレクトリの.subversion/configに対してシンボリックリンクを張る
ln -s $DIR/config $HOME/.subversion/config

