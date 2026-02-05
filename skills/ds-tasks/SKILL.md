---
name: ds-tasks
description: Generate implementation tasks from design and delta specs. Uses Claude Code's native TaskCreate.
---

# /ds:tasks [name] - Create implementation tasks

Create actionable implementation tasks based on the design and delta specs.

## Step 0: Version Check

Check `specs/.delta-spec.json` for version compatibility:
- If file missing → tell user to run `/ds:init` first
- If version matches current plugin version → proceed
- If version mismatch → warn user and offer to migrate:
  > "This project uses delta-spec v{old}. Current version is v{new}."
  > Options:
  > - **Migrate** - Update to current version (may modify spec format)
  > - **Continue anyway** - Use current commands without migrating
  > - **Cancel** - Stop and review changes first

## Step 1: Determine which change(s)

- If `name` provided → use `specs/.delta/<name>/` (single change mode)
- If only one planned change (has design+specs) → use it
- If multiple planned changes and no name → **process all in dependency order** (multi-change mode)
- If none planned → tell user to run `/ds:plan` first

### Multi-Change Mode

When processing multiple changes:

1. **Identify planned changes** - Only include changes with `design.md` AND `specs/` directory
2. **Build dependency graph** - Parse Dependencies section from each proposal
3. **Topological sort** - Independent changes first, then dependents in order
4. **Detect cycles** - If circular dependencies found, warn and ask user to resolve
5. **Process sequentially** - Create tasks for each change in order

### Output Format for Multi-Change

```
=== Tasks for: change-a (1 of 3) ===
[tasks 1-N]

=== Tasks for: change-b (2 of 3) ===
[tasks N+1-M]

=== Tasks for: change-c (3 of 3) ===
[tasks M+1-...]
```

Tasks are numbered sequentially across all changes.

## Step 2: Build context

- Read proposal, design, and delta specs
- Understand the full scope and approach

## Step 2b: Check dependencies

- Parse Dependencies from proposal
- If unsatisfied dependencies exist, warn user and ask to proceed or defer

## Step 3: Explore the codebase

- Identify exact files and functions to modify
- Find where new code should be added
- Understand dependencies and integration points

## Step 4: Create tasks using TaskCreate

- Create specific, actionable tasks
- Reference actual file paths from exploration
- Reference requirements being implemented
- Order tasks by dependency (what needs to happen first)

Example tasks:
- "Add GoogleStrategy to src/auth/strategies/google.ts"
- "Update src/auth/passport.ts to register OAuth strategies"
- "Add OAuth callback routes to src/routes/auth.ts"

**IMPORTANT:** Do NOT create a tasks.md file - use Claude Code's native TaskCreate tool.
