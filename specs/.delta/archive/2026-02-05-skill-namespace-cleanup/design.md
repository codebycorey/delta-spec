# Design: skill-namespace-cleanup

## Context

### Current State

**Directory Structure:**
All 10 skill directories use the `ds-*` prefix:
- `skills/ds-init/`
- `skills/ds-new/`
- `skills/ds-plan/`
- `skills/ds-tasks/`
- `skills/ds-archive/`
- `skills/ds-drop/`
- `skills/ds-spec/`
- `skills/ds-status/`
- `skills/ds-quick/`
- `skills/ds-batch/`

**SKILL.md Frontmatter:**
Every SKILL.md file contains a `name` field in frontmatter:
```yaml
---
name: ds-init
description: Initialize delta-spec...
---
```

**Bug:** Claude Code v2.1.29+ has a known issue (#17271) where the `name` field in SKILL.md frontmatter strips the plugin namespace prefix. This causes skills to appear as `/ds-init` instead of `/ds:init`.

**Cross-Reference Patterns:**
- SKILL.md files: Mix of `/ds:*` (colon, 43 references) and backtick-wrapped mentions
- CLAUDE.md: Uses `/ds-*` (hyphen, ~28 references)
- README.md: Uses `/ds-*` (hyphen, ~28 references)
- specs/skills.md: Uses `/ds-*` (hyphen) in requirement titles

### Plugin Configuration

`plugin.json` defines the namespace:
```json
{
  "name": "ds",
  ...
}
```

`marketplace.json` does NOT explicitly list skills (relies on directory discovery).

## Approach

### Phase 1: Remove Name Field from Frontmatter
Remove the `name` field from all 10 SKILL.md files. This allows the skill name to be inferred from the directory name, which will then have the namespace prefix applied correctly.

### Phase 2: Rename Directories
Rename all skill directories from `ds-*` to plain names:
- `skills/ds-init/` → `skills/init/`
- `skills/ds-new/` → `skills/new/`
- `skills/ds-plan/` → `skills/plan/`
- `skills/ds-tasks/` → `skills/tasks/`
- `skills/ds-archive/` → `skills/archive/`
- `skills/ds-drop/` → `skills/drop/`
- `skills/ds-spec/` → `skills/spec/`
- `skills/ds-status/` → `skills/status/`
- `skills/ds-quick/` → `skills/quick/`
- `skills/ds-batch/` → `skills/batch/`

**Result:** Skills will appear as `/ds:init`, `/ds:new`, etc.

### Phase 3: Update Cross-References
Update all skill invocation references to use the canonical `/ds:*` (colon) format:

**SKILL.md files (43 references):**
- Already mostly use `/ds:*` format
- Update any remaining `/ds-*` references to `/ds:*`

**CLAUDE.md (28 references):**
- Convert all `/ds-*` to `/ds:*`

**README.md (28 references):**
- Convert all `/ds-*` to `/ds:*`

**specs/skills.md:**
- Update requirement titles from `/ds-*` to `/ds:*`

## Decisions

### Decision: Remove name field vs rename directories first
**Choice:** Remove `name` field first, then rename directories
**Why:**
- Safer to make non-destructive change first (edit frontmatter)
- Allows testing that removing `name` field works as expected
- Directory renames are atomic operations that can be done in one batch

**Trade-offs:** None - this is strictly safer ordering

### Decision: Use /ds:* as canonical notation
**Choice:** Standardize on `/ds:init` (colon) format everywhere
**Why:**
- This is the actual invocation format after the bug fix
- Matches Claude Code's plugin namespace convention
- SKILL.md files already predominantly use this format
- More explicit about plugin namespacing

**Trade-offs:**
- Breaks with the historical `/ds-*` (hyphen) format in docs
- Users with muscle memory need to adjust
- But: Aligns with actual behavior, reducing confusion long-term

### Decision: Don't update marketplace.json
**Choice:** Keep marketplace.json unchanged (no explicit skill listing)
**Why:**
- Skills are auto-discovered from `skills/` directory
- Adding explicit listing is unnecessary and adds maintenance burden
- Current structure works correctly

**Trade-offs:** None - explicit listing not needed for local plugins

## Files Affected

### Skill Directories (10 renames)
- `skills/ds-init/` → `skills/init/`
- `skills/ds-new/` → `skills/new/`
- `skills/ds-plan/` → `skills/plan/`
- `skills/ds-tasks/` → `skills/tasks/`
- `skills/ds-archive/` → `skills/archive/`
- `skills/ds-drop/` → `skills/drop/`
- `skills/ds-spec/` → `skills/spec/`
- `skills/ds-status/` → `skills/status/`
- `skills/ds-quick/` → `skills/quick/`
- `skills/ds-batch/` → `skills/batch/`

### SKILL.md Frontmatter (10 edits)
Each SKILL.md file needs the `name` field removed from frontmatter

### Cross-Reference Updates
- `CLAUDE.md` - Update ~28 skill references
- `README.md` - Update ~28 skill references
- `skills/*/SKILL.md` - Update ~43 skill cross-references
- `specs/skills.md` - Update requirement titles

## Risks

### Git History Disruption
**Risk:** Renaming directories may disrupt `git log --follow` for SKILL.md files
**Mitigation:**
- Git automatically tracks renames if >50% similarity
- SKILL.md contents are not changing (except frontmatter)
- Similarity will be >90%, so tracking should work

### User Confusion During Transition
**Risk:** Existing users type `/ds-init` and get nothing
**Mitigation:**
- Update README.md installation section to note the change
- CLAUDE.md will reflect correct invocations immediately
- Claude autocomplete will show correct `/ds:*` format

### Documentation Lag
**Risk:** External references (blog posts, tutorials) may still show `/ds-*`
**Mitigation:**
- Include migration note in README.md
- Accept this as cost of fixing the bug
- External docs will update organically over time

### Breaking Changes for Automation
**Risk:** If anyone has scripts invoking skills, they'll break
**Mitigation:**
- This is a local plugin, unlikely to have automation
- Skills are meant to be human-invoked
- Accept this as necessary breaking change

## Implementation Notes

### Order of Operations
1. **Remove `name` field** from all SKILL.md frontmatter (safe, non-destructive)
2. **Test** that skills still appear with current naming
3. **Rename directories** in dependency order (none exist, so any order works)
4. **Update cross-references** in documentation files
5. **Update cross-references** in SKILL.md files
6. **Verify** with `/skills` command that all appear as `/ds:*`

### Testing Checklist
- [ ] Run `/skills` and verify all skills show as `/ds:*`
- [ ] Test one skill invocation (`/ds:status`) to confirm it works
- [ ] Grep for remaining `/ds-` patterns in docs
- [ ] Check git log for SKILL.md files to verify rename tracking works
