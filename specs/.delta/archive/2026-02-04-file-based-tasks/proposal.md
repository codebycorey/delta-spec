# Proposal: file-based-tasks

## Problem

Currently `/ds-tasks` generates tasks using Claude Code's native TaskCreate tool. These tasks are ephemeral - they're lost when:
- The session restarts or crashes
- Context is cleared
- A different agent needs to see the task list

This prevents effective:
1. **Session persistence** - Can't resume work after restart
2. **Agent swarm coordination** - Multiple agents can't share a task list

## Dependencies

None

## Changes

- Modify `/ds-tasks` to generate `tasks.md` file instead of native TaskCreate
- Update `/ds-status` to read progress from `tasks.md` files
- Update specs to reflect new task file behavior

## Capabilities

### New

- **Persistent task files** - `specs/.delta/<name>/tasks.md` survives sessions
- **Status field tracking** - Tasks have `pending`, `in_progress`, `done` states
- **Ownership tracking** - Tasks can have `owner` field for swarm coordination
- **Archived task history** - Completed changes preserve their task files

### Modified

- `/ds-tasks` skill - Generate file instead of native tasks
- `/ds-status` skill - Read from task files instead of native task list
- `specs/skills.md` - Update task generation requirements

## Out of Scope

- Native TaskCreate integration (no sync between file and native)
- Task dependencies (blocked by other tasks)
- Automatic task assignment in swarms
- Task comments or history tracking

## Success Criteria

- [ ] `/ds-tasks` creates `specs/.delta/<name>/tasks.md`
- [ ] Task file has structured format with status/owner fields
- [ ] `/ds-status` correctly reads and displays progress from task files
- [ ] Agents can update task status by editing the file directly
- [ ] Task files are preserved when changes are archived
