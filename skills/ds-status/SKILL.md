---
name: ds-status
description: Show active changes with progress, dependencies, and next steps.
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

## Step 3: Detect Conflicts

Scan all delta specs in active changes for overlapping modifications:

1. For each change, read `specs/.delta/<name>/specs/*.md`
2. Extract all MODIFIED and REMOVED requirement names
3. Build map: requirement name → list of changes that touch it
4. If any requirement has >1 change, display warning:

```
⚠️  Conflicts detected:
  "View Specifications" modified by: spec-search, other-change
  "Archive Change" modified by: archive-safety, breaking-change
```

## Step 4: Show Progress

For each change, check Claude Code's native task list:

1. Look for tasks with subjects referencing the change name
2. Count by status (pending, in_progress, completed)
3. Display: "Progress: 3/5 tasks" or "No tasks"

Note: Progress only visible if tasks were created via `/ds:tasks` in current session.

## Step 5: Show Dependency Graph

Parse dependencies from all active changes and render ASCII tree:

```
Dependency Graph:
spec-search
└── status-enhancements
    └── archive-safety
plan-dependencies-fix (independent)
tasks-multi-change (independent)
```

- Changes that other changes depend on are roots
- Indent children (dependents) under their dependencies
- Mark independent changes (no dependencies, nothing depends on them) explicitly

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
