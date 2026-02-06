# Delta: Skills

Changes for skill-consistency.

## ADDED Requirements

### Requirement: Shared Proposal Template
The system SHALL extract the proposal template to a shared file to eliminate duplication across skills.

#### Scenario: Create shared proposal template file
- GIVEN the proposal template is duplicated across new, quick, and batch skills
- WHEN organizing skill structure
- THEN a `skills/_shared/proposal-template.md` file contains the canonical proposal template
- AND the template includes Problem, Dependencies, Changes, Capabilities, Out of Scope, and Success Criteria sections

#### Scenario: Include proposal template in new
- GIVEN the new skill creates proposals
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/proposal-template.md` instead of inlining the template

#### Scenario: Include proposal template in quick
- GIVEN the quick skill creates proposals
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/proposal-template.md` instead of inlining the template

#### Scenario: Include proposal template in batch
- GIVEN the batch skill creates proposals
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/proposal-template.md` instead of inlining the template

## MODIFIED Requirements

### Requirement: Initialize Repository
The system SHALL provide a `/ds:init` skill that creates the specs directory structure with protection against auto-invocation.

#### Scenario: Description with trigger phrases
- GIVEN ds-init has disable-model-invocation but descriptions serve human readers
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "initialize", "set up specs", "start using delta-spec"

#### Scenario: Plugin version source specified
- GIVEN init creates `.delta-spec.json` with the current plugin version
- WHEN the skill SKILL.md is defined
- THEN the skill specifies reading the version from `.claude-plugin/plugin.json`

### Requirement: Start New Change
The system SHALL provide a `/ds:new <name>` skill that creates a proposal for a new change, with cycle detection and resolution, with argument hints and placeholder usage.

#### Scenario: Interactive guidance for proposal refinement
- GIVEN the new skill works with the user on the proposal
- WHEN Step 3 is defined
- THEN the step provides specific guidance on which sections to probe
- AND prioritizes Problem, Changes, and Success Criteria
- AND defines when the proposal is complete enough to proceed

#### Scenario: Naming convention guidance
- GIVEN the name parameter is used to create a directory
- WHEN the skill SKILL.md is defined
- THEN the skill specifies kebab-case naming convention
- AND provides examples of converting user input to kebab-case

### Requirement: Plan Change
The system SHALL provide a `/ds:plan [name]` skill that creates design documents and delta specs with argument hints and placeholder usage.

#### Scenario: Integer step numbering in plan
- GIVEN the plan skill uses "Step 2b" for dependency notes
- WHEN the skill SKILL.md is defined
- THEN all steps use sequential integer numbering (0, 1, 2, 3, 4, 5, 6, 7)
- AND no sub-step numbering like 2b is used at the top level

### Requirement: Archive Change
The system SHALL provide a `/ds:archive [name]` skill that safely merges delta specs and archives the change, with cycle detection, with protection against auto-invocation, argument hints, and placeholder usage.

#### Scenario: Description with trigger phrases
- GIVEN ds-archive has disable-model-invocation but descriptions serve human readers
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "done implementing", "finalize change", "merge specs"

### Requirement: Drop Change
The system SHALL provide a `/ds:drop [name]` skill that abandons a change with protection against auto-invocation, argument hints, and placeholder usage.

#### Scenario: Description with trigger phrases
- GIVEN ds-drop has disable-model-invocation but descriptions serve human readers
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "cancel change", "abandon this", "discard proposal"

#### Scenario: No undocumented flags
- GIVEN the drop skill references a --force flag
- WHEN the skill SKILL.md is defined
- THEN no undocumented or unsupported flags are referenced
- AND confirmation is always required for destructive operations
