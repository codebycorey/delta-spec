# Proposal: test-task-generation

## Problem

When `/ds-tasks` generates implementation tasks, it doesn't consider whether the project has tests. Projects with test infrastructure should get test tasks alongside implementation tasks, but currently users have to remember to add them manually.

## Dependencies

None

## Changes

- Update `/ds-tasks` skill to detect test infrastructure during codebase exploration
- Include test tasks when tests exist in the project

## Capabilities

### New

- Context-aware test task generation based on project structure

### Modified

- `skills/ds-tasks/SKILL.md` - Add test detection and task generation guidance

## Out of Scope

- Specific test framework integrations (Claude infers from context)
- Test generation (just tasks, not actual test code)
- Configuration options for enabling/disabling test tasks

## Success Criteria

- `/ds-tasks` checks for test infrastructure during exploration
- Test tasks are included when project has tests
- No change in behavior for projects without tests
