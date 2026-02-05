# Design: project-hygiene

## Context

The project has undergone significant development since the initial v0.0.1 release on 2026-02-03. 12 changes have been archived but the CHANGELOG.md has not been updated. The project is ready for a v0.1.0 release.

Current state:
- **CHANGELOG.md**: Shows only v0.0.1 with basic initial features. The [Unreleased] section is empty.
- **Archived changes**: 12 completed changes in `specs/.delta/archive/` representing substantial new functionality:
  1. `archive-safety` - Pre-archive validation and interactive confirmation
  2. `enhanced-features` - Meta-proposal for usability improvements
  3. `spec-search` - Search capability in `/ds-spec`
  4. `status-enhancements` - Conflict detection, progress tracking, dependency visualization
  5. `plan-dependencies-fix` - Planning phase no longer blocks on unsatisfied dependencies
  6. `tasks-multi-change` - Batch task creation across multiple changes
  7. `circular-dependency-resolution` - Cycle detection and automatic resolution
  8. `ds-batch` - Batch proposal creation from free-form descriptions
  9. `quick-workflow` - `/ds-quick` for streamlined proposal → plan → tasks
  10. `plugin-structure-update` - Skills rename from `/ds:*` to `/ds-*`, documentation updates
  11. `file-based-tasks` - Persistent tasks.md files instead of native TaskCreate
  12. `test-task-generation` - Context-aware test task generation

- **Spec files**: Four spec files have stale `generated: true` frontmatter from initial generation:
  - `specs/spec-format.md`
  - `specs/validation.md`
  - `specs/workflow.md`
  - `specs/skills.md`

- **Plugin version**: Both `plugin.json` and `specs/.delta-spec.json` show version `0.0.1`

- **marketplace.json**: Has duplicate `description` fields (line 4 and line 9)

## Approach

1. **CHANGELOG.md update**: Group the 12 archived changes into logical categories following Keep a Changelog format:
   - **Added**: New skills (`/ds-quick`, `/ds-batch`), new capabilities (search, conflict detection, etc.)
   - **Changed**: Modified skill behaviors (planning dependencies, task generation, etc.)
   - **Fixed**: Bug fixes (dependency handling)

2. **Version bump**: Update from `0.0.1` to `0.1.0` (minor version bump for backward-compatible new features):
   - `plugin.json` version field
   - `specs/.delta-spec.json` version field
   - CHANGELOG.md header for new version

3. **Spec frontmatter cleanup**: Remove `generated: true` and `generated_at` fields from all four spec files. These specs have been manually maintained through delta-spec workflow and are no longer "generated."

4. **marketplace.json cleanup**: Remove the duplicate `description` field in the `metadata` section (line 9), keeping only the top-level one (line 4).

## Decisions

### Decision: Version 0.1.0 vs 1.0.0
**Choice:** Bump to 0.1.0, not 1.0.0
**Why:** Following semantic versioning, we're adding backward-compatible features. The system is not production-ready enough for a 1.0 release (still has `generated` frontmatter, incomplete changelog, etc.)
**Trade-offs:** Stays in pre-1.0 experimental phase, signaling users that breaking changes may still occur

### Decision: Changelog categorization
**Choice:** Use Keep a Changelog categories (Added/Changed/Fixed) rather than grouping by date or feature area
**Why:** Industry standard format, makes it easy for users to understand the nature of changes
**Trade-offs:** Some changes could fit multiple categories; we'll prioritize by primary impact

### Decision: Keep archived proposal details intact
**Choice:** Don't modify the archived proposals themselves
**Why:** Archives are historical records; changes should only affect active project files
**Trade-offs:** None significant

### Decision: Remove all frontmatter from specs
**Choice:** Strip both `generated` and `generated_at` fields
**Why:** The specs have evolved through delta-spec workflow and are no longer generated artifacts
**Trade-offs:** Lose the timestamp of initial generation, but that's already in git history

## Files Affected

- `CHANGELOG.md` - Add v0.1.0 section with categorized entries for all 12 archived changes
- `.claude-plugin/plugin.json` - Update version from "0.0.1" to "0.1.0"
- `specs/.delta-spec.json` - Update version from "0.0.1" to "0.1.0"
- `.claude-plugin/marketplace.json` - Remove duplicate description field (line 9)
- `specs/spec-format.md` - Remove frontmatter (lines 1-4)
- `specs/validation.md` - Remove frontmatter (lines 1-4)
- `specs/workflow.md` - Remove frontmatter (lines 1-4)
- `specs/skills.md` - Remove frontmatter (lines 1-4)

## Risks

- **Version compatibility**: Existing `.delta-spec.json` files in other repos will show version mismatch. This is expected behavior - the version check system is designed to handle this.
- **Changelog accuracy**: Manually extracting features from proposals may miss nuances. Mitigation: Review proposals carefully and cross-reference with git history.
- **Spec format changes**: Removing frontmatter might break any tools that parse it. Mitigation: The frontmatter was never part of the spec format requirements, so this is safe.
