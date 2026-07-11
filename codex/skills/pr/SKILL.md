---
name: pr
description: Prepare and create a GitHub pull request for the current branch. Use when the user asks Codex to create, open, or submit a PR or pull request, including requests such as "create a PR", "open a pull request", or "PRを作って".
---

# Create a Pull Request

## Rules

- Use `gh` for GitHub operations and `git` for local repository inspection.
- Never force-push unless the user explicitly requests it.
- Keep the title under 70 characters, including any task-ID prefix.
- Preserve the repository's pull-request template, including comments and sections.
- Do not include unrelated local changes or commits.
- Treat pushing and opening the PR as requested side effects when the user asks to create a PR. Ask only when a missing choice materially changes the result.

## Resolve Inputs

Use values already provided by the user. Otherwise apply these defaults:

- Base branch: the repository default from `gh repo view --json defaultBranchRef -q .defaultBranchRef.name`.
- Task ID: none.
- Draft: false.
- Assignee: none. Resolve "me" or "自分" with `gh api user --jq .login`.

If the user asks to choose an option or repository instructions require confirmation, ask a concise question before proceeding.

## Inspect the Repository

1. Run independent reads in parallel where possible:
   - `git status --short --branch`
   - `git log --oneline -10`
   - `git branch --show-current`
   - `git remote -v`
2. Find a PR template in this order:
   - `.github/pull_request_template.md`
   - `.github/PULL_REQUEST_TEMPLATE.md`
   - `docs/pull_request_template.md`
   - `pull_request_template.md`
   - `.github/PULL_REQUEST_TEMPLATE/*.md`
3. If multiple templates exist, ask the user which one to use.
4. If the worktree contains uncommitted changes, explain whether they affect the proposed PR. Do not commit or include them without explicit user intent.
5. Determine the base branch and inspect the complete PR range:
   - `git diff <base>...HEAD`
   - `git log <base>...HEAD --oneline`
6. Stop and explain the issue if the branch has no commits to propose, contains unexpected commits, or the intended scope remains ambiguous.

## Draft the PR

- Write a concise imperative title. Prefix it with `[<task-id>] ` when a task ID is provided.
- Base the body on all commits in `<base>...HEAD`, not only the latest commit.
- If a template exists, preserve it verbatim and fill only sections supported by the changes or conversation. Ask for information required by the template that cannot be inferred.
- Without a template, use:

```markdown
## Summary
- <what changed and why>

## Test plan
- [ ] <verification performed or still required>
```

- Never claim a test was run when it was not. Clearly mark unverified checks.

## Publish

1. Check whether the branch has an upstream.
2. Push with `git push -u origin <branch>` when it has none; otherwise use `git push`.
3. Create the PR:

```bash
gh pr create --title "<title>" --base "<base>" \
  [--draft] [--assignee "<assignee>"] --body "$(cat <<'EOF'
<body>
EOF
)"
```

4. Run `gh pr view --json number,title,url,baseRefName,headRefName,isDraft` to verify the result.
5. Report the PR URL, title, base/head branches, draft state, and any tests not run.
