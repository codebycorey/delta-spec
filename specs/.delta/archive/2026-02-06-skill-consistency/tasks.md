# Tasks: skill-consistency

Generated: 2026-02-06

---

## Task 1: Extract proposal template to shared file
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/_shared/proposal-template.md

Create `skills/_shared/proposal-template.md` with the canonical proposal template.

## Task 2: Replace inline template in new/SKILL.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/new/SKILL.md

Replace the inline proposal template with a reference to `_shared/proposal-template.md`. Also add naming convention guidance and expand Step 3.

## Task 3: Replace inline template in quick/SKILL.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/quick/SKILL.md

Replace the inline proposal template with a reference to `_shared/proposal-template.md`.

## Task 4: Replace inline template in batch/SKILL.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/batch/SKILL.md

Replace the inline proposal template with a reference to `_shared/proposal-template.md`.

## Task 5: Add trigger phrases to init, archive, drop descriptions
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/init/SKILL.md, skills/archive/SKILL.md, skills/drop/SKILL.md

Add "Use when..." trigger phrases to the three descriptions that lack them.

## Task 6: Add plugin version source to init
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/init/SKILL.md

Specify that the version should be read from `.claude-plugin/plugin.json`.

## Task 7: Remove --force flag from drop
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/drop/SKILL.md

Remove the undocumented `--force` flag reference from Step 3.

## Task 8: Renumber plan steps
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/plan/SKILL.md

Renumber Step 2b → Step 3, and bump all subsequent steps by 1.

## Task 9: Fix CHANGELOG notation and add 0.1.0 section
- **Status:** done
- **Owner:** (unassigned)
- **Files:** CHANGELOG.md

Replace all `/ds-*` with `/ds:*`, remove the incorrect "Changed" note about skill naming, and promote [Unreleased] to [0.1.0].
