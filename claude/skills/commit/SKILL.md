---
description: Creates a git commit. Use this skill when the user asks to commit, make a commit, or save changes to git (e.g., "コミットして", "commit this", "変更をコミットして", "commit the changes").
---

# Git Commit Skill

## Rules

- Each commit must represent one logical, self-contained change.
- Always use the current model name in the Co-Authored-By trailer. Check system information to determine the exact model name (e.g., "Claude Sonnet 4.6", "Claude Opus 4.6").
- Commit messages must describe **what** was done and **why** — not just a short title.
- Never use `--no-verify` or bypass hooks unless the user explicitly requests it.
- Never force-push unless explicitly requested.

## Steps

1. Run the following in parallel:
   - `git status` to see untracked/modified files
   - `git diff` to see staged and unstaged changes
   - `git log --oneline -5` to understand commit message style

2. Analyze the changes and draft a commit message:
   - Short title (imperative mood, under 70 chars)
   - Body explaining what was done and why
   - Co-Authored-By trailer with the current model name

3. **Show the proposed commit message to the user and ask for confirmation before proceeding.**

4. After confirmation, stage the relevant files and run:
   ```
   git commit -m "$(cat <<'EOF'
   <title>

   <body>

   Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
   EOF
   )"
   ```

5. Run `git status` to confirm the commit succeeded.
