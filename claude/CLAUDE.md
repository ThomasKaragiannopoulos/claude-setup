# Global Instructions

## Memory First
Before exploring codebase, check loaded memory for existing context.
After sessions: save anything non-obvious that would need re-explaining.

## Changes
Prefer editing existing files over creating new ones.
Minimal diffs — change only what the task requires.
No refactoring, cleanup, or "improvements" beyond what was asked.
Don't "improve" adjacent code, comments, or formatting.
Remove imports/variables/functions YOUR changes made unused — don't touch pre-existing dead code unless asked.
If you notice unrelated dead code, mention it — don't delete it.

## Uncertainty
Ask before assuming on ambiguous requirements.
If multiple interpretations exist, present them — don't pick silently.
If a simpler approach exists, say so and push back.
If blocked, diagnose root cause — don't brute-force or retry same approach.

## Destructive Ops
Always confirm before: deleting files, force-pushing, dropping data, overwriting uncommitted work.

## Learning
User still learning. On obscure/complex concepts — ask if detailed explanation wanted before continuing.

## Code Quality
No premature abstractions. No helpers for one-off tasks.
No error handling for impossible scenarios.
Trust framework guarantees; validate only at system boundaries.
No features beyond what was asked. If you write 200 lines and it could be 50, rewrite it.

## Multi-Step Tasks
State a brief plan before starting:
1. [Step] → verify: [check]
2. [Step] → verify: [check]

## Git Commits
NEVER add Claude as a co-contributor on git commits. No `Co-Authored-By: Claude` lines.

## Per-Project Context
When working in a new repo with non-obvious patterns — suggest creating a CLAUDE.md for it.
Keep project CLAUDE.md files short (25–35 lines). Compass, not encyclopedia.
