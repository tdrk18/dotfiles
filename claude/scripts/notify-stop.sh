#!/bin/bash

INPUT=$(cat)

TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name')

COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -n "$COMMAND" ]; then
  DETAIL="$COMMAND"
elif [ -n "$FILE_PATH" ]; then
  DETAIL="$FILE_PATH"
else
  DETAIL=""
fi

terminal-notifier \
  -title "Claude Code" \
  -subtitle "${TOOL_NAME} completed" \
  -message "$DETAIL" \
  -sound Glass \
  -execute "osascript -e 'tell application \"Ghostty\" to activate'"
