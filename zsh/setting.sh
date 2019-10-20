#!/bin/sh

# setting.shがあるパスを取得
DIR=`cd $(dirname $0); pwd`

for file in zshrc zshenv zlogout zlogin zsh_alias zsh_function zsh_keybind zsh_plugin zsh_vcs zsh_abbreviations
do
    # ホームディレクトリに.$fileがあった場合、.$file_oldとリネームして退避
    if [ -e $HOME/.$file ]; then
        old=$file${str}_old
        mv $HOME/.$file $HOME/.$old
    fi

    # ホームフォルダの.$fileに対してシンボリックリンクを張る
    ln -s $DIR/$file $HOME/.$file
done

touch $HOME/.zshenv_local

# pluginのインストール
PLUGIN_DIR=$HOME/lib/zsh
mkdir -p $PLUGIN_DIR
cd $PLUGIN_DIR

if [ ! -e $PLUGIN_DIR/zsh-syntax-highlighting ]; then
    git clone git@github.com:tdrk18/zsh-syntax-highlighting.git
fi
if [ ! -e $PLUGIN_DIR/zsh-autosuggestions ]; then
    git clone git@github.com:tdrk18/zsh-autosuggestions.git
fi
if [ ! -e $PLUGIN_DIR/zsh-abbrev-alias ]; then
    git clone git@github.com:tdrk18/zsh-abbrev-alias.git
fi
if [ ! -e $PLUGIN_DIR/per-directory-history ]; then
    git clone git@github.com:tdrk18/per-directory-history.git
fi

cd -

echo "\033[0;32mzshをデフォルトのシェルにするために'chsh -s /bin/zsh'を実行してください\033[0;39m"
echo "\033[0;32m'exec zsh'を実行してください\033[0;39m"

