---
description: Creates a GitHub Pull Request. Use this skill when the user asks to create a PR, open a pull request, or submit changes for review (e.g., "PRを作って", "create a PR", "pull requestを出して", "open a PR").
---

# Pull Request Skill

## Rules

- Use `gh` CLI for all GitHub operations.
- The PR title must be under 70 characters in total, including any `[<task-id>]` prefix.
- Always push the current branch to remote before creating the PR.
- Never force-push unless explicitly requested.
- Always ask the user which base branch to target before proceeding. If the user doesn't specify, use the repository's default branch.
- If a PR template exists, use it as the structure for the body and fill in the content based on the changes.
- If no PR template exists, use the default body format.

## Steps

1. Collect the following parameters. If a value was already provided in the conversation, use it directly and skip the corresponding question. For any value not yet provided, use the AskUserQuestion tool to ask **one at a time**, in order:

   - **Base branch**: use value from conversation, or ask "どのブランチをベースにしますか？（指定がなければデフォルトブランチを使います）". If not specified, run `gh repo view --json defaultBranchRef -q .defaultBranchRef.name`.
   - **Task ID**: use value from conversation, or ask "タスク ID はありますか？（なければスキップ）". Store as `<task-id>`, or leave empty.
   - **Draft**: use value from conversation, or ask "Draft PR として作成しますか？（yes/no）". Add `--draft` if yes.
   - **Assignee**: use value from conversation, or ask "Assignee を指定しますか？（GitHub username、なければスキップ）". Add `--assignee <assignee>` if provided.

2. Run the following in parallel, then check for uncommitted changes:
   - `git status` to check for uncommitted changes
   - `git log --oneline -10` to review recent commits
   - `git branch --show-current` to get the current branch name
   - Check for PR templates in these locations (in order of priority):
     1. `.github/pull_request_template.md`
     2. `.github/PULL_REQUEST_TEMPLATE.md`
     3. `docs/pull_request_template.md`
     4. `pull_request_template.md`
     5. `.github/PULL_REQUEST_TEMPLATE/*.md` (if multiple templates exist, list them and ask the user which to use)

   After the above, if `git status` shows uncommitted changes, use the AskUserQuestion tool to ask: "未コミットの変更があります。このまま PR を作成しますか？". If the user says no, stop here.

3. Run the following in parallel:
   - `git diff <base-branch>...HEAD` to see all changes that will be in the PR
   - `git log <base-branch>...HEAD --oneline` to see commits included in the PR

4. Analyze the changes across all commits and draft:
   - **Title**: Short, imperative mood. If `<task-id>` is provided, prefix it: `[<task-id>] <title>`. The entire title including the prefix must be under 70 characters.
   - **Body**:
     - If a PR template was found: use the template content as-is as the base. Fill in sections where content can be inferred from the code changes. Leave all other sections (e.g., screenshots, empty checkboxes) exactly as they appear in the template — do not remove or skip any section. Preserve all comments (`<!-- ... -->`) in the template verbatim. After filling in what can be inferred from the code, identify any sections that require user input (e.g., motivation/background, related issues, migration steps, manual choices) and use the AskUserQuestion tool to ask the user for those missing pieces before finalizing the body.
     - If no template was found: use this default format:
       ```
       ## Summary
       - <bullet points describing what changed and why>

       ## Test plan
       - <checklist of how to verify the changes>

       🤖 Generated with [Claude Code](https://claude.com/claude-code)
       ```

5. If the branch has no upstream, push it:
   ```
   git push -u origin <branch-name>
   ```
   Otherwise, push normally:
   ```
   git push
   ```

6. Create the PR with the applicable flags:
   ```
   gh pr create --title "<title>" --base <base-branch> [--draft] [--assignee <assignee>] --body "$(cat <<'EOF'
   <body>
   EOF
   )"
   ```
   Include `--draft` if the user requested a draft PR. Include `--assignee <assignee>` if the user provided one.

7. Return the PR URL to the user.
