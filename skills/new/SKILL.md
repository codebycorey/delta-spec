---
name: new
description: Start a new delta-spec change. Creates proposal.md and works with user to define problem and scope.
---

# /ds:new <name> - Start a new change

Start a new change by creating a proposal.

## Steps

1. Create `specs/.delta/active/<name>/` directory
2. Create `proposal.md` from the template below
3. Work with the user to flesh out the proposal interactively

## Proposal Template

```markdown
# Proposal: <name>

## Problem
[What problem are we solving? Why does this matter?]

## Dependencies
[Other changes that must be completed first, or "None"]
- `<change-name>` - [why this is needed first]

## Changes
- [Specific change 1]
- [Specific change 2]

## Capabilities

### New
- [New capability → becomes new spec or requirements]

### Modified
- [Existing spec that needs changes]

## Out of Scope
- [What we're explicitly NOT doing]

## Success Criteria
- [How do we know this is complete?]
```

## Behavior

- If the change already exists, reopen the proposal for editing/refinement
- Work interactively with the user to fill out each section
- Ask clarifying questions to understand the problem fully
