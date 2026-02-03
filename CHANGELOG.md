# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
