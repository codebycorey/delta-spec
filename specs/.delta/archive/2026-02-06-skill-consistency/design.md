# Design: skill-consistency

## Context
After two rounds of plugin review, a second tier of consistency issues remains:
- The proposal template is duplicated in `new/SKILL.md`, `quick/SKILL.md`, and `batch/SKILL.md`
- 3 skill descriptions (init, archive, drop) lack "Use when..." trigger phrases
- `drop/SKILL.md` references an undocumented `--force` flag
- `new/SKILL.md` Step 3 is vague ("flesh out interactively") with no specific guidance
- `new/SKILL.md` lacks naming convention guidance for the `<name>` parameter
- `init/SKILL.md` doesn't specify where to read the plugin version
- `plan/SKILL.md` uses "Step 2b" instead of integer numbering
- CHANGELOG.md uses `/ds-*` notation instead of `/ds:*` and is missing a `[0.1.0]` section

## Approach
1. Extract the proposal template to `skills/_shared/proposal-template.md` and replace all three inline copies with references
2. Add "Use when..." phrases to the three descriptions missing them
3. Remove the `--force` reference from drop Step 3
4. Expand new Step 3 with actionable interactive guidance
5. Add naming convention note to new Step 1
6. Add version source note to init Step 1
7. Renumber plan steps: 2b→3, 3→4, 4→5, 5→6, 6→7
8. Fix CHANGELOG notation and add 0.1.0 section

## Decisions

### Proposal template location
**Choice:** `skills/_shared/proposal-template.md`
**Why:** Follows established `_shared/` pattern for cross-skill references
**Trade-offs:** None — direct improvement

### Description style for disabled skills
**Choice:** Add "Use when..." phrases even to `disable-model-invocation: true` skills
**Why:** Consistency across all 10 skills; descriptions serve humans reading the skill list too
**Trade-offs:** None

### Plan step renumbering
**Choice:** Renumber 2b→3 and bump all subsequent steps
**Why:** Integer steps are the pattern everywhere else; 2b is an outlier
**Trade-offs:** Existing references to "Step 5" or "Step 6" in plan would shift by one

## Files Affected
- `skills/_shared/proposal-template.md` - NEW: extracted proposal template
- `skills/new/SKILL.md` - replace inline template with reference, expand Step 3, add naming guidance
- `skills/quick/SKILL.md` - replace inline template with reference
- `skills/batch/SKILL.md` - replace inline template with reference
- `skills/init/SKILL.md` - add version source, add trigger phrases to description
- `skills/archive/SKILL.md` - add trigger phrases to description
- `skills/drop/SKILL.md` - remove --force reference, add trigger phrases to description
- `skills/plan/SKILL.md` - renumber steps from 2b onward
- `CHANGELOG.md` - fix notation, add 0.1.0 section

## Risks
- Plan step renumbering shifts step numbers by +1 from step 3 onward; any external references to plan steps will be off by one. Low risk since references are internal.
