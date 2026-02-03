---
name: archive
description: Complete and archive a change. Merges delta specs into main specs and moves to archive.
version: 2.0.0
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

## Step 3: Merge delta specs

For each delta spec in `specs/.delta/<name>/specs/`:
- Read the corresponding main spec in `specs/` (or create if new)
- Apply delta operations in order: RENAMED → REMOVED → MODIFIED → ADDED
- Show the diff and confirm before writing

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
