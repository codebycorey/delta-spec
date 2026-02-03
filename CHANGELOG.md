# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2026-02-02

### Added
- Version tracking via `specs/.delta-spec.json`
- Version check on all commands with migration prompt on mismatch
- `/ds:init` command to initialize repository
- `/ds:plan` command for design and delta spec creation
- `/ds:tasks` command for implementation task generation
- `version` field in all SKILL.md frontmatter

### Changed
- **BREAKING:** Directory changed from `.specs/` to `specs/`
- **BREAKING:** Commands renamed: `/ds:new-change` → `/ds:new`, `/ds:merge` → `/ds:archive`
- Skills now in `skills/` directory (plugin structure)
- Validation script now uses correct paths for delta specs

### Fixed
- README.md now matches actual implementation
- Installation instructions updated for manual setup

## [1.0.0] - 2025-02-01

### Added
- Initial release
- Delta-spec skill with `/ds:spec`, `/ds:new-change`, `/ds:merge`, `/ds:status` commands
- Spec format with RFC 2119 keywords (SHALL/MUST/SHOULD/MAY)
- Delta format with ADDED/MODIFIED/REMOVED/RENAMED operations
- Example specification template
- Validation script (`scripts/validate-specs.sh`)
- OpenSkills and Claude Code plugin compatibility
