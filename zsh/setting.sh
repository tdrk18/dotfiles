#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

for file in zshrc zshenv zlogout zlogin zsh_alias zsh_function zsh_keybind zsh_plugin zsh_vcs
do
    # ホームディレクトリに.$fileがあった場合、.$file_oldとリネームして退避
    if [ -e $HOME/.$file ]; then
        old=$file${str}_old
        mv $HOME/.$file $HOME/.$old
    fi

    # ホームフォルダの.$fileに対してシンボリックリンクを張る
    ln -s $DIR/$file $HOME/.$file
done

echo "\033[0;32mzshをデフォルトのシェルにするために'chsh -s /bin/zsh'を実行してください\033[0;39m"
echo "\033[0;32m'exec zsh'を実行してください\033[0;39m"

