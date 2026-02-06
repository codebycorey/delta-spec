# Proposal: normalize-step-numbering

## Problem
Step numbering and writing style are inconsistent across skills. Some skills mix heading styles (steps under `## Steps` vs top-level `## Step N`), archive uses non-sequential numbering (2.1, 2.5, 2.6), quick/SKILL.md uses second-person writing ("you know what you want"), and init/SKILL.md duplicates its description as the opening line.

## Dependencies
- `extract-cycle-detection` — Step numbering changes should be done after extraction to avoid conflicts
- `extract-spec-format` — Step numbering changes should be done after extraction to avoid conflicts
- `extract-determine-change` — Step numbering changes should be done after extraction to avoid conflicts
- `extract-batch-references` — Step numbering changes should be done after extraction to avoid conflicts

## Changes
- Normalize step numbering convention across all skills to use consistent heading style
- Fix `skills/archive/SKILL.md` — Renumber 2.1/2.5/2.6 to sequential steps
- Fix `skills/new/SKILL.md` — Normalize mixed step heading styles
- Fix `skills/status/SKILL.md` — Normalize mixed step heading styles
- Fix `skills/quick/SKILL.md` — Change second-person to imperative/third-person
- Fix `skills/init/SKILL.md` — Replace duplicate opening line with value-adding content

## Capabilities

### Modified
- Consistent step numbering convention across all skills
- Imperative/third-person writing style throughout
- No duplicate content between descriptions and opening lines

## Out of Scope
- Changing the actual step content or logic
- Reordering steps
- Adding or removing steps

## Success Criteria
- All skills use the same step heading convention
- No non-sequential step numbers (no 2.5, 2.6)
- No second-person writing in any skill
- No description duplication in opening lines
