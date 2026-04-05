---
description: Reviews a GitHub Pull Request. Use this skill when the user asks to review a PR, check a pull request, or analyze changes in a PR (e.g., "PRをレビューして", "review PR 123", "pull requestを確認して", "review this PR").
---

# PR Review Skill

## Rules

- Use `gh` CLI for all GitHub operations.
- Never post comments to the PR unless explicitly requested by the user.
- Always display results in the terminal.
- Focus on code quality, potential bugs, and test coverage.
- Always restore the original branch after checking out a PR.

## Steps

1. **Determine PR number**

   - If a PR number was provided in the conversation or as an argument, use it directly.
   - Otherwise, try to detect a PR from the current branch: `gh pr view --json number -q .number`
   - If no PR is found automatically, use the AskUserQuestion tool to ask: "レビューする PR 番号を教えてください。"

2. **Fetch PR information** — run the following in parallel:

   - `gh pr view <pr-number> --json title,body,baseRefName,headRefName,author,additions,deletions,changedFiles`
   - `gh pr diff <pr-number>` to get the full diff
   - `git branch --show-current` to record the current branch so it can be restored later

3. **Run reviews in parallel**

   Launch both reviewers at the same time using the Task tool:

   **Claude review task**: Analyze the diff obtained in step 2 across the three dimensions below. Store results as **Claude findings**.

   **Codex review task** _(skip only if tmux is not running)_:

   1. Detect the Codex pane:
      ```
      tmux list-panes -a -F "#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}"
      ```
      Use the pane whose `pane_current_command` contains `codex`. If none found, launch Codex in a new pane:
      ```
      tmux split-window -h -t {current}
      tmux send-keys -t <new-pane-id> "codex" Enter
      sleep 3
      ```
      Then use that new pane ID.

   2. Generate unique IDs for the marker and output files:
      ```
      MARKER_ID=$(date +%s)
      MARKER_FILE="/tmp/codex_done_${MARKER_ID}"
      REVIEW_FILE="/tmp/codex_review_${MARKER_ID}.md"
      rm -f "$MARKER_FILE" "$REVIEW_FILE"
      ```

   3. Send the review instruction to the Codex pane:
      ```
      tmux send-keys -t <pane-id> -l "このブランチ（<headRefName>）の <baseRefName> に対する変更をレビューしてください。以下の観点で確認してください：(1) コード品質 — 可読性、命名、不要な複雑さ、重複；(2) 潜在的なバグ — 未処理のエッジケース、エラーハンドリング、誤った前提；(3) テストカバレッジ — テスト漏れ、未テストのエッジケース、意味のないアサーション。ファイル名と行番号を具体的に示してください。レビュー結果を /tmp/codex_review_<MARKER_ID>.md に書き出し、完了したら touch /tmp/codex_done_<MARKER_ID> を実行してください。"
      sleep 0.5
      tmux send-keys -t <pane-id> Enter
      ```

   4. Poll for completion (timeout: 10 minutes):
      ```bash
      for i in $(seq 1 200); do
        if [ -f "$MARKER_FILE" ]; then
          rm -f "$MARKER_FILE"
          break
        fi
        sleep 3
      done
      ```

   5. Read Codex findings from the output file:
      ```
      cat "$REVIEW_FILE"
      ```
      Store the content as **Codex findings**. Then remove the file:
      ```
      rm -f "$REVIEW_FILE"
      ```


   Claude review dimensions:

   ### Code Quality
   - Readability: are names, structure, and logic clear?
   - Consistency with surrounding code style and conventions
   - Unnecessary complexity or duplication
   - Dead code, unused variables, or leftover debug statements

   ### Potential Bugs
   - Edge cases not handled (null/empty/boundary values)
   - Off-by-one errors or incorrect conditions
   - Race conditions or concurrency issues
   - Error handling: are errors caught, surfaced, or silently swallowed?
   - Incorrect assumptions about data or state

   ### Test Coverage
   - Are new features or changed behaviors covered by tests?
   - Are edge cases and error paths tested?
   - Do existing tests still make sense after the change?
   - Are tests meaningful (not just asserting trivially true things)?

4. **Consolidate and output**

   **If Codex was run**: merge both sets of findings. Group by review dimension, noting which reviewer raised each point. If both reviewers flag the same issue, merge it into one item and note that both agree.

   **If Codex was not run**: output Claude findings only, without reviewer labels.

   Output format when both reviewers are available:

   ```
   # PR Review: #<pr-number> — <title>

   **Author**: <author>
   **Changes**: +<additions> / -<deletions> across <changedFiles> files

   ---

   ## Code Quality

   ### Critical
   - [Both] <file>:<line> — <description>
   - [Claude] <file>:<line> — <description>
   - [Codex] <file>:<line> — <description>

   ### Suggestions
   - [Claude] <description>
   - [Codex] <description>

   ---

   ## Potential Bugs

   ### Critical
   - ...

   ### Suggestions
   - ...

   ---

   ## Test Coverage

   ### Critical
   - ...

   ### Suggestions
   - ...

   ---

   ## Strengths
   - <what is done well, from either reviewer>

   ---
   **Overall**: <one-sentence summary of PR quality and readiness, based on both reviews>
   ```

   Output format when only Claude reviewed:

   ```
   # PR Review: #<pr-number> — <title>

   **Author**: <author>
   **Changes**: +<additions> / -<deletions> across <changedFiles> files

   ---

   ## Code Quality
   ### Critical
   - <file>:<line> — <description>
   ### Suggestions
   - <description>

   ## Potential Bugs
   ### Critical
   - ...
   ### Suggestions
   - ...

   ## Test Coverage
   ### Critical
   - ...
   ### Suggestions
   - ...

   ## Strengths
   - <what is done well>

   ---
   **Overall**: <one-sentence summary>
   ```

   - Omit any sub-section that has no items.
   - Always include at least one item in "Strengths" if the code has any positive aspects.
   - Reference specific file paths and line numbers wherever possible.
