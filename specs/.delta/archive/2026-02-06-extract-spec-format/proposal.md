# Proposal: extract-spec-format

## Problem
The spec format template (Markdown structure for specification files) is duplicated across 3 skills (init, spec, plan) with identical or near-identical content. Changes to the format require updating multiple files.

## Dependencies
None

## Changes
- Create `skills/_shared/spec-format.md` with the canonical spec format template
- Update `skills/init/SKILL.md` to reference shared file instead of inline template
- Update `skills/spec/SKILL.md` to reference shared file instead of inline template
- Update `skills/plan/SKILL.md` to reference shared file instead of inline template

## Capabilities

### New
- Shared `_shared/spec-format.md` with canonical spec format definition and template

### Modified
- `init/SKILL.md` — Replace inline spec format with reference
- `spec/SKILL.md` — Replace inline spec format and writing guidelines with reference
- `plan/SKILL.md` — Replace inline delta format template with reference

## Out of Scope
- Changing the spec format itself
- Modifying the delta spec format (only extracting the shared base format)

## Success Criteria
- Single source of truth for spec format in `_shared/spec-format.md`
- All 3 skills reference the shared file
- No duplication of the format template across skills
