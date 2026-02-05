# Proposal: skill-namespace-cleanup

## Problem
Skill directories use `ds-*` prefix naming (e.g., `skills/ds-init/`) and SKILL.md files contain a `name` field that strips the plugin namespace prefix. This causes skills to appear as `/ds-init` instead of the intended `/ds:init`. Cross-references across SKILL.md files use `/ds:new` colon notation while CLAUDE.md and README.md use `/ds-new` hyphen notation, creating inconsistency.

## Dependencies
None

## Changes
- Rename all 10 skill directories from `ds-*` to plain names (e.g., `ds-init/` → `init/`, `ds-new/` → `new/`)
- Remove the `name` field from all 10 SKILL.md frontmatter files
- Update marketplace.json skill paths to reflect new directory names
- Update all cross-references in SKILL.md files to use consistent `/ds:*` colon notation
- Update CLAUDE.md skill references to match the new `/ds:*` format
- Update spec files (`skills.md`, `workflow.md`) that reference skill names

## Capabilities

### Modified
- Skill invocation changes from `/ds-init` to `/ds:init` (and similarly for all 10 skills)
- Autocomplete dropdown shows clean namespaced names

## Out of Scope
- README.md updates (handled by `readme-improvements`)
- Frontmatter changes beyond removing `name` field (handled by `skill-metadata`)
- Any behavioral changes to skill logic

## Success Criteria
- All skills appear as `/ds:*` in the autocomplete dropdown
- No `name` field in any SKILL.md frontmatter
- All cross-references within SKILL.md files and CLAUDE.md use consistent notation
- `claude --plugin-dir` loads all skills without errors
