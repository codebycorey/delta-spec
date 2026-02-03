---
name: tasks
description: Create implementation tasks for a change. Explores codebase and uses TaskCreate for native task tracking.
version: 2.0.0
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

## Step 1: Determine which change

- If `name` provided → use it
- If inferable from conversation → use it
- If only one change in `specs/.delta/` → use it
- If multiple and not inferable → ask user
- If none → tell user to run `/ds:new` first

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
