---
description: Adopt an existing plan from conversation context into delta-spec format. Use when importing a plan, adopting planning that already happened, capturing plan mode output, or bringing in prior design work.
argument-hint: "[name]"
---

# /ds:adopt [name] - Adopt an existing plan

Import planning that already happened in conversation (plan mode, discussion) into delta-spec's tracking format, skipping codebase exploration.

**Arguments:** If `$ARGUMENTS` is provided, use it as a name hint for a single change. Otherwise, extract all changes from the conversation context.

## Step 0: Version Check

See [version-check.md](../_shared/version-check.md) for the standard version compatibility check procedure.

## Step 1: Parse arguments

- If `name` provided → extract only the named change from context
- If no name → extract all changes identified in the conversation context

## Step 2: Extract changes from conversation context

Read the prior conversation to identify planned changes. For each change, extract:

1. **Name** — generate kebab-case name from the plan (e.g., "user authentication" → `user-auth`)
2. **Problem** — what problem the change solves
3. **Approach** — technical decisions, architecture, and implementation strategy from the plan
4. **Files affected** — specific files mentioned in the planning
5. **Delta specs** — new or modified requirements identified in the plan
6. **Dependencies** — relationships between changes, using the same signal patterns as `/ds:batch`

### What to look for in context

- Plan mode output (structured plans with steps, decisions, file lists)
- Discussion of features, architecture, or implementation approach
- Explicit mentions of what to build, change, or add
- Dependency language ("X needs Y first", "after Z is done")

### Key principle

Do NOT re-explore the codebase. The conversation context already contains the exploration results. Extract and structure what exists — do not re-derive it.

## Step 3: Detect cycles

If multiple changes are extracted with dependencies, check for circular dependencies.

See [cycle-detection.md](../_shared/cycle-detection.md) for the cycle detection algorithm. Follow the **Full resolution** flow.

## Step 4: Display extracted changes

Show a summary of each extracted change:

```
Extracted N change(s) from conversation:

1. change-name
   Problem: [brief problem statement]
   Approach: [brief approach summary]
   Files: [list of affected files]
   Dependencies: [list or "None"]

2. another-change
   Problem: ...
   ...
```

For single changes, show the same format with just one entry.

Then ask for confirmation:

> **Create these changes? [y/N]**

- On "y" → continue to Step 5
- On "n" or empty → stop without creating any files. Tell the user they can refine their plan and try again.

## Step 5: Check for conflicts

For each extracted change name, check if `specs/.delta/<name>/` already exists:

- If conflict found, warn and ask for each:
  - **Skip** — don't create this change
  - **Overwrite** — replace the existing change
  - **Rename** — ask for a new name

## Step 6: Create artifacts

For each change in dependency order (dependencies first):

### 6a: Create directory

Create `specs/.delta/<name>/` and `specs/.delta/<name>/specs/`

### 6b: Create proposal.md

Use the standard template from [proposal-template.md](../_shared/proposal-template.md). Fill in sections from the extracted context:

- **Problem** — from the plan's problem statement
- **Dependencies** — from inferred dependencies
- **Changes** — specific changes identified in the plan
- **Capabilities** — new and modified capabilities
- **Out of Scope** — boundaries identified in the plan (or reasonable defaults)
- **Success Criteria** — completion criteria from the plan

### 6c: Create design.md

Write the design document directly from the conversation context:

```markdown
# Design: <name>

## Context
[What the plan identified about the current state — existing code, patterns, constraints]

## Approach
[Technical approach from the plan — architecture, implementation strategy]

## Decisions
[Key decisions made during planning, with Choice/Why/Trade-offs]

## Files Affected
[Specific files from the plan]

## Risks
[Risks or concerns identified during planning]
```

### 6d: Create delta specs

Create `specs/.delta/<name>/specs/<domain>.md` files using the delta format. See [delta-format.md](../_shared/delta-format.md).

Determine affected spec domains from the plan context and create one delta file per domain with ADDED, MODIFIED, or REMOVED requirements as appropriate.

## Step 7: Output summary

Show what was created:

```
✓ Created N change(s):

  change-name/
    ✓ proposal.md
    ✓ design.md
    ✓ specs/domain.md

  another-change/
    ✓ proposal.md
    ✓ design.md
    ✓ specs/domain.md

Next step: Run /ds:tasks to generate implementation tasks.
```

## Edge Cases

### Thin context

If the conversation context lacks detail for a complete design or delta specs:
- Write what is available
- Add `[TODO: needs detail]` markers in sparse sections
- Note to the user which changes may need `/ds:plan` to fill gaps

### Single change with name argument

If `name` is provided but multiple changes exist in context:
- Extract only the change matching the name
- Ignore other changes in context

### No plan found in context

If the conversation has no identifiable planning:
- Tell the user: "No plan found in conversation context. Use `/ds:new` to start a new change, or `/ds:batch` to plan multiple features."
