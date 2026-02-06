---
description: Create multiple proposals from free-form feature descriptions. Use when planning several features at once, batch creating proposals, or setting up related changes.
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

If no overlaps are detected, skip this step entirely and proceed to Step 3.

See [references/consolidation.md](references/consolidation.md) for the full overlap detection and merging algorithm.

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

See [cycle-detection.md](../_shared/cycle-detection.md) for the cycle detection algorithm. Follow the **Full resolution** flow.

After resolution, continue to Step 4 with the resolved graph.

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

## Examples

See [examples/batch-session.md](examples/batch-session.md) for full example sessions showing basic workflow and consolidation scenarios.
