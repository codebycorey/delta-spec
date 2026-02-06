# Delta: Skills

Changes for minor-polish.

## MODIFIED Requirements

### Requirement: Initialize Repository
The system SHALL provide a `/ds:init` skill that creates the specs directory structure with protection against auto-invocation.

#### Scenario: Skill content describes intent not tools
- GIVEN the init skill asks the user a question
- WHEN the skill SKILL.md is defined
- THEN the skill uses intent-based language ("Ask the user")
- AND does not reference specific tool names like `AskUserQuestion`

### Requirement: Archive Change
The system SHALL provide a `/ds:archive [name]` skill that safely merges delta specs and archives the change, with cycle detection, with protection against auto-invocation, argument hints, and placeholder usage.

#### Scenario: No redundant merge documentation
- GIVEN the archive skill documents the merge algorithm
- WHEN the skill SKILL.md is defined
- THEN the merge rules (operation order, validation) are documented once
- AND there is no separate "Delta Rules" section duplicating the merge algorithm

### Requirement: Start New Change
The system SHALL provide a `/ds:new <name>` skill that creates a proposal for a new change, with cycle detection and resolution, with argument hints and placeholder usage.

#### Scenario: No redundant behavior section
- GIVEN the new skill documents behavior in its steps
- WHEN the skill SKILL.md is defined
- THEN there is no separate "Behavior" section that duplicates step content

### Requirement: Quick Start Change
The system SHALL provide a `/ds:quick [name] ["description"]` skill that creates a complete change setup (proposal, design, and tasks) with minimal interaction, with argument hints and placeholder usage.

#### Scenario: Consolidated no-prompt instructions
- GIVEN Steps 5 and 6 both run without interaction
- WHEN the skill SKILL.md is defined
- THEN a single note covers both steps ("Steps 5-6 run without prompts")
- AND the note is not duplicated in each step

### Requirement: Batch Feature Planning
The system SHALL provide a `/ds:batch` skill that creates multiple proposals from a single free-form description, with feature consolidation, dependency inference, and cycle detection and resolution.

#### Scenario: Edge case cross-references steps
- GIVEN the Circular Dependencies edge case describes behavior handled by Step 3.5
- WHEN the skill SKILL.md is defined
- THEN the edge case uses a cross-reference to Step 3.5 rather than re-summarizing the behavior

### Requirement: Shared Version Check
The system SHALL extract version check logic to a shared file to eliminate duplication.

#### Scenario: Consistent heading in shared file
- GIVEN the shared version check file is referenced by multiple skills
- WHEN organizing skill structure
- THEN `skills/_shared/version-check.md` has a heading consistent with other shared files

### Requirement: Shared Change Resolution
The system SHALL extract the "determine which change" logic to a shared file to eliminate duplication across skills.

#### Scenario: Quick skill noted in context
- GIVEN the quick skill creates new changes rather than operating on existing ones
- WHEN the shared determine-change file lists context-specific notes
- THEN it includes a note that quick does not use this procedure
