#!/bin/sh

# AGENTS.mdを削除
if [ -e $HOME/.codex/AGENTS.md ]; then
    rm -f $HOME/.codex/AGENTS.md
fi

# skillsを削除
if [ -e $HOME/.codex/skills ]; then
    rm -rf $HOME/.codex/skills
fi
