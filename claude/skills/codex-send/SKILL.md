---
description: Send an instruction to Codex running in a tmux pane. Use this skill when the user asks to send a message or instruction to Codex (e.g., "Codexに〇〇を依頼して", "codexに伝えて", "send this to codex").
---

# Codex Send Skill

## Rules

- Send one message at a time. If multiple messages are requested, send them sequentially — wait for completion before sending the next one.

## Steps

1. **Send the message**

   Run:
   ```
   ~/.claude/scripts/codex-send.sh "<message>"
   ```

   The script handles pane detection, Codex launch if needed, message sending, and completion polling automatically.

2. **Confirm to the user**

   - If the script outputs `✅ Codex が完了しました。`: inform the user and proceed to the next message if any.
   - If the script outputs `⏱️ タイムアウト...`: inform the user that Codex may still be working.
   - If the script outputs `❌ tmux が起動していないようです。`: inform the user and stop.
