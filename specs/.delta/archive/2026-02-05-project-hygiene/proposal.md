# Proposal: project-hygiene

## Problem
The project's metadata doesn't reflect its actual state. The CHANGELOG.md shows only the initial 0.0.1 release with an empty `[Unreleased]` section despite 12 archived changes adding significant features. The 4 spec files still carry `generated: true` frontmatter even though they've been refined through multiple iterations. The plugin version remains at 0.0.1 despite substantial feature additions.

## Dependencies
None

## Changes
- Populate CHANGELOG.md `[Unreleased]` section with all features from the 12 archived changes
- Remove `generated: true` / `generated_at` frontmatter from all 4 spec files (`skills.md`, `workflow.md`, `spec-format.md`, `validation.md`)
- Bump version from 0.0.1 to 0.1.0 in `plugin.json` and `specs/.delta-spec.json`
- Clean up marketplace.json duplicate description (top-level vs `metadata.description`)

## Capabilities

### Modified
- CHANGELOG accurately reflects project history
- Spec files marked as reviewed/authoritative (no generated frontmatter)
- Plugin version reflects actual feature maturity

## Out of Scope
- Tagging a git release
- Updating version check logic in skills (existing check handles mismatches)
- Adding new CHANGELOG entries for changes not yet archived

## Success Criteria
- CHANGELOG `[Unreleased]` section lists all 12 archived features
- No spec file contains `generated: true` frontmatter
- `plugin.json` version reads `0.1.0`
- `specs/.delta-spec.json` version reads `0.1.0`
- marketplace.json has a single, non-duplicated description
