# Design: extract-batch-references

## Context

The batch skill (`skills/batch/SKILL.md`) is ~544 lines / ~2,500 words, approaching the 3,000-word guideline limit. Two sections account for the bulk:

1. **Step 2.5: Consolidation logic** (lines 55-183, ~130 lines) — Detailed algorithmic content for overlap detection, grouping thresholds, display format, prompt handling, merge logic, and edge cases
2. **Example sessions** (lines 437-543, ~107 lines) — Two full example sessions: basic workflow and consolidation detected

The core workflow (Steps 0-6 minus consolidation detail and examples) would be ~1,300 words — well within guidelines.

The plugin already uses `_shared/` for cross-skill references. For skill-specific reference material, the progressive disclosure pattern suggests `references/` and `examples/` subdirectories within the skill directory.

## Approach

Extract two files from `batch/SKILL.md`:

1. **`skills/batch/references/consolidation.md`** — Full Step 2.5 content (overlap detection signals, grouping threshold, display format, consolidation prompt, merging features, edge cases)
2. **`skills/batch/examples/batch-session.md`** — Both example sessions

Replace inline content with:
- Step 2.5: Brief 3-4 line summary + reference link
- Examples: Reference link at the bottom

## Decisions

### Skill-local directories, not _shared
**Choice:** Use `batch/references/` and `batch/examples/` rather than `_shared/`
**Why:** Consolidation logic and batch examples are specific to the batch skill, not shared across skills. The `_shared/` directory is for cross-skill content.
**Trade-offs:** More directories, but cleaner separation of concerns

### Keep Step 2.5 header and summary inline
**Choice:** Keep the step header and a brief summary in SKILL.md, move only the detail
**Why:** The main SKILL.md should read as a complete workflow without requiring readers to open references for basic understanding
**Trade-offs:** Slight duplication of the summary, but provides essential context in the main file

## Files Affected
- `skills/batch/references/consolidation.md` - New: full consolidation algorithm
- `skills/batch/examples/batch-session.md` - New: example sessions
- `skills/batch/SKILL.md` - Replace inline consolidation + examples with summaries and references

## Risks
- The consolidation logic is tightly integrated with the step flow — the summary must be clear enough that the skill executor knows to read the reference before proceeding
- Example sessions serve as implicit documentation of expected behavior; moving them to a separate file reduces their visibility
