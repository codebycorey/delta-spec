# Proposal: tasks-multi-change

## Problem
The current `/ds:tasks` command only handles one change at a time. When multiple changes are planned with dependencies between them, users must manually:
1. Figure out the correct order to process changes
2. Run `/ds:tasks` for each change separately
3. Track which changes have been processed

This is error-prone and tedious.

## Dependencies
None

## Changes
- Add "all changes" mode to `/ds:tasks` that processes multiple planned changes
- Automatically determine correct order based on dependencies
- Process independent changes first, then dependent changes in sequence
- Create tasks for each change in order, clearly grouped

## Capabilities

### New
- **Batch task creation** - `/ds:tasks` without arguments processes all planned changes in order
- **Dependency-aware ordering** - Independent changes first, then topologically sorted dependents
- **Grouped output** - Tasks clearly labeled by which change they belong to

### Modified
- `/ds:tasks [name]` - Still works for single change; no name = all changes

## Out of Scope
- Parallel execution of independent changes (sequential is fine)
- Automatic task dependencies across changes (tasks are just ordered)

## Success Criteria
- User can run `/ds:tasks` once to get all implementation tasks in correct order
- Tasks are grouped by change for clarity
- Dependency order is respected automatically
