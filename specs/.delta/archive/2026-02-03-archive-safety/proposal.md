# Proposal: archive-safety

## Problem
The current `/ds:archive` command can fail mid-merge or produce unexpected results:
1. **Cross-reference errors** - A delta might reference a requirement that doesn't exist
2. **Silent overwrites** - Diff is shown but no explicit confirmation step
3. **No conflict check** - Archive proceeds even if conflicts exist with other changes

## Dependencies
- `status-enhancements` - Uses conflict detection to warn before archiving

## Changes
- Add pre-archive validation that checks all requirement references exist
- Add interactive confirmation step after showing diff
- Check for conflicts with other active changes before proceeding

## Capabilities

### New
- **Reference validation** - Error if MODIFIED/REMOVED targets don't exist in main spec
- **Interactive confirmation** - Ask "Apply these changes? [y/N]" after showing diff
- **Conflict gate** - Warn if archiving would conflict with another change's delta specs

### Modified
- `/ds:archive` workflow - More defensive, fails fast on validation errors

## Out of Scope
- Automatic conflict resolution
- Partial archive (all or nothing)
- Dry-run mode (diff preview already exists)

## Success Criteria
- Invalid references caught before any files are modified
- User explicitly confirms before changes are written
- Conflicting archives are blocked with clear explanation
