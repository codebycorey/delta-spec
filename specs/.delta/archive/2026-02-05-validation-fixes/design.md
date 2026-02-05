# Design: validation-fixes

## Context

The `scripts/validate-specs.sh` script implements validation for spec files. It currently:
- Uses `set -e` for strict error handling
- Validates main specs for Purpose/Requirements sections, RFC 2119 keywords, and scenario presence
- Validates delta specs for operation sections and empty sections
- Tracks errors and warnings with counter variables using `((counter++))` syntax
- Exits with code 1 if errors > 0, otherwise code 0

**The Bug**: The `((warnings++))` and `((errors++))` expressions cause premature exit under `set -e`. When incrementing from 0, the expression evaluates to 0 (falsy), which bash interprets as exit code 1, triggering `set -e` to abort the script.

**Missing Validations**: The script does not currently validate:
1. Duplicate requirement names within a spec (caught only during archive merge)
2. Orphaned delta specs that reference non-existent main specs
3. Proposal format (required sections: Problem, Dependencies, Changes, Capabilities, Out of Scope, Success Criteria)
4. Design format (required sections: Context, Approach, Decisions, Files Affected, Risks)

These validation gaps cause failures later in the workflow at archive time, when they should be caught during validation.

## Approach

### Fix the Counter Bug
Replace all `((counter++))` with `counter=$((counter + 1))` which:
- Explicitly assigns the incremented value
- Never returns a falsy exit code
- Works correctly under `set -e`

Alternative approaches rejected:
- `((counter++)) || true` - clutters code with || true everywhere
- `: $((counter++))` - less readable, obscure idiom
- Removing `set -e` - loses strict error handling

### Add Duplicate Requirement Validation
In `validate_spec()`:
- Extract all requirement names using `grep "^### Requirement:" | sed 's/^### Requirement: //'`
- Use `sort | uniq -d` to find duplicates
- Error if duplicates exist

### Add Orphaned Delta Spec Validation
In `validate_delta()`:
- Extract the base spec name from delta file path (e.g., `specs/.delta/change/specs/validation.md` → `validation.md`)
- Check if corresponding main spec exists at `specs/{basename}`
- Error if main spec does not exist

### Add Proposal Format Validation
New function `validate_proposal()`:
- Check for required sections: `## Problem`, `## Dependencies`, `## Changes`, `## Capabilities`, `## Out of Scope`, `## Success Criteria`
- Error if any required section is missing
- Called for each `proposal.md` in `.delta/*/`

### Add Design Format Validation
New function `validate_design()`:
- Check for required sections: `## Context`, `## Approach`, `## Decisions`, `## Files Affected`, `## Risks`
- Error if any required section is missing
- Called for each `design.md` in `.delta/*/`

### Script Flow Updates
Main script loop structure:
1. Validate main specs (existing)
2. NEW: Validate proposals in `.delta/*/proposal.md`
3. NEW: Validate designs in `.delta/*/design.md`
4. Validate delta specs in `.delta/*/specs/*.md` (existing, enhanced with orphan check)

## Decisions

### Decision: Use Explicit Assignment for Counters
**Choice:** `counter=$((counter + 1))`
**Why:** Clear, readable, and guaranteed to work under `set -e`. The expression always succeeds.
**Trade-offs:** Slightly more verbose than `((counter++))`, but eliminates an entire class of bugs.

### Decision: Error on Duplicates, Not Warn
**Choice:** Duplicate requirement names are errors, not warnings
**Why:** Duplicates cause merge failures during archive, so they should block validation
**Trade-offs:** More strict, but prevents downstream failures

### Decision: Error on Orphaned Delta Specs
**Choice:** Delta specs without matching main specs are errors
**Why:** Orphaned deltas indicate incorrect file paths or deleted main specs, will fail during merge
**Trade-offs:** Could be a warning, but errors prevent confusion and failed archives

### Decision: Error on Missing Proposal/Design Sections
**Choice:** Missing required sections are errors
**Why:** These documents drive the workflow; incomplete structure indicates the change isn't ready for implementation
**Trade-offs:** Could warn instead, but enforcing structure improves consistency

### Decision: Validate Proposals and Designs Separately
**Choice:** Separate `validate_proposal()` and `validate_design()` functions
**Why:** Different required sections, different validation logic, clearer function responsibilities
**Trade-offs:** More code, but better separation of concerns

## Files Affected

- `scripts/validate-specs.sh` - Fix counter bug, add four new validations (duplicate requirements, orphaned deltas, proposal format, design format)

## Risks

- **Strictness**: New validations may flag existing valid changes that don't follow the format. Mitigation: Run validator before merging to identify any existing issues.
- **Performance**: Additional grep/sed operations for duplicate detection may slow validation on large specs. Mitigation: Current specs are small, acceptable trade-off for correctness.
- **False Positives**: Orphan check assumes `specs/{basename}` naming convention. Mitigation: This matches current workflow spec conventions.
