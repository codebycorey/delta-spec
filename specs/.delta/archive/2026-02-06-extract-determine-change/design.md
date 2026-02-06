# Design: extract-determine-change

## Context

The "determine which change to operate on" logic follows a similar pattern in 4 skills:

- **plan/SKILL.md** (lines 16-22): name → inferable → single → multiple (ask) → none (suggest /ds:new)
- **archive/SKILL.md** (lines 19-25): name → inferable → single → multiple (ask) → none (nothing to archive)
- **drop/SKILL.md** (lines 19-25): name → inferable → single (confirm) → multiple (ask) → none (nothing to drop)
- **tasks/SKILL.md** (lines 16-21): name (single mode) → single planned → multiple (all mode) → none (suggest /ds:plan)

Plan, archive, and drop share an almost identical 5-step pattern. Tasks is different — it has a "multi-change mode" that processes all planned changes in dependency order rather than asking the user to pick one.

## Approach

Create `skills/_shared/determine-change.md` with the standard resolution procedure. The shared file covers the common case (plan, archive, drop) and notes the tasks variant.

The shared procedure:
1. If `name` provided in arguments → use `specs/.delta/<name>/`
2. If inferable from conversation context → use it
3. If only one active change → use it (with optional confirmation for destructive skills)
4. If multiple and not inferable → ask user to pick
5. If none → suggest prerequisite skill

Each skill references the shared file and adds context-specific notes:
- **plan**: prerequisite = `/ds:new`, no confirmation needed for single
- **archive**: prerequisite = none ("nothing to archive"), no confirmation for single
- **drop**: prerequisite = none ("nothing to drop"), confirm even for single
- **tasks**: overrides step 3-4 with multi-change mode (documented inline since it's substantially different)

## Decisions

### Include tasks with a variant note
**Choice:** Include tasks in the shared file with a "tasks variant" section rather than excluding it entirely
**Why:** Steps 1 and 5 are still shared. Only steps 2-4 differ for tasks.
**Trade-offs:** Slightly more complex shared file, but maintains the principle that all change-resolution logic lives in one place

### Parameterize with context notes, not template variables
**Choice:** Use plain-language notes like "For drop: confirm even with single change" rather than template syntax
**Why:** Matches the style of version-check.md and keeps the shared file readable
**Trade-offs:** Skills need a brief inline note about their specific behavior

## Files Affected
- `skills/_shared/determine-change.md` - New: shared change resolution procedure
- `skills/plan/SKILL.md` - Replace lines 16-22 with reference
- `skills/archive/SKILL.md` - Replace lines 19-25 with reference
- `skills/drop/SKILL.md` - Replace lines 19-25 with reference
- `skills/tasks/SKILL.md` - Replace lines 16-21 with reference + inline variant note

## Risks
- Tasks' multi-change mode is substantially different from the other skills; the shared file needs to clearly distinguish the two paths without creating confusion
