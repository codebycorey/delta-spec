# Tasks: file-based-tasks

Generated: 2026-02-04

---

## Task 1: Update ds-tasks skill to generate tasks.md
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-tasks/SKILL.md
- **Refs:** [Generate Tasks requirement]

Modify Step 4 to create `specs/.delta/<name>/tasks.md` instead of using TaskCreate. Include:
- Task file format specification with Status/Owner/Files/Refs fields
- Instructions to write file using Write tool
- Remove the "IMPORTANT: Do NOT create a tasks.md file" warning
- Update skill description to reflect file-based approach

## Task 2: Add task file format section to ds-tasks skill
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-tasks/SKILL.md
- **Refs:** [Task file format scenario]

Add new section documenting the task file format:
- Header: `# Tasks: <change-name>`
- Generated date
- Task structure: `## Task N: <title>` with Status, Owner, Files, Refs fields
- Example task file

## Task 3: Update ds-status skill to read from tasks.md
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-status/SKILL.md
- **Refs:** [Progress from task file scenario]

Modify Step 4 (Show Progress) to:
- Read `specs/.delta/<name>/tasks.md` for each change
- Parse `## Task N:` sections and extract `- **Status:**` values
- Count tasks by status (pending, in_progress, done)
- Display progress as "X/Y done" instead of "X/Y tasks"
- Handle missing tasks.md gracefully with "No tasks" message

## Task 4: Update skill description frontmatter
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-tasks/SKILL.md
- **Refs:** [Generate Tasks requirement]

Change the description in frontmatter from:
> "Generate implementation tasks from design and delta specs. Uses Claude Code's native TaskCreate."

To:
> "Generate implementation tasks from design and delta specs. Creates tasks.md file."
