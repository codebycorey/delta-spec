---
description: Start a new change with a proposal. Use when starting a feature, creating a proposal, or beginning planned work.
argument-hint: "<name>"
---

# /ds:new <name> - Start a new change

Start a new change by creating a proposal.

**Arguments:** If `$ARGUMENTS` is provided, use it as the `name` parameter. Otherwise, ask the user for a change name.

## Step 0: Version Check

See [version-check.md](../_shared/version-check.md) for the standard version compatibility check procedure.

## Step 1: Create change directory

Create `specs/.delta/<name>/` directory.

## Step 2: Create proposal from template

Create `proposal.md` from the template below.

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

## Step 3: Work with user on proposal

Work with the user to flesh out the proposal interactively.

## Step 4: Check for cycles

After the proposal is complete (especially the Dependencies section), check if the declared dependencies create a cycle with existing changes.

See [cycle-detection.md](../_shared/cycle-detection.md) for the cycle detection algorithm. Follow the **Full resolution** flow.
