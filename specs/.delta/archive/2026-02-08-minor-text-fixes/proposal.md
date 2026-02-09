# Proposal: minor-text-fixes

## Problem
Small wording issues across several skills: redundant phrasing ("codebase code"), indirect conditional phrasing, and confusing argument-hint syntax.

## Dependencies
None

## Changes
- `init/SKILL.md` line 8: "existing codebase code" -> "existing codebase"
- `drop/SKILL.md` line 68: "If work should be preserved" -> "To preserve work"
- `quick/SKILL.md` argument-hint: `'[name] ["description"]'` -> `'<name> [description]'`

## Capabilities

### Modified
- Clearer wording across init, drop, and quick skills

## Out of Scope
- Behavior changes
- Description rewrites
- Adding new trigger phrases

## Success Criteria
- All three text fixes applied
- No behavior changes introduced
