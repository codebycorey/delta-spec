# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2026-02-08

### Added
- `/ds:adopt` skill for importing existing plans from conversation context into delta-spec format, skipping redundant codebase exploration

## [0.1.0] - 2026-02-06

### Added
- `/ds:quick` skill for streamlined proposal → plan → tasks workflow with single confirmation
- `/ds:batch` skill for batch proposal creation from free-form feature descriptions with dependency inference
- Feature consolidation in `/ds:batch` - detects overlapping features and suggests merging before planning
- Search capability in `/ds:spec` - find requirements by keyword across all specs
- Conflict detection in `/ds:status` - warns when multiple changes modify the same requirement
- Progress tracking in `/ds:status` - reads `tasks.md` and shows completion (e.g., "2/5 done")
- Dependency visualization in `/ds:status` - ASCII tree showing change relationships
- Circular dependency detection and resolution in `/ds:new`, `/ds:batch`, `/ds:archive`, and `/ds:status`
- Pre-archive validation - checks requirement references exist before merging
- Interactive confirmation step in `/ds:archive` after showing diffs (default to No)
- Persistent task files (`tasks.md`) replacing native TaskCreate tool
- Context-aware test task generation in `/ds:tasks` - includes test tasks when test infrastructure exists
- Multiple changes support in `/ds:tasks` - process all planned changes in dependency order
- Shared reference files in `skills/_shared/`:
  - `version-check.md` - version compatibility check procedure
  - `cycle-detection.md` - DFS cycle detection with full, warn-only, and warn-with-override resolution flows
  - `determine-change.md` - standard change resolution logic with context-specific notes per skill
  - `spec-format.md` - base spec format template and writing guidelines
  - `delta-format.md` - delta spec format template
  - `proposal-template.md` - standard proposal template
- Interactive guidance in `/ds:new` Step 3 - specific prompts for each proposal section with completion criteria
- Kebab-case naming convention documented in `/ds:new`
- `marketplace.json` for plugin installation
- MIT license
- Codebase map in CLAUDE.md for faster agent orientation
- `validate-specs.sh` script for spec format validation

### Changed
- **BREAKING:** Skill directories renamed from `ds-*` to plain names (e.g., `ds-init/` → `init/`)
- **BREAKING:** Skill invocation format changed to `/ds:*` colon notation (e.g., `/ds:init`)
- Skill frontmatter now includes `argument-hint` for skills with parameters
- Destructive skills (`init`, `archive`, `drop`) now set `disable-model-invocation: true`
- Read-only skills (`spec`, `status`) now restrict `allowed-tools` to read operations
- Skill descriptions made concise and action-oriented with "Use when..." trigger phrases across all 10 skills
- Planning phase (`/ds:plan`) no longer blocks on unsatisfied dependencies - warnings only
- `specs/commands.md` renamed to `specs/skills.md` to reflect current terminology
- Extracted consolidation algorithm and examples from batch skill to `references/` and `examples/` subdirectories
- Extracted proposal template to `skills/_shared/proposal-template.md` (was duplicated in new, quick, batch)
- `/ds:plan` steps renumbered to sequential integers (removed Step 2b)
- `/ds:init` now specifies reading version from `.claude-plugin/plugin.json`
- Removed redundant sections: Behavior in `/ds:new`, Delta Rules in `/ds:archive`, duplicate no-prompt notes in `/ds:quick`
- `CLAUDE.md` symlinked to `AGENTS.md`

### Fixed
- Cross-reference validation prevents archiving deltas with invalid requirement references
- Dependency-aware task ordering prevents implementing changes in wrong sequence
- Removed undocumented `--force` flag from `/ds:drop`
- `validate-specs.sh` bash strict mode compatibility

## [0.0.1] - 2026-02-03

Initial pre-release.

### Added
- `/ds:init` - Initialize delta-spec in a repository
- `/ds:new` - Start a new change with proposal
- `/ds:plan` - Create design and delta specs
- `/ds:tasks` - Create implementation tasks
- `/ds:spec` - View and discuss specifications
- `/ds:status` - Show active changes
- `/ds:archive` - Merge delta specs and archive
- `/ds:drop` - Abandon a change and clean up dependencies
- Version tracking via `specs/.delta-spec.json`
- Delta format with ADDED/MODIFIED/REMOVED/RENAMED operations
- Spec format with RFC 2119 keywords (SHALL/MUST/SHOULD/MAY)
- Dependency tracking between changes
