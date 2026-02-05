# Design: plugin-structure-update

## Context

The plugin structure was changed to fix several issues:
1. Commands and skills were merged in Claude Code v2.1.3
2. Having both `commands/` and `skills/` folders caused commands to overshadow skills
3. Skill names like `init`, `plan`, `status` conflicted with built-in Claude Code commands

Current state after code changes:
- `commands/` folder deleted
- Skills renamed from `skills/init/` to `skills/ds-init/`
- Skills now appear as `/ds-init`, `/ds-plan`, etc. (hyphenated, no colon)

Documentation is now out of sync with the actual implementation.

Additionally, skill descriptions are verbose - all start with "This skill should be used when the user asks to..." which is redundant.

## Approach

1. Rename `specs/commands.md` → `specs/skills.md` and update all references
2. Create `CLAUDE.md` symlink pointing to `AGENTS.md`
3. Update `AGENTS.md` with new skill naming
4. Update `README.md` with new skill naming and corrected project structure
5. Clean up skill descriptions in all `SKILL.md` files

All changes are find-and-replace style updates from `/ds:*` to `/ds-*` format, plus terminology changes from "commands" to "skills".

## Decisions

### Rename Spec File
**Choice:** Rename `commands.md` to `skills.md`
**Why:** Reflects the actual implementation - we use skills, not commands
**Trade-offs:** Breaks any external links to `specs/commands.md`

### Symlink for CLAUDE.md
**Choice:** Create symlink `CLAUDE.md` → `AGENTS.md` rather than renaming
**Why:** Keeps the common `AGENTS.md` convention while enabling Claude Code auto-loading
**Trade-offs:** Two filenames for same content (but clearly linked)

### Hyphenated Skill Names
**Choice:** Skills named `/ds-init` instead of `/ds:init`
**Why:** Colon-namespaced skills (like `/ds:init`) conflicted with built-in commands
**Trade-offs:** Slightly longer names, different from original design

### Concise Skill Descriptions
**Choice:** Remove "This skill should be used when..." prefix from descriptions
**Why:** Redundant - Claude already knows it's a skill description
**Trade-offs:** None - strictly an improvement

## Files Affected

- `specs/commands.md` → `specs/skills.md` - Rename and update ~50 occurrences of `/ds:*`
- `AGENTS.md` - Update ~15 occurrences of `/ds:*`
- `README.md` - Update ~20 occurrences of `/ds:*`, fix project structure section
- `CLAUDE.md` - New symlink to `AGENTS.md`
- `skills/ds-init/SKILL.md` - Clean up description
- `skills/ds-new/SKILL.md` - Clean up description
- `skills/ds-plan/SKILL.md` - Clean up description
- `skills/ds-tasks/SKILL.md` - Clean up description
- `skills/ds-archive/SKILL.md` - Clean up description
- `skills/ds-drop/SKILL.md` - Clean up description
- `skills/ds-spec/SKILL.md` - Clean up description
- `skills/ds-status/SKILL.md` - Clean up description

## Skill Description Updates

| Skill | Before | After |
|-------|--------|-------|
| ds-init | "This skill should be used when the user asks to 'initialize delta-spec'..." | "Initialize delta-spec in a repository. Creates specs/ directory structure." |
| ds-new | "This skill should be used when the user asks to 'start a new change'..." | "Start a new change with a proposal. Creates proposal.md interactively." |
| ds-plan | "This skill should be used when the user asks to 'plan the change'..." | "Create design and delta specs. Explores codebase for implementation approach." |
| ds-tasks | "This skill should be used when the user asks to 'create tasks'..." | "Generate implementation tasks from design and delta specs." |
| ds-archive | "This skill should be used when the user asks to 'archive a change'..." | "Complete a change by merging delta specs into main specs." |
| ds-drop | "This skill should be used when the user asks to 'drop a change'..." | "Abandon a change and clean up its directory." |
| ds-spec | "This skill should be used when the user asks to 'view specs'..." | "View, discuss, or search specifications." |
| ds-status | "This skill should be used when the user asks to 'show status'..." | "Show active changes with progress and dependencies." |

## Risks

- External documentation or users familiar with old `/ds:*` naming will need to update
- Git history for `commands.md` will be preserved but file renamed
