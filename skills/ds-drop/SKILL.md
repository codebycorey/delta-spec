---
name: ds-drop
description: Abandon a change and clean up its directory and dependency references.
---

# /ds:drop [name] - Abandon a change

Delete a change that is no longer needed.

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
- If only one change in `specs/.delta/` → confirm with user before dropping
- If multiple and not inferable → ask user which to drop
- If none → nothing to drop

## Step 2: Check for dependents

Scan all other changes in `specs/.delta/` for their Dependencies sections:
- Parse each `proposal.md` for `## Dependencies` section
- Look for references to the change being dropped

If other changes depend on this one, ask:
> "The following changes depend on `<name>`:"
> - `<dependent-1>` - [reason from their Dependencies]
> - `<dependent-2>` - [reason from their Dependencies]
>
> Options:
> - **Drop and clean references** - Remove from their Dependencies sections
> - **Drop all** - Also drop the dependent changes (cascade)
> - **Cancel** - Keep the change

## Step 3: Confirm deletion

Show what will be deleted:
```
Will delete: specs/.delta/<name>/
Contents:
  - proposal.md
  - design.md (if exists)
  - specs/*.md (if any)
```

Ask for confirmation unless `--force` flag or user already confirmed in Step 2.

## Step 4: Clean up references

If user chose "Drop and clean references":
- For each dependent change, edit their `proposal.md`
- Remove the line referencing the dropped change from `## Dependencies`
- If Dependencies section becomes empty, leave as `None` or remove section

## Step 5: Delete

- Delete the entire `specs/.delta/<name>/` directory
- Confirm deletion: "Dropped change `<name>`"
- If references were cleaned: "Updated dependencies in: `<dependent-1>`, `<dependent-2>`"

## Notes

- This is permanent - the change is not archived
- If work should be preserved, use `/ds:archive` instead
- Dropped changes leave no trace (unlike archived changes)
