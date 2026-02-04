# Delta: Commands

Changes for spec-search.

## MODIFIED Requirements

### Requirement: View Specifications
The system SHALL provide a `/ds:spec [domain|search]` command to view, discuss, or search specs.

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
