#!/bin/sh

# skillsを削除
if [ -e $HOME/.copilot/skills ]; then
    rm -rf $HOME/.copilot/skills
fi
