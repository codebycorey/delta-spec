---
name: delta-spec
description: Spec-driven development with delta-based specifications. Manage requirements through proposal → plan → tasks workflow.
triggers:
  - /ds:init
  - /ds:new
  - /ds:plan
  - /ds:tasks
  - /ds:spec
  - /ds:archive
  - /ds:status
---

# Delta-Spec Workflow

You are helping manage specifications using the delta-spec system. Changes flow through: **proposal → plan → tasks**. Delta specs (ADDED/MODIFIED/REMOVED) merge into main specs when complete.

## Directory Structure

```
specs/                        # Source of truth (visible, important)
├── auth.md                   # Main specs by domain
├── payments.md
├── api.md
└── .delta/                   # Work in progress (hidden)
    ├── active/
    │   └── <change-name>/
    │       ├── proposal.md   # Why: problem and scope
    │       ├── design.md     # How: technical approach
    │       └── specs/
    │           └── <domain>.md  # Delta specs
    └── archive/
        └── YYYY-MM-DD-<name>/   # Completed changes preserved
```

## Commands

### `/ds:init` - Initialize delta-spec in a repository

**Step 1: Create directory structure**
- Create `specs/` directory
- Create `specs/.delta/active/` directory
- Create `specs/.delta/archive/` directory

**Step 2: Ask about existing code**
Use AskUserQuestion to ask:
> "Would you like me to explore the codebase and generate initial specs based on existing code?"
>
> Options:
> - **Yes, generate specs** - I'll analyze the codebase and create spec files for each domain I discover
> - **No, start fresh** - Just create the empty folder structure

**If user chooses "generate specs":**

**Step 3: Explore the codebase**
- Identify major domains/bounded contexts (auth, payments, api, etc.)
- Find key behaviors, business rules, and requirements
- Look at existing tests for behavioral expectations
- Examine API routes, models, services for structure

**Step 4: Generate specs per domain**
For each domain discovered:
- Create `specs/<domain>.md` with frontmatter indicating it was generated:
  ```yaml
  ---
  generated: true
  generated_at: YYYY-MM-DD
  ---
  ```
- Document existing behavior as requirements
- Use the standard spec format with Requirements and Scenarios
- User can remove frontmatter after reviewing/refining the spec

**Step 5: Summary**
- List all spec files created
- Note any areas that need manual review
- Suggest running `/ds:status` to see the result

**If user chooses "start fresh":**
- Just confirm the directories were created
- Suggest running `/ds:new <name>` to start their first change

**Idempotency:**
- If `specs/` already exists, skip creation and note it
- If specs already exist, ask before overwriting
- Safe to run multiple times

### `/ds:new <name>` - Start a new change

1. Create `specs/.delta/active/<name>/` directory
2. Create `proposal.md` from the template below
3. Work with the user to flesh out the proposal interactively

**Proposal Template:**
```markdown
# Proposal: <name>

## Problem
[What problem are we solving? Why does this matter?]

## Dependencies
[Other changes that must be completed first, or "None"]
- `<change-name>` - [why this is needed first]

## Changes
- [Specific change 1]
- [Specific change 2]

## Capabilities

### New
- [New capability → becomes new spec or requirements]

### Modified
- [Existing spec that needs changes]

## Out of Scope
- [What we're explicitly NOT doing]

## Success Criteria
- [How do we know this is complete?]
```

If the change already exists, reopen the proposal for editing/refinement.

### `/ds:plan [name]` - Create design and delta specs

**Step 1: Determine which change**
- If `name` provided → use `specs/.delta/active/<name>/`
- If inferable from conversation (e.g., user just ran `/ds:new add-oauth`) → use it
- If only one change in `active/` → use it
- If multiple and not inferable → use AskUserQuestion to let user pick
- If none → tell user to run `/ds:new` first

**Step 2: Build context**
- Read `proposal.md` to understand problem/scope
- Read `design.md` if it exists (for refinement)
- Read existing delta specs if any

**Step 2b: Check dependencies**
- Parse Dependencies section from proposal
- For each dependency, check if it exists in `archive/` (satisfied) or `active/` (not satisfied)
- If unsatisfied dependencies:
  - Warn user: "This change depends on `<name>` which hasn't been archived yet."
  - Ask if they want to proceed anyway or work on the dependency first
- If all satisfied or user chooses to proceed → continue

**Step 3: Explore the codebase**
- Find relevant existing code and patterns
- Identify frameworks and conventions in use
- Determine which files will likely need changes
- Understand the current architecture

**Step 4: Update proposal if needed**
During exploration, if you discover:
- The scope needs adjustment
- Something should be added to "Out of Scope"
- New capabilities are needed
- The problem statement needs refinement

→ Update `proposal.md` and note the changes to the user.

**Step 5: Create/update design.md**

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

**Step 6: Create delta specs**
- Determine which spec domains are affected
- Create delta specs in `specs/<domain>.md`
- Use the delta format (ADDED/MODIFIED/REMOVED sections)
- If main spec doesn't exist yet, note it will be created

### `/ds:tasks [name]` - Create implementation tasks

**Step 1: Determine which change**
- If `name` provided → use it
- If inferable from conversation → use it
- If only one change in `active/` → use it
- If multiple and not inferable → ask user
- If none → tell user to run `/ds:new` first

**Step 2: Build context**
- Read proposal, design, and delta specs
- Understand the full scope and approach

**Step 2b: Check dependencies**
- Parse Dependencies from proposal
- If unsatisfied dependencies exist, warn user and ask to proceed or defer

**Step 3: Explore the codebase**
- Identify exact files and functions to modify
- Find where new code should be added
- Understand dependencies and integration points

**Step 4: Create tasks using TaskCreate**
- Create specific, actionable tasks
- Reference actual file paths from exploration
- Reference requirements being implemented
- Order tasks by dependency (what needs to happen first)

Example tasks:
- "Add GoogleStrategy to src/auth/strategies/google.ts"
- "Update src/auth/passport.ts to register OAuth strategies"
- "Add OAuth callback routes to src/routes/auth.ts"

Do NOT create a tasks.md file - use Claude Code's native TaskCreate.

### `/ds:spec [domain]` - View or discuss specs

- No args: List all specs in `specs/` (excluding `.delta/`)
- With domain: Read and discuss that spec
- Answer questions about current system behavior

### `/ds:archive [name]` - Complete and archive a change

**Step 1: Determine which change**
- If `name` provided → use it
- If inferable from conversation → use it
- If only one change in `active/` → use it
- If multiple and not inferable → ask user
- If none → nothing to archive

**Step 2: Check dependencies**
- Parse Dependencies from proposal
- If unsatisfied dependencies exist:
  - Warn: "This change depends on `<name>` which should be archived first."
  - Ask to proceed anyway or archive dependency first
- Archiving out of order may result in specs that reference requirements that don't exist yet

**Step 3: Merge delta specs**
For each delta spec in `specs/.delta/active/<name>/specs/`:
- Read the corresponding main spec in `specs/` (or create if new)
- Apply delta operations in order: RENAMED → REMOVED → MODIFIED → ADDED
- Show the diff and confirm before writing

**Step 4: Archive**
- Move entire folder to `specs/.delta/archive/YYYY-MM-DD-<name>/`
- Summarize what was merged

### `/ds:status` - Show active changes

1. List changes in `specs/.delta/active/`
2. For each, read the proposal and show:
   - Which artifacts exist (proposal? design? specs?)
   - Brief summary from proposal
   - Dependencies status:
     - Check if dependencies are still in `active/` (blocked) or `archive/` (satisfied)
     - Show: `✓ ready` or `⏳ blocked by: <change-name>`
   - Next step (plan? tasks? ready to archive?)

Example output:
```
Active changes:

add-user-model
  Status: design + specs complete
  Summary: Add user schema for authentication
  Dependencies: None
  ✓ Ready to archive

add-oauth
  Status: proposal only
  Summary: Add social login with Google/GitHub
  Dependencies: add-user-model (active)
  ⏳ Blocked - run /ds:plan after add-user-model is archived
```

## Spec Format

Main specs use this format:

```markdown
# <Domain> Specification

## Purpose
Brief description of what this domain covers.

## Requirements

### Requirement: <Name>
The system [SHALL|MUST|SHOULD|MAY] <behavior description>.

#### Scenario: <Scenario Name>
- GIVEN <precondition>
- WHEN <action>
- THEN <expected outcome>

### Requirement: <Another Name>
...
```

### Spec Writing Guidelines
- Use RFC 2119 keywords: SHALL/MUST (required), SHOULD (recommended), MAY (optional)
- Each requirement should be testable
- Scenarios use Given/When/Then format
- Keep requirements atomic - one behavior per requirement
- Name requirements clearly - they're referenced in deltas

## Delta Format

Delta specs describe what's CHANGING, not the full spec:

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

### Delta Rules
- ADDED: New requirement - fails if name exists
- MODIFIED: Full replacement - fails if name doesn't exist
- REMOVED: Delete - fails if name doesn't exist
- RENAMED: Change name only, apply MODIFIED separately if needed
- Order: RENAMED → REMOVED → MODIFIED → ADDED

## Merge Algorithm

1. Parse main spec into requirement blocks (`### Requirement: X` through next requirement or EOF)
2. Parse delta into operations by section
3. Apply in order:
   - RENAMED: Update requirement name
   - REMOVED: Delete the block
   - MODIFIED: Replace entire block
   - ADDED: Append to end of Requirements section
4. Write updated main spec

## Example Workflow

```
User: /ds:new add-oauth

Claude: Creates specs/.delta/active/add-oauth/proposal.md
        "What problem does OAuth solve for your users?"

User: Users hate creating passwords, we need social login

Claude: Fills in proposal with problem, changes, capabilities
        "Proposal ready. Here's what I captured: [summary]"

User: /ds:plan

Claude: Reads proposal
        Explores codebase - finds Passport.js, existing auth patterns
        Updates proposal: "Added 'token refresh' to scope based on your session setup"
        Creates design.md with approach fitting existing code
        Creates specs/.delta/active/add-oauth/specs/auth.md with:
        - ADDED: OAuth provider requirements
        - MODIFIED: Session handling updates
        "Plan complete. Design and specs created."

User: /ds:tasks

Claude: Reads all artifacts
        Explores codebase for exact file locations
        Uses TaskCreate:
        - "Add GoogleStrategy to src/auth/strategies/google.ts"
        - "Update src/auth/passport.ts to register OAuth strategies"
        - "Add OAuth routes to src/routes/auth.ts"
        - "Update src/config/auth.ts with OAuth credentials config"

User: [implements tasks]

User: /ds:archive

Claude: Shows diff of auth.md changes
        User confirms
        Merges delta into specs/auth.md
        Moves folder to specs/.delta/archive/2026-02-02-add-oauth/
        "Archived. OAuth requirements merged into auth.md"
```
