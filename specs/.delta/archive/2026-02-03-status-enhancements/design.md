# Design: status-enhancements

## Context

The current `/ds:status` command (defined in `skills/status/SKILL.md`) shows:
- List of active changes in `specs/.delta/`
- Which artifacts exist (proposal, design, specs)
- Brief summary from proposal
- Dependency status (blocked or ready)
- Recommended next step

Missing capabilities:
1. **Conflict detection** - No warning when multiple changes modify the same requirement
2. **Progress tracking** - No indication of task completion
3. **Dependency visualization** - Flat list doesn't show relationships

## Approach

Enhance the status output with three new sections:

### 1. Conflict Detection
- Scan all delta specs in active changes
- Build a map: requirement name → list of changes that MODIFY or REMOVE it
- If any requirement has >1 change, display a conflict warning
- Uses the search/scanning pattern from spec-search

### 2. Progress Tracking
- Check Claude Code's native task list for the current session
- Count tasks by status (pending, in_progress, completed)
- Display as "Progress: 3/5 tasks" or percentage
- Note: Only works if tasks were created via `/ds:tasks`

### 3. Dependency Graph
- Parse dependencies from all active changes
- Render as ASCII tree showing relationships
- Example:
  ```
  Dependency Graph:
  spec-search
  └── status-enhancements
      └── archive-safety
  enhanced-features (no dependencies)
  ```

## Decisions

### Conflict Scope: Active Changes Only
**Choice:** Only check for conflicts between active (non-archived) changes
**Why:** Archived changes are already merged; conflicts would have been resolved
**Trade-offs:** Can't detect conflicts with historical changes

### Progress Source: Native Tasks
**Choice:** Read from Claude Code's task system, not from files
**Why:** Tasks are created with TaskCreate per the delta-spec convention
**Trade-offs:** Progress only visible in sessions where tasks were created

### Graph Format: ASCII Tree
**Choice:** Simple ASCII tree representation
**Why:** Works in any terminal, no dependencies
**Trade-offs:** Complex dependency graphs may be hard to read (mitigated by typical small number of active changes)

## Files Affected
- `skills/status/SKILL.md` - Add conflict detection, progress, and graph sections
- `commands/ds/status.md` - Update description to mention new capabilities

## Risks
- Progress tracking depends on tasks existing in current session
- Conflict detection may have false positives if requirement names aren't unique across domains
