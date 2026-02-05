# Delta: Skills

Changes for test-task-generation.

## MODIFIED Requirements

### Requirement: Generate Tasks
The system SHALL provide a `/ds-tasks [name]` skill that creates a `tasks.md` file, supporting both single-change and multi-change modes.

#### Scenario: Create task file
- GIVEN a change with design and delta specs
- WHEN the user runs `/ds-tasks`
- THEN the system creates `specs/.delta/<name>/tasks.md`
- AND each task has Status, Owner, Files, and Refs fields
- AND tasks are ordered by dependency

#### Scenario: Test task generation
- GIVEN a project with test infrastructure (test directories, test configs, existing tests)
- WHEN the user runs `/ds-tasks`
- THEN the system includes tasks for testing new or modified behavior
- AND test tasks reference the appropriate test files and patterns

#### Scenario: No test infrastructure
- GIVEN a project without test infrastructure
- WHEN the user runs `/ds-tasks`
- THEN the system does not include test tasks

#### Scenario: Task file format
- GIVEN a task file is being generated
- WHEN writing tasks
- THEN each task has `## Task N: <title>` header
- AND has `- **Status:** pending` field
- AND has `- **Owner:** (unassigned)` field
- AND may have `- **Files:**` and `- **Refs:**` fields

#### Scenario: Single change by name
- GIVEN multiple planned changes
- WHEN the user runs `/ds-tasks my-change`
- THEN the system creates `tasks.md` only for the named change

#### Scenario: All changes mode
- GIVEN multiple changes with design and delta specs
- WHEN the user runs `/ds-tasks` without a name
- THEN the system creates `tasks.md` for each planned change in dependency order

#### Scenario: Dependency ordering
- GIVEN changes A depends on B, and C is independent
- WHEN processing all changes
- THEN the system processes changes in order respecting dependencies
- AND each change gets its own `tasks.md` file

#### Scenario: Skip unplanned changes
- GIVEN a change with only a proposal (no design or specs)
- WHEN processing all changes
- THEN the system skips that change
- AND notes it was skipped because planning is incomplete

#### Scenario: Cycle detection
- GIVEN changes with circular dependencies
- WHEN attempting to order changes
- THEN the system warns about the cycle
- AND asks the user to resolve the dependency issue
