#!/usr/bin/zsh

if [ $# -eq 0 ]; then
    echo "設定ファイルを適用したいものを引数として指定してください"
    exit 1
fi

for folder in $@
do
    cd $folder
    sh setting.sh
    cd ..
done

