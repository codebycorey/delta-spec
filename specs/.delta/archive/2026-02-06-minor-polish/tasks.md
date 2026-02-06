# Tasks: minor-polish

Generated: 2026-02-06

---

## Task 1: Fix consolidation.md heading
- **Status:** done
- **Owner:** assistant
- **Files:** skills/batch/references/consolidation.md

Replace `## Step 2.5: Consolidate overlapping features (if detected)` with `# Overlap Consolidation Algorithm` — reference documents should use standalone headings.

## Task 2: Add heading to version-check.md
- **Status:** done
- **Owner:** assistant
- **Files:** skills/_shared/version-check.md

Add `# Version Check` as the first line, followed by a blank line before the existing content. Matches the heading style of other shared files.

## Task 3: Add quick note to determine-change.md
- **Status:** done
- **Owner:** assistant
- **Files:** skills/_shared/determine-change.md

Add to the context-specific notes section:
`- **quick**: Creates new changes; does not use this resolution procedure.`

## Task 4: Replace AskUserQuestion reference in init/SKILL.md
- **Status:** done
- **Owner:** assistant
- **Files:** skills/init/SKILL.md

Change line 39 from `Use AskUserQuestion to ask:` to `Ask the user:`

## Task 5: Consolidate Delta Rules into Merge Algorithm in archive/SKILL.md
- **Status:** done
- **Owner:** assistant
- **Files:** skills/archive/SKILL.md

Merge the "## Delta Rules" section into the "## Merge Algorithm" section as validation notes. Remove the separate heading.

## Task 6: Remove Behavior section from new/SKILL.md
- **Status:** done
- **Owner:** assistant
- **Files:** skills/new/SKILL.md

Remove the entire `## Behavior` section — all bullets duplicate content from Steps 1-4.

## Task 7: Consolidate "no prompts" notes in quick/SKILL.md
- **Status:** done
- **Owner:** assistant
- **Files:** skills/quick/SKILL.md

Remove duplicate "Do not ask for confirmation" lines from Steps 5 and 6. Add single note after Step 4.

## Task 8: Replace Circular Dependencies edge case in batch/SKILL.md
- **Status:** done
- **Owner:** assistant
- **Files:** skills/batch/SKILL.md

Replace the Circular Dependencies subsection with a one-line cross-reference to Step 3.5.
