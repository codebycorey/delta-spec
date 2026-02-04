# Delta: Commands

Changes for archive-safety.

## MODIFIED Requirements

### Requirement: Archive Change
The system SHALL provide a `/ds:archive [name]` command that safely merges delta specs and archives the change.

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
