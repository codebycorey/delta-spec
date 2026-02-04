---
generated: true
generated_at: 2026-02-03
---

# Workflow Specification

## Purpose

Defines the end-to-end workflow for spec-driven development, including the lifecycle of changes, dependency management, and the archive process.

## Requirements

### Requirement: Change Lifecycle
The system SHALL enforce a structured lifecycle for changes: proposal, plan, tasks, archive.

#### Scenario: Standard workflow
- GIVEN a user wants to make a change
- WHEN they follow the workflow
- THEN they create a proposal with `/ds:new`
- AND create design and delta specs with `/ds:plan`
- AND create implementation tasks with `/ds:tasks`
- AND merge specs with `/ds:archive` after implementation

#### Scenario: Abandonment workflow
- GIVEN a change is no longer needed
- WHEN the user runs `/ds:drop`
- THEN the change is permanently deleted without archiving

### Requirement: Proposal Structure
The system SHALL use a structured proposal template with required sections.

#### Scenario: Proposal sections
- GIVEN a new proposal is created
- WHEN the template is generated
- THEN it includes Problem, Dependencies, Changes, Capabilities (New/Modified), Out of Scope, and Success Criteria sections

### Requirement: Design Structure
The system SHALL use a structured design template capturing technical decisions.

#### Scenario: Design sections
- GIVEN a design is created during planning
- WHEN the template is generated
- THEN it includes Context, Approach, Decisions, Files Affected, and Risks sections

#### Scenario: Decision documentation
- GIVEN a technical decision is made
- WHEN documenting in design.md
- THEN the decision includes Choice, Why, and Trade-offs

### Requirement: Dependency Tracking
The system SHALL track dependencies between changes in the proposal.

#### Scenario: Declare dependency
- GIVEN a change depends on another change
- WHEN writing the proposal
- THEN the dependency is listed in the Dependencies section with a reason

#### Scenario: Dependency satisfied
- GIVEN a dependency has been archived
- WHEN checking dependency status
- THEN the dependency is marked as satisfied

#### Scenario: Dependency unsatisfied
- GIVEN a dependency is still in specs/.delta/
- WHEN checking dependency status
- THEN the dependency is marked as unsatisfied and blocks progress

### Requirement: Dependency Enforcement
The system SHOULD warn when proceeding with unsatisfied dependencies, but only at phases where it matters.

#### Scenario: Planning with unsatisfied dependencies
- GIVEN a change that depends on another unarchived change
- WHEN running `/ds:plan`
- THEN the system notes the dependency exists
- AND proceeds without asking for confirmation

#### Scenario: Tasks with unsatisfied dependencies
- GIVEN a change that depends on another unarchived change
- WHEN running `/ds:tasks`
- THEN the system warns about unsatisfied dependencies
- AND asks whether to proceed or defer

#### Scenario: Archive with unsatisfied dependencies
- GIVEN a change that depends on another unarchived change
- WHEN running `/ds:archive`
- THEN the system warns about unsatisfied dependencies
- AND asks whether to proceed or archive dependencies first

#### Scenario: Dependency phases rationale
- GIVEN the dependency enforcement design
- WHEN determining where to enforce
- THEN planning is informational (safe to proceed)
- AND tasks warns (implementation order matters)
- AND archive warns (merge order matters)

### Requirement: Dependent Cleanup on Drop
The system SHALL handle dependent changes when dropping a change.

#### Scenario: Identify dependents
- GIVEN other changes depend on the change being dropped
- WHEN running `/ds:drop`
- THEN the system identifies all dependent changes

#### Scenario: Cleanup options
- GIVEN dependents are identified
- WHEN dropping a change
- THEN the system offers: clean references, cascade delete, or cancel

#### Scenario: Clean references
- GIVEN user chooses to clean references
- WHEN dropping a change
- THEN the system removes the dropped change from all dependent proposals

### Requirement: Archive Preservation
The system SHALL preserve all change artifacts when archiving.

#### Scenario: Timestamped archive
- GIVEN a change is being archived
- WHEN the archive completes
- THEN the change folder moves to `specs/.delta/archive/YYYY-MM-DD-<name>/`

#### Scenario: Complete preservation
- GIVEN a change with proposal, design, and specs
- WHEN archived
- THEN all artifacts are preserved in the archive folder

### Requirement: Version Compatibility
The system SHALL check version compatibility on all commands.

#### Scenario: Version check
- GIVEN the plugin version differs from specs/.delta-spec.json
- WHEN running any command
- THEN the system warns about the mismatch and offers migration options

#### Scenario: Migration options
- GIVEN a version mismatch is detected
- WHEN the user is prompted
- THEN options include: Migrate, Continue anyway, Cancel

#### Scenario: Missing initialization
- GIVEN specs/.delta-spec.json does not exist
- WHEN running any command except init
- THEN the system tells the user to run `/ds:init` first
