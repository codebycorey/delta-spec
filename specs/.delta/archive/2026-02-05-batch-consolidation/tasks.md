# Tasks: batch-consolidation

## Task 1: Add Step 2.5 section header and algorithm overview [done]

**File:** `/Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md`

**Location:** After Step 2, before Step 3

**Changes:**
- Add new section heading "## Step 2.5: Consolidate overlapping features (if detected)"
- Add introductory paragraph explaining purpose: "Before inferring dependencies, analyze parsed features for potential overlaps. If multiple features appear to describe similar or related functionality, suggest consolidating them to avoid duplicate work during planning and implementation."
- Add note: "If no overlaps are detected, this step is skipped entirely and the workflow proceeds directly to Step 3."

**Dependencies:** None

**Estimated effort:** 5 minutes

---

## Task 2: Add overlap detection signals section [done]

**File:** `/Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md`

**Location:** Within Step 2.5, after introductory paragraph

**Changes:**
- Add subsection "### Overlap Detection Signals"
- Document four signal types:

  1. **File/directory overlap**:
     - Features mention the same file paths or directories
     - Normalize paths: strip `./` prefix, trailing `/`
     - Examples: `auth.ts`, `./auth.ts`, `src/auth/` all indicate auth domain
     - Signal strength: exact match = strong, same directory = medium

  2. **Keyword overlap**:
     - Features share domain-specific terms
     - Filter stop words ("the", "a", "and", etc.)
     - Focus on nouns and technical terms
     - Signal strength: 3+ shared terms = strong, 2 shared terms = medium

  3. **Sequential phrasing**:
     - Detect transition words: "then", "after that", "next", "also", "additionally", "with"
     - Example: "Add JWT auth. Then add role-based permissions."
     - Signal strength: sequential marker + 1 other signal = suggest merge

  4. **Domain synonym detection**:
     - Common domain synonyms:
       - auth/authentication/login/signin
       - dashboard/panel/UI/interface
       - rate-limiting/throttling/quota
       - API/endpoint/service
     - Signal strength: synonym match = medium

**Dependencies:** Task 1

**Estimated effort:** 15 minutes

---

## Task 3: Add consolidation threshold and grouping logic [done]

**File:** `/Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md`

**Location:** Within Step 2.5, after overlap detection signals

**Changes:**
- Add subsection "### Grouping Threshold (Conservative)"
- Document when to suggest merging:
  - 2+ strong signals (e.g., file overlap + keyword overlap)
  - 1 strong + 2 medium signals
  - Sequential phrasing + 1 other signal
- Document when NOT to suggest:
  - Only 1 weak signal
  - Features have different domains (e.g., "auth" vs "payments")
  - Features mention different files with no overlap
- Add note: "Use conservative threshold to minimize false positives. Users can manually recognize obvious duplicates, but unmerging incorrectly grouped features requires dropping and recreating proposals."

**Dependencies:** Task 2

**Estimated effort:** 10 minutes

---

## Task 4: Add consolidation suggestions display format [done]

**File:** `/Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md`

**Location:** Within Step 2.5, after grouping threshold

**Changes:**
- Add subsection "### Display Consolidation Suggestions"
- Add format example:

```
Parsed 5 features, found potential overlap:

Group 1: user-auth + jwt-login
  Signals: both mention "authentication", "auth.ts", "JWT"
  Suggestion: Merge into "user-auth"?

Group 2: admin-dashboard + management-ui
  Signals: both mention "admin", "UI", "dashboard"
  Suggestion: Merge into "admin-dashboard"?

Remaining: api-rate-limiting (no overlaps)
```

- Document format rules:
  - Show each suggested group with feature names
  - List specific signals detected (not just "overlap found")
  - Show example evidence from descriptions
  - Suggest using first feature's name as base
  - List remaining features with no overlaps at the end

**Dependencies:** Task 3

**Estimated effort:** 10 minutes

---

## Task 5: Add consolidation prompt format and options [done]

**File:** `/Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md`

**Location:** Within Step 2.5, after display format

**Changes:**
- Add subsection "### Consolidation Prompt"
- Add prompt format:

```
Accept suggested groupings? [y/N/c]
```

- Document options:
  - **y**: Apply all suggested consolidations
  - **N** (default): Keep all features separate, proceed with original list
  - **c**: Choose per-group (custom)

- Add per-group prompt format (when user selects "c"):

```
Group 1 (user-auth + jwt-login): Merge? [y/N]
Group 2 (admin-dashboard + management-ui): Merge? [y/N]
```

- Document behavior:
  - On "y" to individual group: merge those features
  - On "N" or empty: keep those features separate
  - After all groups processed: proceed to Step 3 with consolidated list

**Dependencies:** Task 4

**Estimated effort:** 10 minutes

---

## Task 6: Add merge behavior description [done]

**File:** `/Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md`

**Location:** Within Step 2.5, after consolidation prompt

**Changes:**
- Add subsection "### Merging Features"
- Document merge behavior:
  - **Name**: Use first feature's name as base (user can rename in proposal later)
  - **Description**: Combine descriptions intelligently:
    - Remove redundant phrases
    - Preserve unique details from both features
    - Example: "User authentication with JWT" + "JWT login system" → "User authentication with JWT login system"
  - **Dependencies**: Preserve all unique dependencies from both features
  - **Result**: Single consolidated feature that proceeds to Step 3

**Dependencies:** Task 5

**Estimated effort:** 10 minutes

---

## Task 7: Add edge cases section for Step 2.5 [done]

**File:** `/Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md`

**Location:** Within Step 2.5, after merge behavior

**Changes:**
- Add subsection "### Edge Cases"
- Document edge cases:

  1. **No overlaps detected**:
     - Step 2.5 is skipped entirely
     - Workflow proceeds directly from Step 2 to Step 3
     - No user prompt shown

  2. **All features overlap into one group**:
     - Show single group suggestion
     - User can accept (creates 1 feature) or reject (keeps all separate)

  3. **Only single-item groups**:
     - If all groups contain only 1 feature after filtering, treat as "no overlaps"
     - Skip Step 2.5

  4. **User rejects all consolidations**:
     - Proceed to Step 3 with original parsed list
     - No error, workflow continues normally

**Dependencies:** Task 6

**Estimated effort:** 10 minutes

---

## Task 8: Update Step 3 header to note it receives consolidated list [done]

**File:** `/Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md`

**Location:** Step 3 section header

**Changes:**
- Update "## Step 3: Infer dependencies" section
- Add note after heading: "This step receives the feature list from Step 2 (or the consolidated list from Step 2.5 if overlaps were detected and confirmed)."
- No other changes to Step 3 content

**Dependencies:** Task 7

**Estimated effort:** 5 minutes

---

## Task 9: Update Edge Cases section to reference consolidation [done]

**File:** `/Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md`

**Location:** "## Edge Cases" section (near end of file)

**Changes:**
- Add new subsection under "## Edge Cases" titled "### No Overlaps Detected"
- Content: "If Step 2 parsing completes and no overlap signals are detected between features, Step 2.5 is skipped entirely. The workflow proceeds directly from Step 2 to Step 3 with the original parsed feature list."
- This supplements the edge cases already documented in Step 2.5

**Dependencies:** Task 8

**Estimated effort:** 5 minutes

---

## Task 10: Add consolidation example to example session [done]

**File:** `/Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md`

**Location:** "## Example Session" section (at end of file)

**Changes:**
- Add new example session showing consolidation in action
- Insert before or after existing example
- Example session:

```
### Example: Consolidation Detected

User: /ds-batch

Claude: Describe the features you want to plan:

User: Add argument-hint support to all skills. Also add
disable-model-invocation flags to skills. And update the
skills README with new frontmatter fields.

Claude: Parsed 3 features, found potential overlap:

Group 1: argument-hint-support + disable-invocation-flags
  Signals: both mention "skills", "frontmatter", "SKILL.md"
  Suggestion: Merge into "argument-hint-support"?

Remaining: skills-readme-update (no overlaps)

Accept suggested groupings? [y/N/c]

User: c

Claude: Group 1 (argument-hint-support + disable-invocation-flags): Merge? [y/N]

User: y

Claude: Consolidated to 2 features:

  skill-frontmatter-fields (independent)

  skills-readme-update (independent)

Features:
  1. skill-frontmatter-fields - Add argument-hint and disable-model-invocation support to all skills
  2. skills-readme-update - Update skills README with new frontmatter fields

Create these proposals? [y/N]

User: y

Claude:
Created specs/.delta/skill-frontmatter-fields/proposal.md
Created specs/.delta/skills-readme-update/proposal.md

Created 2 proposals. Run /ds-plan for all? [y/N]
```

**Dependencies:** Task 9

**Estimated effort:** 15 minutes

---

## Task 11: Add note about consolidation before cycle detection [done]

**File:** `/Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md`

**Location:** Step 3.5 (Detect and resolve cycles) section header

**Changes:**
- Add note at beginning of Step 3.5: "Note: Consolidation (Step 2.5) happens before this step. Merging overlapping features may eliminate some cycles (e.g., if A and B depend on each other but are actually the same feature)."

**Dependencies:** Task 10

**Estimated effort:** 5 minutes

---

## Summary

Total tasks: 11
Estimated total effort: 100 minutes (~1.5 hours)

These tasks will add the consolidation step to the `/ds-batch` skill workflow, enabling automatic detection and user-confirmed merging of overlapping features before dependency inference.
