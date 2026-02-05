# Delta: Skills

Changes for skill-namespace-cleanup.

## MODIFIED Requirements

### Requirement: Initialize Repository
The system SHALL provide a `/ds:init` skill that creates the specs directory structure.

#### Scenario: First-time initialization
- GIVEN a repository without a specs directory
- WHEN the user runs `/ds:init`
- THEN the system creates `specs/`, `specs/.delta/`, and `specs/.delta/archive/`
- AND creates `specs/.delta-spec.json` with the current plugin version

### Requirement: Start New Change
The system SHALL provide a `/ds:new <name>` skill that creates a proposal for a new change, with cycle detection and resolution.

#### Scenario: Create proposal
- GIVEN an initialized repository
- WHEN the user runs `/ds:new add-feature`
- THEN the system creates `specs/.delta/add-feature/proposal.md`
- AND works interactively with the user to define the problem and scope

#### Scenario: Cycle resolution in new
- GIVEN a cycle is detected during `/ds:new`
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
- AND runs `/ds:plan` for all affected changes in dependency order

### Requirement: Plan Change
The system SHALL provide a `/ds:plan [name]` skill that creates design documents and delta specs.

#### Scenario: Create design from proposal
- GIVEN a change with a completed proposal
- WHEN the user runs `/ds:plan`
- THEN the system explores the codebase for context
- AND creates `design.md` with technical approach
- AND generates delta specs in `specs/.delta/<name>/specs/`

### Requirement: Generate Tasks
The system SHALL provide a `/ds:tasks [name]` skill that creates a `tasks.md` file, supporting both single-change and multi-change modes, with cycle detection.

#### Scenario: Create task file
- GIVEN a change with design and delta specs
- WHEN the user runs `/ds:tasks`
- THEN the system creates `specs/.delta/<name>/tasks.md`
- AND each task has Status, Owner, Files, and Refs fields
- AND tasks are ordered by dependency

#### Scenario: Single change by name
- GIVEN multiple planned changes
- WHEN the user runs `/ds:tasks my-change`
- THEN the system creates `tasks.md` only for the named change

### Requirement: Archive Change
The system SHALL provide a `/ds:archive [name]` skill that safely merges delta specs and archives the change, with cycle detection.

#### Scenario: Merge and archive
- GIVEN a change with delta specs
- WHEN the user runs `/ds:archive`
- THEN the system validates all references first
- AND merges deltas into main specs
- AND moves the change to `specs/.delta/archive/YYYY-MM-DD-<name>/`

### Requirement: Drop Change
The system SHALL provide a `/ds:drop [name]` skill that abandons a change.

#### Scenario: Permanent deletion
- GIVEN an active change
- WHEN the user runs `/ds:drop`
- THEN the system permanently deletes `specs/.delta/<name>/`
- AND the change is NOT archived

### Requirement: Show Status
The system SHALL provide a `/ds:status` skill that shows all active changes with conflicts, progress from task files, dependency visualization, and cycle warnings.

#### Scenario: List changes with status
- GIVEN active changes in specs/.delta/
- WHEN the user runs `/ds:status`
- THEN the system lists each change with artifacts, dependencies, and next steps

### Requirement: View Specifications
The system SHALL provide a `/ds:spec [domain|search]` skill to view, discuss, or search specs.

#### Scenario: List all specs
- GIVEN specs exist in the specs directory
- WHEN the user runs `/ds:spec` without arguments
- THEN the system lists all spec files (excluding .delta/)

### Requirement: Quick Start Change
The system SHALL provide a `/ds:quick [name] ["description"]` skill that creates a complete change setup (proposal, design, and tasks) with minimal interaction.

#### Scenario: With arguments
- GIVEN an initialized repository
- WHEN the user runs `/ds:quick my-feature "Add support for X"`
- THEN the system creates `specs/.delta/my-feature/proposal.md` from the arguments
- AND shows the proposal to the user
- AND asks "Proceed? [y/N]"

#### Scenario: After confirmation
- GIVEN the user confirms the proposal with "y"
- WHEN proceeding with the workflow
- THEN the system explores the codebase (as in `/ds:plan`)
- AND creates `design.md` without prompting
- AND creates delta specs in `specs/` without prompting
- AND creates `tasks.md` without prompting
- AND outputs a summary of all created artifacts

### Requirement: Batch Feature Planning
The system SHALL provide a `/ds:batch` skill that creates multiple proposals from a single free-form description, with cycle detection and resolution.

#### Scenario: Prompt for features
- GIVEN an initialized repository
- WHEN the user runs `/ds:batch`
- THEN the system prompts "Describe the features you want to plan:"

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
- AND runs `/ds:plan` for all affected changes in dependency order

#### Scenario: Batch planning offer
- GIVEN all proposals have been created
- WHEN the batch is complete
- THEN the system asks "Run /ds:plan for all? [y/N]"

#### Scenario: Single feature input
- GIVEN the user describes only one feature
- WHEN parsing features
- THEN the system suggests using `/ds:quick` or `/ds:new` instead
- AND offers to proceed anyway if the user wants

## ADDED Requirements

### Requirement: Skill Directory Structure
The system SHALL organize skills in plain-named directories without namespace prefix.

#### Scenario: Directory naming convention
- GIVEN the plugin namespace is `ds`
- WHEN organizing skill directories
- THEN each skill directory uses a plain name (e.g., `skills/init/`, `skills/new/`)
- AND does NOT include the namespace prefix in the directory name

#### Scenario: Skill discovery
- GIVEN skill directories follow the plain naming convention
- WHEN Claude Code discovers skills
- THEN skills appear with the plugin namespace (e.g., `/ds:init`, `/ds:new`)

### Requirement: SKILL.md Frontmatter Constraints
The system SHALL NOT include a `name` field in SKILL.md frontmatter.

#### Scenario: Infer skill name from directory
- GIVEN a skill in directory `skills/init/`
- WHEN Claude Code loads the skill
- THEN the skill name is inferred from the directory name
- AND the plugin namespace is applied (resulting in `/ds:init`)

#### Scenario: Required frontmatter fields
- GIVEN a SKILL.md file
- WHEN defining frontmatter
- THEN the file MUST include `description`
- AND MAY include optional fields: `license`, `argument-hint`, `disable-model-invocation`, `user-invocable`, `allowed-tools`, `model`
- AND MUST NOT include a `name` field

### Requirement: Canonical Skill Invocation Format
The system SHALL use `/ds:*` (colon notation) as the canonical skill invocation format in all documentation and cross-references.

#### Scenario: Documentation references
- GIVEN documentation files (README.md, CLAUDE.md)
- WHEN referencing skills
- THEN use the format `/ds:init`, `/ds:new`, etc.
- AND NOT the hyphenated format `/ds-init`, `/ds-new`

#### Scenario: Cross-references in SKILL.md
- GIVEN a SKILL.md file references another skill
- WHEN writing the reference
- THEN use the colon format `/ds:plan`, `/ds:archive`, etc.

#### Scenario: Spec requirement titles
- GIVEN requirement titles in specs/skills.md
- WHEN naming requirements about specific skills
- THEN use the colon format in the title (e.g., "Initialize Repository" for `/ds:init`)
- AND reference the skill with colon notation in the requirement text
