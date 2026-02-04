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
6. **Keep README in sync** - After any changes to commands, workflow, or features, update README.md to match

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

## Learnings

**Always update this section** when discovering workflow insights, gotchas, or best practices while using delta-spec.

### Planning vs Implementation Dependencies
Dependencies declared in proposals are **informational during planning** but **enforced during implementation**:
- `/ds:plan` - Notes dependencies, proceeds without blocking (planning is safe)
- `/ds:tasks` - Warns about unsatisfied dependencies (implementation order matters)
- `/ds:archive` - Warns about unsatisfied dependencies (merge order matters)

This allows batch planning of multiple dependent changes in sequence.

### Batch Workflow Pattern
When planning multiple related changes:
1. Create all proposals first (`/ds:new` for each)
2. Plan all changes in dependency order (`/ds:plan` for each)
3. Create tasks for all changes (`/ds:tasks` - processes in dependency order)
4. Implement and archive in dependency order

### Task Ordering for Multiple Changes
When `/ds:tasks` is run without a name and multiple planned changes exist:
1. Independent changes (no dependencies) are processed first
2. Dependent changes follow in topological order
3. Tasks are numbered sequentially across all changes
4. Changes with only proposals (not yet planned) are skipped

### Dogfooding
When improving delta-spec itself, use delta-spec to track the changes. This validates the workflow and catches friction points.

### README Synchronization
After making changes, check if README.md needs updates. Key sections to verify:
- **Commands table** - Must match available `/ds:*` commands
- **Workflow diagram** - Must reflect current command flow
- **Project Structure** - Must match actual directory layout
- **Installation** - Must reflect current setup process
- **How It Works** - Examples should use current syntax

When in doubt, read README.md and compare against the change you just made.
