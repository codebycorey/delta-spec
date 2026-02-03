# Delta-Spec

This project uses delta-spec for specification-driven development.

## Commands

| Command | Description |
|---------|-------------|
| `/ds:init` | Initialize delta-spec (optionally generate specs from existing code) |
| `/ds:new <name>` | Start a new change (creates + works on proposal) |
| `/ds:plan [name]` | Create design + delta specs (explores codebase) |
| `/ds:tasks [name]` | Create implementation tasks |
| `/ds:archive [name]` | Merge delta specs and archive |
| `/ds:drop [name]` | Abandon a change (deletes, cleans up dependencies) |
| `/ds:spec [domain]` | View and discuss specifications |
| `/ds:status` | See active changes |

## Conventions

1. **Specs are the source of truth** - Code should match specs
2. **Delta changes** - Don't edit main specs directly, use delta format
3. **Codebase-aware planning** - `/ds:plan` explores actual code to fit approach
4. **Native tasks** - Use Claude Code's TaskCreate, not task files
5. **Archive preserves context** - Completed changes kept in `specs/.delta/archive/`

## Spec Domains

Create specs by domain (e.g., `auth.md`, `payments.md`, `api.md`). Each spec file covers one bounded context.

## Version Handling

The `.delta-spec.json` file tracks the version used to initialize specs:
```json
{
  "version": "0.0.1",
  "initialized": "2026-02-02"
}
```

Skills check this version against the current plugin version (in `.claude-plugin/plugin.json`). On mismatch, warn the user and offer migration options.

## Conventional Commits

All commits MUST follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `chore` | Maintenance tasks, dependencies |

### Scopes

| Scope | Description |
|-------|-------------|
| `skill` | Changes to `skills/` |
| `spec` | Changes to spec format or examples |
| `plugin` | Changes to plugin manifest |

### Breaking Changes

Add `!` after type/scope:
```
feat(spec)!: change requirement header format
```
