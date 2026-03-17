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
   - `which codex` to check if Codex CLI is available (exit code 0 = available)

3. **Run Codex review** _(only if `codex` is available)_

   Check out the PR locally and run `codex review`, then restore the original branch:

   ```
   gh pr checkout <pr-number>
   codex review --base <baseRefName> "Review this PR focusing on: (1) code quality — readability, naming, unnecessary complexity, duplication; (2) potential bugs — unhandled edge cases, error handling, incorrect assumptions; (3) test coverage — missing tests, untested edge cases, meaningless assertions. Be specific with file and line references."
   git checkout <original-branch>
   ```

   Capture the full output of `codex review` as **Codex findings**.
   If `codex` is not available, skip this step entirely and proceed with Claude-only review.

4. **Run Claude review**

   Independently analyze the diff obtained in step 2 across the same three dimensions:

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

5. **Consolidate and output**

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
