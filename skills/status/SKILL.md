---
name: status
description: Show active delta-spec changes with their status, dependencies, and next steps.
version: 0.0.1
license: MIT
---

# /ds:status - Show active changes

Show status of all active changes.

## Step 0: Version Check

Check `specs/.delta-spec.json` for version compatibility:
- If file missing → show warning that delta-spec is not initialized
- If version mismatch → show warning in status output:
  ```
  ⚠️  Version mismatch: project v{old}, current v{new}
      Run any command to migrate, or review CHANGELOG for breaking changes.
  ```

## Steps

1. List changes in `specs/.delta/` (excluding `archive/`)
2. For each, read the proposal and show:
   - Which artifacts exist (proposal? design? specs?)
   - Brief summary from proposal
   - Dependencies status:
     - Check if dependencies are still in `specs/.delta/` (blocked) or `archive/` (satisfied)
     - Show: `✓ ready` or `⏳ blocked by: <change-name>`
   - Next step (plan? tasks? ready to archive?)

## Example Output

```
Active changes:

add-user-model
  Status: design + specs complete
  Summary: Add user schema for authentication
  Dependencies: None
  ✓ Ready to archive

add-oauth
  Status: proposal only
  Summary: Add social login with Google/GitHub
  Dependencies: add-user-model (active)
  ⏳ Blocked - run /ds:plan after add-user-model is archived
```

## Notes

- If no active changes, suggest running `/ds:new <name>`
- Show clear next action for each change
