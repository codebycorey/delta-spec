# Proposal: improve-skill-descriptions

## Problem
Skill descriptions in YAML frontmatter lack trigger phrases for model-invocable skills. They describe what the skill does but not when to invoke it, reducing effectiveness for automatic model invocation. The descriptions use imperative form rather than the recommended "This skill should be used when..." pattern.

## Dependencies
- `extract-cycle-detection` — Descriptions should reference final content structure
- `extract-spec-format` — Descriptions should reference final content structure
- `extract-determine-change` — Descriptions should reference final content structure
- `extract-batch-references` — Descriptions should reference final content structure

## Changes
- Update `description` field in frontmatter for all 7 model-invocable skills:
  - `skills/new/SKILL.md`
  - `skills/plan/SKILL.md`
  - `skills/tasks/SKILL.md`
  - `skills/spec/SKILL.md`
  - `skills/status/SKILL.md`
  - `skills/quick/SKILL.md`
  - `skills/batch/SKILL.md`

## Capabilities

### Modified
- All 7 model-invocable skill descriptions updated with:
  - "This skill should be used when..." pattern
  - Specific trigger phrases users might type
  - Clear activation criteria

## Out of Scope
- Changing descriptions for `disable-model-invocation: true` skills (init, archive, drop)
- Modifying skill content beyond the `description` frontmatter field

## Success Criteria
- All 7 model-invocable skills have descriptions with trigger phrases
- Descriptions follow "This skill should be used when..." pattern
- Each description includes 2-3 example trigger phrases
