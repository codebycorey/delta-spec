# Design: plan-dependencies-fix

## Context

The current workflow enforces dependency checks at three points:
1. `/ds:plan` - Warns and asks to proceed or defer
2. `/ds:tasks` - Warns and asks to proceed or defer
3. `/ds:archive` - Warns and asks to proceed or archive dependency first

This was designed to prevent users from getting ahead of themselves, but it creates friction when users want to plan multiple changes in sequence (a common pattern).

The key insight: **Planning is read-only exploration + document creation**. It doesn't modify main specs or create code. Dependencies only matter when:
- Creating tasks (implementation order)
- Archiving (spec merge order)

## Approach

1. Change `/ds:plan` to **note** dependencies without **blocking**
2. Keep `/ds:tasks` and `/ds:archive` warnings as-is (they affect real artifacts)
3. Update the workflow spec to document this distinction
4. Add this learning to CLAUDE.md for future reference

## Decisions

### Plan Phase: Note vs Block
**Choice:** Show dependencies as informational, don't ask for confirmation
**Why:** Planning is safe; blocking interrupts batch workflows
**Trade-offs:** Users might forget about dependencies (mitigated by tasks/archive still checking)

### Keep Tasks/Archive Warnings
**Choice:** Continue warning at tasks and archive phases
**Why:** These phases affect implementation order and spec integrity
**Trade-offs:** Some friction remains, but at appropriate points

## Files Affected
- `skills/plan/SKILL.md` - Change Step 2b from blocking to informational
- `specs/workflow.md` - Clarify dependency enforcement phases
- `CLAUDE.md` - Add learnings section with this insight

## Risks
- None significant; this reduces friction without removing safety checks
