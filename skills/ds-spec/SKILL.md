---
name: ds-spec
description: View, discuss, or search specifications.
---

# /ds:spec [domain|search] - View, discuss, or search specs

View, discuss, or search current specifications.

## Behavior

- **No args:** List all specs in `specs/` (excluding `.delta/`)
- **With domain:** Read and discuss that specific spec (if `specs/<arg>.md` exists)
- **With search term:** Search all specs for matching requirements (if no matching file)
- Answer questions about current system behavior based on specs

## Search Mode

When the argument does not match an existing spec filename:

1. Treat the argument as a search term
2. Scan all `specs/*.md` files (excluding `.delta/`)
3. Search in:
   - Requirement names (`### Requirement: <Name>`)
   - Requirement body text
   - Scenario names and content
4. Use **case-insensitive** matching

### Search Output Format

```
Search results for "authentication":

commands.md
  → Requirement: Initialize Repository
    "...creates the specs directory structure..."

workflow.md
  → Requirement: Dependency Enforcement
    "...authentication flow depends on..."

Found 2 matches in 2 files.
```

Group results by spec file, show requirement name and matching excerpt.

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
