# Design: extract-shared-templates

## Context
The plugin already has 6 shared files in `skills/_shared/` (version-check, cycle-detection, spec-format, delta-format, determine-change, proposal-template). Three more templates are duplicated across skills but not yet extracted:

1. **Design template** — inlined in `plan/SKILL.md` (lines 54-76), `adopt/SKILL.md` (lines 108-125), and implicitly used by `quick/SKILL.md`
2. **Task format** — fully documented in `tasks/SKILL.md` (lines 82-125), partially in `adopt/SKILL.md` (line 140)
3. **Dependency signals** — defined in `batch/SKILL.md` (lines 69-79), referenced by name in `adopt/SKILL.md` (line 30)

## Approach
Follow the same pattern as existing shared files:
1. Extract content verbatim from the canonical source into new `_shared/*.md` files
2. Replace inline content in each SKILL.md with a markdown link reference
3. Use the same reference style as existing shared files (e.g., `See [design-template.md](../_shared/design-template.md)`)

## Decisions

### Use plan/SKILL.md as canonical source for design template
**Choice:** Extract from plan since it has the most complete version
**Why:** Plan is the primary skill that creates design docs; adopt and quick follow its format
**Trade-offs:** None — the templates are nearly identical

### Use tasks/SKILL.md as canonical source for task format
**Choice:** Extract from tasks since it has the full format with field table
**Why:** Tasks is the primary skill for task generation; adopt only creates tasks secondarily
**Trade-offs:** None

### Use batch/SKILL.md as canonical source for dependency signals
**Choice:** Extract from batch since it has the full keywords table
**Why:** Batch is where dependency inference was first designed; adopt references it by name
**Trade-offs:** None

## Files Affected
- `skills/_shared/design-template.md` - New file
- `skills/_shared/task-format.md` - New file
- `skills/_shared/dependency-signals.md` - New file
- `skills/plan/SKILL.md` - Replace inline design template with reference
- `skills/adopt/SKILL.md` - Replace inline design template, task format description, and dependency signal reference with shared file references
- `skills/quick/SKILL.md` - Add explicit reference to shared design template
- `skills/tasks/SKILL.md` - Replace inline task format with reference
- `skills/batch/SKILL.md` - Replace inline dependency keywords table with reference

## Risks
- Skills that reference the shared files need to provide enough context so the agent understands how to use the template in that skill's specific context
