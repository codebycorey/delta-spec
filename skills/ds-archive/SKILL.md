---
name: ds-archive
description: Complete a change by merging delta specs into main specs and archiving.
---

# /ds:archive [name] - Complete and archive a change

Merge delta specs into main specs and archive the change.

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

## Step 1: Determine which change

- If `name` provided → use it
- If inferable from conversation → use it
- If only one change in `specs/.delta/` → use it
- If multiple and not inferable → ask user
- If none → nothing to archive

## Step 2: Check dependencies

- Parse Dependencies from proposal
- If unsatisfied dependencies exist:
  - Warn: "This change depends on `<name>` which should be archived first."
  - Ask to proceed anyway or archive dependency first
- Archiving out of order may result in specs that reference requirements that don't exist yet

### Step 2.1: Check for cycles

Check if this change is part of a circular dependency:

1. Build dependency graph from all active changes
2. Detect if this change is in a cycle

If cycle detected:

```
⚠️  Cycle detected: this-change → other-a → other-b → this-change
    Run /ds-new or /ds-batch to resolve the cycle.

Proceed anyway? [y/N]
```

- Allow override since archiving this change might break the cycle
- On "y": proceed with archiving (user takes responsibility)
- On "n" or empty: stop and let user resolve the cycle first

## Step 2.5: Pre-validate References

Before showing any diffs, validate all delta operations:

1. Parse all delta specs in `specs/.delta/<name>/specs/`
2. For each MODIFIED/REMOVED requirement:
   - Check if requirement exists in corresponding main spec
   - If not found, error: "Cannot modify 'X': requirement not found in specs/Y.md"
3. For each ADDED requirement:
   - Check if requirement already exists in main spec
   - If found, error: "Cannot add 'X': requirement already exists in specs/Y.md"
4. If any validation fails, stop immediately - **no files are modified**

## Step 2.6: Check for Conflicts

Before proceeding with merge:

1. Scan other active changes in `specs/.delta/` for overlapping modifications
2. For each delta spec, check if another change also MODIFIES or REMOVES the same requirement
3. If conflict found:
   - Warn: "Conflict: 'X' is also modified by change 'Y'"
   - Ask: "Proceed anyway or resolve conflict first?"
4. Uses same conflict detection logic as `/ds:status`

## Step 3: Merge delta specs with confirmation

For each delta spec in `specs/.delta/<name>/specs/`:
- Read the corresponding main spec in `specs/` (or create if new)
- Apply delta operations in order: RENAMED → REMOVED → MODIFIED → ADDED
- Show the diff for all files

After showing all diffs, require explicit confirmation:
1. Show summary: "Will modify: commands.md, workflow.md"
2. Ask: "Apply these changes? [y/N]"
3. **Default to No** - empty input or "n" cancels
4. Only proceed on explicit "y" or "yes"

## Step 4: Archive

- Move entire folder to `specs/.delta/archive/YYYY-MM-DD-<name>/`
- Summarize what was merged

## Merge Algorithm

1. Parse main spec into requirement blocks (`### Requirement: X` through next requirement or EOF)
2. Parse delta into operations by section
3. Apply in order:
   - RENAMED: Update requirement name
   - REMOVED: Delete the block
   - MODIFIED: Replace entire block
   - ADDED: Append to end of Requirements section
4. Write updated main spec

## Delta Rules

- ADDED: New requirement - fails if name exists
- MODIFIED: Full replacement - fails if name doesn't exist
- REMOVED: Delete - fails if name doesn't exist
- RENAMED: Change name only, apply MODIFIED separately if needed
- Order: RENAMED → REMOVED → MODIFIED → ADDED
