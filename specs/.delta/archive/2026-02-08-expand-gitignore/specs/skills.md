# Delta: Skills

Changes for expand-gitignore.

_Note: This change does not affect the skills specification. It modifies `.gitignore` only. Delta spec created for completeness._

## ADDED Requirements

### Requirement: Repository Hygiene
The system SHALL maintain a `.gitignore` file with common development artifact patterns.

#### Scenario: Standard ignore patterns
- GIVEN the repository is used by contributors with various toolchains
- WHEN the `.gitignore` is configured
- THEN it includes patterns for OS artifacts (`.DS_Store`)
- AND includes patterns for dependency directories (`node_modules/`)
- AND includes patterns for environment files (`.env`)
- AND includes patterns for temporary files (`*.tmp`, `*.log`)
