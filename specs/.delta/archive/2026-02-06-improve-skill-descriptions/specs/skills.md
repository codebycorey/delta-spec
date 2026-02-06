# Delta: Skills

Changes for improve-skill-descriptions.

## MODIFIED Requirements

### Requirement: Start New Change
The system SHALL provide a `/ds:new <name>` skill that creates a proposal for a new change, with cycle detection and resolution, with argument hints and placeholder usage.

#### Scenario: Description with trigger phrases
- GIVEN ds-new is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "start a change", "create a proposal", "plan a feature"

### Requirement: Plan Change
The system SHALL provide a `/ds:plan [name]` skill that creates design documents and delta specs with argument hints and placeholder usage.

#### Scenario: Description with trigger phrases
- GIVEN ds-plan is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "plan this change", "create a design", "explore implementation"

### Requirement: Generate Tasks
The system SHALL provide a `/ds:tasks [name]` skill that creates a `tasks.md` file, supporting both single-change and multi-change modes, with cycle detection, with argument hints and placeholder usage.

#### Scenario: Description with trigger phrases
- GIVEN ds-tasks is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "create tasks", "generate implementation steps", "what needs to be done"

### Requirement: View Specifications
The system SHALL provide a `/ds:spec [domain|search]` skill to view, discuss, or search specs, with tool restrictions for read-only access, argument hints, and placeholder usage.

#### Scenario: Description with trigger phrases
- GIVEN ds-spec is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "show specs", "search specs", "what does the spec say"

### Requirement: Show Status
The system SHALL provide a `/ds:status` skill that shows all active changes with conflicts, progress from task files, dependency visualization, and cycle warnings, with tool restrictions for read-only access.

#### Scenario: Description with trigger phrases
- GIVEN ds-status is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "what's the status", "show active changes", "what are we working on"

### Requirement: Quick Start Change
The system SHALL provide a `/ds:quick [name] ["description"]` skill that creates a complete change setup (proposal, design, and tasks) with minimal interaction, with argument hints and placeholder usage.

#### Scenario: Description with trigger phrases
- GIVEN ds-quick is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "quick start", "fast-track this change", "set it all up"

### Requirement: Batch Feature Planning
The system SHALL provide a `/ds:batch` skill that creates multiple proposals from a single free-form description, with feature consolidation, dependency inference, and cycle detection and resolution.

#### Scenario: Description with trigger phrases
- GIVEN ds-batch is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "plan multiple features", "batch create proposals", "several features to plan"
