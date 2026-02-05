# Tasks: skill-namespace-cleanup

Generated: 2026-02-05

---

## Task 1: Remove name field from SKILL.md frontmatter files
- **Status:** done
- **Owner:** (unassigned)
- **Files:**
  - /Users/horti/projects/personal/delta-spec/skills/ds-init/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/ds-new/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/ds-plan/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/ds-tasks/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/ds-archive/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/ds-drop/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/ds-spec/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/ds-status/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/ds-quick/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/ds-batch/SKILL.md
- **Refs:** [SKILL.md Frontmatter Constraints]

Remove the `name` field from the frontmatter of all 10 SKILL.md files. Each file currently has a frontmatter like:
```yaml
---
name: ds-init
description: Initialize delta-spec...
---
```

After this task, it should be:
```yaml
---
description: Initialize delta-spec...
---
```

This allows Claude Code to infer the skill name from the directory name and apply the namespace prefix correctly.

---

## Task 2: Rename skill directories from ds-* to plain names
- **Status:** done
- **Owner:** (unassigned)
- **Files:**
  - /Users/horti/projects/personal/delta-spec/skills/ds-init/ → skills/init/
  - /Users/horti/projects/personal/delta-spec/skills/ds-new/ → skills/new/
  - /Users/horti/projects/personal/delta-spec/skills/ds-plan/ → skills/plan/
  - /Users/horti/projects/personal/delta-spec/skills/ds-tasks/ → skills/tasks/
  - /Users/horti/projects/personal/delta-spec/skills/ds-archive/ → skills/archive/
  - /Users/horti/projects/personal/delta-spec/skills/ds-drop/ → skills/drop/
  - /Users/horti/projects/personal/delta-spec/skills/ds-spec/ → skills/spec/
  - /Users/horti/projects/personal/delta-spec/skills/ds-status/ → skills/status/
  - /Users/horti/projects/personal/delta-spec/skills/ds-quick/ → skills/quick/
  - /Users/horti/projects/personal/delta-spec/skills/ds-batch/ → skills/batch/
- **Refs:** [Skill Directory Structure]

Rename all 10 skill directories by removing the `ds-` prefix. Use `git mv` to preserve history:
```bash
git mv skills/ds-init skills/init
git mv skills/ds-new skills/new
git mv skills/ds-plan skills/plan
git mv skills/ds-tasks skills/tasks
git mv skills/ds-archive skills/archive
git mv skills/ds-drop skills/drop
git mv skills/ds-spec skills/spec
git mv skills/ds-status skills/status
git mv skills/ds-quick skills/quick
git mv skills/ds-batch skills/batch
```

After this task, skills will appear as `/ds:init`, `/ds:new`, etc. in Claude Code's autocomplete.

---

## Task 3: Update cross-references in SKILL.md files (hyphenated to colon)
- **Status:** done
- **Owner:** (unassigned)
- **Files:**
  - /Users/horti/projects/personal/delta-spec/skills/archive/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/new/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/batch/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/status/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/quick/SKILL.md
  - /Users/horti/projects/personal/delta-spec/skills/tasks/SKILL.md
- **Refs:** [Canonical Skill Invocation Format]

Update the 17 remaining hyphenated skill references (`/ds-*`) to use colon notation (`/ds:*`) in SKILL.md files. Files affected:
- skills/archive/SKILL.md (1 reference)
- skills/new/SKILL.md (1 reference)
- skills/batch/SKILL.md (8 references)
- skills/status/SKILL.md (2 references)
- skills/quick/SKILL.md (4 references)
- skills/tasks/SKILL.md (1 reference)

Replace patterns like `/ds-new` with `/ds:new`, `/ds-plan` with `/ds:plan`, etc.

---

## Task 4: Update cross-references in CLAUDE.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** /Users/horti/projects/personal/delta-spec/CLAUDE.md
- **Refs:** [Canonical Skill Invocation Format]

Update all 27 skill references in CLAUDE.md from hyphenated format (`/ds-*`) to colon notation (`/ds:*`). This includes:
- The Skills table in the main section
- The Workflow section
- Any cross-references in the Conventions section
- The Learnings section

Replace patterns like `/ds-init` with `/ds:init`, `/ds-new` with `/ds:new`, etc.

---

## Task 5: Update cross-references in specs/skills.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** /Users/horti/projects/personal/delta-spec/specs/skills.md
- **Refs:** [Canonical Skill Invocation Format]

Update all 58 skill references in specs/skills.md from hyphenated format (`/ds-*`) to colon notation (`/ds:*`). This includes:
- Requirement titles (though the title text may not contain the invocation format)
- Scenario descriptions
- Any inline skill references

Replace patterns like `/ds-init` with `/ds:init`, `/ds-new` with `/ds:new`, etc.

---

## Task 6: Update cross-references in specs/workflow.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** /Users/horti/projects/personal/delta-spec/specs/workflow.md
- **Refs:** [Canonical Skill Invocation Format]

Update all 10 skill references in specs/workflow.md from hyphenated format (`/ds-*`) to colon notation (`/ds:*`). Workflow.md currently has references in colon format already, but verify and update any remaining hyphenated references if found.

Replace patterns like `/ds-init` with `/ds:init`, `/ds-new` with `/ds:new`, etc.

---

## Task 7: Verify skill registration with /skills command
- **Status:** done
- **Owner:** (unassigned)
- **Files:** (verification only, no file changes)
- **Refs:** [Skill Directory Structure], [Canonical Skill Invocation Format]

After all changes are complete, verify that skills are correctly registered and appear with the proper namespace:

1. Run `claude --plugin-dir=/Users/horti/projects/personal/delta-spec` to start Claude Code with the plugin
2. Type `/skills` to list all available skills
3. Verify that all 10 skills appear as:
   - `/ds:init`
   - `/ds:new`
   - `/ds:plan`
   - `/ds:tasks`
   - `/ds:archive`
   - `/ds:drop`
   - `/ds:spec`
   - `/ds:status`
   - `/ds:quick`
   - `/ds:batch`
4. Test one skill invocation (e.g., `/ds:status`) to confirm it works correctly
5. Check that autocomplete shows the correct format when typing `/ds:`

If any skills are missing or appear with incorrect names, review the directory structure and frontmatter to ensure Task 1 and Task 2 were completed correctly.
