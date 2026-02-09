# Delta: Skills

Changes for fix-step-numbering.

## MODIFIED Requirements

### Requirement: Generate Tasks
The system SHALL provide a `/ds:tasks [name]` skill that creates a `tasks.md` file, supporting both single-change and multi-change modes, with cycle detection, with argument hints and placeholder usage.

#### Scenario: Sequential step numbering in tasks
- GIVEN the tasks skill uses "Step 2b" for dependency checking
- WHEN the skill SKILL.md is defined
- THEN all steps use sequential integer numbering (0, 1, 2, 3, 4, 5)
- AND no sub-step numbering like 2b is used at the top level

### Requirement: Batch Feature Planning
The system SHALL provide a `/ds:batch` skill that creates multiple proposals from a single free-form description, with feature consolidation, dependency inference, and cycle detection and resolution.

#### Scenario: Sequential step numbering in batch
- GIVEN the batch skill uses fractional step numbers (2.5, 3.5)
- WHEN the skill SKILL.md is defined
- THEN all steps use sequential integer numbering (0, 1, 2, 3, 4, 5, 6, 7, 8)
- AND no fractional numbering like 2.5 or 3.5 is used
