# Delta: Skills

Changes for quick-workflow.

## ADDED Requirements

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
