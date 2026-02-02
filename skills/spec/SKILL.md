---
name: spec
description: View or discuss specifications. List all specs or read a specific domain spec.
---

# /ds:spec [domain] - View or discuss specs

View and discuss current specifications.

## Behavior

- **No args:** List all specs in `specs/` (excluding `.delta/`)
- **With domain:** Read and discuss that specific spec
- Answer questions about current system behavior based on specs

## Spec Format Reference

Specs use this format:

```markdown
# <Domain> Specification

## Purpose
Brief description of what this domain covers.

## Requirements

### Requirement: <Name>
The system [SHALL|MUST|SHOULD|MAY] <behavior description>.

#### Scenario: <Scenario Name>
- GIVEN <precondition>
- WHEN <action>
- THEN <expected outcome>
```

## Spec Writing Guidelines

- Use RFC 2119 keywords: SHALL/MUST (required), SHOULD (recommended), MAY (optional)
- Each requirement should be testable
- Scenarios use Given/When/Then format
- Keep requirements atomic - one behavior per requirement
- Name requirements clearly - they're referenced in deltas
