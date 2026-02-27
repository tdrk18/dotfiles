# CLAUDE.md

This file contains personal instructions for Claude Code, specific to this user's preferences and workflow.

## Work in Meaningful Chunks

Break work into meaningful, logical units and proceed step by step. Do not implement everything at once — complete one coherent piece, confirm it's on the right track, then move to the next.

## Git Commit Settings

Each commit should represent one logical, self-contained change — following the same granularity as the work chunks above.

When creating git commits, always use the current model name in the Co-Authored-By trailer:

```
Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
```

**IMPORTANT**: Always check your system information to determine the actual model you are running on, and use that exact model name (e.g., "Claude Sonnet 4.6", "Claude Opus 4.6", etc.).

Commit messages must include a description of what was done and why — not just a short title.

## Clarify Before Implementing

When there are unknowns or ambiguities, do not proceed with implementation unilaterally. Always ask the user for clarification first, especially in these cases:

- Requirements are unclear or open to multiple interpretations
- A judgment call is needed on implementation approach
- The impact on existing code or architecture is uncertain

