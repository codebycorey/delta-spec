# Delta: Workflow

Changes for adopt-plan.

## MODIFIED Requirements

### Requirement: Change Lifecycle
The system SHALL enforce a structured lifecycle for changes: proposal, plan, tasks, archive.

#### Scenario: Standard workflow
- GIVEN a user wants to make a change
- WHEN they follow the workflow
- THEN they create a proposal with `/ds:new`
- AND create design and delta specs with `/ds:plan`
- AND create implementation tasks with `/ds:tasks`
- AND merge specs with `/ds:archive` after implementation

#### Scenario: Adopt workflow
- GIVEN a user has already planned changes outside delta-spec (plan mode, conversation)
- WHEN they want to track those changes with delta-spec
- THEN they import the plan with `/ds:adopt`
- AND the system creates proposals, designs, and delta specs from the existing context
- AND they create implementation tasks with `/ds:tasks`
- AND merge specs with `/ds:archive` after implementation

#### Scenario: Abandonment workflow
- GIVEN a change is no longer needed
- WHEN the user runs `/ds:drop`
- THEN the change is permanently deleted without archiving
