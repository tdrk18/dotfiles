#!/bin/sh

# CLAUDE.mdを削除
if [ -e $HOME/.claude/CLAUDE.md ]; then
    rm -f $HOME/.claude/CLAUDE.md
fi

# scriptsを削除
if [ -e $HOME/.claude/scripts ]; then
    rm -rf $HOME/.claude/scripts
fi
