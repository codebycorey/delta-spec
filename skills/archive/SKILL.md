---
description: Complete a change by merging delta specs into main specs and archiving.
argument-hint: "[name]"
disable-model-invocation: true
---

# /ds:archive [name] - Complete and archive a change

Merge delta specs into main specs and archive the change.

**Arguments:** If `$ARGUMENTS` is provided, use it as the `name` parameter. Otherwise, follow the determination logic below.

**Note:** This skill performs permanent operations (merging specs) and requires explicit user invocation.

## Step 0: Version Check

See [version-check.md](../_shared/version-check.md) for the standard version compatibility check procedure.

## Step 1: Determine which change

See [determine-change.md](../_shared/determine-change.md) for the standard change resolution procedure. If none → nothing to archive.

## Step 2: Check dependencies

- Parse Dependencies from proposal
- If unsatisfied dependencies exist:
  - Warn: "This change depends on `<name>` which should be archived first."
  - Ask to proceed anyway or archive dependency first
- Archiving out of order may result in specs that reference requirements that don't exist yet

## Step 3: Check for cycles

Check if this change is part of a circular dependency.

See [cycle-detection.md](../_shared/cycle-detection.md) for the cycle detection algorithm. Follow the **Warn with override** flow (archiving may break the cycle).

## Step 4: Pre-validate references

Before showing any diffs, validate all delta operations:

1. Parse all delta specs in `specs/.delta/<name>/specs/`
2. For each MODIFIED/REMOVED requirement:
   - Check if requirement exists in corresponding main spec
   - If not found, error: "Cannot modify 'X': requirement not found in specs/Y.md"
3. For each ADDED requirement:
   - Check if requirement already exists in main spec
   - If found, error: "Cannot add 'X': requirement already exists in specs/Y.md"
4. If any validation fails, stop immediately - **no files are modified**

## Step 5: Check for conflicts

Before proceeding with merge:

1. Scan other active changes in `specs/.delta/` for overlapping modifications
2. For each delta spec, check if another change also MODIFIES or REMOVES the same requirement
3. If conflict found:
   - Warn: "Conflict: 'X' is also modified by change 'Y'"
   - Ask: "Proceed anyway or resolve conflict first?"
4. Uses same conflict detection logic as `/ds:status`

## Step 6: Merge delta specs with confirmation

For each delta spec in `specs/.delta/<name>/specs/`:
- Read the corresponding main spec in `specs/` (or create if new)
- Apply delta operations in order: RENAMED → REMOVED → MODIFIED → ADDED
- Show the diff for all files

After showing all diffs, require explicit confirmation:
1. Show summary: "Will modify: commands.md, workflow.md"
2. Ask: "Apply these changes? [y/N]"
3. **Default to No** - empty input or "n" cancels
4. Only proceed on explicit "y" or "yes"

## Step 7: Archive

- Move entire folder to `specs/.delta/archive/YYYY-MM-DD-<name>/`
- Summarize what was merged

## Merge Algorithm

1. Parse main spec into requirement blocks (`### Requirement: X` through next requirement or EOF)
2. Parse delta into operations by section
3. Apply in order:
   - RENAMED: Update requirement name
   - REMOVED: Delete the block (fails if name doesn't exist)
   - MODIFIED: Replace entire block (fails if name doesn't exist)
   - ADDED: Append to end of Requirements section (fails if name exists)
4. Write updated main spec
