# Delta-Spec

This project uses delta-spec for specification-driven development.

## Quick Start

- `/ds:init` - Initialize delta-spec (optionally generate specs from existing code)
- `/ds:new <name>` - Start a new change (creates + works on proposal)
- `/ds:plan [name]` - Create design + delta specs (explores codebase)
- `/ds:tasks [name]` - Create implementation tasks
- `/ds:archive [name]` - Merge delta specs and archive
- `/ds:spec [domain]` - View and discuss specifications
- `/ds:status` - See active changes

## Workflow

```
/ds:init               → Set up specs/ folder (once per repo)
/ds:new add-feature    → Work on proposal (problem, scope)
/ds:plan               → Explore codebase, create design + delta specs
/ds:tasks              → Create implementation tasks
[implement]
/ds:archive            → Merge deltas into specs, archive change
```

## Project Structure

```
specs/                    # Source of truth (visible)
├── auth.md               # Main specs by domain
├── payments.md
└── .delta/               # Work in progress (hidden)
    ├── active/           # Current changes
    └── archive/          # Completed changes preserved
```

- `skills/` - Individual skill files (one per command)
- `.claude-plugin/plugin.json` - Plugin manifest (namespace: `ds:`)
- `CHANGELOG.md` - Version history

## Conventions

1. **Specs are the source of truth** - Code should match specs
2. **Delta changes** - Don't edit main specs directly, use delta format
3. **Codebase-aware planning** - `/ds:plan` explores actual code to fit approach
4. **Native tasks** - Use Claude Code's TaskCreate, not task files
5. **Archive preserves context** - Completed changes kept in `specs/.delta/archive/`

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
| `skill` | Changes to `.claude/skills/` |
| `spec` | Changes to spec format or examples |
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
