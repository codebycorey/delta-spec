# Proposal: minor-polish

## Problem
After the major refactoring (shared extractions, description improvements, step normalization), several minor polish items remain from the plugin review. These are small, low-risk fixes that don't warrant individual changes.

## Dependencies
None

## Changes
- Fix `consolidation.md` heading — replace `## Step 2.5:` with standalone heading since it's a reference document, not a step
- Add heading to `version-check.md` for consistency with other shared files
- Remove `AskUserQuestion` tool reference in init/SKILL.md — use "Ask the user" instead
- Remove minor content redundancies:
  - archive/SKILL.md: consolidate "Delta Rules" section with Step 6 operation order
  - new/SKILL.md: consolidate Behavior section with Steps 3-4
  - quick/SKILL.md: merge duplicate "no prompts" notes from Steps 5 and 6
  - batch/SKILL.md: replace Circular Dependencies edge case summary with cross-reference to Step 3.5
- Add `quick` note to `determine-change.md` context-specific notes

## Capabilities

### Modified
- Cleaner reference documents with standalone headings
- Reduced content redundancy across 4 skills
- More consistent shared file formatting

## Out of Scope
- Further description changes (the "Use when..." format is intentional — not adopting verbose "This skill should be used when the user says..." pattern)
- Adding `version` field to frontmatter (low value for current project size)
- Expanding `.gitignore` (separate concern)
- Removing non-standard `plugin.json` fields (harmless)

## Success Criteria
- All shared files have consistent heading style
- No tool-specific references in skill content
- No redundant content sections in skills
- `determine-change.md` mentions all relevant skills
