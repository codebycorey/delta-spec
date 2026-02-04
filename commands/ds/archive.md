---
description: Safely merge delta specs and archive a completed change
argument-hint: [name]
---

Complete and archive a change with safety checks.

**Input**: $ARGUMENTS (optional change name, or inferred from context)

Safety features:
- Pre-validates all requirement references before showing diffs
- Checks for conflicts with other active changes
- Requires explicit confirmation before writing

Merges delta specs into main specs and moves the change to `specs/.delta/archive/`.

Use the archive skill to execute this workflow.
