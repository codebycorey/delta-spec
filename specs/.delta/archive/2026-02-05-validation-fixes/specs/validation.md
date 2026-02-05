# Delta: Validation

Changes for validation-fixes.

## MODIFIED Requirements

### Requirement: Main Spec Validation
The system SHALL validate main spec files for required structure and uniqueness constraints.

#### Scenario: Purpose section check
- GIVEN a main spec file
- WHEN validated
- THEN warn if `## Purpose` section is missing

#### Scenario: Requirements section check
- GIVEN a main spec file
- WHEN validated
- THEN error if `## Requirements` section is missing

#### Scenario: Duplicate requirement names
- GIVEN a main spec file with multiple requirements
- WHEN validated
- THEN error if any requirement names are duplicated within the file
- AND list all duplicate names found

### Requirement: Delta Spec Validation
The system SHALL validate delta spec files for operation structure and main spec references.

#### Scenario: Operation section check
- GIVEN a delta spec file
- WHEN validated
- THEN error if no operation sections (ADDED, MODIFIED, REMOVED, RENAMED) are found

#### Scenario: Empty operation check
- GIVEN an ADDED or MODIFIED section
- WHEN validated
- THEN warn if the section contains no actual requirements

#### Scenario: Orphaned delta spec
- GIVEN a delta spec file
- WHEN validated
- THEN error if the corresponding main spec does not exist
- AND show the expected main spec path

## ADDED Requirements

### Requirement: Proposal Format Validation
The system SHALL validate proposal files for required structure.

#### Scenario: Required sections check
- GIVEN a proposal.md file
- WHEN validated
- THEN error if any required section is missing
- AND required sections are: Problem, Dependencies, Changes, Capabilities, Out of Scope, Success Criteria

#### Scenario: Incomplete proposal
- GIVEN a proposal missing required sections
- WHEN validation runs
- THEN list all missing sections
- AND exit with code 1

### Requirement: Design Format Validation
The system SHALL validate design files for required structure.

#### Scenario: Required sections check
- GIVEN a design.md file
- WHEN validated
- THEN error if any required section is missing
- AND required sections are: Context, Approach, Decisions, Files Affected, Risks

#### Scenario: Incomplete design
- GIVEN a design missing required sections
- WHEN validation runs
- THEN list all missing sections
- AND exit with code 1

### Requirement: Validation Script Robustness
The system SHALL run validation to completion under strict error handling.

#### Scenario: Counter increment under set -e
- GIVEN the validation script uses `set -e`
- WHEN incrementing error or warning counters from 0
- THEN the script continues execution
- AND does not exit prematurely due to falsy counter expressions

#### Scenario: Complete error reporting
- GIVEN multiple validation errors across different files
- WHEN validation runs
- THEN all errors are reported before exiting
- AND the summary shows the total count of errors and warnings
