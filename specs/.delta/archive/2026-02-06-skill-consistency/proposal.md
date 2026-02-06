# Proposal: skill-consistency

## Problem
After two rounds of plugin review, a second tier of polish items remains: a duplicated proposal template across 3 skills, missing trigger phrases on 3 descriptions, an undocumented `--force` flag, vague interactive guidance in `/ds:new`, inconsistent step numbering, and CHANGELOG notation mismatches. These reduce maintainability and consistency.

## Dependencies
None

## Changes
- **Extract proposal template** to `skills/_shared/proposal-template.md`; replace inline copies in new, quick, and batch with references
- **Remove `--force` flag** reference from `drop/SKILL.md` line 50 (undocumented, unsupported)
- **Add "Use when..." trigger phrases** to init, archive, and drop descriptions for consistency with other 7 skills
- **Expand `new/SKILL.md` Step 3** with specific interactive guidance (which sections to probe, when proposal is complete)
- **Add kebab-case naming guidance** to `new/SKILL.md` for the `<name>` parameter
- **Add plugin version source** to `init/SKILL.md` — specify reading version from `.claude-plugin/plugin.json`
- **Fix `plan/SKILL.md` Step 2b** — renumber to integer step (Step 3) and renumber subsequent steps
- **Fix CHANGELOG.md** — replace `/ds-*` notation with `/ds:*`, add `[0.1.0]` section

## Capabilities

### Modified
- Shared proposal template eliminates 3-way duplication
- All 10 skill descriptions follow consistent "Use when..." pattern
- Cleaner drop skill without phantom flag
- Better interactive guidance for new skill
- Consistent integer step numbering across all skills

## Out of Scope
- Extracting merge algorithm from archive to references/ (low duplication risk, single location)
- Extracting task format from tasks to references/ (same)
- Adding status example output to examples/ (low value)
- Changing description form to "This skill should be used when..." (current "Use when..." is fine)

## Success Criteria
- Proposal template exists in exactly one place (`_shared/proposal-template.md`)
- All 10 descriptions include trigger phrases
- No undocumented flags in any skill
- `new/SKILL.md` Step 3 has actionable interactive guidance
- All skills use integer step numbering (no 2b, 2.5 etc. at top level)
- CHANGELOG uses `/ds:*` notation throughout
