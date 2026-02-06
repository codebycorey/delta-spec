# Delta: Skills

Changes for normalize-step-numbering.

## MODIFIED Requirements

### Requirement: Start New Change
The system SHALL provide a `/ds:new <name>` skill that creates a proposal for a new change, with cycle detection and resolution, with argument hints and placeholder usage.

#### Scenario: Consistent step headings in new
- GIVEN the new skill uses mixed heading styles
- WHEN the skill SKILL.md is defined
- THEN all major steps use `## Step N: <title>` heading format
- AND numbered list items are converted to step headings

### Requirement: Archive Change
The system SHALL provide a `/ds:archive [name]` skill that safely merges delta specs and archives the change, with cycle detection, with protection against auto-invocation, argument hints, and placeholder usage.

#### Scenario: Sequential step numbering in archive
- GIVEN the archive skill uses non-sequential step numbers (2.1, 2.5, 2.6)
- WHEN the skill SKILL.md is defined
- THEN all steps are numbered sequentially (1, 2, 3, 4, 5, 6, 7)
- AND no sub-step numbering like 2.1 or 2.5 is used at the top level

### Requirement: Show Status
The system SHALL provide a `/ds:status` skill that shows all active changes with conflicts, progress from task files, dependency visualization, and cycle warnings, with tool restrictions for read-only access.

#### Scenario: Consistent step headings in status
- GIVEN the status skill uses mixed heading styles
- WHEN the skill SKILL.md is defined
- THEN all major steps use `## Step N: <title>` heading format
- AND numbered list items under `## Steps` are converted to step headings or content under step headings

### Requirement: Quick Start Change
The system SHALL provide a `/ds:quick [name] ["description"]` skill that creates a complete change setup (proposal, design, and tasks) with minimal interaction, with argument hints and placeholder usage.

#### Scenario: Imperative writing style in quick
- GIVEN the quick skill uses second-person writing ("you know what you want", "make sure it captures your intent")
- WHEN the skill SKILL.md is defined
- THEN all content uses imperative or third-person form
- AND no second-person pronouns ("you", "your") appear in the skill body

### Requirement: Initialize Repository
The system SHALL provide a `/ds:init` skill that creates the specs directory structure with protection against auto-invocation.

#### Scenario: Non-duplicate opening line in init
- GIVEN the init skill opening line duplicates the description verbatim
- WHEN the skill SKILL.md is defined
- THEN the opening line adds value beyond the description
- AND does not repeat the description text
