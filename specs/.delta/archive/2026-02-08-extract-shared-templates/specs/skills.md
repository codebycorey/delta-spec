# Delta: Skills

Changes for extract-shared-templates.

## ADDED Requirements

### Requirement: Shared Design Template
The system SHALL extract the design document template to a shared file to eliminate duplication across skills.

#### Scenario: Create shared design template file
- GIVEN the design template is duplicated across plan, adopt, and quick skills
- WHEN organizing skill structure
- THEN a `skills/_shared/design-template.md` file contains the canonical design template
- AND includes Context, Approach, Decisions, Files Affected, and Risks sections

#### Scenario: Include design template in plan
- GIVEN the plan skill creates design documents
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/design-template.md` instead of inlining the template

#### Scenario: Include design template in adopt
- GIVEN the adopt skill creates design documents from conversation context
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/design-template.md` instead of inlining the template

#### Scenario: Include design template in quick
- GIVEN the quick skill creates design documents
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/design-template.md` for the design format

### Requirement: Shared Task Format
The system SHALL extract the task file format to a shared file to eliminate duplication across skills.

#### Scenario: Create shared task format file
- GIVEN the task format is duplicated across tasks and adopt skills
- WHEN organizing skill structure
- THEN a `skills/_shared/task-format.md` file contains the canonical task format
- AND includes the file structure, task fields table, and updating instructions

#### Scenario: Include task format in tasks
- GIVEN the tasks skill creates task files
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/task-format.md` instead of inlining the format

#### Scenario: Include task format in adopt
- GIVEN the adopt skill creates task files from conversation context
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/task-format.md` instead of inlining the format

### Requirement: Shared Dependency Signals
The system SHALL extract dependency signal patterns to a shared file to eliminate implicit cross-skill references.

#### Scenario: Create shared dependency signals file
- GIVEN the dependency keywords table is defined in batch and referenced by name in adopt
- WHEN organizing skill structure
- THEN a `skills/_shared/dependency-signals.md` file contains the canonical dependency keyword patterns
- AND includes the keywords table, matching rules, and confidence levels

#### Scenario: Include dependency signals in batch
- GIVEN the batch skill infers dependencies from descriptions
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/dependency-signals.md` instead of inlining the keywords table

#### Scenario: Include dependency signals in adopt
- GIVEN the adopt skill infers dependencies from conversation context
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/dependency-signals.md` instead of a cross-reference to batch
