# Design: archive-safety

## Context

The current `/ds:archive` command (defined in `skills/archive/SKILL.md`):
- Shows diff and asks to confirm before writing
- Has delta rules that fail if MODIFIED/REMOVED targets don't exist
- But these failures happen during merge, potentially after some specs are already modified

Current flow:
1. Determine change
2. Check dependencies (warn if unsatisfied)
3. Merge delta specs (fail mid-merge if invalid reference)
4. Archive

The problem is step 3 can fail partway through, leaving specs in an inconsistent state.

## Approach

Add safety checks before any modifications:

### 1. Pre-validation Phase (new Step 2.5)
Before showing any diffs:
- Parse all delta specs
- For each MODIFIED/REMOVED operation, verify the requirement exists in main spec
- For each ADDED operation, verify the requirement doesn't already exist
- If any validation fails, stop immediately with clear error message
- No files are modified during validation

### 2. Conflict Check (new Step 2.6)
Before proceeding with merge:
- Scan other active changes for overlapping modifications
- If another change also touches the same requirement, warn user
- Leverage conflict detection logic from status-enhancements
- Ask to proceed or resolve conflicts first

### 3. Interactive Confirmation (enhanced Step 3)
After showing all diffs:
- Require explicit "y" confirmation
- Show summary: "Will modify: commands.md, workflow.md. Proceed? [y/N]"
- Default to No (safe by default)

## Decisions

### Validation Before Diff
**Choice:** Run all validations before showing any diff
**Why:** Users shouldn't see diffs for operations that will fail
**Trade-offs:** Slightly longer before seeing output (negligible)

### Fail-Fast on First Error
**Choice:** Stop at first validation error, don't collect all errors
**Why:** One error is enough to block; showing all might overwhelm
**Trade-offs:** Users fix errors one at a time

### Default to No on Confirmation
**Choice:** [y/N] with N as default (empty input = cancel)
**Why:** Destructive operations should require explicit consent
**Trade-offs:** Slightly more friction for experienced users

## Files Affected
- `skills/archive/SKILL.md` - Add pre-validation, conflict check, and explicit confirmation
- `commands/ds/archive.md` - Update description to mention safety checks

## Risks
- Conflict detection depends on status-enhancements being implemented
- Could add friction to the archive workflow (mitigated by being safer)
