# Proposal: fix-readme-inconsistency

## Problem
README.md line ~127 shows `## Solution` in the proposal example, but the actual proposal template in `_shared/proposal-template.md` uses `## Changes`. This confuses users who read the README then encounter a different format.

## Dependencies
None

## Changes
- Update the README "How It Works" section to use `## Changes` instead of `## Solution`

## Capabilities

### Modified
- README.md proposal example matches the actual proposal template

## Out of Scope
- Other README content changes
- Proposal template changes

## Success Criteria
- README proposal example uses `## Changes` header
- Example content reflects the actual proposal template structure
