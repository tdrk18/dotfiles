---
description: Send an instruction to Codex running in a tmux pane. Use this skill when the user asks to send a message or instruction to Codex (e.g., "Codexに〇〇を依頼して", "codexに伝えて", "send this to codex").
---

# Codex Send Skill

## Rules

- Always auto-detect the Codex pane from tmux. Never ask the user for the pane ID.
- Use `-l` flag with `tmux send-keys` to send text as literal characters.
- Always insert `sleep 0.5` between sending the text and sending Enter.
- Send one message at a time. If multiple messages are requested, send them sequentially and wait for the user to confirm completion before sending the next one.
- Never assume Codex has completed its work — just send the message and inform the user it was sent.

## Steps

1. **Detect the Codex pane**

   Run:
   ```
   tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}"
   ```

   Find the pane whose `pane_current_command` contains `codex`. Use that pane ID (e.g., `0:3.2`).

   If no Codex pane is found, inform the user: "Codex が動いている tmux pane が見つかりませんでした。"

2. **Send the message**

   Run the following two commands:
   ```
   tmux send-keys -t <pane-id> -l "<message>"
   sleep 0.5
   tmux send-keys -t <pane-id> Enter
   ```

3. **Confirm to the user**

   Tell the user the message was sent, and wait for them to confirm that Codex has finished before sending the next message (if multiple were requested).
