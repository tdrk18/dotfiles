#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`


for file in zshrc zshenv zprofile zpreztorc zprezto zlogout zlogin
do
    # ホームディレクトリに.$fileがあった場合、.$file_oldとリネームして退避
    if [ -e $HOME/.$file ]; then
        old=$file${str}_old
        mv $HOME/.$file $HOME/.$old
    fi

    # ホームフォルダの.$fileに対してシンボリックリンクを張る
    ln -s $DIR/$file $HOME/.$file
done

# pecoをインストール
case "${OSTYPE}" in
linux*)
    wget https://github.com/peco/peco/releases/download/v0.3.3/peco_linux_amd64.tar.gz
    tar -xzvf peco_linux_amd64.tar.gz
    sudo mv peco_linux_amd64/peco /usr/local/bin/
    ;;
darwin*)
    brew install go
    go get github.com/lestrrat/peco/cmd/peco/
    ;;
esac
exec zsh

