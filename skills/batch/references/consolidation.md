## Step 2.5: Consolidate overlapping features (if detected)

Before inferring dependencies, analyze parsed features for potential overlaps. If multiple features appear to describe similar or related functionality, suggest consolidating them to avoid duplicate work during planning and implementation.

If no overlaps are detected, this step is skipped entirely and the workflow proceeds directly to Step 3.

### Overlap Detection Signals

Analyze each pair of parsed features for the following signals:

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

### Grouping Threshold (Conservative)

**When to suggest merging:**
- 2+ strong signals (e.g., file overlap + keyword overlap)
- 1 strong + 2 medium signals
- Sequential phrasing + 1 other signal

**When NOT to suggest:**
- Only 1 weak signal
- Features have different domains (e.g., "auth" vs "payments")
- Features mention different files with no overlap

Use conservative threshold to minimize false positives. Users can manually recognize obvious duplicates, but unmerging incorrectly grouped features requires dropping and recreating proposals.

### Display Consolidation Suggestions

When overlaps are detected, display them in this format:

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

Format rules:
- Show each suggested group with feature names
- List specific signals detected (not just "overlap found")
- Show example evidence from descriptions
- Suggest using first feature's name as base
- List remaining features with no overlaps at the end

### Consolidation Prompt

After displaying suggestions, prompt the user:

```
Accept suggested groupings? [y/N/c]
```

Options:
- **y**: Apply all suggested consolidations
- **N** (default): Keep all features separate, proceed with original list
- **c**: Choose per-group (custom)

When user selects "c", show per-group prompts:

```
Group 1 (user-auth + jwt-login): Merge? [y/N]
Group 2 (admin-dashboard + management-ui): Merge? [y/N]
```

Behavior:
- On "y" to individual group: merge those features
- On "N" or empty: keep those features separate
- After all groups processed: proceed to Step 3 with consolidated list

### Merging Features

When features are merged, combine them as follows:

- **Name**: Use first feature's name as base (user can rename in proposal later)
- **Description**: Combine descriptions intelligently:
  - Remove redundant phrases
  - Preserve unique details from both features
  - Example: "User authentication with JWT" + "JWT login system" → "User authentication with JWT login system"
- **Dependencies**: Preserve all unique dependencies from both features
- **Result**: Single consolidated feature that proceeds to Step 3

### Edge Cases

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
