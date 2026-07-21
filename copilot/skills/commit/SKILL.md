---
description: Creates a git commit. Use this skill when the user asks to commit, make a commit, or save changes to git (e.g., "コミットして", "commit this", "変更をコミットして", "commit the changes").
---

# Git Commit Skill

## Rules

- Each commit must represent one logical, self-contained change.
- Always include the Co-authored-by trailer for Copilot: `Co-authored-by: Copilot App <223556219+Copilot@users.noreply.github.com>` (unless the user explicitly asks to omit it).
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
   - Co-authored-by trailer

3. After confirmation, stage the relevant files and run:
   ```
   git commit -m "$(cat <<'EOF'
   <title>

   <body>

   Co-authored-by: Copilot App <223556219+Copilot@users.noreply.github.com>
   EOF
   )"
   ```

4. Run `git status` to confirm the commit succeeded.
