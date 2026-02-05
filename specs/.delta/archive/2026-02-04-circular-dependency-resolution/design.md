# Design: circular-dependency-resolution

## Context

Currently, cycle handling in delta-spec is minimal:
- `/ds-batch` has a "Circular Dependencies" edge case that just warns and asks user to clarify
- `/ds-tasks` mentions "Detect cycles" in multi-change mode but only warns
- `/ds-new`, `/ds-status`, `/ds-archive` have no cycle detection

The proposal template includes a Dependencies section, and cycles can form when:
1. `/ds-batch` infers dependencies that create a loop
2. `/ds-new` declares a dependency that creates a loop with existing changes
3. Manual editing of proposal.md

## Approach

Add two levels of cycle handling:

1. **Detection + Resolution** in `/ds-batch` and `/ds-new`
   - Analyze descriptions to find common concepts
   - Suggest extracting a base change
   - On confirm: create base proposal, update dependencies, clean artifacts, re-plan

2. **Detection + Warning** in `/ds-status`, `/ds-tasks`, `/ds-archive`
   - Detect cycles when building dependency graph
   - Warn with actionable message pointing to resolution

### Cycle Detection Algorithm

```
function detectCycle(changes):
  visited = {}
  path = []

  for change in changes:
    if hasCycle(change, visited, path):
      return path  // the cycle
  return null

function hasCycle(change, visited, path):
  if change in path:
    return true  // found cycle
  if visited[change]:
    return false  // already checked, no cycle

  path.push(change)
  for dep in change.dependencies:
    if hasCycle(dep, visited, path):
      return true
  path.pop()
  visited[change] = true
  return false
```

### Extraction Suggestion Algorithm

When a cycle is detected (e.g., `auth → permissions → admin → auth`):

1. Collect all descriptions from changes in the cycle
2. Tokenize and find common terms (excluding stop words)
3. Rank by frequency across descriptions
4. Suggest name from top term(s): "user" → `user-model`, "auth" → `auth-base`
5. If no clear winner, ask user to name it

### Resolution Flow

```
1. Detect cycle: [auth, permissions, admin]
2. Analyze descriptions for common concept
3. Suggest: "Extract 'user-model' as base change"
4. Show which proposals have artifacts to remove
5. On confirm:
   a. Create specs/.delta/user-model/proposal.md
   b. Update auth/proposal.md dependencies → user-model
   c. Update permissions/proposal.md dependencies → user-model
   d. Update admin/proposal.md dependencies (remove auth, keep permissions)
   e. Delete design.md and tasks.md from affected changes
   f. Run /ds-plan for user-model, auth, permissions, admin in order
```

## Decisions

### Where Resolution Lives
**Choice:** `/ds-batch` and `/ds-new` only
**Why:** These have fresh descriptions to analyze. Other skills just warn.
**Trade-offs:** Can't resolve cycles from `/ds-status`, but cycles are rare from manual edits.

### Artifact Cleanup
**Choice:** Delete design.md and tasks.md, then re-plan automatically
**Why:** Outdated artifacts are misleading. Re-planning is fast.
**Trade-offs:** Loses any manual edits to design/tasks, but those are rare.

### Single Suggestion
**Choice:** Suggest one extraction, user can refine
**Why:** Multiple suggestions add complexity. User can rename or adjust.
**Trade-offs:** May not always pick the ideal name.

## Files Affected

- `skills/ds-batch/SKILL.md` - Add Step 3.5 for cycle resolution
- `skills/ds-new/SKILL.md` - Add cycle check after proposal creation
- `skills/ds-status/SKILL.md` - Add cycle detection to dependency graph
- `skills/ds-tasks/SKILL.md` - Add cycle warning in multi-change mode
- `skills/ds-archive/SKILL.md` - Add cycle warning in dependency check

## Risks

- Extraction suggestion may not match user's mental model
- Re-planning multiple changes takes time
- Complex cycles (4+ changes) may have multiple valid resolutions
