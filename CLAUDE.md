# Delta-Spec

This project uses delta-spec for specification-driven development.

## Quick Start

- `/ds:spec` - View and discuss specifications
- `/ds:new-change <name>` - Start a new change with specs
- `/ds:merge` - Merge completed delta specs into main specs
- `/ds:status` - See active changes

## Project Structure

- `.specs/` - All specifications live here
- `.specs/changes/` - Active changes with delta specs
- `SKILL.md` - The workflow skill (install to `.claude/skills/` in your project)

## Conventions

1. **Specs are the source of truth** - Code should match specs
2. **Delta changes** - Don't edit main specs directly, use delta format
3. **Native tasks** - Use Claude Code's TaskCreate, not task files
4. **Git history** - Merged changes are preserved in Git, no archive folder needed

## Spec Domains

Create specs by domain (e.g., `auth.md`, `payments.md`, `api.md`). Each spec file covers one bounded context.
