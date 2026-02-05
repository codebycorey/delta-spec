# Spec Format Specification

## Purpose

Defines the format and structure of specification files, including main specs and delta specs. Ensures consistency and enables reliable parsing for merge operations.

## Requirements

### Requirement: Main Spec Structure
The system SHALL use a consistent structure for main specification files.

#### Scenario: Required sections
- GIVEN a main spec file
- WHEN validated
- THEN it MUST contain a `## Purpose` section
- AND it MUST contain a `## Requirements` section

#### Scenario: Domain organization
- GIVEN specifications for a system
- WHEN organizing spec files
- THEN each file covers one bounded context (e.g., auth.md, payments.md)

### Requirement: Requirement Format
The system SHALL use a consistent format for requirements.

#### Scenario: Requirement structure
- GIVEN a requirement is documented
- WHEN writing the requirement
- THEN it follows the format: `### Requirement: <Name>`
- AND the body uses RFC 2119 keywords (SHALL, MUST, SHOULD, MAY)

#### Scenario: Unique naming
- GIVEN requirements within a domain
- WHEN naming requirements
- THEN each name MUST be unique within that domain

### Requirement: RFC 2119 Keywords
The system SHALL use RFC 2119 keywords to indicate requirement levels.

#### Scenario: Required behavior
- GIVEN a behavior that is mandatory
- WHEN documenting the requirement
- THEN use SHALL or MUST

#### Scenario: Recommended behavior
- GIVEN a behavior that is recommended but not mandatory
- WHEN documenting the requirement
- THEN use SHOULD

#### Scenario: Optional behavior
- GIVEN a behavior that is optional
- WHEN documenting the requirement
- THEN use MAY

### Requirement: Scenario Format
The system SHALL use Given/When/Then format for scenarios.

#### Scenario: Scenario structure
- GIVEN a scenario is documented
- WHEN writing the scenario
- THEN it follows the format: `#### Scenario: <Name>`
- AND includes GIVEN, WHEN, and THEN clauses

#### Scenario: Testable outcomes
- GIVEN a scenario is written
- WHEN reviewing the THEN clause
- THEN the outcome MUST be verifiable

### Requirement: Delta Spec Structure
The system SHALL use operation sections for delta specs.

#### Scenario: Operation sections
- GIVEN a delta spec
- WHEN documenting changes
- THEN use sections: `## ADDED Requirements`, `## MODIFIED Requirements`, `## REMOVED Requirements`, `## RENAMED Requirements`

#### Scenario: At least one operation
- GIVEN a delta spec file
- WHEN validated
- THEN it MUST contain at least one operation section

### Requirement: ADDED Operation
The system SHALL append new requirements with the ADDED operation.

#### Scenario: Add new requirement
- GIVEN a new requirement to add
- WHEN using ADDED
- THEN the requirement is appended to the Requirements section

#### Scenario: Duplicate prevention
- GIVEN an ADDED requirement
- WHEN the name already exists in main spec
- THEN the merge MUST fail with an error

### Requirement: MODIFIED Operation
The system SHALL replace existing requirements with the MODIFIED operation.

#### Scenario: Modify existing requirement
- GIVEN an existing requirement to change
- WHEN using MODIFIED
- THEN the entire requirement block is replaced

#### Scenario: Missing requirement
- GIVEN a MODIFIED requirement
- WHEN the name does not exist in main spec
- THEN the merge MUST fail with an error

### Requirement: REMOVED Operation
The system SHALL delete requirements with the REMOVED operation.

#### Scenario: Remove requirement
- GIVEN a requirement to remove
- WHEN using REMOVED
- THEN document with `### Requirement: <Name>` plus `**Reason:**` and `**Migration:**`

#### Scenario: Missing requirement
- GIVEN a REMOVED requirement
- WHEN the name does not exist in main spec
- THEN the merge MUST fail with an error

### Requirement: RENAMED Operation
The system SHALL update requirement names with the RENAMED operation.

#### Scenario: Rename requirement
- GIVEN a requirement to rename
- WHEN using RENAMED
- THEN use format: `- FROM: \`Old Name\`` and `- TO: \`New Name\``

### Requirement: Merge Order
The system SHALL apply delta operations in strict order.

#### Scenario: Operation order
- GIVEN a delta spec with multiple operations
- WHEN merging into main spec
- THEN apply in order: RENAMED, REMOVED, MODIFIED, ADDED

#### Scenario: Order rationale
- GIVEN the merge order
- WHEN RENAMED runs first
- THEN subsequent operations can reference the new names

### Requirement: Generated Spec Frontmatter
The system SHOULD mark generated specs with frontmatter.

#### Scenario: Generated indicator
- GIVEN a spec generated from existing code
- WHEN created
- THEN include YAML frontmatter with `generated: true` and `generated_at: YYYY-MM-DD`

#### Scenario: User review
- GIVEN a generated spec with frontmatter
- WHEN the user reviews and refines it
- THEN they can remove the frontmatter to indicate the spec is finalized
