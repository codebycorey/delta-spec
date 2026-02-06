# Proposal: extract-determine-change

## Problem
The "determine which change to operate on" logic follows the same 5-step pattern in 4 skills (plan, tasks, archive, drop): check arguments, infer from conversation, use single change, ask if multiple, suggest prerequisite if none. This is repeated almost identically four times.

## Dependencies
None

## Changes
- Create `skills/_shared/determine-change.md` with the canonical resolution procedure
- Update `skills/plan/SKILL.md` to reference shared file
- Update `skills/tasks/SKILL.md` to reference shared file
- Update `skills/archive/SKILL.md` to reference shared file
- Update `skills/drop/SKILL.md` to reference shared file

## Capabilities

### New
- Shared `_shared/determine-change.md` with the 5-step change resolution procedure

### Modified
- `plan/SKILL.md` — Replace inline resolution logic with reference
- `tasks/SKILL.md` — Replace inline resolution logic with reference
- `archive/SKILL.md` — Replace inline resolution logic with reference
- `drop/SKILL.md` — Replace inline resolution logic with reference

## Out of Scope
- Changing the resolution algorithm
- Adding new resolution strategies

## Success Criteria
- Single source of truth for change resolution in `_shared/determine-change.md`
- All 4 skills reference the shared file
- No duplication of the 5-step resolution pattern across skills
