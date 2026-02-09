# Proposal: extract-shared-templates

## Problem
Design template, task format, and dependency signal patterns are duplicated across multiple skills, risking drift when one is updated but others are not. The plugin already uses `_shared/` for 6 files — these 3 templates should follow the same pattern.

## Dependencies
None

## Changes
- Extract design.md template from `plan`, `adopt`, and `quick` into `_shared/design-template.md`
- Extract task format from `tasks` and `adopt` into `_shared/task-format.md`
- Extract dependency signal keywords table from `batch` and `adopt` into `_shared/dependency-signals.md`
- Update all referencing skills to use the new shared files

## Capabilities

### New
- `_shared/design-template.md` - Canonical design document template
- `_shared/task-format.md` - Canonical task file format and field reference
- `_shared/dependency-signals.md` - Dependency keyword patterns for inference

### Modified
- `plan/SKILL.md` - Reference shared design template
- `adopt/SKILL.md` - Reference shared design template, task format, and dependency signals
- `quick/SKILL.md` - Reference shared design template
- `tasks/SKILL.md` - Reference shared task format
- `batch/SKILL.md` - Reference shared dependency signals

## Out of Scope
- Changing the content of the templates themselves
- Refactoring other shared files
- Adding new template content

## Success Criteria
- All 3 shared files exist in `_shared/`
- No inline design template, task format, or dependency signal table in any SKILL.md
- All referencing skills point to the shared files
- Content is identical to what was inlined before
