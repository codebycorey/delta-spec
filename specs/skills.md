---
generated: true
generated_at: 2026-02-03
---

# Skills Specification

## Purpose

Defines the skills that provide the user interface for delta-spec. Each skill follows consistent patterns for version checking, change inference, and dependency management.

## Requirements

### Requirement: Initialize Repository
The system SHALL provide a `/ds-init` skill that creates the specs directory structure.

#### Scenario: First-time initialization
- GIVEN a repository without a specs directory
- WHEN the user runs `/ds-init`
- THEN the system creates `specs/`, `specs/.delta/`, and `specs/.delta/archive/`
- AND creates `specs/.delta-spec.json` with the current plugin version

#### Scenario: Optional spec generation
- GIVEN an initialized repository with existing code
- WHEN the user chooses to generate specs during init
- THEN the system explores the codebase and creates domain-based spec files

#### Scenario: Idempotent initialization
- GIVEN a repository already initialized with delta-spec
- WHEN the user runs `/ds-init`
- THEN the system detects existing structure and asks before overwriting

### Requirement: Start New Change
The system SHALL provide a `/ds-new <name>` skill that creates a proposal for a new change, with cycle detection and resolution.

#### Scenario: Create proposal
- GIVEN an initialized repository
- WHEN the user runs `/ds-new add-feature`
- THEN the system creates `specs/.delta/add-feature/proposal.md`
- AND works interactively with the user to define the problem and scope

#### Scenario: Reopen existing proposal
- GIVEN a change with an existing proposal
- WHEN the user runs `/ds-new add-feature`
- THEN the system reopens the proposal for refinement

#### Scenario: Cycle detection on dependency declaration
- GIVEN the user declares dependencies that create a cycle with existing changes
- WHEN validating the dependency graph
- THEN the system detects the cycle before finalizing the proposal

#### Scenario: Cycle resolution in new
- GIVEN a cycle is detected during `/ds-new`
- WHEN prompting the user
- THEN the system shows the cycle and suggests extraction
- AND lists existing proposals that have artifacts to remove
- AND asks "Extract '<name>' as base change? [y/N]"

#### Scenario: Cycle resolution accepted in new
- GIVEN the user confirms cycle resolution with "y"
- WHEN resolving the cycle
- THEN the system creates the base proposal
- AND updates the new proposal's dependencies
- AND updates existing proposals' dependencies
- AND removes design.md and tasks.md from affected existing proposals
- AND runs `/ds-plan` for all affected changes in dependency order

#### Scenario: Cycle resolution declined in new
- GIVEN the user declines cycle resolution
- WHEN resolution is declined
- THEN the system asks user to remove a dependency from their proposal
- AND proceeds only after cycle is broken

### Requirement: Plan Change
The system SHALL provide a `/ds-plan [name]` skill that creates design documents and delta specs.

#### Scenario: Create design from proposal
- GIVEN a change with a completed proposal
- WHEN the user runs `/ds-plan`
- THEN the system explores the codebase for context
- AND creates `design.md` with technical approach
- AND generates delta specs in `specs/.delta/<name>/specs/`

#### Scenario: Dependency warning
- GIVEN a change that depends on another unarchived change
- WHEN the user runs `/ds-plan`
- THEN the system warns about unsatisfied dependencies
- AND asks whether to proceed or defer

### Requirement: Generate Tasks
The system SHALL provide a `/ds-tasks [name]` skill that creates a `tasks.md` file, supporting both single-change and multi-change modes, with cycle detection.

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

#### Scenario: Cycle detection in tasks
- GIVEN changes with circular dependencies
- WHEN attempting to order changes
- THEN the system warns about the cycle
- AND shows the cycle path
- AND suggests running `/ds-new` or `/ds-batch` to resolve
- AND does not proceed until cycle is resolved

### Requirement: Archive Change
The system SHALL provide a `/ds-archive [name]` skill that safely merges delta specs and archives the change, with cycle detection.

#### Scenario: Merge and archive
- GIVEN a change with delta specs
- WHEN the user runs `/ds-archive`
- THEN the system validates all references first
- AND merges deltas into main specs
- AND moves the change to `specs/.delta/archive/YYYY-MM-DD-<name>/`

#### Scenario: Show diff before writing
- GIVEN delta specs to merge
- WHEN archiving a change
- THEN the system shows the diff before writing to main specs

#### Scenario: Pre-validation of references
- GIVEN a delta spec with MODIFIED or REMOVED operations
- WHEN the user runs `/ds-archive`
- THEN the system verifies all referenced requirements exist in main specs
- AND stops with an error if any reference is invalid
- AND no files are modified if validation fails

#### Scenario: Pre-validation of additions
- GIVEN a delta spec with ADDED operations
- WHEN the user runs `/ds-archive`
- THEN the system verifies no added requirements already exist
- AND stops with an error if a duplicate would be created

#### Scenario: Conflict check
- GIVEN another active change also modifies the same requirement
- WHEN the user runs `/ds-archive`
- THEN the system warns about the conflict
- AND asks to proceed or resolve conflicts first

#### Scenario: Cycle detection in archive
- GIVEN active changes with circular dependencies including this change
- WHEN the user runs `/ds-archive`
- THEN the system warns about the cycle
- AND shows the cycle path
- AND suggests running `/ds-new` or `/ds-batch` to resolve
- AND asks whether to proceed anyway

#### Scenario: Interactive confirmation
- GIVEN diffs have been shown
- WHEN the user is prompted to confirm
- THEN the system asks "Apply these changes? [y/N]"
- AND requires explicit "y" to proceed
- AND cancels on empty input or "n"

#### Scenario: Confirmation summary
- GIVEN multiple spec files will be modified
- WHEN showing the confirmation prompt
- THEN the system lists all files that will be changed

### Requirement: Drop Change
The system SHALL provide a `/ds-drop [name]` skill that abandons a change.

#### Scenario: Permanent deletion
- GIVEN an active change
- WHEN the user runs `/ds-drop`
- THEN the system permanently deletes `specs/.delta/<name>/`
- AND the change is NOT archived

#### Scenario: Dependent cleanup
- GIVEN a change that other changes depend on
- WHEN the user runs `/ds-drop`
- THEN the system offers to clean references from dependent changes
- OR cascade delete all dependents

### Requirement: Show Status
The system SHALL provide a `/ds-status` skill that shows all active changes with conflicts, progress from task files, dependency visualization, and cycle warnings.

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

#### Scenario: Cycle detection in status
- GIVEN active changes with circular dependencies
- WHEN the user runs `/ds-status`
- THEN the system displays a cycle warning showing the cycle path
- AND suggests running `/ds-new` or `/ds-batch` to resolve

### Requirement: View Specifications
The system SHALL provide a `/ds-spec [domain|search]` skill to view, discuss, or search specs.

#### Scenario: List all specs
- GIVEN specs exist in the specs directory
- WHEN the user runs `/ds-spec` without arguments
- THEN the system lists all spec files (excluding .delta/)

#### Scenario: View specific domain
- GIVEN a domain spec exists
- WHEN the user runs `/ds-spec auth`
- THEN the system reads and discusses the auth specification

#### Scenario: Search by keyword
- GIVEN specs exist with requirements
- WHEN the user runs `/ds-spec "authentication"`
- THEN the system searches all spec files for matching requirements
- AND displays results grouped by spec file with requirement name and context

#### Scenario: Search vs domain detection
- GIVEN a search term that does not match any spec filename
- WHEN the user runs `/ds-spec <term>`
- THEN the system treats it as a search term

#### Scenario: Case insensitive search
- GIVEN a spec contains "Authentication" (capitalized)
- WHEN the user runs `/ds-spec "authentication"` (lowercase)
- THEN the system finds the match

### Requirement: Change Inference
The system SHALL infer the current change when name is omitted from skills.

#### Scenario: Single active change
- GIVEN exactly one change in specs/.delta/
- WHEN the user runs a skill without a name
- THEN the system uses that change

#### Scenario: Multiple changes
- GIVEN multiple changes in specs/.delta/
- WHEN the user runs a skill without a name and it cannot be inferred
- THEN the system asks the user to pick

#### Scenario: No active changes
- GIVEN no changes in specs/.delta/
- WHEN the user runs a skill requiring a change
- THEN the system tells the user to run `/ds-new` first

### Requirement: Quick Start Change
The system SHALL provide a `/ds-quick [name] ["description"]` skill that creates a complete change setup (proposal, design, and tasks) with minimal interaction.

#### Scenario: With arguments
- GIVEN an initialized repository
- WHEN the user runs `/ds-quick my-feature "Add support for X"`
- THEN the system creates `specs/.delta/my-feature/proposal.md` from the arguments
- AND shows the proposal to the user
- AND asks "Proceed? [y/N]"

#### Scenario: Without arguments (context inference)
- GIVEN an initialized repository and prior conversation context
- WHEN the user runs `/ds-quick`
- THEN the system infers the change name and description from conversation
- AND creates and shows the proposal
- AND asks "Proceed? [y/N]"

#### Scenario: After confirmation
- GIVEN the user confirms the proposal with "y"
- WHEN proceeding with the workflow
- THEN the system explores the codebase (as in `/ds-plan`)
- AND creates `design.md` without prompting
- AND creates delta specs in `specs/` without prompting
- AND creates `tasks.md` without prompting
- AND outputs a summary of all created artifacts

#### Scenario: Proposal rejected
- GIVEN the user rejects the proposal with "n" or empty input
- WHEN the confirmation is rejected
- THEN the system stops without creating design or tasks
- AND the proposal remains for manual editing via `/ds-new`

#### Scenario: Change already exists
- GIVEN a change with the same name already exists
- WHEN the user runs `/ds-quick my-feature "..."`
- THEN the system warns about the existing change
- AND asks whether to continue with that change or pick a different name

### Requirement: Batch Feature Planning
The system SHALL provide a `/ds-batch` skill that creates multiple proposals from a single free-form description, with cycle detection and resolution.

#### Scenario: Prompt for features
- GIVEN an initialized repository
- WHEN the user runs `/ds-batch`
- THEN the system prompts "Describe the features you want to plan:"

#### Scenario: Parse free-form input
- GIVEN the user provides a free-form description of multiple features
- WHEN the system parses the input
- THEN the system extracts individual features with names and descriptions
- AND infers dependencies from relationship phrases (e.g., "needs auth", "requires X", "uses Y", "builds on Z", "after X")

#### Scenario: Infer feature names
- GIVEN extracted features without explicit names
- WHEN naming features
- THEN the system generates kebab-case names from descriptions (e.g., "user authentication" → "user-auth")

#### Scenario: Confident dependency inference
- GIVEN clear relationship phrases in descriptions
- WHEN inferring dependencies
- THEN the system automatically sets dependencies without asking

#### Scenario: Uncertain dependency inference
- GIVEN ambiguous or unclear relationships
- WHEN inferring dependencies
- THEN the system asks for clarification before proceeding

#### Scenario: Cycle detection
- GIVEN inferred dependencies form a cycle (A → B → C → A)
- WHEN validating the dependency graph
- THEN the system detects the cycle before showing confirmation

#### Scenario: Cycle analysis
- GIVEN a cycle is detected
- WHEN analyzing the cycle
- THEN the system examines descriptions of all changes in the cycle
- AND identifies common concepts (terms appearing in multiple descriptions)
- AND suggests a base change name from the common concept

#### Scenario: Cycle resolution offer
- GIVEN a cycle is detected with a suggested extraction
- WHEN prompting the user
- THEN the system shows the cycle and suggested extraction
- AND lists any artifacts (design.md, tasks.md) that will be removed
- AND asks "Extract '<name>' as base change? [y/N]"

#### Scenario: Cycle resolution accepted
- GIVEN the user confirms cycle resolution with "y"
- WHEN resolving the cycle
- THEN the system creates a new proposal for the base change
- AND updates dependencies in affected proposals to point to the base
- AND removes design.md and tasks.md from affected proposals
- AND runs `/ds-plan` for all affected changes in dependency order

#### Scenario: Cycle resolution declined
- GIVEN the user declines cycle resolution with "n" or empty input
- WHEN resolution is declined
- THEN the system asks user to manually specify which dependency to remove
- AND proceeds only after cycle is broken

#### Scenario: Show dependency graph
- GIVEN parsed features with dependencies (no cycle)
- WHEN displaying for confirmation
- THEN the system shows an ASCII dependency graph
- AND lists each feature with its inferred dependencies

#### Scenario: Graph format
- GIVEN features A (independent), B depends on A, C depends on B
- WHEN displaying the graph
- THEN the system shows arrows indicating dependency flow (e.g., "A → B → C")

#### Scenario: Confirm before creating
- GIVEN the dependency graph is displayed (no cycle)
- WHEN prompting for confirmation
- THEN the system asks "Create these proposals? [y/N]"
- AND requires explicit "y" to proceed

#### Scenario: Create proposals
- GIVEN the user confirms with "y"
- WHEN creating proposals
- THEN the system creates `specs/.delta/<name>/proposal.md` for each feature
- AND each proposal includes the inferred problem, changes, and dependencies
- AND proposals are created in dependency order (dependencies first)

#### Scenario: Proposal template
- GIVEN a feature to create a proposal for
- WHEN writing the proposal
- THEN the system uses the standard proposal template
- AND fills in Problem, Dependencies, Changes, Capabilities, Out of Scope, and Success Criteria

#### Scenario: Existing change conflict
- GIVEN a feature name matches an existing change in specs/.delta/
- WHEN creating proposals
- THEN the system warns about the conflict
- AND asks to skip, overwrite, or rename

#### Scenario: Batch planning offer
- GIVEN all proposals have been created
- WHEN the batch is complete
- THEN the system asks "Run /ds-plan for all? [y/N]"

#### Scenario: Accept batch planning
- GIVEN the user confirms batch planning with "y"
- WHEN running batch planning
- THEN the system runs the planning phase for each feature in dependency order
- AND shows progress as each feature is planned

#### Scenario: Decline batch planning
- GIVEN the user declines with "n" or empty input
- WHEN batch planning is declined
- THEN the system stops
- AND tells the user they can run `/ds-plan` individually later

#### Scenario: Empty input
- GIVEN the user provides empty or whitespace-only input
- WHEN parsing features
- THEN the system asks for features again or exits gracefully

#### Scenario: Single feature input
- GIVEN the user describes only one feature
- WHEN parsing features
- THEN the system suggests using `/ds-new` or `/ds-quick` instead
- AND offers to proceed anyway if the user wants
