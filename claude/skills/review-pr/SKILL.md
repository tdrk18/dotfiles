---
description: Reviews a GitHub Pull Request. Use this skill when the user asks to review a PR, check a pull request, or analyze changes in a PR (e.g., "PRをレビューして", "review PR 123", "pull requestを確認して", "review this PR").
---

# PR Review Skill

## Rules

- Use `gh` CLI for all GitHub operations.
- Never post comments to the PR unless explicitly requested by the user.
- Always display results in the terminal.
- Focus on code quality, potential bugs, and test coverage.

## Steps

1. **Determine PR number**

   - If a PR number was provided in the conversation or as an argument, use it directly.
   - Otherwise, try to detect a PR from the current branch: `gh pr view --json number -q .number`
   - If no PR is found automatically, use the AskUserQuestion tool to ask: "レビューする PR 番号を教えてください。"

2. **Fetch PR information** — run the following in parallel:

   - `gh pr view <pr-number> --json title,body,baseRefName,headRefName,author,additions,deletions,changedFiles`
   - `gh pr diff <pr-number>` to get the full diff
   - `gh pr view <pr-number> --json files -q '.files[].path'` to list changed files

3. **Analyze the PR** across three dimensions:

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

4. **Output the review** in this format:

   ```
   # PR Review: #<pr-number> — <title>

   **Author**: <author>
   **Changes**: +<additions> / -<deletions> across <changedFiles> files

   ---

   ## Critical Issues (must fix)
   - <file>:<line> — <description>

   ## Important Issues (should fix)
   - <file>:<line> — <description>

   ## Suggestions (nice to have)
   - <file>:<line> — <description>

   ## Strengths
   - <what is done well>

   ---
   **Overall**: <one-sentence summary of the PR quality and readiness>
   ```

   - If there are no items in a section, omit that section entirely.
   - Always include at least one item in "Strengths" if the code has any positive aspects.
   - Reference specific file paths and line numbers wherever possible.
