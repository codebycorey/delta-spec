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
- `.claude-plugin/plugin.json` - Plugin manifest with version info
- `CHANGELOG.md` - Version history

## Conventions

1. **Specs are the source of truth** - Code should match specs
2. **Delta changes** - Don't edit main specs directly, use delta format
3. **Native tasks** - Use Claude Code's TaskCreate, not task files
4. **Git history** - Merged changes are preserved in Git, no archive folder needed

## Spec Domains

Create specs by domain (e.g., `auth.md`, `payments.md`, `api.md`). Each spec file covers one bounded context.

## Versioning

This project uses [Semantic Versioning](https://semver.org/):

- **MAJOR** (1.x.x) - Breaking changes to skill commands or spec format
- **MINOR** (x.1.x) - New features, backward compatible
- **PATCH** (x.x.1) - Bug fixes, documentation updates

When releasing:
1. Update version in `.claude-plugin/plugin.json`
2. Add entry to `CHANGELOG.md`
3. Commit and tag: `git tag v1.0.0`

## Conventional Commits

All commits MUST follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, no code change |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `test` | Adding or updating tests |
| `chore` | Maintenance tasks, dependencies |

### Scopes

| Scope | Description |
|-------|-------------|
| `skill` | Changes to SKILL.md |
| `spec` | Changes to spec format or examples |
| `plugin` | Changes to plugin manifest |
| `scripts` | Changes to validation or other scripts |

### Examples

```bash
feat(skill): add /ds:archive command
fix(skill): correct merge algorithm for RENAMED operations
docs: update installation instructions in README
chore(plugin): bump version to 1.1.0
refactor(skill): simplify delta parsing logic
```

### Breaking Changes

Add `!` after type/scope and include `BREAKING CHANGE:` in footer:

```
feat(spec)!: change requirement header format

BREAKING CHANGE: Requirements now use `## Requirement:` instead of `### Requirement:`
```
