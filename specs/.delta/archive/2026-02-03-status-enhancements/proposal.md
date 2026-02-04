# Proposal: status-enhancements

## Problem
The current `/ds:status` command shows basic information about active changes but lacks:
1. **Conflict detection** - No warning when multiple changes modify the same requirement
2. **Progress tracking** - No indication of how much work remains
3. **Dependency visualization** - Flat list doesn't show relationships clearly

## Dependencies
- `spec-search` - Uses search capability to identify conflicting requirements across changes

## Changes
- Add conflict detection that scans delta specs for overlapping requirement modifications
- Add progress indicator based on completed vs. pending tasks
- Add ASCII dependency graph visualization

## Capabilities

### New
- **Conflict warnings** - Show when two changes both MODIFY or REMOVE the same requirement
- **Progress percentage** - Show "3/5 tasks complete" style progress
- **Dependency tree** - Visual representation of which changes block which

### Modified
- `/ds:status` output format - Richer, more informative display

## Out of Scope
- Automatic conflict resolution
- Task creation from status view
- Integration with external task trackers

## Success Criteria
- Conflicts are detected and displayed before they cause archive failures
- Users can see at a glance how much work remains on each change
- Dependency relationships are visually clear
