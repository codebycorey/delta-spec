# Design: minor-polish

## Context

After the major refactoring (6 changes for shared extractions, descriptions, normalization), several minor polish items remain. All are small, low-risk text edits.

Current state of affected files:
- `batch/references/consolidation.md` — heading is `## Step 2.5:` (step-numbered, should be standalone)
- `_shared/version-check.md` — no heading (all other shared files have headings)
- `_shared/determine-change.md` — missing `quick` in context notes
- `init/SKILL.md` line 39 — says `Use AskUserQuestion to ask:` (tool-specific reference)
- `archive/SKILL.md` lines 79-96 — "Merge Algorithm" and "Delta Rules" partially duplicate Step 6
- `new/SKILL.md` lines 65-70 — "Behavior" section duplicates Steps 3 and 4
- `quick/SKILL.md` lines 81, 92 — both say "Do not ask for confirmation during this step."
- `batch/SKILL.md` lines 240-246 — "Circular Dependencies" edge case re-summarizes Step 3.5

## Approach

Direct text edits — each fix is a simple replacement or removal. No structural changes.

## Decisions

### Consolidate archive's Delta Rules into Merge Algorithm
**Choice:** Merge the "Delta Rules" section into the "Merge Algorithm" section as bullet notes
**Why:** Both describe the same operation order and validation rules
**Trade-offs:** Slightly longer Merge Algorithm section, but eliminates duplication

### Remove new's Behavior section entirely
**Choice:** Remove the section since all 4 bullets duplicate content from steps
**Why:** "Work interactively" = Step 3, "check for cycles" = Step 4, "reopen" = already implicit, "ask clarifying questions" = part of Step 3
**Trade-offs:** Loses the quick-reference, but the steps are clear enough

## Files Affected
- `skills/batch/references/consolidation.md` — fix heading
- `skills/_shared/version-check.md` — add heading
- `skills/_shared/determine-change.md` — add quick note
- `skills/init/SKILL.md` — replace tool reference
- `skills/archive/SKILL.md` — merge Delta Rules into Merge Algorithm
- `skills/new/SKILL.md` — remove Behavior section
- `skills/quick/SKILL.md` — consolidate "no prompts" notes
- `skills/batch/SKILL.md` — replace Circular Dependencies with cross-reference

## Risks
None — all changes are cosmetic text edits
