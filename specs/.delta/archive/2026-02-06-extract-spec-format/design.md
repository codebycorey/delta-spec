# Design: extract-spec-format

## Context

The spec format template appears in multiple skills:

- **init/SKILL.md** (lines 81-100): "Spec Format" section — base spec template with `# Domain`, `## Purpose`, `## Requirements`, `### Requirement:`, `#### Scenario:` structure
- **spec/SKILL.md** (lines 56-84): "Spec Format Reference" — identical base template + "Spec Writing Guidelines" (RFC 2119 keywords, atomic requirements, Given/When/Then)
- **plan/SKILL.md** (lines 89-122): "Delta Format" — this is the *delta* format (`## ADDED Requirements`, `## MODIFIED Requirements`, etc.), which is distinct from the base spec format

On closer inspection, init and spec share the **base spec format**, while plan has a separate **delta format**. Both should be extracted since the delta format is also referenced conceptually by archive and batch.

The existing shared reference pattern uses: `See [file.md](../_shared/file.md)` (from version-check.md).

## Approach

Create two shared files:

1. **`skills/_shared/spec-format.md`** — Base spec format template + writing guidelines
   - Combines the template from init/spec with the writing guidelines from spec
   - Referenced by init (for generation) and spec (for reference display)

2. **`skills/_shared/delta-format.md`** — Delta spec format template
   - Extracted from plan/SKILL.md
   - Referenced by plan (for creation) and potentially archive (for merge understanding)

Each skill replaces its inline format with a reference and brief context note.

## Decisions

### Two files instead of one
**Choice:** Separate `spec-format.md` (base) and `delta-format.md` (delta)
**Why:** Base spec format and delta format serve different purposes and are used by different skills. Combining them would force skills to include irrelevant content.
**Trade-offs:** Two files to maintain instead of one, but each is focused and clear

### Include writing guidelines in spec-format.md
**Choice:** Merge the "Spec Writing Guidelines" from spec/SKILL.md into the shared spec-format.md
**Why:** Writing guidelines are inseparable from the format — you need to know them when writing specs in any context
**Trade-offs:** Slightly larger shared file, but avoids a third shared file for guidelines alone

## Files Affected
- `skills/_shared/spec-format.md` - New: base spec format template + writing guidelines
- `skills/_shared/delta-format.md` - New: delta spec format template
- `skills/init/SKILL.md` - Replace lines 81-100 with reference
- `skills/spec/SKILL.md` - Replace lines 56-84 with reference
- `skills/plan/SKILL.md` - Replace lines 89-122 with reference

## Risks
- The spec format in init is labeled "Spec Format" while in spec it's "Spec Format Reference" — the shared file name needs to work for both contexts
- Plan's delta format section also serves as inline documentation during planning; the reference must be equally accessible
