# Delta: Skills

Changes for extract-cycle-detection.

## ADDED Requirements

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

## MODIFIED Requirements

### Requirement: Start New Change
The system SHALL provide a `/ds:new <name>` skill that creates a proposal for a new change, with cycle detection and resolution, with argument hints and placeholder usage.

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

### Requirement: Batch Feature Planning
The system SHALL provide a `/ds:batch` skill that creates multiple proposals from a single free-form description, with feature consolidation, dependency inference, and cycle detection and resolution.

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

### Requirement: Archive Change
The system SHALL provide a `/ds:archive [name]` skill that safely merges delta specs and archives the change, with cycle detection, with protection against auto-invocation, argument hints, and placeholder usage.

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

### Requirement: Show Status
The system SHALL provide a `/ds:status` skill that shows all active changes with conflicts, progress from task files, dependency visualization, and cycle warnings, with tool restrictions for read-only access.

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
