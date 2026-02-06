---
description: View, discuss, or search specifications. Use when checking current specs, searching requirements, or understanding system behavior.
argument-hint: "[domain|search]"
allowed-tools: ["Read", "Glob", "Grep"]
---

# /ds:spec [domain|search] - View, discuss, or search specs

View, discuss, or search current specifications.

**Arguments:** If `$ARGUMENTS` is provided, use it as the `domain` or search term parameter. Otherwise, list all specs.

**Note:** This skill is read-only and restricted to Read, Glob, and Grep tools.

## Step 0: Version Check

See [version-check.md](../_shared/version-check.md) for the standard version compatibility check procedure.

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

See [spec-format.md](../_shared/spec-format.md) for the standard spec format and writing guidelines.
