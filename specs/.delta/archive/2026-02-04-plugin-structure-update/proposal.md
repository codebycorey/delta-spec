# Proposal: plugin-structure-update

## Problem

The plugin structure documentation and specs are out of date after significant changes to how skills are organized. The changes were made to fix issues with:
1. Commands overshadowing skills (skills not appearing in `/skills`)
2. Skill names conflicting with built-in Claude Code commands (`/plan`, `/init`, `/status`)
3. Understanding the correct plugin structure for Claude Code

Additionally, AGENTS.md is not being loaded by Claude Code - only CLAUDE.md is auto-loaded.

Commands and skills were merged in Claude Code v2.1.3. The specs currently use "commands" terminology and `/ds:*` naming, but we now use skills with `/ds-*` naming.

Skill descriptions are also verbose - they all start with "This skill should be used when..." which is redundant.

## Dependencies

None

## Changes

- Rename `specs/commands.md` to `specs/skills.md`
- Create `CLAUDE.md` as a symlink to `AGENTS.md` (so Claude Code auto-loads it)
- Update all skill references from `/ds:init` to `/ds-init` format (hyphenated, no colon)
- Add documentation about plugin structure requirements
- Document why skills need the `ds-` prefix (to avoid built-in conflicts)
- Update terminology from "commands" to "skills" throughout
- Update README.md skill table to match new naming
- Clean up skill descriptions to be more concise

## Capabilities

### New

- Plugin structure specification documenting:
  - Skills-only approach (no commands folder)
  - Skill folder naming conventions (`ds-<name>`)
  - Valid SKILL.md frontmatter fields
  - How to avoid conflicts with built-in commands

- `CLAUDE.md` symlink → `AGENTS.md` (enables Claude Code auto-loading)

### Modified

- `specs/commands.md` → `specs/skills.md` - Rename and update:
  - `/ds:init` → `/ds-init`
  - `/ds:new` → `/ds-new`
  - `/ds:plan` → `/ds-plan`
  - `/ds:tasks` → `/ds-tasks`
  - `/ds:archive` → `/ds-archive`
  - `/ds:drop` → `/ds-drop`
  - `/ds:spec` → `/ds-spec`
  - `/ds:status` → `/ds-status`

- `AGENTS.md` - Update:
  - All skill references to `/ds-*` format
  - Terminology from "commands" to "skills"

- `README.md` - Update:
  - Command table → Skill table with `/ds-*` names
  - Terminology from "commands" to "skills"
  - Any references to plugin structure

- `skills/*/SKILL.md` - Clean up descriptions:
  - Remove "This skill should be used when..." prefix
  - Make descriptions action-oriented and concise
  - Example: "Initialize delta-spec in a repository. Creates specs/ directory..."

## Out of Scope

- Changing the actual skill implementations (beyond frontmatter)
- Renaming the plugin itself
- Changes to the workflow or validation specs

## Success Criteria

- All specs use "skills" terminology (not "commands")
- All skill references use `/ds-*` format (hyphenated)
- Plugin structure requirements are documented
- CLAUDE.md symlink exists and points to AGENTS.md
- README.md skill table matches actual skill names
- Skill descriptions are concise and action-oriented
