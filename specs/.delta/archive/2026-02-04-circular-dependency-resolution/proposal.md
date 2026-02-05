# Proposal: circular-dependency-resolution

## Problem
When circular dependencies form (A → B → C → A), the system currently just warns and asks the user to resolve it manually. This is unhelpful - the user needs to figure out what to extract and how to restructure.

## Dependencies
None

## Changes
- Add cycle detection and resolution to `/ds-batch` and `/ds-new`
- Add cycle detection (warning only) to `/ds-status`, `/ds-tasks`, `/ds-archive`
- When resolving: extract shared concept into new base proposal, update dependencies, delete invalidated artifacts, re-run planning

## Capabilities

### New
- **Cycle analysis** - Analyze feature descriptions to find common concepts causing the cycle
- **Extraction suggestion** - Suggest a new base change name based on shared concepts (e.g., "user" appears in auth, permissions, admin → suggest `user-model`)
- **Automatic extraction** - Create new proposal, move relevant description parts, update dependency references
- **Artifact cleanup** - Delete invalidated design.md and tasks.md from affected proposals
- **Automatic re-planning** - Run `/ds-plan` for affected proposals after resolution

### Modified
- `/ds-batch` - Cycle detection + resolution (Step 3.5, before confirmation)
- `/ds-new` - Cycle detection + resolution (after dependencies declared)
- `/ds-status` - Cycle detection + warning in dependency graph
- `/ds-tasks` - Cycle detection + warning (suggest fix via `/ds-new` or `/ds-batch`)
- `/ds-archive` - Cycle detection + warning (suggest fix before archiving)

## Out of Scope
- Resolution in `/ds-status`, `/ds-tasks`, `/ds-archive` (detection + warning only)
- Multiple extraction suggestions (suggest one, user can refine)
- Preserving outdated design/tasks (delete and re-plan is safer)

## Success Criteria
- `/ds-batch` and `/ds-new` detect cycles and offer resolution
- On confirm: new base proposal created, dependencies updated, artifacts cleaned
- Affected proposals automatically re-planned
- `/ds-status`, `/ds-tasks`, `/ds-archive` warn about cycles with actionable message
