---
description: Reviews a GitHub Pull Request. Use this skill when the user asks to review a PR, check a pull request, or analyze changes in a PR (e.g., "PRをレビューして", "review PR 123", "pull requestを確認して", "review this PR").
---

# PR Review Skill

## Rules

- Use `gh` CLI for all GitHub operations.
- Never post comments to the PR unless explicitly requested by the user.
- Always display results in the terminal.
- Delegate the actual analysis to the built-in `code-review` subagent — do not duplicate its work by re-analyzing the diff yourself.

## Steps

1. **Determine PR number**

   - If a PR number was provided in the conversation or as an argument, use it directly.
   - Otherwise, try to detect a PR from the current branch: `gh pr view --json number -q .number`
   - If no PR is found automatically, use the ask_user tool to ask: "レビューする PR 番号を教えてください。"

2. **Fetch PR information** — run the following in parallel:

   - `gh pr view <pr-number> --json title,body,baseRefName,headRefName,author,additions,deletions,changedFiles`
   - `gh pr diff <pr-number>` to get the full diff, and write it to `/tmp/pr_diff_<pr-number>.diff`

3. **Run the review**

   Launch the `code-review` subagent (via the task tool, agent_type `code-review`) with the diff from step 2. Ask it to analyze the change across three dimensions and report findings for each:

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

   Store the returned findings.

4. **Output**

   Format the subagent's findings as:

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
