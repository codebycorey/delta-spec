# Proposal: skill-metadata

## Problem
SKILL.md files lack several frontmatter fields that improve discoverability and safety. Skills that accept arguments don't advertise expected arguments in autocomplete. Destructive skills (archive, drop, init) can be invoked automatically by the model without user intent. Every skill except ds-init duplicates an identical 13-line version check block (~117 lines total). Skills don't use the `$ARGUMENTS` placeholder for explicit argument handling. Read-only skills lack `allowed-tools` restrictions.

## Dependencies
- `skill-namespace-cleanup` - SKILL.md files must be renamed/relocated before modifying their frontmatter and content

## Changes
- Add `argument-hint` frontmatter to 7 skills: new (`<name>`), plan (`[name]`), tasks (`[name]`), archive (`[name]`), drop (`[name]`), spec (`[domain|search]`), quick (`[name] ["description"]`)
- Add `disable-model-invocation: true` to 3 destructive skills: archive, drop, init
- Extract duplicated "Step 0: Version Check" block into `skills/_shared/version-check.md` and replace with references in all 9 skills
- Add `$ARGUMENTS` placeholder to skills that accept arguments, with fallback to context inference
- Add `allowed-tools: Read, Grep, Glob` to read-only skills: spec, status

## Capabilities

### New
- Argument hints visible during autocomplete for all argument-accepting skills
- Shared version check file (single source of truth)
- Explicit `$ARGUMENTS` handling in skill prompts

### Modified
- Destructive skills require explicit user invocation
- Read-only skills restricted to read-only tools
- ~117 lines of duplicated content reduced to 9 one-line references

## Out of Scope
- Changing skill behavior or logic beyond metadata
- Adding new skills
- Modifying the version check logic itself (only extracting it)

## Success Criteria
- `argument-hint` appears in autocomplete for all 7 applicable skills
- Archive, drop, and init cannot be triggered by model inference
- `skills/_shared/version-check.md` exists and is referenced by all 9 non-init skills
- Skills correctly receive arguments via `$ARGUMENTS` placeholder
- `ds-spec` and `ds-status` only have access to Read, Grep, Glob tools
