# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- `/ds-quick` skill for streamlined proposal → plan → tasks workflow with single confirmation
- `/ds-batch` skill for batch proposal creation from free-form feature descriptions
- Search capability in `/ds-spec` - find requirements by keyword across all specs
- Conflict detection in `/ds-status` - warns when multiple changes modify the same requirement
- Progress tracking in `/ds-status` - shows completed vs pending tasks
- Dependency visualization in `/ds-status` - ASCII tree showing change relationships
- Circular dependency detection and resolution in `/ds-new` and `/ds-batch`
- Pre-archive validation - checks requirement references exist before merging
- Interactive confirmation step in `/ds-archive` after showing diff
- Persistent task files (`tasks.md`) replacing native TaskCreate tool
- Context-aware test task generation in `/ds-tasks`
- Multiple changes support in `/ds-tasks` - process all planned changes in dependency order

### Changed
- Planning phase (`/ds-plan`) no longer blocks on unsatisfied dependencies - warnings only
- Skill naming from `/ds:*` to `/ds-*` format to avoid built-in command conflicts
- Skill descriptions made more concise and action-oriented
- `specs/commands.md` renamed to `specs/skills.md` to reflect current terminology

### Fixed
- Cross-reference validation prevents archiving deltas with invalid requirement references
- Dependency-aware task ordering prevents implementing changes in wrong sequence

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
