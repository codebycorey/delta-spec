# Design: fix-step-numbering

## Context
- `tasks/SKILL.md` uses "Step 2b" (line 56) for the dependency check step between Step 2 and Step 3
- `batch/SKILL.md` uses "Step 2.5" (line 55) for consolidation and "Step 3.5" (line 107) for cycle detection

The skills.md spec has scenarios that reference fractional step numbers (e.g., "Step 2.5") which will also need updating.

## Approach
Renumber steps sequentially:

**tasks/SKILL.md:**
- Step 0: Version Check (unchanged)
- Step 1: Determine which change(s) (unchanged)
- Step 2: Build context (unchanged)
- Step 2b: Check dependencies → **Step 3: Check dependencies**
- Step 3: Explore the codebase → **Step 4: Explore the codebase**
- Step 4: Create tasks.md → **Step 5: Create tasks.md**

**batch/SKILL.md:**
- Step 0: Version Check (unchanged)
- Step 1: Prompt for features (unchanged)
- Step 2: Parse and extract features (unchanged)
- Step 2.5: Consolidate → **Step 3: Consolidate overlapping features**
- Step 3: Infer dependencies → **Step 4: Infer dependencies**
- Step 3.5: Detect cycles → **Step 5: Detect and resolve cycles**
- Step 4: Display dependency graph → **Step 6: Display dependency graph**
- Step 5: Confirm and create proposals → **Step 7: Confirm and create proposals**
- Step 6: Offer batch planning → **Step 8: Offer batch planning**

## Decisions

### Renumber rather than use sub-steps
**Choice:** Sequential integers only
**Why:** Consistent with all other skills which use integer steps
**Trade-offs:** Existing cross-references in specs/skills.md use fractional step numbers and will need updating

## Files Affected
- `skills/tasks/SKILL.md` - Renumber steps
- `skills/batch/SKILL.md` - Renumber steps, update internal cross-references

## Risks
- specs/skills.md references fractional step numbers in scenarios — these should be updated but are lower priority since the spec describes intent not exact step numbers
