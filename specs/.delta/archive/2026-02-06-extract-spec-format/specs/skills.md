# Delta: Skills

Changes for extract-spec-format.

## ADDED Requirements

### Requirement: Shared Spec Format
The system SHALL extract spec format templates to shared files to eliminate duplication across skills.

#### Scenario: Create shared base spec format file
- GIVEN the base spec format template is duplicated across init and spec skills
- WHEN organizing skill structure
- THEN a `skills/_shared/spec-format.md` file contains the canonical base spec format
- AND includes the template structure (Domain, Purpose, Requirements, Scenarios)
- AND includes writing guidelines (RFC 2119 keywords, atomic requirements, Given/When/Then)

#### Scenario: Create shared delta format file
- GIVEN the delta spec format template exists only in the plan skill but is conceptually shared
- WHEN organizing skill structure
- THEN a `skills/_shared/delta-format.md` file contains the canonical delta format
- AND includes ADDED, MODIFIED, REMOVED, and RENAMED sections

#### Scenario: Include spec format in init
- GIVEN the init skill generates specs during initialization
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/spec-format.md` for the format template
- AND does not duplicate the format inline

#### Scenario: Include spec format in spec
- GIVEN the spec skill displays format reference to users
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/spec-format.md` for the format and guidelines
- AND does not duplicate the format or guidelines inline

#### Scenario: Include delta format in plan
- GIVEN the plan skill creates delta specs
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/delta-format.md` for the delta format template
- AND does not duplicate the format inline

## MODIFIED Requirements

### Requirement: Initialize Repository
The system SHALL provide a `/ds:init` skill that creates the specs directory structure with protection against auto-invocation.

#### Scenario: First-time initialization
- GIVEN a repository without a specs directory
- WHEN the user runs `/ds:init`
- THEN the system creates `specs/`, `specs/.delta/`, and `specs/.delta/archive/`
- AND creates `specs/.delta-spec.json` with the current plugin version

#### Scenario: Optional spec generation
- GIVEN an initialized repository with existing code
- WHEN the user chooses to generate specs during init
- THEN the system explores the codebase and creates domain-based spec files
- AND uses the format defined in `_shared/spec-format.md`

#### Scenario: Idempotent initialization
- GIVEN a repository already initialized with delta-spec
- WHEN the user runs `/ds:init`
- THEN the system detects existing structure and asks before overwriting

#### Scenario: Destructive operation protection
- GIVEN ds-init can overwrite existing files
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `disable-model-invocation: true`

### Requirement: View Specifications
The system SHALL provide a `/ds:spec [domain|search]` skill to view, discuss, or search specs, with tool restrictions for read-only access, argument hints, and placeholder usage.

#### Scenario: List all specs
- GIVEN specs exist in the specs directory
- WHEN the user runs `/ds:spec` without arguments
- THEN the system lists all spec files (excluding .delta/)

#### Scenario: View specific domain
- GIVEN a domain spec exists
- WHEN the user runs `/ds:spec auth`
- THEN the system reads and discusses the auth specification

#### Scenario: Search by keyword
- GIVEN specs exist with requirements
- WHEN the user runs `/ds:spec "authentication"`
- THEN the system searches all spec files for matching requirements
- AND displays results grouped by spec file with requirement name and context

#### Scenario: Search vs domain detection
- GIVEN a search term that does not match any spec filename
- WHEN the user runs `/ds:spec <term>`
- THEN the system treats it as a search term

#### Scenario: Case insensitive search
- GIVEN a spec contains "Authentication" (capitalized)
- WHEN the user runs `/ds:spec "authentication"` (lowercase)
- THEN the system finds the match

#### Scenario: Read-only tool restrictions
- GIVEN ds-spec only reads and displays specs
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `allowed-tools: ["Read", "Glob", "Grep"]`

#### Scenario: Argument hint for domain or search parameter
- GIVEN ds-spec accepts a domain or search term argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[domain|search]"`

#### Scenario: Arguments placeholder documented
- GIVEN ds-spec accepts a domain or search argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the argument

#### Scenario: Shared spec format reference
- GIVEN ds-spec displays format information to users
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/spec-format.md` instead of inlining the format

### Requirement: Plan Change
The system SHALL provide a `/ds:plan [name]` skill that creates design documents and delta specs with argument hints and placeholder usage.

#### Scenario: Create design from proposal
- GIVEN a change with a completed proposal
- WHEN the user runs `/ds:plan`
- THEN the system explores the codebase for context
- AND creates `design.md` with technical approach
- AND generates delta specs in `specs/.delta/<name>/specs/`
- AND uses the format defined in `_shared/delta-format.md`

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

#### Scenario: Shared delta format reference
- GIVEN ds-plan creates delta specs
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/delta-format.md` instead of inlining the delta format
