#!/bin/sh

DIR=`cd $(dirname $0); pwd`

# CLAUDE.mdを設置
rm -f $HOME/.claude/CLAUDE.md
ln -s $DIR/CLAUDE.md $HOME/.claude/CLAUDE.md

# scriptsを設置
rm -rf $HOME/.claude/scripts
ln -s $DIR/scripts $HOME/.claude/scripts
