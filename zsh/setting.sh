#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

# zplugをクローン
if [ ! -e $HOME/.zplug ]; then
    git clone https://github.com/b4b4r07/zplug ~/.zplug
fi

for file in zshrc zshenv zprofile zpreztorc zprezto zlogout zlogin zsh_alias zsh_function zsh_keybind zsh_plugin
do
    # ホームディレクトリに.$fileがあった場合、.$file_oldとリネームして退避
    if [ -e $HOME/.$file ]; then
        old=$file${str}_old
        mv $HOME/.$file $HOME/.$old
    fi

    # ホームフォルダの.$fileに対してシンボリックリンクを張る
    ln -s $DIR/$file $HOME/.$file
done

echo "'exec zsh'を実行してください"

