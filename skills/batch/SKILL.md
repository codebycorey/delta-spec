---
description: Create multiple proposals from free-form feature descriptions with automatic dependency inference.
---

# /ds:batch - Batch create proposals

Create multiple proposals from a single free-form description of features.

## Step 0: Version Check

See [version-check.md](../_shared/version-check.md) for the standard version compatibility check procedure.

## Step 1: Prompt for features

Ask the user to describe the features they want to plan:

> **Describe the features you want to plan:**

Accept free-form prose, numbered lists, or bullet points. Examples:

```
I need user authentication with JWT tokens. Then a permissions
system that builds on auth for role-based access. Also want an
audit log that tracks all API calls - that one is independent.
Finally an admin dashboard that needs permissions.
```

Or:

```
1. User authentication with JWT
2. Role-based permissions (requires auth)
3. Audit logging (independent)
4. Admin dashboard (requires permissions)
```

## Step 2: Parse and extract features

Extract individual features from the input:

1. Split on sentence boundaries, list markers (1., 2., -, •), or logical breaks
2. For each feature, extract:
   - **Description**: The core description of what the feature does
   - **Name**: Generate kebab-case name from key terms (e.g., "user authentication" → `user-auth`)
3. Look for dependency signals in each description

### Name Generation

Generate concise kebab-case names:
- "user authentication with JWT" → `user-auth`
- "role-based permissions system" → `role-permissions`
- "audit logging for API calls" → `audit-logging`
- "admin dashboard" → `admin-dashboard`

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

## Step 3: Infer dependencies

This step receives the feature list from Step 2 (or the consolidated list from Step 2.5 if overlaps were detected and confirmed).

Scan each feature description for dependency keywords:

### Dependency Keywords

| Pattern | Example | Meaning |
|---------|---------|---------|
| `needs X` | "needs auth" | Depends on feature matching "auth" |
| `requires X` | "requires authentication" | Depends on feature matching "authentication" |
| `uses X` | "uses the permissions system" | Depends on feature matching "permissions" |
| `builds on X` | "builds on auth" | Depends on feature matching "auth" |
| `after X` | "after auth is done" | Depends on feature matching "auth" |
| `depends on X` | "depends on user model" | Depends on feature matching "user model" |
| `(requires X)` | "(requires auth)" | Parenthetical dependency hint |

### Matching Feature Names

When a dependency keyword is found:
1. Extract the referenced term (e.g., "auth" from "needs auth")
2. Fuzzy match against other feature names in the batch
3. Match if the term appears in the feature name or description

### Confidence Levels

**High confidence** (proceed automatically):
- Exact name match: "needs user-auth" matches feature named `user-auth`
- Clear substring: "needs auth" matches `user-auth`
- Single possible match in the batch

**Low confidence** (ask for clarification):
- Multiple possible matches: "needs users" could match `user-auth` or `user-profile`
- No matches found but dependency keyword present
- Ambiguous reference

If uncertain, ask:

> Feature "admin-dashboard" mentions "needs permissions". Did you mean:
> 1. `role-permissions` - Role-based permissions system
> 2. Something not in this batch (will be added to Dependencies as external)
> 3. No dependency intended

## Step 3.5: Detect and resolve cycles

Note: Consolidation (Step 2.5) happens before this step. Merging overlapping features may eliminate some cycles (e.g., if A and B depend on each other but are actually the same feature).

After inferring dependencies, check for circular dependencies before displaying the graph.

### Cycle Detection Algorithm

Use depth-first search with path tracking:

```
for each feature:
  if feature creates a cycle when following dependencies:
    return the cycle path (e.g., [auth, permissions, admin, auth])
```

A cycle exists when following dependencies leads back to a feature already in the current path.

### If Cycle Detected

1. **Analyze descriptions** - Collect descriptions from all features in the cycle
2. **Find common concepts** - Tokenize descriptions, find terms appearing in multiple (excluding stop words)
3. **Suggest extraction** - Generate a base change name from the most common term:
   - "user" appears in auth, permissions, admin → suggest `user-model`
   - "auth" appears frequently → suggest `auth-base`
   - If no clear winner, ask user to name it

4. **Show resolution prompt**:

```
⚠️  Cycle detected: auth → permissions → admin → auth

Analysis: "user" appears in all descriptions
Suggested: Extract "user-model" as base change

This will:
  - Create new proposal: user-model
  - Update dependencies: auth, permissions, admin → depend on user-model
  - Remove artifacts from: permissions (has design.md, tasks.md)

Extract "user-model" as base change? [y/N]
```

### On Confirm ("y")

1. Create `specs/.delta/<base-name>/proposal.md` with:
   - Problem: extracted from common concept across descriptions
   - Dependencies: None
   - Changes: the shared functionality

2. Update each proposal in the cycle:
   - Change dependencies to point to the new base change
   - Remove the dependency that was causing the cycle

3. Delete invalidated artifacts:
   - Remove `design.md` from affected changes (if exists)
   - Remove `tasks.md` from affected changes (if exists)

4. Run `/ds:plan` for all affected changes in dependency order:
   - Plan the new base change first
   - Then plan each updated change

5. Continue to Step 4 with the resolved graph

### On Decline ("n" or empty)

Ask user to manually break the cycle:

> Which dependency should be removed to break the cycle?
> 1. auth → permissions (remove permissions' dependency on auth)
> 2. permissions → admin (remove admin's dependency on permissions)
> 3. admin → auth (remove auth's dependency on admin)

After user selects, update the dependency and continue to Step 4.

## Step 4: Display dependency graph

Show the parsed features and their dependencies:

```
Parsed 4 features:

  user-auth ──→ role-permissions ──→ admin-dashboard
  │
  audit-logging (independent)

Features:
  1. user-auth - User authentication with JWT tokens
  2. role-permissions - Role-based permissions system
     └─ depends on: user-auth
  3. audit-logging - Audit log for API calls
  4. admin-dashboard - Admin dashboard
     └─ depends on: role-permissions
```

### Graph Notation

- `A ──→ B` means B depends on A (A must be done first)
- `(independent)` marks features with no dependencies
- Multiple roots shown on separate lines
- Linear chains shown with arrows

### Complex Example

```
  feature-a ──┬──→ feature-c ──→ feature-e
              │
  feature-b ──┘

  feature-d (independent)
```

This shows: feature-c depends on both a and b, feature-e depends on c, feature-d is independent.

## Step 5: Confirm and create proposals

After showing the graph, ask for confirmation:

> **Create these proposals? [y/N]**

On "y":
1. Create `specs/.delta/<name>/` directory for each feature
2. Create `proposal.md` using the standard template
3. Fill in sections from the parsed description
4. Create in dependency order (dependencies first)

### Proposal Template

```markdown
# Proposal: <name>

## Problem
<Generated from the feature description - what problem does this solve?>

## Dependencies
<List of dependencies, or "None">
- `<dep-name>` - <brief reason>

## Changes
- <Inferred changes based on description>

## Capabilities

### New
- <Inferred new capabilities>

### Modified
- <If applicable, otherwise omit>

## Out of Scope
- <Reasonable boundaries based on description>

## Success Criteria
- <Derived from problem/changes>
```

On "n" or empty input:
- Stop and tell user they can refine their description and try again

## Step 6: Offer batch planning

After all proposals are created, ask:

> **Created N proposals. Run `/ds:plan` for all? [y/N]**

On "y":
1. Run the planning phase for each feature in dependency order
2. Show progress: "Planning 1/4: user-auth..."
3. For each, explore codebase and create design.md + delta specs
4. After all complete, show summary

On "n" or empty:
- Stop and tell user they can run `/ds:plan <name>` individually

## Edge Cases

### Empty Input

If the user provides empty or whitespace-only input:
- Ask again: "Please describe at least one feature, or type 'cancel' to exit."

### Single Feature

If only one feature is detected:
- Suggest: "Only one feature detected. Consider using `/ds:quick` or `/ds:new` instead."
- Offer: "Proceed with batch anyway? [y/N]"

### Name Conflicts

If a generated name matches an existing change in `specs/.delta/`:
- Warn: "Feature 'user-auth' conflicts with existing change."
- Ask: "Skip / Overwrite / Rename?"
  - **Skip**: Don't create this proposal
  - **Overwrite**: Replace the existing proposal
  - **Rename**: Ask for a new name

### No Overlaps Detected

If Step 2 parsing completes and no overlap signals are detected between features, Step 2.5 is skipped entirely. The workflow proceeds directly from Step 2 to Step 3 with the original parsed feature list.

### Circular Dependencies

Handled in Step 3.5. The system will:
- Detect the cycle and analyze descriptions for common concepts
- Suggest extracting a base change to break the cycle
- On confirm: create base proposal, update dependencies, clean artifacts, re-plan
- On decline: ask user which dependency to remove manually

## Example Session

```
User: /ds:batch

Claude: Describe the features you want to plan:

User: I need JWT authentication for users, then a permissions
layer that uses auth to control access. Also want webhooks
for external integrations - that's separate. And finally
an admin panel that needs permissions to manage users.

Claude: Parsed 4 features:

  jwt-auth ──→ permissions ──→ admin-panel

  webhooks (independent)

Features:
  1. jwt-auth - JWT authentication for users
  2. permissions - Permissions layer for access control
     └─ depends on: jwt-auth
  3. webhooks - Webhooks for external integrations
  4. admin-panel - Admin panel for user management
     └─ depends on: permissions

Create these proposals? [y/N]

User: y

Claude:
Created specs/.delta/jwt-auth/proposal.md
Created specs/.delta/permissions/proposal.md
Created specs/.delta/webhooks/proposal.md
Created specs/.delta/admin-panel/proposal.md

Created 4 proposals. Run /ds:plan for all? [y/N]

User: y

Claude:
Planning 1/4: jwt-auth...
  ✓ Created design.md
  ✓ Created specs/auth.md

Planning 2/4: permissions...
  ✓ Created design.md
  ✓ Created specs/auth.md (delta)

Planning 3/4: webhooks...
  ✓ Created design.md
  ✓ Created specs/integrations.md

Planning 4/4: admin-panel...
  ✓ Created design.md
  ✓ Created specs/admin.md

Done! 4 changes planned. Run /ds:tasks to generate implementation tasks.
```

### Example: Consolidation Detected

```
User: /ds:batch

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

Created 2 proposals. Run /ds:plan for all? [y/N]
```
