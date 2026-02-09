# Tasks: extract-shared-templates

Generated: 2026-02-08

---

## Task 1: Create _shared/design-template.md
- **Status:** done
- **Owner:** claude
- **Files:** skills/_shared/design-template.md
- **Refs:** [Shared Design Template]

Extract the design.md template from `skills/plan/SKILL.md` lines 54-76 into a new shared file. Include the full markdown template with Context, Approach, Decisions, Files Affected, and Risks sections.

## Task 2: Create _shared/task-format.md
- **Status:** done
- **Owner:** claude
- **Files:** skills/_shared/task-format.md
- **Refs:** [Shared Task Format]

Extract the task file format from `skills/tasks/SKILL.md` lines 82-125 into a new shared file. Include the file structure template, Task Fields table, and Updating Tasks instructions.

## Task 3: Create _shared/dependency-signals.md
- **Status:** done
- **Owner:** claude
- **Files:** skills/_shared/dependency-signals.md
- **Refs:** [Shared Dependency Signals]

Extract the dependency keywords table from `skills/batch/SKILL.md` lines 69-99 into a new shared file. Include the keywords table, matching feature names logic, and confidence levels.

## Task 4: Update plan/SKILL.md to reference shared design template
- **Status:** done
- **Owner:** claude
- **Files:** skills/plan/SKILL.md
- **Refs:** [Shared Design Template]

Replace the inline design.md template (lines 54-76) with a reference to `_shared/design-template.md`. Keep the step heading and any contextual instructions around the template.

## Task 5: Update tasks/SKILL.md to reference shared task format
- **Status:** done
- **Owner:** claude
- **Files:** skills/tasks/SKILL.md
- **Refs:** [Shared Task Format]

Replace the inline task format section (lines 82-125) with a reference to `_shared/task-format.md`. Keep the "Task File Format" heading with a reference link.

## Task 6: Update batch/SKILL.md to reference shared dependency signals
- **Status:** done
- **Owner:** claude
- **Files:** skills/batch/SKILL.md
- **Refs:** [Shared Dependency Signals]

Replace the inline dependency keywords table and matching logic (lines 69-99) with a reference to `_shared/dependency-signals.md`. Keep the step context.

## Task 7: Update adopt/SKILL.md to reference all three shared files
- **Status:** done
- **Owner:** claude
- **Files:** skills/adopt/SKILL.md
- **Refs:** [Shared Design Template], [Shared Task Format], [Shared Dependency Signals]

Replace: (1) inline design template in Step 6c with reference to `_shared/design-template.md`, (2) inline task format description in Step 6e with reference to `_shared/task-format.md`, (3) cross-reference to batch dependency signals in Step 2 with reference to `_shared/dependency-signals.md`.

## Task 8: Update quick/SKILL.md to reference shared design template
- **Status:** done
- **Owner:** claude
- **Files:** skills/quick/SKILL.md
- **Refs:** [Shared Design Template]

Add explicit reference to `_shared/design-template.md` in Step 5 where design.md is created. Currently the template is implicit.
