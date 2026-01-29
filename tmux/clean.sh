#!/bin/sh

if [ -e $HOME/.tmux.conf ]; then
   rm -f $HOME/.tmux.conf
fi

if [ -e $HOME/.tmux-session ]; then
    rm -f $HOME/.tmux-session
fi

if [ -e $HOME/.tmux/plugins ]; then
    rm -rf $HOME/.tmux/plugins 
fi
