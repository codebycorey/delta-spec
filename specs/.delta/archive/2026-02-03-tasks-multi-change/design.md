# Design: tasks-multi-change

## Context

The current `/ds:tasks` skill (in `skills/tasks/SKILL.md`) has Step 1 "Determine which change" that picks a single change. When multiple changes exist, it asks the user to pick one.

This doesn't support the common workflow of planning multiple changes and then wanting tasks for all of them in the right order.

## Approach

Modify Step 1 to support an "all changes" mode:

1. **No name provided + multiple changes with design+specs** → Process all in dependency order
2. **No name provided + only one change** → Use that change (current behavior)
3. **Name provided** → Use that specific change (current behavior)

### Ordering Algorithm
1. Parse dependencies from all proposals
2. Build dependency graph
3. Topological sort: changes with no dependencies first, then dependents
4. If cycles detected, warn and ask user to resolve

### Task Grouping
When processing multiple changes, output format:
```
=== Tasks for: plan-dependencies-fix ===
1. Update skills/plan/SKILL.md...
2. ...

=== Tasks for: spec-search ===
3. Update commands/ds/spec.md...
4. ...
```

Tasks are numbered sequentially across all changes for easy reference.

## Decisions

### Trigger: No Name = All Changes
**Choice:** When no name given and multiple planned changes exist, process all
**Why:** Most common use case after batch planning
**Trade-offs:** Changes behavior slightly; users who want to pick can use `/ds:tasks <name>`

### Only Process Planned Changes
**Choice:** Skip changes that only have proposals (no design+specs)
**Why:** Unplanned changes aren't ready for task creation
**Trade-offs:** Could confuse users if some changes are skipped; mitigate with clear output

### Sequential Numbering
**Choice:** Tasks numbered 1, 2, 3... across all changes, not restarting per change
**Why:** Easier to reference "task 5" than "task 2 of change 3"
**Trade-offs:** Numbers might get high; acceptable for typical workflows

## Files Affected
- `skills/tasks/SKILL.md` - Update Step 1 for multi-change mode, add ordering algorithm
- `commands/ds/tasks.md` - Update description to mention batch mode

## Risks
- Complex dependency graphs could be confusing (mitigated by typical small number of changes)
- Cycle detection adds complexity (but necessary for correctness)
