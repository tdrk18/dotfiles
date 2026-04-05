#!/bin/sh

DIR=`cd $(dirname $0); pwd`

# AGENTS.mdを設置
rm -f $HOME/.codex/AGENTS.md
ln -s $DIR/AGENTS.md $HOME/.codex/AGENTS.md

# skillsを設置
rm -rf $HOME/.codex/skills
ln -s $DIR/skills $HOME/.codex/skills
