# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Version tracking via `specs/.delta-spec.json`
- Version check on all commands with migration prompt on mismatch
- Restructured as Claude Code plugin with `ds:` namespace

### Changed
- Skills now in `skills/` directory (plugin structure)
- Commands renamed: `/ds:init`, `/ds:new`, `/ds:plan`, `/ds:tasks`, `/ds:archive`, `/ds:spec`, `/ds:status`

## [1.0.0] - 2025-02-01

### Added
- Initial release
- Delta-spec skill with `/ds:spec`, `/ds:new-change`, `/ds:merge`, `/ds:status` commands
- Spec format with RFC 2119 keywords (SHALL/MUST/SHOULD/MAY)
- Delta format with ADDED/MODIFIED/REMOVED/RENAMED operations
- Example specification template
- Validation script (`scripts/validate-specs.sh`)
- OpenSkills and Claude Code plugin compatibility
