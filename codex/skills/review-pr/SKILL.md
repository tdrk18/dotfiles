---
name: review-pr
description: Review a GitHub pull request for bugs, behavioral regressions, security or reliability risks, and missing tests. Use when the user asks Codex to review, inspect, check, or analyze a PR or pull request, including requests such as "review PR 123", "check this pull request", or "PRをレビューして".
---

# Review a Pull Request

## Rules

- Use `gh` for GitHub data and `git` for local repository inspection.
- Do not post reviews or comments to GitHub unless the user explicitly requests it.
- Prioritize actionable defects over summaries, style preferences, or praise.
- Support every finding with a concrete failure mode and a precise file and line reference.
- Do not report a speculative concern as a defect. Inspect surrounding code or repository conventions first.
- Treat existing code outside the PR as context, not as a PR finding, unless the change makes an existing problem newly reachable or worse.

## Identify the PR

Use a PR number or URL already present in the conversation. Otherwise try the current branch:

```bash
gh pr view --json number -q .number
```

If no PR can be determined, ask the user for the PR number or URL.

## Gather Context

Run independent reads in parallel where possible:

```bash
gh pr view <pr> --json number,title,body,url,baseRefName,headRefName,author,additions,deletions,changedFiles,commits,files
gh pr diff <pr>
gh pr checks <pr>
```

Then:

1. Read repository instructions such as `AGENTS.md` and relevant nested instruction files.
2. Inspect the complete diff and commit list, not only the latest commit.
3. Open changed files and the surrounding implementation needed to understand contracts, callers, data flow, and error handling.
4. Inspect relevant tests and search for analogous patterns with `rg`.
5. Check whether failures in `gh pr checks` are plausibly caused by the PR. Do not diagnose from a check name alone.
6. If the local checkout does not contain the PR head, use `gh pr checkout <pr>` only when changing the current worktree is acceptable. Otherwise inspect content with `gh api`, `git show`, or a temporary worktree.

## Review Dimensions

Evaluate changes for:

- Correctness: wrong conditions, boundary errors, invalid state transitions, stale data, and broken contracts.
- Reliability: missing error handling, partial failures, retries, concurrency, resource cleanup, and destructive behavior.
- Security and privacy: validation, authorization, injection, secrets, and unintended data exposure.
- Compatibility: callers, schemas, migrations, configuration, APIs, and platform or version assumptions.
- Tests: missing coverage for changed behavior, important edge cases, and error paths.

Avoid findings that are only formatting preferences, optional refactors, or unsupported guesses.

## Write the Review

List findings first, ordered by severity:

- `Critical`: data loss, security exposure, widespread outage, or similarly severe impact.
- `High`: a likely user-facing failure or major behavioral regression.
- `Medium`: a real defect with narrower impact or a meaningful reliability problem.
- `Low`: a minor but actionable defect. Do not use this category for cosmetic suggestions.

Format each finding as:

```markdown
- **[High] Short imperative title** — `path/to/file.ext:42`
  Explain the triggering conditions, resulting behavior, and why the changed code causes it. Keep the cited range as small as possible.
```

After findings, include `Open Questions` only for unresolved assumptions that affect correctness. End with a short summary and test status as secondary context.

If no findings remain after verification, say so clearly and mention any tests not run or residual areas that could not be validated. Do not invent a finding to fill a section.

## GitHub Posting

When the user explicitly asks to post the review:

1. Show or summarize the exact review content before posting if it has not already been presented.
2. Use `gh pr review <pr> --comment --body-file <file>` by default.
3. Use `--approve` or `--request-changes` only when the user explicitly selects that outcome.
4. Return the PR URL and the action performed.
