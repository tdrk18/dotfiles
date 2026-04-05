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

   - If the command fails (non-zero exit code), inform the user: "tmux が起動していないようです。" and stop.
   - If the command succeeds but no pane's `pane_current_command` contains `codex`, proceed to step 2 to launch Codex in a new pane.
   - Otherwise, use the matched pane ID (e.g., `0:3.2`) and skip to step 3.

2. **Launch Codex in a new pane** _(only if no Codex pane was found)_

   Run the following to split the current window and start Codex:
   ```
   tmux split-window -h -t {current}
   ```

   Then get the new pane's ID:
   ```
   tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}" | tail -1
   ```

   Start Codex in that pane:
   ```
   tmux send-keys -t <new-pane-id> "codex" Enter
   ```

   Wait for Codex to start up:
   ```
   sleep 3
   ```

   Inform the user: "Codex が起動していなかったため、新しい pane で起動しました。"

3. **Send the message**

   Run the following two commands:
   ```
   tmux send-keys -t <pane-id> -l "<message>"
   sleep 0.5
   tmux send-keys -t <pane-id> Enter
   ```

4. **Confirm to the user**

   Tell the user the message was sent, and wait for them to confirm that Codex has finished before sending the next message (if multiple were requested).
