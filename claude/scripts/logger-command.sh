#!/bin/sh

echo "[$(date '+%Y/%m/%d %H:%M:%S')] $USER: $(jq -r '.tool_input.command')" >> ~/.claude/log/command_history.log
