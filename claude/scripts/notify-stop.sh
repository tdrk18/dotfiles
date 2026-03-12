#!/bin/bash

command -v terminal-notifier &>/dev/null || exit 0

terminal-notifier \
  -title "Claude Code" \
  -subtitle "Task completed" \
  -message "" \
  -sound Glass \
  -execute "osascript -e 'tell application \"Ghostty\" to activate'"
