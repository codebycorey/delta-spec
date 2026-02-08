# Skills Specification

## Purpose

Defines the skills that provide the user interface for delta-spec. Each skill follows consistent patterns for version checking, change inference, and dependency management.

## Requirements

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

#### Scenario: Non-duplicate opening line in init
- GIVEN the init skill opening line duplicates the description verbatim
- WHEN the skill SKILL.md is defined
- THEN the opening line adds value beyond the description
- AND does not repeat the description text

#### Scenario: Skill content describes intent not tools
- GIVEN the init skill asks the user a question
- WHEN the skill SKILL.md is defined
- THEN the skill uses intent-based language ("Ask the user")
- AND does not reference specific tool names like `AskUserQuestion`

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

#### Scenario: Create proposal
- GIVEN an initialized repository
- WHEN the user runs `/ds:new add-feature`
- THEN the system creates `specs/.delta/add-feature/proposal.md`
- AND works interactively with the user to define the problem and scope

#### Scenario: Reopen existing proposal
- GIVEN a change with an existing proposal
- WHEN the user runs `/ds:new add-feature`
- THEN the system reopens the proposal for refinement

#### Scenario: Cycle detection on dependency declaration
- GIVEN the user declares dependencies that create a cycle with existing changes
- WHEN validating the dependency graph
- THEN the system detects the cycle using the shared cycle detection procedure
- AND follows the full resolution flow from `_shared/cycle-detection.md`

#### Scenario: Cycle resolution in new
- GIVEN a cycle is detected during `/ds:new`
- WHEN prompting the user
- THEN the system follows the full resolution flow from `_shared/cycle-detection.md`
- AND shows the cycle, suggests extraction, and lists affected artifacts

#### Scenario: Cycle resolution accepted in new
- GIVEN the user confirms cycle resolution with "y"
- WHEN resolving the cycle
- THEN the system follows the confirm behavior from `_shared/cycle-detection.md`

#### Scenario: Cycle resolution declined in new
- GIVEN the user declines cycle resolution
- WHEN resolution is declined
- THEN the system follows the decline behavior from `_shared/cycle-detection.md`

#### Scenario: Shared cycle detection reference in new
- GIVEN the new skill needs cycle detection
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/cycle-detection.md` instead of inlining the algorithm
- AND includes a brief context note about when cycle detection runs (after Dependencies section)

#### Scenario: Argument hint for name parameter
- GIVEN ds-new requires a name argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "<name>"`

#### Scenario: Arguments placeholder documented
- GIVEN ds-new accepts a name argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the name

#### Scenario: Description with trigger phrases
- GIVEN ds-new is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "start a change", "create a proposal", "plan a feature"

#### Scenario: Consistent step headings in new
- GIVEN the new skill uses mixed heading styles
- WHEN the skill SKILL.md is defined
- THEN all major steps use `## Step N: <title>` heading format
- AND numbered list items are converted to step headings

#### Scenario: No redundant behavior section
- GIVEN the new skill documents behavior in its steps
- WHEN the skill SKILL.md is defined
- THEN there is no separate "Behavior" section that duplicates step content

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

#### Scenario: Shared change resolution reference
- GIVEN ds-plan determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md` instead of inlining the logic

#### Scenario: Description with trigger phrases
- GIVEN ds-plan is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "plan this change", "create a design", "explore implementation"

#### Scenario: Integer step numbering in plan
- GIVEN the plan skill uses "Step 2b" for dependency notes
- WHEN the skill SKILL.md is defined
- THEN all steps use sequential integer numbering (0, 1, 2, 3, 4, 5, 6, 7)
- AND no sub-step numbering like 2b is used at the top level

### Requirement: Generate Tasks
The system SHALL provide a `/ds:tasks [name]` skill that creates a `tasks.md` file, supporting both single-change and multi-change modes, with cycle detection, with argument hints and placeholder usage.

#### Scenario: Create task file
- GIVEN a change with design and delta specs
- WHEN the user runs `/ds:tasks`
- THEN the system creates `specs/.delta/<name>/tasks.md`
- AND each task has Status, Owner, Files, and Refs fields
- AND tasks are ordered by dependency

#### Scenario: Test task generation
- GIVEN a project with test infrastructure (test directories, test configs, existing tests)
- WHEN the user runs `/ds:tasks`
- THEN the system includes tasks for testing new or modified behavior
- AND test tasks reference the appropriate test files and patterns

#### Scenario: No test infrastructure
- GIVEN a project without test infrastructure
- WHEN the user runs `/ds:tasks`
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
- WHEN the user runs `/ds:tasks my-change`
- THEN the system creates `tasks.md` only for the named change

#### Scenario: All changes mode
- GIVEN multiple changes with design and delta specs
- WHEN the user runs `/ds:tasks` without a name
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
- AND suggests running `/ds:new` or `/ds:batch` to resolve
- AND does not proceed until cycle is resolved

#### Scenario: Argument hint for optional name parameter
- GIVEN ds-tasks accepts an optional name argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[name]"`

#### Scenario: Arguments placeholder documented
- GIVEN ds-tasks accepts a name argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the name

#### Scenario: Shared change resolution reference
- GIVEN ds-tasks determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md` for argument handling
- AND documents multi-change mode variant inline

#### Scenario: Description with trigger phrases
- GIVEN ds-tasks is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "create tasks", "generate implementation steps", "what needs to be done"

### Requirement: Archive Change
The system SHALL provide a `/ds:archive [name]` skill that safely merges delta specs and archives the change, with cycle detection, with protection against auto-invocation, argument hints, and placeholder usage.

#### Scenario: Merge and archive
- GIVEN a change with delta specs
- WHEN the user runs `/ds:archive`
- THEN the system validates all references first
- AND merges deltas into main specs
- AND moves the change to `specs/.delta/archive/YYYY-MM-DD-<name>/`

#### Scenario: Show diff before writing
- GIVEN delta specs to merge
- WHEN archiving a change
- THEN the system shows the diff before writing to main specs

#### Scenario: Pre-validation of references
- GIVEN a delta spec with MODIFIED or REMOVED operations
- WHEN the user runs `/ds:archive`
- THEN the system verifies all referenced requirements exist in main specs
- AND stops with an error if any reference is invalid
- AND no files are modified if validation fails

#### Scenario: Pre-validation of additions
- GIVEN a delta spec with ADDED operations
- WHEN the user runs `/ds:archive`
- THEN the system verifies no added requirements already exist
- AND stops with an error if a duplicate would be created

#### Scenario: Conflict check
- GIVEN another active change also modifies the same requirement
- WHEN the user runs `/ds:archive`
- THEN the system warns about the conflict
- AND asks to proceed or resolve conflicts first

#### Scenario: Cycle detection in archive
- GIVEN active changes with circular dependencies including this change
- WHEN the user runs `/ds:archive`
- THEN the system detects the cycle using the shared cycle detection procedure
- AND follows the warn-only flow from `_shared/cycle-detection.md`
- AND offers the archive-specific override option

#### Scenario: Shared cycle detection reference in archive
- GIVEN the archive skill needs cycle detection
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/cycle-detection.md` instead of inlining the algorithm
- AND includes a brief context note about archive-specific override behavior

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

#### Scenario: Destructive operation protection
- GIVEN ds-archive permanently merges specs
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `disable-model-invocation: true`

#### Scenario: Argument hint for optional name parameter
- GIVEN ds-archive accepts an optional name argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[name]"`

#### Scenario: Arguments placeholder documented
- GIVEN ds-archive accepts a name argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the name

#### Scenario: Shared change resolution reference
- GIVEN ds-archive determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md` instead of inlining the logic

#### Scenario: Sequential step numbering in archive
- GIVEN the archive skill uses non-sequential step numbers (2.1, 2.5, 2.6)
- WHEN the skill SKILL.md is defined
- THEN all steps are numbered sequentially (1, 2, 3, 4, 5, 6, 7)
- AND no sub-step numbering like 2.1 or 2.5 is used at the top level

#### Scenario: No redundant merge documentation
- GIVEN the archive skill documents the merge algorithm
- WHEN the skill SKILL.md is defined
- THEN the merge rules (operation order, validation) are documented once
- AND there is no separate "Delta Rules" section duplicating the merge algorithm

#### Scenario: Description with trigger phrases
- GIVEN ds-archive has disable-model-invocation but descriptions serve human readers
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "done implementing", "finalize change", "merge specs"

### Requirement: Drop Change
The system SHALL provide a `/ds:drop [name]` skill that abandons a change with protection against auto-invocation, argument hints, and placeholder usage.

#### Scenario: Permanent deletion
- GIVEN an active change
- WHEN the user runs `/ds:drop`
- THEN the system permanently deletes `specs/.delta/<name>/`
- AND the change is NOT archived

#### Scenario: Dependent cleanup
- GIVEN a change that other changes depend on
- WHEN the user runs `/ds:drop`
- THEN the system offers to clean references from dependent changes
- OR cascade delete all dependents

#### Scenario: Destructive operation protection
- GIVEN ds-drop permanently deletes change directories
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `disable-model-invocation: true`

#### Scenario: Argument hint for optional name parameter
- GIVEN ds-drop accepts an optional name argument
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[name]"`

#### Scenario: Arguments placeholder documented
- GIVEN ds-drop accepts a name argument
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the name

#### Scenario: Shared change resolution reference
- GIVEN ds-drop determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md` instead of inlining the logic
- AND notes that confirmation is required even with a single change

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

### Requirement: Show Status
The system SHALL provide a `/ds:status` skill that shows all active changes with conflicts, progress from task files, dependency visualization, and cycle warnings, with tool restrictions for read-only access.

#### Scenario: List changes with status
- GIVEN active changes in specs/.delta/
- WHEN the user runs `/ds:status`
- THEN the system lists each change with artifacts, dependencies, and next steps

#### Scenario: Version mismatch warning
- GIVEN a version mismatch between project and plugin
- WHEN the user runs `/ds:status`
- THEN the system shows a warning about the mismatch

#### Scenario: Conflict detection
- GIVEN two active changes both MODIFY the same requirement
- WHEN the user runs `/ds:status`
- THEN the system displays a conflict warning showing which changes overlap

#### Scenario: No conflicts
- GIVEN active changes with no overlapping requirement modifications
- WHEN the user runs `/ds:status`
- THEN the system does not display conflict warnings

#### Scenario: Progress from task file
- GIVEN a change has `tasks.md` file
- WHEN the user runs `/ds:status`
- THEN the system reads task statuses from the file
- AND shows completion progress (e.g., "2/5 done")

#### Scenario: No task file
- GIVEN a change has no `tasks.md` file
- WHEN the user runs `/ds:status`
- THEN the system shows "No tasks" or suggests running `/ds:tasks`

#### Scenario: Dependency graph
- GIVEN multiple active changes with dependencies
- WHEN the user runs `/ds:status`
- THEN the system displays an ASCII dependency tree showing relationships

#### Scenario: Independent changes in graph
- GIVEN changes with no dependencies
- WHEN displaying the dependency graph
- THEN independent changes are shown as separate roots

#### Scenario: Cycle detection in status
- GIVEN active changes with circular dependencies
- WHEN the user runs `/ds:status`
- THEN the system detects the cycle using the shared cycle detection procedure
- AND follows the warn-only flow from `_shared/cycle-detection.md`

#### Scenario: Shared cycle detection reference in status
- GIVEN the status skill needs cycle detection
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/cycle-detection.md` instead of inlining the algorithm
- AND includes a brief context note about display-only behavior

#### Scenario: Read-only tool restrictions
- GIVEN ds-status only reads change state
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `allowed-tools: ["Read", "Glob"]`

#### Scenario: Description with trigger phrases
- GIVEN ds-status is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "what's the status", "show active changes", "what are we working on"

#### Scenario: Consistent step headings in status
- GIVEN the status skill uses mixed heading styles
- WHEN the skill SKILL.md is defined
- THEN all major steps use `## Step N: <title>` heading format
- AND numbered list items under `## Steps` are converted to step headings or content under step headings

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

#### Scenario: Description with trigger phrases
- GIVEN ds-spec is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "show specs", "search specs", "what does the spec say"

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

### Requirement: Quick Start Change
The system SHALL provide a `/ds:quick [name] ["description"]` skill that creates a complete change setup (proposal, design, and tasks) with minimal interaction, with argument hints and placeholder usage.

#### Scenario: With arguments
- GIVEN an initialized repository
- WHEN the user runs `/ds:quick my-feature "Add support for X"`
- THEN the system creates `specs/.delta/my-feature/proposal.md` from the arguments
- AND shows the proposal to the user
- AND asks "Proceed? [y/N]"

#### Scenario: Without arguments (context inference)
- GIVEN an initialized repository and prior conversation context
- WHEN the user runs `/ds:quick`
- THEN the system infers the change name and description from conversation
- AND creates and shows the proposal
- AND asks "Proceed? [y/N]"

#### Scenario: After confirmation
- GIVEN the user confirms the proposal with "y"
- WHEN proceeding with the workflow
- THEN the system explores the codebase (as in `/ds:plan`)
- AND creates `design.md` without prompting
- AND creates delta specs in `specs/` without prompting
- AND creates `tasks.md` without prompting
- AND outputs a summary of all created artifacts

#### Scenario: Proposal rejected
- GIVEN the user rejects the proposal with "n" or empty input
- WHEN the confirmation is rejected
- THEN the system stops without creating design or tasks
- AND the proposal remains for manual editing via `/ds:new`

#### Scenario: Change already exists
- GIVEN a change with the same name already exists
- WHEN the user runs `/ds:quick my-feature "..."`
- THEN the system warns about the existing change
- AND asks whether to continue with that change or pick a different name

#### Scenario: Argument hint for optional parameters
- GIVEN ds-quick accepts optional name and description arguments
- WHEN the skill SKILL.md is defined
- THEN the frontmatter includes `argument-hint: "[name] [\"description\"]"`

#### Scenario: Arguments placeholder documented
- GIVEN ds-quick accepts name and description arguments
- WHEN the skill SKILL.md is defined
- THEN the skill body documents using `$ARGUMENTS` to reference the arguments

#### Scenario: Description with trigger phrases
- GIVEN ds-quick is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "quick start", "fast-track this change", "set it all up"

#### Scenario: Imperative writing style in quick
- GIVEN the quick skill uses second-person writing ("you know what you want", "make sure it captures your intent")
- WHEN the skill SKILL.md is defined
- THEN all content uses imperative or third-person form
- AND no second-person pronouns ("you", "your") appear in the skill body

#### Scenario: Consolidated no-prompt instructions
- GIVEN Steps 5 and 6 both run without interaction
- WHEN the skill SKILL.md is defined
- THEN a single note covers both steps ("Steps 5-6 run without prompts")
- AND the note is not duplicated in each step

### Requirement: Batch Feature Planning
The system SHALL provide a `/ds:batch` skill that creates multiple proposals from a single free-form description, with feature consolidation, dependency inference, and cycle detection and resolution.

#### Scenario: Step order with consolidation
- GIVEN the batch workflow includes consolidation
- WHEN executing `/ds:batch`
- THEN the system follows this order:
  1. Step 0: Version check
  2. Step 1: Prompt for features
  3. Step 2: Parse and extract features
  4. Step 2.5: Consolidate overlapping features (if overlaps found)
  5. Step 3: Infer dependencies
  6. Step 3.5: Detect and resolve cycles (if cycles found)
  7. Step 4: Display dependency graph
  8. Step 5: Confirm and create proposals
  9. Step 6: Offer batch planning

#### Scenario: Prompt for features
- GIVEN an initialized repository
- WHEN the user runs `/ds:batch`
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
- GIVEN inferred dependencies form a cycle (A -> B -> C -> A)
- WHEN validating the dependency graph
- THEN the system detects the cycle using the shared cycle detection procedure
- AND follows the full resolution flow from `_shared/cycle-detection.md`

#### Scenario: Cycle analysis
- GIVEN a cycle is detected
- WHEN analyzing the cycle
- THEN the system follows the analysis procedure from `_shared/cycle-detection.md`

#### Scenario: Cycle resolution offer
- GIVEN a cycle is detected with a suggested extraction
- WHEN prompting the user
- THEN the system follows the full resolution flow from `_shared/cycle-detection.md`

#### Scenario: Cycle resolution accepted
- GIVEN the user confirms cycle resolution with "y"
- WHEN resolving the cycle
- THEN the system follows the confirm behavior from `_shared/cycle-detection.md`

#### Scenario: Cycle resolution declined
- GIVEN the user declines cycle resolution with "n" or empty input
- WHEN resolution is declined
- THEN the system follows the decline behavior from `_shared/cycle-detection.md`

#### Scenario: Shared cycle detection reference in batch
- GIVEN the batch skill needs cycle detection
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/cycle-detection.md` instead of inlining the algorithm
- AND includes a brief context note about consolidation happening before cycle detection

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
- THEN the system asks "Run /ds:plan for all? [y/N]"

#### Scenario: Accept batch planning
- GIVEN the user confirms batch planning with "y"
- WHEN running batch planning
- THEN the system runs the planning phase for each feature in dependency order
- AND shows progress as each feature is planned

#### Scenario: Decline batch planning
- GIVEN the user declines with "n" or empty input
- WHEN batch planning is declined
- THEN the system stops
- AND tells the user they can run `/ds:plan` individually later

#### Scenario: Empty input
- GIVEN the user provides empty or whitespace-only input
- WHEN parsing features
- THEN the system asks for features again or exits gracefully

#### Scenario: Single feature input
- GIVEN the user describes only one feature
- WHEN parsing features
- THEN the system suggests using `/ds:new` or `/ds:quick` instead
- AND offers to proceed anyway if the user wants

#### Scenario: Example sessions as reference
- GIVEN the batch skill includes example sessions
- WHEN the skill SKILL.md is defined
- THEN example sessions are stored in `examples/batch-session.md`
- AND the main SKILL.md references the examples file
- AND examples include both basic workflow and consolidation detected scenarios

#### Scenario: Skill word count within guidelines
- GIVEN the batch SKILL.md was ~2,500 words
- WHEN consolidation detail and examples are extracted
- THEN the main SKILL.md is ~1,300 words
- AND well within the 3,000-word guideline

#### Scenario: Description with trigger phrases
- GIVEN ds-batch is model-invocable
- WHEN the skill SKILL.md is defined
- THEN the description includes what the skill does and trigger context
- AND mentions triggers like "plan multiple features", "batch create proposals", "several features to plan"

#### Scenario: Edge case cross-references steps
- GIVEN the Circular Dependencies edge case describes behavior handled by Step 3.5
- WHEN the skill SKILL.md is defined
- THEN the edge case uses a cross-reference to Step 3.5 rather than re-summarizing the behavior

### Requirement: Consolidate overlapping features in batch
The system SHALL detect and suggest consolidation of overlapping features during `/ds:batch` before dependency inference.

#### Scenario: Progressive disclosure for consolidation
- GIVEN the consolidation algorithm is detailed (~130 lines)
- WHEN the batch skill SKILL.md is defined
- THEN the main SKILL.md contains a brief summary of Step 2.5 (3-4 lines)
- AND references `references/consolidation.md` for the full algorithm
- AND the reference file contains the complete overlap detection, grouping, prompting, merging, and edge case logic

#### Scenario: Detect file overlap
- GIVEN multiple parsed features mention the same file path
- WHEN analyzing for overlap signals
- THEN the system identifies this as a strong signal for consolidation
- AND follows the full procedure in `references/consolidation.md`

#### Scenario: Detect keyword overlap
- GIVEN two features share 3 or more domain-specific terms
- WHEN analyzing for overlap signals
- THEN the system identifies this as a strong signal for consolidation
- AND suggests grouping those features

#### Scenario: Detect sequential phrasing
- GIVEN a feature description contains "then", "after that", "also", or "additionally"
- WHEN analyzing for overlap signals
- THEN the system treats this as a signal that it may extend the previous feature
- AND suggests grouping with the previous feature if other signals present

#### Scenario: Detect domain synonyms
- GIVEN features use synonyms for the same domain (e.g., "auth"/"authentication"/"login")
- WHEN analyzing for overlap signals
- THEN the system identifies this as a medium signal for consolidation
- AND may suggest grouping if combined with other signals

#### Scenario: Conservative grouping threshold
- GIVEN overlap signals are detected between features
- WHEN deciding whether to suggest consolidation
- THEN the system follows the threshold rules in `references/consolidation.md`

#### Scenario: Display consolidation suggestions
- GIVEN overlapping features are detected
- WHEN presenting suggestions to the user
- THEN the system shows each group with:
  - Feature names to be merged
  - Specific overlap signals detected
  - Suggested merged name
- AND lists remaining features with no overlaps

#### Scenario: Consolidation prompt format
- GIVEN consolidation suggestions are displayed
- WHEN prompting for confirmation
- THEN the system asks "Accept suggested groupings? [y/N/c]"
- AND explains: "y" applies all, "N" keeps separate, "c" chooses per-group

#### Scenario: Accept all consolidations
- GIVEN the user responds "y" to the consolidation prompt
- WHEN applying consolidations
- THEN the system merges all suggested groups
- AND uses the first feature's name in each group as the base name
- AND combines descriptions preserving unique details
- AND proceeds to dependency inference with the consolidated list

#### Scenario: Reject all consolidations
- GIVEN the user responds "N" or empty input to the consolidation prompt
- WHEN handling rejection
- THEN the system keeps all features separate
- AND proceeds to dependency inference with the original parsed list

#### Scenario: Choose per-group consolidation
- GIVEN the user responds "c" to the consolidation prompt
- WHEN presenting individual groups
- THEN the system asks "Group N (...): Merge? [y/N]" for each group
- AND applies consolidation only for groups the user confirms with "y"
- AND keeps other features separate

#### Scenario: Merge feature descriptions
- GIVEN two features are consolidated
- WHEN creating the merged feature
- THEN the system combines descriptions intelligently
- AND removes redundant phrases
- AND preserves unique details from both original descriptions

#### Scenario: No overlaps detected
- GIVEN parsed features have no overlap signals
- WHEN checking for consolidation
- THEN the system skips Step 2.5 entirely
- AND proceeds directly from Step 2 (parsing) to Step 3 (dependency inference)

#### Scenario: Consolidation before dependency inference
- GIVEN consolidation suggestions are confirmed
- WHEN the workflow continues
- THEN dependency inference (Step 3) works on the consolidated feature list
- AND dependency keywords reference the merged feature names

#### Scenario: Consolidation may eliminate cycles
- GIVEN features A and B depend on each other
- WHEN consolidation merges A and B into a single feature
- THEN the cycle is eliminated
- AND cycle detection (Step 3.5) operates on the consolidated graph

#### Scenario: Display signals in suggestions
- GIVEN a consolidation suggestion is shown
- WHEN displaying the group
- THEN the system lists specific signals detected
- AND shows example evidence (e.g., "both mention 'auth.ts'", "shared terms: authentication, JWT, user")

#### Scenario: Normalize file paths for comparison
- GIVEN features mention file paths with varying formats
- WHEN comparing paths for overlap
- THEN the system normalizes paths (removes leading `./`, trailing `/`)
- AND treats `auth.ts`, `./auth.ts`, and `src/auth.ts` as potential overlaps

#### Scenario: Stop word filtering in keyword analysis
- GIVEN feature descriptions contain common words like "the", "a", "and"
- WHEN extracting keywords for overlap analysis
- THEN the system filters out stop words
- AND focuses on domain-specific terms (nouns, technical terms)

#### Scenario: Consolidation step numbering
- GIVEN Step 2.5 is added to the workflow
- WHEN documenting the skill
- THEN existing steps remain numbered: 0, 1, 2, 3, 3.5, 4, 5, 6
- AND the new step is inserted as Step 2.5 (between 2 and 3)
- AND all references to subsequent steps remain unchanged

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

#### Scenario: Consistent heading in shared file
- GIVEN the shared version check file is referenced by multiple skills
- WHEN organizing skill structure
- THEN `skills/_shared/version-check.md` has a heading consistent with other shared files

### Requirement: Shared Cycle Detection
The system SHALL extract cycle detection logic to a shared file to eliminate duplication across skills.

#### Scenario: Create shared cycle detection file
- GIVEN cycle detection logic is duplicated across multiple skills
- WHEN organizing skill structure
- THEN a `skills/_shared/cycle-detection.md` file contains the canonical procedure
- AND the procedure includes DFS algorithm, description analysis, and resolution prompts

#### Scenario: Core algorithm section
- GIVEN the shared cycle detection file
- WHEN defining the core algorithm
- THEN the file documents DFS with path tracking
- AND returns the cycle path when a cycle is found

#### Scenario: Analysis and extraction section
- GIVEN the shared cycle detection file
- WHEN defining the analysis procedure
- THEN the file documents description tokenization and common concept extraction
- AND documents base change name suggestion from common terms

#### Scenario: Full resolution flow section
- GIVEN the shared cycle detection file
- WHEN defining the full resolution flow (used by new, batch)
- THEN the file documents the extraction prompt format
- AND documents confirm behavior (create base, update deps, clean artifacts)
- AND documents decline behavior (ask user which dep to remove)

#### Scenario: Warn-only resolution section
- GIVEN the shared cycle detection file
- WHEN defining the warn-only flow (used by archive, status)
- THEN the file documents the warning display format
- AND documents suggesting `/ds:new` or `/ds:batch` to resolve

#### Scenario: Archive-specific override option
- GIVEN the shared cycle detection file
- WHEN defining archive-specific behavior
- THEN the file documents the "proceed anyway?" option
- AND notes that archiving may break the cycle

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

### Requirement: Shared Change Resolution
The system SHALL extract the "determine which change" logic to a shared file to eliminate duplication across skills.

#### Scenario: Create shared change resolution file
- GIVEN change resolution logic is duplicated across multiple skills
- WHEN organizing skill structure
- THEN a `skills/_shared/determine-change.md` file contains the standard procedure
- AND the procedure covers: argument provided, conversation inference, single change, multiple changes, no changes

#### Scenario: Standard resolution flow
- GIVEN the shared change resolution file
- WHEN defining the standard flow
- THEN step 1 checks if name is provided in arguments
- AND step 2 checks if inferable from conversation context
- AND step 3 uses the single active change if only one exists
- AND step 4 asks user to pick if multiple changes exist
- AND step 5 suggests a prerequisite if no changes exist

#### Scenario: Parameterized behavior
- GIVEN skills have slightly different resolution behavior
- WHEN defining the shared procedure
- THEN the file documents context-specific variations as notes
- AND includes: prerequisite suggestion varies by skill
- AND includes: drop confirms even with single change
- AND includes: tasks uses multi-change mode instead of asking

#### Scenario: Include in plan
- GIVEN the plan skill determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md`
- AND notes prerequisite is `/ds:new`

#### Scenario: Include in archive
- GIVEN the archive skill determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md`
- AND notes "nothing to archive" when no changes exist

#### Scenario: Include in drop
- GIVEN the drop skill determines which change to operate on
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md`
- AND notes confirmation is required even for single change

#### Scenario: Include in tasks with variant
- GIVEN the tasks skill has a multi-change mode
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/determine-change.md` for argument handling
- AND documents the multi-change variant inline (processing all planned changes)

#### Scenario: Quick skill noted in context
- GIVEN the quick skill creates new changes rather than operating on existing ones
- WHEN the shared determine-change file lists context-specific notes
- THEN it includes a note that quick does not use this procedure

#### Scenario: Adopt skill noted in context
- GIVEN the adopt skill creates new changes from conversation context
- WHEN the shared determine-change file lists context-specific notes
- THEN it includes a note that adopt does not use this procedure

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

#### Scenario: Include proposal template in adopt
- GIVEN the adopt skill creates proposals
- WHEN the skill SKILL.md is defined
- THEN the skill references `_shared/proposal-template.md` instead of inlining the template
