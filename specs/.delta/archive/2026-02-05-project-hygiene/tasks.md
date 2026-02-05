# Tasks: project-hygiene

## Overview
This change updates project metadata to reflect the current state after 12 archived changes. Tasks are ordered by dependency - version bumps first, then documentation updates that reference those versions.

## Tasks

### 1. Update plugin.json version
**Status:** done
**Description:** Bump version from "0.0.1" to "0.1.0" in `.claude-plugin/plugin.json`
**Files:**
- `/Users/horti/projects/personal/delta-spec/.claude-plugin/plugin.json`

**Details:**
- Line 4: Change `"version": "0.0.1"` to `"version": "0.1.0"`

---

### 2. Update .delta-spec.json version
**Status:** done
**Description:** Bump tracked version from "0.0.1" to "0.1.0" in `specs/.delta-spec.json`
**Files:**
- `/Users/horti/projects/personal/delta-spec/specs/.delta-spec.json`

**Details:**
- Line 2: Change `"version": "0.0.1"` to `"version": "0.1.0"`

---

### 3. Clean up marketplace.json duplicate description
**Status:** done
**Description:** Remove duplicate description field from marketplace.json metadata section
**Files:**
- `/Users/horti/projects/personal/delta-spec/.claude-plugin/marketplace.json`

**Details:**
- Remove lines 8-10 (metadata.description field)
- Keep top-level description field (line 4)

---

### 4. Populate CHANGELOG.md [Unreleased] section
**Status:** done
**Description:** Add all 12 archived features to the [Unreleased] section, categorized by Added/Changed/Fixed
**Files:**
- `/Users/horti/projects/personal/delta-spec/CHANGELOG.md`

**Details:**
Add between lines 8-9 (in the [Unreleased] section):

```markdown
### Added
- `/ds-quick` skill for streamlined proposal → plan → tasks workflow with single confirmation
- `/ds-batch` skill for batch proposal creation from free-form feature descriptions
- Search capability in `/ds-spec` - find requirements by keyword across all specs
- Conflict detection in `/ds-status` - warns when multiple changes modify the same requirement
- Progress tracking in `/ds-status` - shows completed vs pending tasks
- Dependency visualization in `/ds-status` - ASCII tree showing change relationships
- Circular dependency detection and resolution in `/ds-new` and `/ds-batch`
- Pre-archive validation - checks requirement references exist before merging
- Interactive confirmation step in `/ds-archive` after showing diff
- Persistent task files (`tasks.md`) replacing native TaskCreate tool
- Context-aware test task generation in `/ds-tasks`
- Multiple changes support in `/ds-tasks` - process all planned changes in dependency order

### Changed
- Planning phase (`/ds-plan`) no longer blocks on unsatisfied dependencies - warnings only
- Skill naming from `/ds:*` to `/ds-*` format to avoid built-in command conflicts
- Skill descriptions made more concise and action-oriented
- `specs/commands.md` renamed to `specs/skills.md` to reflect current terminology

### Fixed
- Cross-reference validation prevents archiving deltas with invalid requirement references
- Dependency-aware task ordering prevents implementing changes in wrong sequence
```

---

### 5. Remove generated frontmatter from specs/skills.md
**Status:** done
**Description:** Remove the generated frontmatter (lines 1-4) from skills.md
**Files:**
- `/Users/horti/projects/personal/delta-spec/specs/skills.md`

**Details:**
- Remove lines 1-4:
```
---
generated: true
generated_at: 2026-02-03
---
```

---

### 6. Remove generated frontmatter from specs/workflow.md
**Status:** done
**Description:** Remove the generated frontmatter (lines 1-4) from workflow.md
**Files:**
- `/Users/horti/projects/personal/delta-spec/specs/workflow.md`

**Details:**
- Remove lines 1-4:
```
---
generated: true
generated_at: 2026-02-03
---
```

---

### 7. Remove generated frontmatter from specs/spec-format.md
**Status:** done
**Description:** Remove the generated frontmatter (lines 1-4) from spec-format.md
**Files:**
- `/Users/horti/projects/personal/delta-spec/specs/spec-format.md`

**Details:**
- Remove lines 1-4:
```
---
generated: true
generated_at: 2026-02-03
---
```

---

### 8. Remove generated frontmatter from specs/validation.md
**Status:** done
**Description:** Remove the generated frontmatter (lines 1-4) from validation.md
**Files:**
- `/Users/horti/projects/personal/delta-spec/specs/validation.md`

**Details:**
- Remove lines 1-4:
```
---
generated: true
generated_at: 2026-02-03
---
```

---

### 9. Verify version consistency
**Status:** done
**Description:** Confirm all version references are consistent at 0.1.0
**Files:**
- `/Users/horti/projects/personal/delta-spec/.claude-plugin/plugin.json`
- `/Users/horti/projects/personal/delta-spec/specs/.delta-spec.json`

**Details:**
- Read both files and verify version field shows "0.1.0"
- Check that no other files reference 0.0.1 (except archived materials and git history)

---

## Summary
- Total tasks: 9
- Pending: 0
- In progress: 0
- Done: 9

## Dependencies
None - this change is independent.
