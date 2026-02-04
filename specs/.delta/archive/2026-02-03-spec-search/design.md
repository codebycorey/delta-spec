# Design: spec-search

## Context

The current `/ds:spec` command (defined in `commands/ds/spec.md` and `skills/spec/SKILL.md`) has two modes:
1. No args: List all spec files in `specs/` (excluding `.delta/`)
2. With domain: Read and display that specific spec file

The skill is implemented as markdown instructions that Claude follows. There is no compiled code - the behavior is defined declaratively in the SKILL.md file.

Spec files follow a consistent format with:
- `## Requirements` section containing `### Requirement: <Name>` headers
- Requirements use RFC 2119 keywords (SHALL, MUST, SHOULD, MAY)
- Scenarios under each requirement with GIVEN/WHEN/THEN

## Approach

Add a third mode to `/ds:spec` that detects when the argument is a search term rather than a domain name:

1. **Detection heuristic**: If the argument matches an existing spec file name (minus `.md`), treat it as a domain. Otherwise, treat it as a search term.
2. **Search behavior**: Scan all `specs/*.md` files for the search term, looking in:
   - Requirement names (`### Requirement: <Name>`)
   - Requirement body text
   - Scenario names and content
3. **Output format**: Show matches grouped by spec file with requirement name and matching context.

## Decisions

### Detection: File Match vs Search
**Choice:** Check if `specs/<arg>.md` exists; if yes, treat as domain view; if no, treat as search
**Why:** Simple, predictable behavior - users can always force search by using terms that don't match file names
**Trade-offs:** If user wants to search for a term that happens to match a spec filename, they'd need to quote it or add context

### Search Scope: Main Specs Only
**Choice:** Only search `specs/*.md`, not `specs/.delta/` or archives
**Why:** Per proposal, searching deltas/archives is out of scope; main specs are the source of truth
**Trade-offs:** Users can't find requirements in work-in-progress changes

### Match Display: Requirement-Level Grouping
**Choice:** Show results as "spec-file → requirement name → matching excerpt"
**Why:** Requirements are the atomic unit; showing file and requirement helps users navigate
**Trade-offs:** Multiple matches within one requirement are collapsed

## Files Affected
- `commands/ds/spec.md` - Update argument-hint and description to mention search
- `skills/spec/SKILL.md` - Add search mode behavior and output format

## Risks
- Search on large spec repositories could show many results; no pagination planned
- Case sensitivity could surprise users (will use case-insensitive matching)
