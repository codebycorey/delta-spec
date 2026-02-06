---
description: Abandon a change and clean up its directory and dependency references. Use when canceling a change, discarding a proposal, or removing planned work.
argument-hint: "[name]"
disable-model-invocation: true
---

# /ds:drop [name] - Abandon a change

Delete a change that is no longer needed.

**Arguments:** If `$ARGUMENTS` is provided, use it as the `name` parameter. Otherwise, follow the determination logic below.

**Note:** This skill performs permanent operations (deleting change directories) and requires explicit user invocation.

## Step 0: Version Check

See [version-check.md](../_shared/version-check.md) for the standard version compatibility check procedure.

## Step 1: Determine which change

See [determine-change.md](../_shared/determine-change.md) for the standard change resolution procedure. For drop: confirm with user even when only one change exists (destructive operation). If none → nothing to drop.

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

Ask for confirmation unless the user already confirmed in Step 2.

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
