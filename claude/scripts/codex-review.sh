#!/bin/bash

HEAD_REF="$1"
BASE_REF="$2"
DIFF_FILE="$3"

if [ -z "$HEAD_REF" ] || [ -z "$BASE_REF" ] || [ -z "$DIFF_FILE" ]; then
  echo "Usage: codex-review.sh <headRefName> <baseRefName> <diff-file>"
  exit 1
fi

if [ ! -f "$DIFF_FILE" ]; then
  echo "❌ diff ファイルが見つかりません: $DIFF_FILE"
  exit 1
fi

# 1. tmux チェック
if ! tmux info &>/dev/null 2>&1; then
  echo "❌ tmux が起動していないようです。"
  exit 1
fi

# 2. Codex pane を検出
echo "🔍 Codex pane を検索中..."
PANE_ID=$(tmux list-panes -F "#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}" \
  | grep codex | head -1 | awk '{print $1}')

# 3. なければ新しい pane で起動
if [ -z "$PANE_ID" ]; then
  echo "🚀 Codex pane が見つかりませんでした。新しい pane で起動します..."
  PANE_ID=$(tmux split-window -h -P -F "#{session_name}:#{window_index}.#{pane_index}")
  tmux send-keys -t "$PANE_ID" "codex" Enter
  sleep 10
  echo "✅ Codex を起動しました(pane: $PANE_ID)"
else
  echo "✅ Codex pane を検出しました(pane: $PANE_ID)"
fi

# 4. ユニークなファイルを生成
MARKER_ID=$(date +%s)
MARKER_FILE="/tmp/codex_done_${MARKER_ID}"
REVIEW_FILE="/tmp/codex_review_${MARKER_ID}.md"
rm -f "$MARKER_FILE" "$REVIEW_FILE"
echo "📝 レビュー結果ファイル: $REVIEW_FILE"

# 5. レビュー指示を送信
echo "📤 レビュー指示を送信中..."
tmux send-keys -t "$PANE_ID" -l "${DIFF_FILE} に PR(${HEAD_REF} → ${BASE_REF})の diff があります。このファイルを読んで以下の観点でレビューしてください：(1) コード品質 — 可読性、命名、不要な複雑さ、重複；(2) 潜在的なバグ — 未処理のエッジケース、エラーハンドリング、誤った前提；(3) テストカバレッジ — テスト漏れ、未テストのエッジケース、意味のないアサーション。ファイル名と行番号を具体的に示してください。レビュー結果を ${REVIEW_FILE} に書き出し、完了したら touch ${MARKER_FILE} を実行してください。"
sleep 0.5
tmux send-keys -t "$PANE_ID" Enter
echo "⏳ Codex のレビュー完了を待機中(最大10分)..."

# 6. 完了を polling(3秒おき、最大10分)
for i in $(seq 1 200); do
  if [ -f "$MARKER_FILE" ]; then
    echo "✅ Codex がレビューを完了しました。"
    cat "$REVIEW_FILE"
    exit 0
  fi
  sleep 3
done

echo "⏱️ タイムアウトしました。Codex がまだ作業中の可能性があります。"
exit 1
