# Delta: Skills

Changes for plugin-structure-update.

Note: This delta renames `specs/commands.md` to `specs/skills.md` and updates all skill references.

## RENAMED File

- FROM: `specs/commands.md`
- TO: `specs/skills.md`

## MODIFIED Requirements

### Requirement: Initialize Repository
The system SHALL provide a `/ds-init` skill that creates the specs directory structure.

(Replaces `/ds:init` command reference)

### Requirement: Start New Change
The system SHALL provide a `/ds-new <name>` skill that creates a proposal for a new change.

(Replaces `/ds:new` command reference)

### Requirement: Plan Change
The system SHALL provide a `/ds-plan [name]` skill that creates design documents and delta specs.

(Replaces `/ds:plan` command reference)

### Requirement: Generate Tasks
The system SHALL provide a `/ds-tasks [name]` skill that creates implementation tasks, supporting both single-change and multi-change modes.

(Replaces `/ds:tasks` command reference)

### Requirement: Archive Change
The system SHALL provide a `/ds-archive [name]` skill that safely merges delta specs and archives the change.

(Replaces `/ds:archive` command reference)

### Requirement: Drop Change
The system SHALL provide a `/ds-drop [name]` skill that abandons a change.

(Replaces `/ds:drop` command reference)

### Requirement: Show Status
The system SHALL provide a `/ds-status` skill that shows all active changes with conflicts, progress, and dependency visualization.

(Replaces `/ds:status` command reference)

### Requirement: View Specifications
The system SHALL provide a `/ds-spec [domain|search]` skill to view, discuss, or search specs.

(Replaces `/ds:spec` command reference)

### Requirement: Change Inference
The system SHALL infer the current change when name is omitted from skills.

(Replaces "command" terminology with "skill")

## MODIFIED Scenarios

All scenarios referencing `/ds:*` commands are updated to use `/ds-*` skill format. The behavior remains identical - only the invocation syntax changes.

Example changes:
- "WHEN the user runs `/ds:init`" → "WHEN the user runs `/ds-init`"
- "WHEN the user runs `/ds:new add-feature`" → "WHEN the user runs `/ds-new add-feature`"
- "tell the user to run `/ds:new` first" → "tell the user to run `/ds-new` first"
