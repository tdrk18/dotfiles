---
description: Send an instruction to Codex running in a tmux pane. Use this skill when the user asks to send a message or instruction to Codex (e.g., "Codexに〇〇を依頼して", "codexに伝えて", "send this to codex").
---

# Codex Send Skill

## Rules

- Always auto-detect the Codex pane from tmux. Never ask the user for the pane ID.
- Use `-l` flag with `tmux send-keys` to send text as literal characters.
- Always insert `sleep 0.5` between sending the text and sending Enter.
- Send one message at a time. If multiple messages are requested, send them sequentially — wait for completion detection before sending the next one.
- Always append the completion notification instruction to the message before sending.

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

3. **Generate a unique marker ID**

   Generate a unique ID using the current timestamp:
   ```
   MARKER_ID=$(date +%s)
   MARKER_FILE="/tmp/codex_done_${MARKER_ID}"
   ```

4. **Send the message**

   Append the following to the user's message before sending:
   > 「作業が完了したら `touch /tmp/codex_done_<MARKER_ID>` を実行してください。」

   Then send:
   ```
   tmux send-keys -t <pane-id> -l "<message>\n作業が完了したら `touch /tmp/codex_done_<MARKER_ID>` を実行してください。"
   sleep 0.5
   tmux send-keys -t <pane-id> Enter
   ```

5. **Wait for completion**

   Poll for the specific marker file every 3 seconds, with a timeout of 5 minutes:
   ```bash
   for i in $(seq 1 100); do
     if [ -f "$MARKER_FILE" ]; then
       rm -f "$MARKER_FILE"
       echo "done"
       break
     fi
     sleep 3
   done
   ```

   - If the file appears: inform the user "✅ Codex が完了しました。" and proceed to the next message if any.
   - If the timeout is reached (100 × 3s = 5 minutes): inform the user "⏱️ タイムアウトしました。Codex がまだ作業中の可能性があります。" and stop polling.

6. **Confirm to the user**

   Tell the user the result and, if multiple messages were queued, send the next one.
