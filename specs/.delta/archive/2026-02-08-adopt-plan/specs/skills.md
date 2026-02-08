# Delta: Skills

Changes for adopt-plan.

## ADDED Requirements

### Requirement: Adopt Existing Plan
The system SHALL provide a `/ds:adopt` skill that imports an existing plan from conversation context into delta-spec's format, skipping codebase exploration, with argument hints and placeholder usage.

#### Scenario: Extract changes from conversation context
- GIVEN an initialized repository and prior planning in conversation (plan mode or discussion)
- WHEN the user runs `/ds:adopt`
- THEN the system reads the conversation context to identify planned changes
- AND extracts structured proposals, designs, and delta specs from the context
- AND does not re-explore the codebase

#### Scenario: Single change extraction
- GIVEN the conversation context describes one change
- WHEN extracting changes
- THEN the system creates one proposal, one design, and delta specs for that change

#### Scenario: Multi-change extraction
- GIVEN the conversation context describes multiple changes
- WHEN extracting changes
- THEN the system creates proposals, designs, and delta specs for each change
- AND infers dependencies between changes from the context

#### Scenario: Confirmation before writing
- GIVEN changes have been extracted from context
- WHEN presenting to the user
- THEN the system shows a summary of each extracted change (name, problem, approach, files affected)
- AND asks "Create these changes? [y/N]"
- AND requires explicit "y" to proceed

#### Scenario: Confirmation accepted
- GIVEN the user confirms with "y"
- WHEN creating artifacts
- THEN the system creates `specs/.delta/<name>/` for each change
- AND writes `proposal.md`, `design.md`, and `specs/*.md` for each
- AND creates in dependency order (dependencies first)

#### Scenario: Confirmation rejected
- GIVEN the user responds with "n" or empty input
- WHEN handling rejection
- THEN the system stops without creating any files
- AND tells the user they can refine their plan and try again

#### Scenario: Dependency inference from context
- GIVEN changes extracted from context describe relationships
- WHEN inferring dependencies
- THEN the system uses the same dependency signal patterns as `/ds:batch`
- AND includes explicit dependency statements from the plan

#### Scenario: Cycle detection
- GIVEN inferred dependencies form a cycle
- WHEN validating the dependency graph
- THEN the system detects the cycle using the shared cycle detection procedure
- AND follows the full resolution flow from `_shared/cycle-detection.md`

#### Scenario: Output summary and next step
- GIVEN all artifacts have been created
- WHEN the adoption is complete
- THEN the system shows a summary of created artifacts
- AND suggests running `/ds:tasks` as the next step

#### Scenario: Existing change conflict
- GIVEN an extracted change name matches an existing change in `specs/.delta/`
- WHEN creating artifacts
- THEN the system warns about the conflict
- AND asks to skip, overwrite, or rename

#### Scenario: Argument hint for optional name parameter
- GIVEN ds-adopt accepts an optional name argument (to adopt a single named change)
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[name]"`

#### Scenario: Arguments placeholder documented
- GIVEN ds-adopt accepts a name argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the name

#### Scenario: Description with trigger phrases
- GIVEN ds-adopt is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "adopt this plan", "import plan", "capture this planning", "bring in the plan"

#### Scenario: Shared references
- GIVEN ds-adopt uses shared patterns
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/proposal-template.md` for proposal format
- AND references `_shared/delta-format.md` for delta spec format
- AND references `_shared/cycle-detection.md` for cycle detection

## MODIFIED Requirements

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
- THEN the system tells the user to run `/ds:new` first
