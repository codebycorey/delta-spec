# Proposal: batch-consolidation

## Problem
`/ds-batch` parses input features 1:1 into proposals with no consolidation step. If a user feeds it a raw list of 18 improvements, it creates 18 separate proposals rather than recognizing that related items (e.g., "add argument-hint to skills" and "add disable-model-invocation to skills") should be grouped. Users must pre-group their input manually, which defeats the purpose of a "dump your ideas and let batch organize them" workflow.

Discovered through dogfooding: when applying IMPROVEMENTS.md (18 items) via `/ds-batch`, the grouping had to be done entirely in conversation before invoking the skill.

## Dependencies
None

## Changes
- Add a **Step 2.5: Consolidation** to the ds-batch SKILL.md between parsing and dependency inference
- After parsing individual features, analyze for overlap signals:
  - Features touching the same files or directories
  - Features in the same domain (e.g., multiple SKILL.md changes)
  - Features that are sequential steps of a single logical change
  - Features with similar keywords in their descriptions
- Display suggested groupings and let the user confirm, split, or re-merge
- Proceed to dependency inference with the consolidated feature list

## Capabilities

### New
- Automatic overlap detection between parsed features
- Suggested groupings with rationale (e.g., "These 3 features all modify SKILL.md files")
- Interactive confirmation: user can accept groups, split them, or merge differently
- Consolidation summary showing original count vs grouped count

### Modified
- `/ds-batch` workflow gains a consolidation step between parsing and dependency inference
- Batch becomes viable for raw, unstructured input (brain dumps)

## Out of Scope
- Automatic grouping without user confirmation (always interactive)
- Changing how dependency inference works
- Modifying other skills
- Grouping across separate `/ds-batch` invocations

## Success Criteria
- Feeding 18 raw improvements from IMPROVEMENTS.md produces ~5-6 suggested groups, not 18 proposals
- User can accept, reject, or modify each suggested group
- Groups have clear rationale displayed (e.g., "all touch skills/*.md")
- Single-item groups are left as-is (no unnecessary consolidation)
- Consolidated features carry forward into dependency inference correctly
