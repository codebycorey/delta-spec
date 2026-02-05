# Design: skill-metadata

## Context

All 10 skill files currently have this frontmatter pattern:
```yaml
---
name: ds-<skill>
description: ...
---
```

According to Claude Code plugin documentation, SKILL.md supports additional frontmatter fields:
- `argument-hint` - Shows in UI/autocomplete what arguments the skill expects
- `disable-model-invocation: true` - Prevents AI from auto-invoking (for destructive actions)
- `allowed-tools` - Restricts which tools the skill can use (useful for read-only operations)

Currently, 9 out of 10 skills have identical version check boilerplate (~13 lines each = ~117 lines duplicated):
- ds-new, ds-plan, ds-tasks, ds-archive, ds-drop, ds-status, ds-quick, ds-batch, ds-spec

Only ds-init doesn't have the version check since it creates `.delta-spec.json`.

Skills that accept arguments currently use patterns like `[name]`, `<name>`, `[domain|search]` in their headers, but these are not standardized throughout the skill body. The `$ARGUMENTS` placeholder provides a consistent way to reference user-provided arguments within skill text.

## Approach

### 1. Extract version check to shared include

Create `skills/_shared/version-check.md` containing the standard version check logic. Each skill will reference it via:

```markdown
## Step 0: Version Check

{{include: ../_shared/version-check.md}}
```

This reduces duplication from ~117 lines to ~9 references + 1 shared file (~20 lines).

### 2. Add argument-hint frontmatter

Add `argument-hint` to 7 skills that accept arguments:

| Skill | argument-hint |
|-------|---------------|
| ds-new | `<name>` |
| ds-plan | `[name]` |
| ds-tasks | `[name]` |
| ds-archive | `[name]` |
| ds-drop | `[name]` |
| ds-spec | `[domain\|search]` |
| ds-quick | `[name] ["description"]` |

Skills without arguments (ds-init, ds-status, ds-batch) don't get `argument-hint`.

### 3. Add disable-model-invocation to destructive skills

Add `disable-model-invocation: true` to 3 skills that perform permanent/destructive operations:

- **ds-archive** - Permanently merges delta specs into main specs
- **ds-drop** - Permanently deletes change directories
- **ds-init** - Creates directory structure (destructive if overwriting)

This prevents Claude from auto-invoking these skills without explicit user confirmation.

### 4. Add $ARGUMENTS placeholder usage

For skills that accept arguments, add a note in the skill body about using `$ARGUMENTS`:

```markdown
Use `$ARGUMENTS` to reference the user's provided arguments throughout the skill execution.
```

Place this note immediately after the skill header, before Step 0.

### 5. Add allowed-tools to read-only skills

Add `allowed-tools` to 2 strictly read-only skills:

- **ds-spec** - Only reads and displays specs: `["Read", "Glob", "Grep"]`
- **ds-status** - Only reads change state: `["Read", "Glob"]`

This prevents accidental modifications and clearly signals intent.

## Decisions

### Decision: Use include pattern for version check
**Choice:** Reference shared file with `{{include: ../_shared/version-check.md}}`
**Why:** Eliminates duplication, ensures consistency, single point of update
**Trade-offs:** Introduces one level of indirection; skill files less standalone

### Decision: disable-model-invocation for archive, drop, init only
**Choice:** Only add to truly destructive operations
**Why:** These operations can't be undone (archive merges specs, drop deletes, init overwrites)
**Trade-offs:** Skills like ds-new still auto-invokable (but creates recoverable files)

### Decision: allowed-tools for spec and status only
**Choice:** Only restrict truly read-only skills
**Why:** Other skills need Write/Edit for creating proposals, designs, tasks
**Trade-offs:** More granular restrictions possible but add complexity

### Decision: Document $ARGUMENTS but don't mandate usage
**Choice:** Add informational note about `$ARGUMENTS` availability
**Why:** Skills already reference args correctly; this adds clarity for future edits
**Trade-offs:** Not enforced, but documented pattern

## Files Affected

- `skills/_shared/version-check.md` - [CREATE] Shared version check logic
- `skills/ds-new/SKILL.md` - [ADD] argument-hint, $ARGUMENTS note, include reference
- `skills/ds-plan/SKILL.md` - [ADD] argument-hint, $ARGUMENTS note, include reference
- `skills/ds-tasks/SKILL.md` - [ADD] argument-hint, $ARGUMENTS note, include reference
- `skills/ds-archive/SKILL.md` - [ADD] argument-hint, $ARGUMENTS note, disable-model-invocation, include reference
- `skills/ds-drop/SKILL.md` - [ADD] argument-hint, $ARGUMENTS note, disable-model-invocation, include reference
- `skills/ds-spec/SKILL.md` - [ADD] argument-hint, $ARGUMENTS note, allowed-tools, include reference
- `skills/ds-status/SKILL.md` - [ADD] allowed-tools, include reference
- `skills/ds-quick/SKILL.md` - [ADD] argument-hint, $ARGUMENTS note, include reference
- `skills/ds-batch/SKILL.md` - [ADD] include reference
- `skills/ds-init/SKILL.md` - [ADD] disable-model-invocation (no version check needed)

## Risks

- Include pattern might not be supported by Claude Code (need to verify)
- If includes aren't supported, may need to use a build step or keep duplication
- `$ARGUMENTS` placeholder may not be standard (document in case it changes)
- allowed-tools restrictions might be too strict if skills need additional tools later
