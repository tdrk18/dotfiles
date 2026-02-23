#!/bin/sh

# CLAUDE.mdを削除
if [ -e $HOME/.claude/CLAUDE.md ]; then
    rm -f $HOME/.claude/CLAUDE.md
fi

# scriptsを削除
if [ -e $HOME/.claude/scripts ]; then
    rm -rf $HOME/.claude/scripts
fi

# settings.jsonを削除
if [ -e $HOME/.claude/settings.json ]; then
    rm -rf $HOME/.claude/settings.json
fi
