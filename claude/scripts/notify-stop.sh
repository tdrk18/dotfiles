#!/bin/bash

terminal-notifier \
  -title "Claude Code" \
  -subtitle "Task completed" \
  -message "" \
  -sound Glass \
  -execute "osascript -e 'tell application \"Ghostty\" to activate'"
