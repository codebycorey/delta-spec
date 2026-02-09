---
description: Generate implementation tasks from design and delta specs. Use when creating a task list, breaking down work, or preparing to implement.
argument-hint: "[name]"
---

# /ds:tasks [name] - Create implementation tasks

Create actionable implementation tasks based on the design and delta specs.

**Arguments:** If `$ARGUMENTS` is provided, use it as the `name` parameter. Otherwise, generate tasks for all planned changes.

## Step 0: Version Check

See [version-check.md](../_shared/version-check.md) for the standard version compatibility check procedure.

## Step 1: Determine which change(s)

See [determine-change.md](../_shared/determine-change.md) for the standard change resolution procedure. For tasks, uses multi-change mode: if no name provided and multiple planned changes exist, process all in dependency order. Prerequisite: suggest `/ds:plan`.

### Multi-Change Mode

When processing multiple changes:

1. **Identify planned changes** - Only include changes with `design.md` AND `specs/` directory
2. **Build dependency graph** - Parse Dependencies section from each proposal
3. **Topological sort** - Independent changes first, then dependents in order
4. **Detect cycles** - If circular dependencies found:
   ```
   ⚠️  Cycle detected: auth → permissions → admin → auth
       Cannot determine task order.
       Run /ds:new or /ds:batch to resolve the cycle first.
   ```
   **Do not proceed** until cycle is resolved (hard block - task ordering is impossible with cycles)
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

## Step 3: Check dependencies

- Parse Dependencies from proposal
- If unsatisfied dependencies exist, warn user and ask to proceed or defer

## Step 4: Explore the codebase

- Identify exact files and functions to modify
- Find where new code should be added
- Understand dependencies and integration points
- Check for test infrastructure (test directories, test configs, existing test patterns)

## Step 5: Create tasks.md file

Create `specs/.delta/<name>/tasks.md` with specific, actionable tasks:

- Reference actual file paths from exploration
- Reference requirements being implemented
- Order tasks by dependency (what needs to happen first)
- All tasks start with `Status: pending` and `Owner: (unassigned)`
- If the project has tests, include tasks for testing new or modified behavior

Use the Write tool to create the task file.

## Task File Format

See [task-format.md](../_shared/task-format.md) for the task file format, fields, and update instructions.

### Multi-Change Mode

When processing multiple changes, create a separate `tasks.md` for each change in its own directory.
