# Design: fix-readme-inconsistency

## Context
README.md line ~126-128 shows a proposal example with `## Solution` header. The actual proposal template in `_shared/proposal-template.md` uses `## Changes`. This was likely from an earlier version of the template.

## Approach
Update the README example to use `## Changes` and adjust the example content to match the current proposal template style.

## Decisions

### Match the current template exactly
**Choice:** Use `## Changes` with bullet-point list style matching the template
**Why:** The README example should demonstrate the actual format users will encounter
**Trade-offs:** None

## Files Affected
- `README.md` - Update "How It Works" section proposal example (lines ~120-128)

## Risks
- None — purely cosmetic documentation fix
