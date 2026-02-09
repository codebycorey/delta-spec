# Proposal: expand-gitignore

## Problem
`.gitignore` only has 2 entries (`.DS_Store` and `*.log`), which is insufficient for contributor protection across different toolchains.

## Dependencies
None

## Changes
- Add common entries to `.gitignore`: `node_modules/`, `.env`, `*.tmp`

## Capabilities

### Modified
- `.gitignore` covers common development artifacts

## Out of Scope
- Adding project-specific ignores
- CI/CD configuration

## Success Criteria
- `.gitignore` includes `node_modules/`, `.env`, and `*.tmp` entries
