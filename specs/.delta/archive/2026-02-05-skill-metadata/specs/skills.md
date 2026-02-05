# Delta: Skills

Changes for skill-metadata.

## ADDED Requirements

### Requirement: Skill Frontmatter Metadata
The system SHALL include appropriate frontmatter fields in SKILL.md files to control skill behavior and improve UX.

#### Scenario: Argument hints for skills with parameters
- GIVEN a skill accepts arguments
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint` showing the expected argument pattern
- AND the pattern uses `<arg>` for required args and `[arg]` for optional args

#### Scenario: Disable auto-invocation for destructive skills
- GIVEN a skill performs destructive or permanent operations
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `disable-model-invocation: true`
- AND the skill requires explicit user invocation

#### Scenario: Restrict tools for read-only skills
- GIVEN a skill only reads data without modifications
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `allowed-tools` listing only read operations
- AND the skill cannot accidentally modify files

### Requirement: Arguments Placeholder
The system SHALL document the use of `$ARGUMENTS` for referencing user-provided arguments in skill execution.

#### Scenario: Skills with arguments reference placeholder
- GIVEN a skill accepts arguments
- WHEN the skill SKILL.md is defined
- THEN the skill body includes a note about using `$ARGUMENTS`
- AND the note appears immediately after the skill header

#### Scenario: Skills without arguments omit placeholder
- GIVEN a skill does not accept arguments
- WHEN the skill SKILL.md is defined
- THEN the skill body does not mention `$ARGUMENTS`

### Requirement: Shared Version Check
The system SHALL extract version check logic to a shared file to eliminate duplication.

#### Scenario: Create shared version check file
- GIVEN version check logic is duplicated across multiple skills
- WHEN organizing skill structure
- THEN a `skills/_shared/version-check.md` file contains the standard check
- AND the check validates `.delta-spec.json` version against plugin version

#### Scenario: Include shared version check in skills
- GIVEN a skill requires version checking
- WHEN the skill SKILL.md is defined
- THEN Step 0 references `{{include: ../_shared/version-check.md}}`
- AND the skill does not duplicate the version check logic inline

#### Scenario: Init skill skips version check
- GIVEN the ds-init skill creates `.delta-spec.json`
- WHEN the skill SKILL.md is defined
- THEN the skill does not include a version check step
- AND the skill does not reference the shared version check file

## MODIFIED Requirements

### Requirement: Initialize Repository
The system SHALL provide a `/ds-init` skill that creates the specs directory structure with protection against auto-invocation.

(All existing scenarios remain unchanged)

#### Scenario: Destructive operation protection - ADDED
- GIVEN ds-init can overwrite existing files
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `disable-model-invocation: true`

### Requirement: Start New Change
The system SHALL provide a `/ds-new <name>` skill that creates a proposal for a new change, with cycle detection and resolution, with argument hints and placeholder usage.

(All existing scenarios remain unchanged)

#### Scenario: Argument hint for name parameter - ADDED
- GIVEN ds-new requires a name argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "<name>"`

#### Scenario: Arguments placeholder documented - ADDED
- GIVEN ds-new accepts a name argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the name

### Requirement: Plan Change
The system SHALL provide a `/ds-plan [name]` skill that creates design documents and delta specs with argument hints and placeholder usage.

(All existing scenarios remain unchanged)

#### Scenario: Argument hint for optional name parameter - ADDED
- GIVEN ds-plan accepts an optional name argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[name]"`

#### Scenario: Arguments placeholder documented - ADDED
- GIVEN ds-plan accepts a name argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the name

### Requirement: Generate Tasks
The system SHALL provide a `/ds-tasks [name]` skill that creates a `tasks.md` file, supporting both single-change and multi-change modes, with cycle detection, with argument hints and placeholder usage.

(All existing scenarios remain unchanged)

#### Scenario: Argument hint for optional name parameter - ADDED
- GIVEN ds-tasks accepts an optional name argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[name]"`

#### Scenario: Arguments placeholder documented - ADDED
- GIVEN ds-tasks accepts a name argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the name

### Requirement: Archive Change
The system SHALL provide a `/ds-archive [name]` skill that safely merges delta specs and archives the change, with cycle detection, with protection against auto-invocation, argument hints, and placeholder usage.

(All existing scenarios remain unchanged)

#### Scenario: Destructive operation protection - ADDED
- GIVEN ds-archive permanently merges specs
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `disable-model-invocation: true`

#### Scenario: Argument hint for optional name parameter - ADDED
- GIVEN ds-archive accepts an optional name argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[name]"`

#### Scenario: Arguments placeholder documented - ADDED
- GIVEN ds-archive accepts a name argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the name

### Requirement: Drop Change
The system SHALL provide a `/ds-drop [name]` skill that abandons a change with protection against auto-invocation, argument hints, and placeholder usage.

(All existing scenarios remain unchanged)

#### Scenario: Destructive operation protection - ADDED
- GIVEN ds-drop permanently deletes change directories
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `disable-model-invocation: true`

#### Scenario: Argument hint for optional name parameter - ADDED
- GIVEN ds-drop accepts an optional name argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[name]"`

#### Scenario: Arguments placeholder documented - ADDED
- GIVEN ds-drop accepts a name argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the name

### Requirement: Show Status
The system SHALL provide a `/ds-status` skill that shows all active changes with conflicts, progress from task files, dependency visualization, and cycle warnings, with tool restrictions for read-only access.

(All existing scenarios remain unchanged)

#### Scenario: Read-only tool restrictions - ADDED
- GIVEN ds-status only reads change state
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `allowed-tools: ["Read", "Glob"]`

### Requirement: View Specifications
The system SHALL provide a `/ds-spec [domain|search]` skill to view, discuss, or search specs, with tool restrictions for read-only access, argument hints, and placeholder usage.

(All existing scenarios remain unchanged)

#### Scenario: Read-only tool restrictions - ADDED
- GIVEN ds-spec only reads and displays specs
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `allowed-tools: ["Read", "Glob", "Grep"]`

#### Scenario: Argument hint for domain or search parameter - ADDED
- GIVEN ds-spec accepts a domain or search term argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[domain|search]"`

#### Scenario: Arguments placeholder documented - ADDED
- GIVEN ds-spec accepts a domain or search argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the argument

### Requirement: Quick Start Change
The system SHALL provide a `/ds-quick [name] ["description"]` skill that creates a complete change setup (proposal, design, and tasks) with minimal interaction, with argument hints and placeholder usage.

(All existing scenarios remain unchanged)

#### Scenario: Argument hint for optional parameters - ADDED
- GIVEN ds-quick accepts optional name and description arguments
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[name] [\"description\"]"`

#### Scenario: Arguments placeholder documented - ADDED
- GIVEN ds-quick accepts name and description arguments
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the arguments

### Requirement: Batch Feature Planning
The system SHALL provide a `/ds-batch` skill that creates multiple proposals from a single free-form description, with cycle detection and resolution.

(All existing scenarios remain unchanged - ds-batch does not accept command-line arguments, only prompts for input interactively)
