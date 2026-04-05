#!/bin/bash

MESSAGE="$1"

# 1. tmux チェック
if ! tmux info &>/dev/null 2>&1; then
  echo "❌ tmux が起動していないようです。"
  exit 1
fi

# 2. Codex pane を検出
echo "🔍 Codex pane を検索中..."
PANE_ID=$(tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}" \
  | grep codex | head -1 | awk '{print $1}')

# 3. なければ新しい pane で起動
if [ -z "$PANE_ID" ]; then
  echo "🚀 Codex pane が見つかりませんでした。新しい pane で起動します..."
  tmux split-window -h
  PANE_ID=$(tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index}" | tail -1)
  tmux send-keys -t "$PANE_ID" "codex" Enter
  sleep 3
  echo "✅ Codex を起動しました(pane: $PANE_ID)"
else
  echo "✅ Codex pane を検出しました(pane: $PANE_ID)"
fi

# 4. ユニークなマーカーファイルを生成
MARKER_FILE="/tmp/codex_done_$(date +%s)"
echo "📝 マーカーファイル: $MARKER_FILE"

# 5. メッセージ送信
echo "📤 メッセージを送信中..."
tmux send-keys -t "$PANE_ID" -l "${MESSAGE}
作業が完了したら \`touch ${MARKER_FILE}\` を実行してください。"
sleep 0.5
tmux send-keys -t "$PANE_ID" Enter
echo "⏳ Codex の完了を待機中..."

# 6. 完了を polling(3秒おき、最大5分)
for i in $(seq 1 100); do
  if [ -f "$MARKER_FILE" ]; then
    rm -f "$MARKER_FILE"
    echo "✅ Codex が完了しました。"
    exit 0
  fi
  sleep 3
done

echo "⏱️ タイムアウトしました。Codex がまだ作業中の可能性があります。"
exit 1
