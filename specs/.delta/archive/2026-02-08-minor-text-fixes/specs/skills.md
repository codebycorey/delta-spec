# Delta: Skills

Changes for minor-text-fixes.

## MODIFIED Requirements

### Requirement: Initialize Repository
The system SHALL provide a `/ds:init` skill that creates the specs directory structure with protection against auto-invocation.

#### Scenario: Non-redundant opening line in init
- GIVEN the init skill opening line contains "codebase code"
- WHEN the skill SKILL.md is defined
- THEN the opening line uses "existing codebase" without redundancy

### Requirement: Drop Change
The system SHALL provide a `/ds:drop [name]` skill that abandons a change with protection against auto-invocation, argument hints, and placeholder usage.

#### Scenario: Direct phrasing for preservation note
- GIVEN the drop skill notes that work can be preserved
- WHEN the skill SKILL.md is defined
- THEN the note uses direct phrasing ("To preserve work, use `/ds:archive` instead")
- AND does not use conditional phrasing ("If work should be preserved")

### Requirement: Quick Start Change
The system SHALL provide a `/ds:quick [name] ["description"]` skill that creates a complete change setup (proposal, design, and tasks) with minimal interaction, with argument hints and placeholder usage.

#### Scenario: Simplified argument hint for quick
- GIVEN ds-quick accepts optional name and description arguments
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "<name> [description]"`
- AND uses angle brackets for the primary argument and square brackets for optional
