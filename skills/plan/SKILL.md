---
description: Create design and delta specs. Explores codebase for implementation approach that fits existing patterns.
argument-hint: "[name]"
---

# /ds:plan [name] - Create design and delta specs

Create a design document and delta specs based on the proposal and codebase exploration.

**Arguments:** If `$ARGUMENTS` is provided, use it as the `name` parameter. Otherwise, follow the determination logic below.

## Step 0: Version Check

See [version-check.md](../_shared/version-check.md) for the standard version compatibility check procedure.

## Step 1: Determine which change

- If `name` provided → use `specs/.delta/<name>/`
- If inferable from conversation (e.g., user just ran `/ds:new add-oauth`) → use it
- If only one change in `specs/.delta/` → use it
- If multiple and not inferable → use AskUserQuestion to let user pick
- If none → tell user to run `/ds:new` first

## Step 2: Build context

- Read `proposal.md` to understand problem/scope
- Read `design.md` if it exists (for refinement)
- Read existing delta specs if any

## Step 2b: Note dependencies (informational)

- Parse Dependencies section from proposal
- For each dependency, check if it exists in `archive/` (satisfied) or `specs/.delta/` (not satisfied)
- If unsatisfied dependencies exist:
  - Note to user: "Dependencies: `<name>` (not yet archived)"
  - **Proceed without asking** - planning is safe and doesn't require dependencies
- Planning can always proceed; dependencies are enforced at `/ds:tasks` and `/ds:archive`

## Step 3: Explore the codebase

- Find relevant existing code and patterns
- Identify frameworks and conventions in use
- Determine which files will likely need changes
- Understand the current architecture

## Step 4: Update proposal if needed

During exploration, if you discover:
- The scope needs adjustment
- Something should be added to "Out of Scope"
- New capabilities are needed
- The problem statement needs refinement

→ Update `proposal.md` and note the changes to the user.

## Step 5: Create/update design.md

```markdown
# Design: <name>

## Context
[What exists today? Relevant code, patterns, constraints discovered from codebase exploration]

## Approach
[Technical approach that fits the existing codebase]

## Decisions

### [Decision Name]
**Choice:** [What we're doing]
**Why:** [Rationale - why this over alternatives?]
**Trade-offs:** [What we're giving up]

## Files Affected
- `path/to/file.ts` - [what changes]
- `path/to/other.ts` - [what changes]

## Risks
- [Known limitations or concerns]
```

## Step 6: Create delta specs

- Determine which spec domains are affected
- Create delta specs in `specs/.delta/<name>/specs/<domain>.md`
- Use the delta format (ADDED/MODIFIED/REMOVED sections)
- If main spec doesn't exist yet, note it will be created

## Delta Format

```markdown
# Delta: <Domain>

Changes for <change-name>.

## ADDED Requirements

### Requirement: <New Requirement>
The system SHALL <new behavior>.

#### Scenario: <Name>
- GIVEN <precondition>
- WHEN <action>
- THEN <outcome>

## MODIFIED Requirements

### Requirement: <Existing Requirement>
The system SHALL <updated behavior>.
(Completely replaces the requirement with this name)

## REMOVED Requirements

### Requirement: <Requirement To Remove>
**Reason:** [Why this is being removed]
**Migration:** [What replaces it, if anything]

## RENAMED Requirements

- FROM: `Old Name`
- TO: `New Name`
```
