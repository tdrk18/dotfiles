#!/bin/sh

DIR=`cd $(dirname $0); pwd`

# skillsを設置
mkdir -p $HOME/.copilot
rm -rf $HOME/.copilot/skills
ln -s $DIR/skills $HOME/.copilot/skills
