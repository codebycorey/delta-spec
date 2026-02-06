# Tasks: normalize-step-numbering

Generated: 2026-02-06

---

## Task 20: Normalize step headings in new/SKILL.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/new/SKILL.md
- **Refs:** [Start New Change]

After extraction changes are applied, normalize the step structure:

- Convert `## Steps` section (numbered list items 1-3) into individual `## Step N:` headings:
  - `## Step 1: Create change directory`
  - `## Step 2: Create proposal from template`
  - `## Step 3: Work with user on proposal`
- Keep `## Step 4: Check for cycles` (already correct format)
- Ensure the `## Proposal Template` section sits naturally between the create step and the interactive step

## Task 21: Renumber steps in archive/SKILL.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/archive/SKILL.md
- **Refs:** [Archive Change]

After extraction changes are applied, renumber all steps sequentially:

- `## Step 0: Version Check` → stays
- `## Step 1: Determine which change` → stays
- `## Step 2: Check dependencies` → stays
- `### Step 2.1: Check for cycles` → `## Step 3: Check for cycles`
- `## Step 2.5: Pre-validate References` → `## Step 4: Pre-validate references`
- `## Step 2.6: Check for Conflicts` → `## Step 5: Check for conflicts`
- `## Step 3: Merge delta specs with confirmation` → `## Step 6: Merge delta specs with confirmation`
- `## Step 4: Archive` → `## Step 7: Archive`

Update any internal references to step numbers (e.g., "see Step 2.5" → "see Step 4").

## Task 22: Normalize step headings in status/SKILL.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/status/SKILL.md
- **Refs:** [Show Status]

After extraction changes are applied, normalize the step structure:

- Convert `## Steps` numbered list into proper headings:
  - `## Step 1: List active changes` — list changes in `specs/.delta/` excluding `archive/`
  - `## Step 2: Show change details` — for each, read proposal and show artifacts, summary, dependencies, next step
- Keep `## Step 3: Detect Conflicts`, `## Step 4: Show Progress`, `## Step 5: Show Dependency Graph` (already correct format)

## Task 23: Fix second-person writing in quick/SKILL.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/quick/SKILL.md
- **Refs:** [Quick Start Change]

Update the "## Behavior Notes" section (lines 107-112):

Change from:
```
- This skill is for straightforward changes where you know what you want
- For complex changes requiring discussion, use `/ds:new` → `/ds:plan` → `/ds:tasks`
- The proposal confirmation is the single gate—make sure it captures your intent
- Archive still requires separate confirmation (`/ds:archive`)
```

To imperative/third-person:
```
- Designed for straightforward changes with well-understood scope
- For complex changes requiring discussion, use `/ds:new` → `/ds:plan` → `/ds:tasks`
- The proposal confirmation is the single gate — it must capture the intended scope
- Archive still requires separate confirmation (`/ds:archive`)
```

## Task 24: Fix duplicate opening line in init/SKILL.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/init/SKILL.md
- **Refs:** [Initialize Repository]

Replace line 8 from:
```
Initialize delta-spec in a repository.
```

To something that adds value beyond the description:
```
Set up the specs directory structure and optionally generate initial specifications from existing codebase code.
```
