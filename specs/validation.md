---
generated: true
generated_at: 2026-02-03
---

# Validation Specification

## Purpose

Defines the validation rules for specification files, including format compliance checks and error reporting.

## Requirements

### Requirement: Main Spec Validation
The system SHALL validate main spec files for required structure.

#### Scenario: Purpose section check
- GIVEN a main spec file
- WHEN validated
- THEN warn if `## Purpose` section is missing

#### Scenario: Requirements section check
- GIVEN a main spec file
- WHEN validated
- THEN error if `## Requirements` section is missing

### Requirement: RFC 2119 Keyword Validation
The system SHALL validate that specs use RFC 2119 keywords.

#### Scenario: Keyword presence
- GIVEN a main spec file with requirements
- WHEN validated
- THEN warn if no RFC 2119 keywords (SHALL, MUST, SHOULD, MAY) are found

### Requirement: Scenario Validation
The system SHOULD validate that requirements have scenarios.

#### Scenario: Scenario presence
- GIVEN a requirement in a spec
- WHEN validated
- THEN warn if the requirement has no scenarios

### Requirement: Delta Spec Validation
The system SHALL validate delta spec files for operation structure.

#### Scenario: Operation section check
- GIVEN a delta spec file
- WHEN validated
- THEN error if no operation sections (ADDED, MODIFIED, REMOVED, RENAMED) are found

#### Scenario: Empty operation check
- GIVEN an ADDED or MODIFIED section
- WHEN validated
- THEN warn if the section contains no actual requirements

### Requirement: Validation Output
The system SHALL provide clear validation output with severity levels.

#### Scenario: Error reporting
- GIVEN validation errors found
- WHEN displaying results
- THEN show errors in red with ERROR prefix

#### Scenario: Warning reporting
- GIVEN validation warnings found
- WHEN displaying results
- THEN show warnings in yellow with WARNING prefix

#### Scenario: Pass reporting
- GIVEN validation passes
- WHEN displaying results
- THEN show success in green with PASS prefix

### Requirement: Validation Exit Codes
The system SHALL use exit codes to indicate validation result.

#### Scenario: Validation passed
- GIVEN no errors found
- WHEN validation completes
- THEN exit with code 0

#### Scenario: Validation failed
- GIVEN errors found
- WHEN validation completes
- THEN exit with code 1
