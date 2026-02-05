---
name: ds-tasks
description: Generate implementation tasks from design and delta specs. Creates tasks.md file.
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
- Check for test infrastructure (test directories, test configs, existing test patterns)

## Step 4: Create tasks.md file

Create `specs/.delta/<name>/tasks.md` with specific, actionable tasks:

- Reference actual file paths from exploration
- Reference requirements being implemented
- Order tasks by dependency (what needs to happen first)
- All tasks start with `Status: pending` and `Owner: (unassigned)`
- If the project has tests, include tasks for testing new or modified behavior

Use the Write tool to create the task file.

## Task File Format

```markdown
# Tasks: <change-name>

Generated: YYYY-MM-DD

---

## Task 1: <title>
- **Status:** pending
- **Owner:** (unassigned)
- **Files:** path/to/file.ts
- **Refs:** [Requirement Name]

<description of what to do>

## Task 2: <title>
- **Status:** pending
- **Owner:** (unassigned)
- **Files:** path/to/other.ts
- **Refs:** [Another Requirement]

<description>
```

### Task Fields

| Field | Required | Values |
|-------|----------|--------|
| Status | Yes | `pending`, `in_progress`, `done` |
| Owner | Yes | Agent identifier or `(unassigned)` |
| Files | No | Primary file(s) affected |
| Refs | No | Links to requirements |

### Updating Tasks

Agents update tasks by editing the file directly:

1. **Claim task:** Set `Status: in_progress` and `Owner: <agent-id>`
2. **Complete task:** Set `Status: done` (keep owner for attribution)
3. **Unclaim task:** Set `Status: pending` and `Owner: (unassigned)`

### Multi-Change Mode

When processing multiple changes, create a separate `tasks.md` for each change in its own directory.
