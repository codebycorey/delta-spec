# Proposal: extract-batch-references

## Problem
The batch skill (`batch/SKILL.md`) is ~2,500 words, approaching the 3,000-word guideline limit. Step 2.5 (consolidation logic) is ~1,000 words of detailed algorithmic content and the two example sessions are ~120 lines. These inflate the core skill file and bury the main workflow.

## Dependencies
None

## Changes
- Create `skills/batch/references/consolidation.md` with the full Step 2.5 consolidation algorithm
- Create `skills/batch/examples/batch-session.md` with the example sessions
- Update `skills/batch/SKILL.md` to replace inline content with brief summaries and references

## Capabilities

### New
- `batch/references/consolidation.md` — Full overlap detection and merging algorithm
- `batch/examples/batch-session.md` — Example sessions showing basic and consolidation workflows

### Modified
- `batch/SKILL.md` — Replace Step 2.5 detail with summary + reference, move examples to reference

## Out of Scope
- Changing the consolidation algorithm
- Modifying the example content
- Restructuring other steps in the batch skill

## Success Criteria
- `batch/SKILL.md` reduced from ~2,500 to ~1,500 words
- Consolidation logic preserved in full in `references/consolidation.md`
- Example sessions preserved in `examples/batch-session.md`
- Core SKILL.md retains brief summary of consolidation with pointer to reference
