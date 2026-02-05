---
name: ds-new
description: Start a new change with a proposal. Creates proposal.md and works interactively to define problem and scope.
---

# /ds:new <name> - Start a new change

Start a new change by creating a proposal.

## Step 0: Version Check

Check `specs/.delta-spec.json` for version compatibility:
- If file missing → tell user to run `/ds:init` first
- If version matches current plugin version → proceed
- If version mismatch → warn user and offer to migrate:
  > "This project uses delta-spec v{old}. Current version is v{new}."
  > Options:
  > - **Migrate** - Update to current version (may modify spec format)
  > - **Continue anyway** - Use current commands without migrating
  > - **Cancel** - Stop and review changes first

## Steps

1. Create `specs/.delta/<name>/` directory
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

## Step 4: Check for cycles

After the proposal is complete (especially the Dependencies section), check if the declared dependencies create a cycle with existing changes.

### Cycle Detection

1. Load all existing changes from `specs/.delta/` (excluding `archive/`)
2. Parse Dependencies from each proposal
3. Add the new change to the graph
4. Check if following dependencies creates a cycle

### If Cycle Detected

1. **Analyze descriptions** - Collect descriptions from new proposal + existing proposals in the cycle
2. **Find common concepts** - Identify terms appearing across multiple descriptions
3. **Suggest extraction** - Propose a base change name from the common concept

4. **Show resolution prompt**:

```
⚠️  Cycle detected: new-feature → existing-a → existing-b → new-feature

Analysis: "user" appears in multiple descriptions
Suggested: Extract "user-model" as base change

This will:
  - Create new proposal: user-model
  - Update dependencies in: new-feature, existing-a, existing-b
  - Remove artifacts from: existing-a (has design.md, tasks.md)

Extract "user-model" as base change? [y/N]
```

### On Confirm ("y")

1. Create `specs/.delta/<base-name>/proposal.md` with extracted common functionality
2. Update the new proposal's dependencies to point to the base
3. Update existing proposals' dependencies to point to the base
4. Delete `design.md` and `tasks.md` from affected existing proposals
5. Run `/ds-plan` for all affected changes in dependency order

### On Decline ("n" or empty)

Ask user to modify their dependencies:

> Your dependencies create a cycle. Please remove one:
> - `existing-a` - [reason from proposal]
> - `existing-b` - [reason from proposal]

Update the proposal's Dependencies section and continue.

## Behavior

- If the change already exists, reopen the proposal for editing/refinement
- Work interactively with the user to fill out each section
- Ask clarifying questions to understand the problem fully
- After Dependencies are defined, check for cycles before finalizing
