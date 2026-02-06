# Delta: Skills

Changes for extract-determine-change.

## ADDED Requirements

### Requirement: Shared Change Resolution
The system SHALL extract the "determine which change" logic to a shared file to eliminate duplication across skills.

#### Scenario: Create shared change resolution file
- GIVEN change resolution logic is duplicated across multiple skills
- WHEN organizing skill structure
- THEN a `skills/_shared/determine-change.md` file contains the standard procedure
- AND the procedure covers: argument provided, conversation inference, single change, multiple changes, no changes

#### Scenario: Standard resolution flow
- GIVEN the shared change resolution file
- WHEN defining the standard flow
- THEN step 1 checks if name is provided in arguments
- AND step 2 checks if inferable from conversation context
- AND step 3 uses the single active change if only one exists
- AND step 4 asks user to pick if multiple changes exist
- AND step 5 suggests a prerequisite if no changes exist

#### Scenario: Parameterized behavior
- GIVEN skills have slightly different resolution behavior
- WHEN defining the shared procedure
- THEN the file documents context-specific variations as notes
- AND includes: prerequisite suggestion varies by skill
- AND includes: drop confirms even with single change
- AND includes: tasks uses multi-change mode instead of asking

#### Scenario: Include in plan
- GIVEN the plan skill determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md`
- AND notes prerequisite is `/ds:new`

#### Scenario: Include in archive
- GIVEN the archive skill determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md`
- AND notes "nothing to archive" when no changes exist

#### Scenario: Include in drop
- GIVEN the drop skill determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md`
- AND notes confirmation is required even for single change

#### Scenario: Include in tasks with variant
- GIVEN the tasks skill has a multi-change mode
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md` for argument handling
- AND documents the multi-change variant inline (processing all planned changes)

## MODIFIED Requirements

### Requirement: Plan Change
The system SHALL provide a `/ds:plan [name]` skill that creates design documents and delta specs with argument hints and placeholder usage.

#### Scenario: Create design from proposal
- GIVEN a change with a completed proposal
- WHEN the user runs `/ds:plan`
- THEN the system explores the codebase for context
- AND creates `design.md` with technical approach
- AND generates delta specs in `specs/.delta/<name>/specs/`

#### Scenario: Dependency warning
- GIVEN a change that depends on another unarchived change
- WHEN the user runs `/ds:plan`
- THEN the system warns about unsatisfied dependencies
- AND asks whether to proceed or defer

#### Scenario: Argument hint for optional name parameter
- GIVEN ds-plan accepts an optional name argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[name]"`

#### Scenario: Arguments placeholder documented
- GIVEN ds-plan accepts a name argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the name

#### Scenario: Shared change resolution reference
- GIVEN ds-plan determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md` instead of inlining the logic

### Requirement: Generate Tasks
The system SHALL provide a `/ds:tasks [name]` skill that creates a `tasks.md` file, supporting both single-change and multi-change modes, with cycle detection, with argument hints and placeholder usage.

#### Scenario: Create task file
- GIVEN a change with design and delta specs
- WHEN the user runs `/ds:tasks`
- THEN the system creates `specs/.delta/<name>/tasks.md`
- AND each task has Status, Owner, Files, and Refs fields
- AND tasks are ordered by dependency

#### Scenario: Shared change resolution reference
- GIVEN ds-tasks determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md` for argument handling
- AND documents multi-change mode variant inline

### Requirement: Archive Change
The system SHALL provide a `/ds:archive [name]` skill that safely merges delta specs and archives the change, with cycle detection, with protection against auto-invocation, argument hints, and placeholder usage.

#### Scenario: Shared change resolution reference
- GIVEN ds-archive determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md` instead of inlining the logic

### Requirement: Drop Change
The system SHALL provide a `/ds:drop [name]` skill that abandons a change with protection against auto-invocation, argument hints, and placeholder usage.

#### Scenario: Shared change resolution reference
- GIVEN ds-drop determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md` instead of inlining the logic
- AND notes that confirmation is required even with a single change
