#!/bin/sh

type rustup >/dev/null 2>&1
if [ "$?" -ne 0 ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
    rustup update
fi
