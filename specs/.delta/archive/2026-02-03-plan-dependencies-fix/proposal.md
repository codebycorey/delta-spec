# Proposal: plan-dependencies-fix

## Problem
The current `/ds:plan` command warns and asks for confirmation when a change has unsatisfied dependencies. This is overly restrictive because:

1. **Planning is safe** - You're just designing, not implementing or merging
2. **Batch planning is common** - Users often want to plan multiple related changes in sequence
3. **Interruptions slow workflow** - Asking "proceed anyway?" for each dependent change is tedious

Dependencies should only block or warn during:
- `/ds:tasks` - Implementation order matters
- `/ds:archive` - Merge order matters

## Dependencies
None

## Changes
- Update workflow spec to clarify planning doesn't require satisfied dependencies
- Update plan skill to note dependencies without blocking
- Add learning to CLAUDE.md about this workflow insight

## Capabilities

### New
None

### Modified
- `/ds:plan` behavior - Notes dependencies exist but proceeds without confirmation
- Workflow spec - Clarifies which phases enforce dependencies

## Out of Scope
- Changing tasks/archive dependency behavior (those should still warn)

## Success Criteria
- Users can plan multiple dependent changes in sequence without interruption
- Dependency information is still visible during planning (just not blocking)
