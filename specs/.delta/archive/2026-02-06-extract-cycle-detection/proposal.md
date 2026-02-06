# Proposal: extract-cycle-detection

## Problem
Cycle detection logic is duplicated across 4 skills (new, batch, archive, status) with slightly different wording but the same core algorithm. This creates maintenance burden and inconsistency risk when the logic needs updating.

## Dependencies
None

## Changes
- Create `skills/_shared/cycle-detection.md` with the canonical cycle detection procedure
- Parameterize context-specific behavior (e.g., "offer extraction" in batch vs "allow override" in archive)
- Update `skills/new/SKILL.md` to reference shared file instead of inline logic
- Update `skills/batch/SKILL.md` to reference shared file instead of inline logic
- Update `skills/archive/SKILL.md` to reference shared file instead of inline logic
- Update `skills/status/SKILL.md` to reference shared file instead of inline logic

## Capabilities

### New
- Shared `_shared/cycle-detection.md` with canonical DFS-based cycle detection procedure
- Context parameters for skill-specific behavior on cycle detection

### Modified
- `new/SKILL.md` — Replace inline cycle detection with reference
- `batch/SKILL.md` — Replace inline cycle detection with reference
- `archive/SKILL.md` — Replace inline cycle detection with reference
- `status/SKILL.md` — Replace inline cycle detection with reference

## Out of Scope
- Changing the cycle detection algorithm itself
- Modifying how individual skills respond to detected cycles (just extracting the shared detection logic)

## Success Criteria
- Single source of truth for cycle detection logic in `_shared/cycle-detection.md`
- All 4 skills reference the shared file with brief context-specific notes
- No duplication of the core DFS algorithm across skills
