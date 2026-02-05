# Delta: Skills

Changes for ds-batch.

## ADDED Requirements

### Requirement: Batch Feature Planning
The system SHALL provide a `/ds-batch` skill that creates multiple proposals from a single free-form description.

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

#### Scenario: Show dependency graph
- GIVEN parsed features with dependencies
- WHEN displaying for confirmation
- THEN the system shows an ASCII dependency graph
- AND lists each feature with its inferred dependencies

#### Scenario: Graph format
- GIVEN features A (independent), B depends on A, C depends on B
- WHEN displaying the graph
- THEN the system shows arrows indicating dependency flow (e.g., "A → B → C")

#### Scenario: Confirm before creating
- GIVEN the dependency graph is displayed
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
