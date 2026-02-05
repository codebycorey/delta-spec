# Delta: Skills

Changes for file-based-tasks.

## MODIFIED Requirements

### Requirement: Generate Tasks
The system SHALL provide a `/ds-tasks [name]` skill that creates a `tasks.md` file, supporting both single-change and multi-change modes.

#### Scenario: Create task file
- GIVEN a change with design and delta specs
- WHEN the user runs `/ds-tasks`
- THEN the system creates `specs/.delta/<name>/tasks.md`
- AND each task has Status, Owner, Files, and Refs fields
- AND tasks are ordered by dependency

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

### Requirement: Show Status
The system SHALL provide a `/ds-status` skill that shows all active changes with conflicts, progress from task files, and dependency visualization.

#### Scenario: List changes with status
- GIVEN active changes in specs/.delta/
- WHEN the user runs `/ds-status`
- THEN the system lists each change with artifacts, dependencies, and next steps

#### Scenario: Version mismatch warning
- GIVEN a version mismatch between project and plugin
- WHEN the user runs `/ds-status`
- THEN the system shows a warning about the mismatch

#### Scenario: Conflict detection
- GIVEN two active changes both MODIFY the same requirement
- WHEN the user runs `/ds-status`
- THEN the system displays a conflict warning showing which changes overlap

#### Scenario: No conflicts
- GIVEN active changes with no overlapping requirement modifications
- WHEN the user runs `/ds-status`
- THEN the system does not display conflict warnings

#### Scenario: Progress from task file
- GIVEN a change has `tasks.md` file
- WHEN the user runs `/ds-status`
- THEN the system reads task statuses from the file
- AND shows completion progress (e.g., "2/5 done")

#### Scenario: No task file
- GIVEN a change has no `tasks.md` file
- WHEN the user runs `/ds-status`
- THEN the system shows "No tasks" or suggests running `/ds-tasks`

#### Scenario: Dependency graph
- GIVEN multiple active changes with dependencies
- WHEN the user runs `/ds-status`
- THEN the system displays an ASCII dependency tree showing relationships

#### Scenario: Independent changes in graph
- GIVEN changes with no dependencies
- WHEN displaying the dependency graph
- THEN independent changes are shown as separate roots

## REMOVED Requirements

### Requirement: No task files (implicit in old Generate Tasks)
**Reason:** This behavior is being reversed - we now want task files
**Migration:** The new "Create task file" scenario replaces this
