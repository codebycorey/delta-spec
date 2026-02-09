# Proposal: fix-step-numbering

## Problem
Inconsistent step numbering across skills: `tasks/SKILL.md` uses "Step 2b" instead of sequential integers, and `batch/SKILL.md` uses fractional steps (2.5, 3.5). This makes the skills harder to follow and reference.

## Dependencies
None

## Changes
- Renumber `tasks/SKILL.md` steps to clean sequential integers
- Renumber `batch/SKILL.md` steps to clean sequential integers

## Capabilities

### Modified
- `tasks/SKILL.md` step numbering follows consistent sequential pattern
- `batch/SKILL.md` step numbering follows consistent sequential pattern

## Out of Scope
- Changing step content or behavior
- Renumbering steps in other skills

## Success Criteria
- `tasks/SKILL.md` uses sequential integer steps with no "2b" style numbering
- `batch/SKILL.md` uses sequential integer steps with no fractional numbering
- All step cross-references within each file are updated to match
