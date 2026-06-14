# Global Instructions

## Memory First
Before exploring codebase, check loaded memory for existing context.
After sessions: save anything non-obvious that would need re-explaining.

## Changes
Prefer editing existing files over creating new ones.
Minimal diffs — change only what the task requires.
No refactoring, cleanup, or "improvements" beyond what was asked.

## Uncertainty
Ask before assuming on ambiguous requirements.
If blocked, diagnose root cause — don't brute-force or retry same approach.

## Destructive Ops
Always confirm before: deleting files, force-pushing, dropping data, overwriting uncommitted work.

## Learning
User still learning. On obscure/complex concepts — ask if detailed explanation wanted before continuing.

## Code Quality
No premature abstractions. No helpers for one-off tasks.
No error handling for impossible scenarios.
Trust framework guarantees; validate only at system boundaries.

## Git Commits
NEVER add Claude as a co-contributor on git commits. No `Co-Authored-By: Claude` lines.

## Per-Project Context
When working in a new repo with non-obvious patterns — suggest creating a CLAUDE.md for it.
Keep project CLAUDE.md files short (25–35 lines). Compass, not encyclopedia.
