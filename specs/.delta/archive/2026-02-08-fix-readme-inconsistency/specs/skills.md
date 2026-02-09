# Delta: Skills

Changes for fix-readme-inconsistency.

## MODIFIED Requirements

### Requirement: Canonical Skill Invocation Format
The system SHALL use `/ds:*` (colon notation) as the canonical skill invocation format in all documentation and cross-references.

#### Scenario: README proposal example matches template
- GIVEN the README.md "How It Works" section includes a proposal example
- WHEN the example is written
- THEN the proposal section headers match `_shared/proposal-template.md`
- AND `## Changes` is used instead of `## Solution`
