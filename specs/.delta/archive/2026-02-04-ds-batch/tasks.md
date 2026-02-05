# Tasks: ds-batch

Generated: 2026-02-04

---

## Task 1: Create skill directory and SKILL.md
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-batch/SKILL.md
- **Refs:** [Batch Feature Planning]

Create `skills/ds-batch/` directory and `SKILL.md` file with:
- Frontmatter: `name: ds-batch`, `description: Create multiple proposals from free-form feature descriptions`
- Step 0: Version check (standard pattern)
- Step 1: Prompt for features
- Step 2: Parse and extract features
- Step 3: Infer dependencies
- Step 4: Display dependency graph
- Step 5: Confirm and create proposals
- Step 6: Offer batch planning

Include the proposal template and dependency inference keywords.

## Task 2: Document dependency inference rules
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-batch/SKILL.md
- **Refs:** [Batch Feature Planning - Parse free-form input, Confident dependency inference]

Add a section documenting the dependency inference rules:
- Keyword patterns: "needs X", "requires X", "uses X", "builds on X", "after X", "depends on X"
- How to match feature names (fuzzy matching on kebab-case names)
- When to ask for clarification (ambiguous references, multiple possible matches)

## Task 3: Document graph display format
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-batch/SKILL.md
- **Refs:** [Batch Feature Planning - Show dependency graph, Graph format]

Add examples of the ASCII dependency graph format:
- Linear chains: `auth → permissions → admin-dashboard`
- Parallel roots: Multiple independent features shown as separate starting points
- Mixed: Some independent, some dependent

## Task 4: Document edge cases
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-batch/SKILL.md
- **Refs:** [Batch Feature Planning - Empty input, Single feature input, Existing change conflict]

Add behavior sections for edge cases:
- Empty input: Ask again or exit gracefully
- Single feature: Suggest `/ds-new` or `/ds-quick`, offer to proceed
- Name conflicts: Warn and ask to skip, overwrite, or rename
- Circular dependencies: Warn and ask user to clarify

## Task 5: Update README.md skills table
- **Status:** done
- **Owner:** claude
- **Files:** README.md
- **Refs:** [README Synchronization]

Add `/ds-batch` to the skills table in README.md with description:
"Create multiple proposals from free-form feature descriptions"
