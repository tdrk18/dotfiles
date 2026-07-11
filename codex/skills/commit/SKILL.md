---
name: commit
description: Create a focused Git commit from the current worktree changes. Use when the user asks Codex to commit, save changes to Git, or make a commit, including requests such as "commit this", "commit the changes", or "コミットして".
---

# Create a Git Commit

## Rules

- Make each commit one logical, self-contained change.
- Preserve unrelated user changes and exclude them from the commit.
- Describe what changed and why in the commit message.
- Follow the repository's existing commit-message style unless the user specifies another style.
- Never bypass hooks with `--no-verify` unless the user explicitly requests it.
- Never amend an existing commit or force-push unless the user explicitly requests it.
- Do not add an AI attribution or co-author trailer unless the user or repository instructions require one.

## Workflow

1. Inspect the worktree with:
   - `git status --short --branch`
   - `git diff`
   - `git diff --cached`
   - `git log --oneline -5`
2. Identify the files and hunks that belong to one logical change. If the intended scope is ambiguous, ask the user before staging.
3. Stage only that change. Prefer explicit paths; use patch staging when a file contains unrelated changes.
4. Review `git diff --cached` and confirm it contains no unrelated or sensitive material.
5. Create the commit with a concise imperative subject, normally under 70 characters. Add a body when the reason is not clear from the subject.
6. Run `git status --short --branch` and report the commit hash, subject, and any remaining changes.

If a hook fails, fix the underlying issue when it is within scope, then create a new commit attempt. Do not amend a commit that was successfully created unless the user asks.
