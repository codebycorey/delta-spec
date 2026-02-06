# Design: normalize-step-numbering

## Context

Step numbering and writing style are inconsistent across skills:

### Step Numbering Issues

1. **new/SKILL.md**: Mixed — numbered list under `## Steps` (1-3), then `## Step 4: Check for cycles` as a separate top-level heading
2. **archive/SKILL.md**: Non-sequential — `## Step 2`, `### Step 2.1`, `## Step 2.5`, `## Step 2.6`, `## Step 3`, `## Step 4` (sub-steps inserted post-hoc)
3. **status/SKILL.md**: Mixed — numbered list under `## Steps` (1-2), then `## Step 3`, `## Step 4`, `## Step 5` as top-level headings
4. **plan/SKILL.md**, **tasks/SKILL.md**, **quick/SKILL.md**, **batch/SKILL.md**: Consistent — use `## Step N:` top-level headings throughout (good)

### Writing Style Issues

5. **quick/SKILL.md** (lines 109, 111): Second person — "where you know what you want", "make sure it captures your intent"
6. **init/SKILL.md** (line 8): Opening line "Initialize delta-spec in a repository." duplicates the description verbatim

## Approach

### Convention: All steps as top-level `## Step N:` headings

This matches the majority pattern (plan, tasks, quick, batch already use it). Sub-steps use `### Step N.M:` or `###` sub-headings within a step.

Apply to new, archive, and status:
- **new**: Convert numbered list items 1-3 to `## Step 1`-`## Step 3` headings, keep `## Step 4`
- **archive**: Renumber: Step 2 → Step 2, Step 2.1 → Step 3, Step 2.5 → Step 4, Step 2.6 → Step 5, Step 3 → Step 6, Step 4 → Step 7
- **status**: Convert numbered list items 1-2 to content under `## Step 1` and `## Step 2`, keep Steps 3-5

### Writing style fixes
- **quick**: Change to imperative/third-person
- **init**: Replace duplicate opening line with value-adding content

## Decisions

### Top-level `## Step N:` convention
**Choice:** Standardize on `## Step N: <title>` for all major steps
**Why:** Already used by 4 of 10 skills; provides clear visual hierarchy and makes each step independently scannable
**Trade-offs:** Archive skill changes from 4 to 7 top-level steps, but each step is clearer

### Renumber archive sequentially
**Choice:** Renumber archive from 2/2.1/2.5/2.6/3/4 to sequential 2/3/4/5/6/7
**Why:** Non-sequential numbers (2.5, 2.6) suggest ad-hoc insertions and create cognitive load
**Trade-offs:** Diff will be larger since most headings change, but the result is cleaner

## Files Affected
- `skills/new/SKILL.md` - Normalize step headings (convert numbered list to ## Step headings)
- `skills/archive/SKILL.md` - Renumber steps sequentially
- `skills/status/SKILL.md` - Normalize step headings
- `skills/quick/SKILL.md` - Fix second-person writing in Behavior Notes
- `skills/init/SKILL.md` - Replace duplicate opening line

## Risks
- These changes should be done AFTER the extraction changes (cycle-detection, spec-format, determine-change, batch-references) to avoid merge conflicts, since extraction will remove some of the content being renumbered
- Step references within the skill (e.g., "see Step 2.5") need to be updated when renumbering
