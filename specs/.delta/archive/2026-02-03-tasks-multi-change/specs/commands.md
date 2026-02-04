# Delta: Commands

Changes for tasks-multi-change.

## MODIFIED Requirements

### Requirement: Generate Tasks
The system SHALL provide a `/ds:tasks [name]` command that creates implementation tasks, supporting both single-change and multi-change modes.

#### Scenario: Create native tasks
- GIVEN a change with design and delta specs
- WHEN the user runs `/ds:tasks`
- THEN the system creates tasks using Claude Code's native TaskCreate tool
- AND each task references specific file paths
- AND tasks are ordered by dependency

#### Scenario: No task files
- GIVEN any state
- WHEN the user runs `/ds:tasks`
- THEN the system MUST NOT create a `tasks.md` file

#### Scenario: Single change by name
- GIVEN multiple planned changes
- WHEN the user runs `/ds:tasks my-change`
- THEN the system creates tasks only for the named change

#### Scenario: All changes mode
- GIVEN multiple changes with design and delta specs
- WHEN the user runs `/ds:tasks` without a name
- THEN the system creates tasks for all planned changes in dependency order

#### Scenario: Dependency ordering
- GIVEN changes A depends on B, and C is independent
- WHEN processing all changes
- THEN the system orders tasks as: C first, then B, then A
- OR orders as: B first, then A, then C (independent changes can be anywhere)

#### Scenario: Skip unplanned changes
- GIVEN a change with only a proposal (no design or specs)
- WHEN processing all changes
- THEN the system skips that change
- AND notes it was skipped because planning is incomplete

#### Scenario: Grouped output
- GIVEN multiple changes being processed
- WHEN creating tasks
- THEN tasks are grouped by change with clear headers
- AND tasks are numbered sequentially across all changes

#### Scenario: Cycle detection
- GIVEN changes with circular dependencies
- WHEN attempting to order changes
- THEN the system warns about the cycle
- AND asks the user to resolve the dependency issue
