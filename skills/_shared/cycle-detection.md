# Shared: Cycle Detection

Detect and resolve circular dependencies between active changes.

## Core Algorithm

Use depth-first search (DFS) with path tracking:

1. Build dependency graph from all active changes in `specs/.delta/` (excluding `archive/`)
2. Parse Dependencies section from each `proposal.md`
3. For each change, follow dependencies recursively
4. If a path leads back to a node already in the current path, a cycle exists
5. Return the cycle path (e.g., `[auth, permissions, admin, auth]`)

## Analysis Procedure

For skills that need full resolution (new, batch):

1. Collect descriptions from all changes in the cycle
2. Tokenize descriptions and filter stop words ("the", "a", "and", "to", "for", etc.)
3. Find common terms appearing across multiple descriptions
4. Suggest a base change name from the most common concept
5. If no clear winner, ask user to name it

## Resolution: Full (new, batch)

Show the resolution prompt with analysis and suggested extraction:

```
⚠️  Cycle detected: <cycle path>

Analysis: "<common-term>" appears in multiple descriptions
Suggested: Extract "<base-name>" as base change

This will:
  - Create new proposal: <base-name>
  - Update dependencies in: <list of changes>
  - Remove artifacts from: <changes with design.md, tasks.md>

Extract "<base-name>" as base change? [y/N]
```

### On Confirm ("y")

1. Create `specs/.delta/<base-name>/proposal.md` with extracted common functionality
2. Update affected proposals' dependencies to point to the base
3. Remove the dependency that was causing the cycle
4. Delete `design.md` and `tasks.md` from affected changes (if exist)
5. Run `/ds:plan` for all affected changes in dependency order

### On Decline ("n" or empty)

Ask user which dependency to remove to break the cycle:

> Which dependency should be removed to break the cycle?
> 1. auth → permissions (remove permissions' dependency on auth)
> 2. permissions → admin (remove admin's dependency on permissions)
> 3. admin → auth (remove auth's dependency on admin)

After user selects, update the proposal and continue.

## Resolution: Warn-only (status)

Display warning only, no action taken:

```
⚠️  Cycle detected: <cycle path>
    Run /ds:new or /ds:batch to resolve.
```

## Resolution: Warn with override (archive)

Show warning with override option:

```
⚠️  Cycle detected: <cycle path>
    Run /ds:new or /ds:batch to resolve the cycle.

Proceed anyway? [y/N]
```

- Allow override since archiving this change might break the cycle
- On "y": proceed with archiving (user takes responsibility)
- On "n" or empty: stop and let user resolve the cycle first
