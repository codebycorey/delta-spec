# Design: file-based-tasks

## Context

Currently, `/ds-tasks` generates tasks using Claude Code's native `TaskCreate` tool (see `skills/ds-tasks/SKILL.md:70-82`). The skill explicitly prohibits creating task files:

> **IMPORTANT:** Do NOT create a tasks.md file - use Claude Code's native TaskCreate tool.

The `/ds-status` skill reads progress from "Claude Code's native task list" (`skills/ds-status/SKILL.md:46-54`), with the caveat:

> Note: Progress only visible if tasks were created via `/ds-tasks` in current session.

This session-bound limitation is the core problem we're solving.

## Approach

Replace native TaskCreate with file-based task generation:

1. **`/ds-tasks`** generates `specs/.delta/<name>/tasks.md` instead of calling TaskCreate
2. **`/ds-status`** reads from `tasks.md` files instead of native task list
3. **Agents update tasks directly** by editing the file with Edit tool
4. **Archive preserves tasks** - folder move includes tasks.md automatically

### Task File Location

Per-change at `specs/.delta/<name>/tasks.md`:
- Co-located with change artifacts (proposal.md, design.md, specs/)
- Natural cleanup on archive/drop
- Multi-change aggregation reads multiple files

### Task File Format

Structured markdown with metadata fields per task:

```markdown
# Tasks: <change-name>

Generated: YYYY-MM-DD

---

## Task 1: <title>
- **Status:** pending
- **Owner:** (unassigned)
- **Files:** path/to/file.ts
- **Refs:** [Requirement Name]

<description>

## Task 2: <title>
...
```

**Fields:**
| Field | Required | Values |
|-------|----------|--------|
| Status | Yes | `pending`, `in_progress`, `done` |
| Owner | No | Agent identifier or `(unassigned)` |
| Files | No | Primary file(s) affected |
| Refs | No | Links to requirements |

### Task Updates

Agents edit the file directly:
1. Read `tasks.md`
2. Find task by number
3. Update `Status` and/or `Owner` fields
4. Save with Edit tool

For swarm coordination:
- Claim: Set `Status: in_progress` and `Owner: <agent-id>` atomically
- Complete: Set `Status: done`, keep owner for attribution
- Unclaim: Set `Status: pending`, clear owner to `(unassigned)`

## Decisions

### Per-change vs single file
**Choice:** Per-change file at `specs/.delta/<name>/tasks.md`
**Why:** Co-location with change artifacts, natural cleanup on archive/drop
**Trade-offs:** Must aggregate across files for multi-change view

### Status fields vs checkboxes
**Choice:** Explicit status field (`pending`/`in_progress`/`done`)
**Why:** Machine parseable, supports ownership, richer than binary done/not-done
**Trade-offs:** Slightly more verbose than `- [ ]` checkboxes

### No native task integration
**Choice:** Skip TaskCreate entirely, file is sole source of truth
**Why:** Eliminates sync complexity, native tasks don't help with persistence or swarms
**Trade-offs:** Lose Claude Code spinner UI for task progress

## Files Affected

- `skills/ds-tasks/SKILL.md` - Replace TaskCreate with file generation
- `skills/ds-status/SKILL.md` - Read from tasks.md instead of native tasks
- `specs/skills.md` - Update task generation requirements

## Risks

- **Race conditions in swarms** - Mitigated by "read before claim" pattern; edits are atomic
- **Format changes** - Structured format is simple and stable
- **No backward compatibility needed** - Tasks are ephemeral per change; no migration
