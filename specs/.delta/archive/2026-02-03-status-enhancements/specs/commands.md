# Delta: Commands

Changes for status-enhancements.

## MODIFIED Requirements

### Requirement: Show Status
The system SHALL provide a `/ds:status` command that shows all active changes with conflicts, progress, and dependency visualization.

#### Scenario: List changes with status
- GIVEN active changes in specs/.delta/
- WHEN the user runs `/ds:status`
- THEN the system lists each change with artifacts, dependencies, and next steps

#### Scenario: Version mismatch warning
- GIVEN a version mismatch between project and plugin
- WHEN the user runs `/ds:status`
- THEN the system shows a warning about the mismatch

#### Scenario: Conflict detection
- GIVEN two active changes both MODIFY the same requirement
- WHEN the user runs `/ds:status`
- THEN the system displays a conflict warning showing which changes overlap

#### Scenario: No conflicts
- GIVEN active changes with no overlapping requirement modifications
- WHEN the user runs `/ds:status`
- THEN the system does not display conflict warnings

#### Scenario: Progress tracking
- GIVEN tasks were created via `/ds:tasks` for a change
- WHEN the user runs `/ds:status`
- THEN the system shows task completion progress (e.g., "3/5 tasks")

#### Scenario: No tasks
- GIVEN no tasks exist for a change
- WHEN the user runs `/ds:status`
- THEN the system shows "No tasks" or omits progress line

#### Scenario: Dependency graph
- GIVEN multiple active changes with dependencies
- WHEN the user runs `/ds:status`
- THEN the system displays an ASCII dependency tree showing relationships

#### Scenario: Independent changes in graph
- GIVEN changes with no dependencies
- WHEN displaying the dependency graph
- THEN independent changes are shown as separate roots
