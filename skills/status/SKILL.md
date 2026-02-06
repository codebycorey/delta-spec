---
description: Show active changes with progress, dependencies, and next steps. Use when checking status, viewing active work, or reviewing the dependency graph.
allowed-tools: ["Read", "Glob"]
---

# /ds:status - Show active changes

Show status of all active changes.

**Note:** This skill is read-only and restricted to Read and Glob tools.

## Step 0: Version Check

See [version-check.md](../_shared/version-check.md) for the standard version compatibility check procedure.

## Step 1: List active changes

List changes in `specs/.delta/` (excluding `archive/`).

## Step 2: Show change details

For each change, read the proposal and show:
- Which artifacts exist (proposal? design? specs?)
- Brief summary from proposal
- Dependencies status:
  - Check if dependencies are still in `specs/.delta/` (blocked) or `archive/` (satisfied)
  - Show: `✓ ready` or `⏳ blocked by: <change-name>`
- Next step (plan? tasks? ready to archive?)

## Step 3: Detect conflicts

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

## Step 4: Show progress

For each change, read `specs/.delta/<name>/tasks.md`:

1. If file exists, parse all `## Task N:` sections
2. Extract status from `- **Status:**` line for each task
3. Count by status (pending, in_progress, done)
4. Display: "Progress: 2/5 done" or "Progress: 0/5 pending"

If `tasks.md` doesn't exist, show "No tasks (run /ds:tasks)"

## Step 5: Show dependency graph

Parse dependencies from all active changes and render ASCII tree.

### Step 5.1: Detect Cycles

See [cycle-detection.md](../_shared/cycle-detection.md) for the cycle detection algorithm. Follow the **Warn-only** flow.

### Step 5.2: Render Graph

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
- If a cycle exists, still show the graph (cycle will be visible in the structure)

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
