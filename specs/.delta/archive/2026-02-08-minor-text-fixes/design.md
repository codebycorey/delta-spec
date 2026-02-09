# Design: minor-text-fixes

## Context
Three minor wording issues identified during plugin review:
1. `init/SKILL.md` line 8: "existing codebase code" — redundant
2. `drop/SKILL.md` line 68: "If work should be preserved" — indirect conditional
3. `quick/SKILL.md` frontmatter: `'[name] ["description"]'` — nested quotes/brackets confuse users

## Approach
Apply targeted single-line fixes to each file.

## Decisions

### Simplify argument-hint for quick
**Choice:** Change to `'<name> [description]'`
**Why:** Angle brackets for required args and square brackets for optional args is the established convention in this plugin
**Trade-offs:** The `<name>` changes from optional `[name]` to required `<name>`, which better matches the skill's typical usage

## Files Affected
- `skills/init/SKILL.md` - Line 8 wording fix
- `skills/drop/SKILL.md` - Line 68 wording fix
- `skills/quick/SKILL.md` - Frontmatter argument-hint fix

## Risks
- None — purely cosmetic text changes
