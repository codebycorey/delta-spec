---
name: delta-spec
description: Spec-driven development with delta-based specifications. Manage requirements using ADDED/MODIFIED/REMOVED deltas that merge into main specs.
triggers:
  - /ds:spec
  - /ds:new-change
  - /ds:merge
  - /ds:status
---

# Delta-Spec Workflow

You are helping manage specifications using the delta-spec system. This system uses delta-based changes (ADDED/MODIFIED/REMOVED) that merge into main specs.

## Directory Structure

```
.specs/
├── <domain>.md              # Main specs (source of truth)
└── changes/
    └── <change-name>/
        ├── proposal.md      # What we're building and why
        └── delta-<domain>.md # Changes to specs (delta format)
```

## Commands

### `/ds:spec` - View or discuss specs
- List available specs: `ls .specs/*.md`
- Read a spec to understand current behavior
- Answer questions about what the system does

### `/ds:new-change <name>` - Start a new change
1. Create `.specs/changes/<name>/` directory
2. Create `proposal.md` with this template:

```markdown
# <Change Name>

## Problem
What problem are we solving? Why does this matter?

## Solution
High-level approach to solving the problem.

## Scope
- What's included
- What's explicitly NOT included

## Success Criteria
How do we know when this is done?
```

3. Ask the user what specs this change will affect
4. Create `delta-<domain>.md` files for each affected spec using the delta format below
5. Use Claude Code's TaskCreate to create implementation tasks

### `/ds:merge` - Merge delta specs into main specs
1. List all delta files in the current change
2. For each delta file:
   - Read the corresponding main spec
   - Parse the delta operations (ADDED/MODIFIED/REMOVED/RENAMED)
   - Apply changes to the main spec content
   - Write the updated main spec
3. Confirm with user before writing
4. After successful merge, the change folder can be deleted (Git history preserves it)

### `/ds:status` - Show current change status
1. List active changes in `.specs/changes/`
2. For each change, show:
   - Proposal summary (first few lines)
   - Delta files present
   - Whether implementation tasks exist

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
- AND <additional outcome>

#### Scenario: <Another Scenario>
...

### Requirement: <Another Requirement>
...
```

### Spec Writing Guidelines
- Use RFC 2119 keywords: SHALL/MUST (required), SHOULD (recommended), MAY (optional)
- Each requirement should be testable
- Scenarios use Given/When/Then format (Gherkin-style)
- Keep requirements atomic - one behavior per requirement
- Name requirements clearly - they're referenced in deltas

## Delta Format

Delta specs describe what's CHANGING, not the full spec:

```markdown
# Delta: <Domain>

Changes to <domain> specification for <change-name>.

## ADDED Requirements

### Requirement: <New Requirement Name>
The system SHALL <new behavior>.

#### Scenario: <Scenario Name>
- GIVEN <precondition>
- WHEN <action>
- THEN <outcome>

## MODIFIED Requirements

### Requirement: <Existing Requirement Name>
The system SHALL <updated behavior>.
(This completely replaces the existing requirement with the same name)

#### Scenario: <Updated Scenario>
- GIVEN <new precondition>
- WHEN <new action>
- THEN <new outcome>

## REMOVED Requirements

### Requirement: <Requirement To Remove>
(Just the header - indicates this requirement should be deleted)

## RENAMED Requirements

- FROM: `### Requirement: Old Name`
- TO: `### Requirement: New Name`
```

### Delta Rules
- ADDED: New requirement - fails if name already exists
- MODIFIED: Full replacement of existing requirement - fails if name doesn't exist
- REMOVED: Delete requirement - fails if name doesn't exist
- RENAMED: Change requirement name, then apply any MODIFIED for the new name
- Order of operations: RENAMED → REMOVED → MODIFIED → ADDED

## Merge Algorithm

When merging delta specs:

1. Parse main spec into sections, extract each `### Requirement: X` as a block
2. Parse delta spec into operations by section header
3. Apply in order:
   - RENAMED: Update requirement name in the block
   - REMOVED: Delete the block from main spec
   - MODIFIED: Replace entire block content
   - ADDED: Append new block to Requirements section
4. Reconstruct the spec preserving original requirement order (new ones at end)
5. Write to main spec file

## Integration with Claude Code Tasks

When creating implementation tasks, use Claude Code's native task system:

- Use `TaskCreate` to create tasks from the proposal/specs
- Set task descriptions to reference specific requirements
- Mark tasks `in_progress` when starting work
- Mark tasks `completed` when done and verified

Do NOT create a tasks.md file - the native task system is better.

## Example Workflow

User: `/ds:new-change user-authentication`

1. Create `.specs/changes/user-authentication/proposal.md`
2. Discuss requirements with user
3. Create `.specs/changes/user-authentication/delta-auth.md` with ADDED requirements
4. Create implementation tasks using TaskCreate
5. Implement, marking tasks complete as you go
6. Run `/ds:merge` to apply delta to `.specs/auth.md`
7. Delete or keep the change folder (Git has the history)
8. Commit: "feat(auth): add user authentication - closes #123"
