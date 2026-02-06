# Tasks: extract-batch-references

Generated: 2026-02-06

---

## Task 16: Create batch/references/consolidation.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/batch/references/consolidation.md
- **Refs:** [Consolidate overlapping features in batch]

Create `skills/batch/references/consolidation.md` by extracting lines 55-183 from `batch/SKILL.md`. Include all of:

- Overlap Detection Signals (file/directory overlap, keyword overlap, sequential phrasing, domain synonym detection)
- Grouping Threshold (conservative rules for when to suggest/not suggest merging)
- Display Consolidation Suggestions format
- Consolidation Prompt (y/N/c options, per-group prompts)
- Merging Features (name, description, dependencies combining rules)
- Edge Cases (no overlaps, all overlap into one group, single-item groups, user rejects all)

## Task 17: Create batch/examples/batch-session.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/batch/examples/batch-session.md
- **Refs:** [Batch Feature Planning]

Create `skills/batch/examples/batch-session.md` by extracting lines 437-543 from `batch/SKILL.md`. Include both example sessions:

1. Basic workflow example (jwt-auth, permissions, webhooks, admin-panel)
2. Consolidation detected example (argument-hint-support + disable-invocation-flags merge)

## Task 18: Update batch/SKILL.md with references
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/batch/SKILL.md
- **Refs:** [Batch Feature Planning], [Consolidate overlapping features in batch]

Replace inline content with summaries and references:

1. **Step 2.5**: Keep the heading and the first 3 lines of context ("Before inferring dependencies, analyze parsed features..."). Replace the detailed subsections with: `See [references/consolidation.md](references/consolidation.md) for the full overlap detection and merging algorithm.` Add a brief note: "If no overlaps are detected, skip to Step 3."

2. **Example sections**: Replace the two inline example sessions (lines 437-543) with: `## Examples\n\nSee [examples/batch-session.md](examples/batch-session.md) for full example sessions showing basic workflow and consolidation scenarios.`

3. Keep the "## Edge Cases" section at the bottom (lines 403-435) since it's brief and part of the core workflow reference.
