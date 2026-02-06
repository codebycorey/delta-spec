# Tasks: extract-determine-change

Generated: 2026-02-06

---

## Task 11: Create shared determine-change.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/_shared/determine-change.md
- **Refs:** [Shared Change Resolution]

Create `skills/_shared/determine-change.md` with the standard resolution procedure:

1. If `name` provided in arguments → use `specs/.delta/<name>/`
2. If inferable from conversation context (e.g., user just ran another skill for a specific change) → use it
3. If only one active change in `specs/.delta/` (excluding `archive/`) → use it
4. If multiple and not inferable → use AskUserQuestion to let user pick
5. If none → suggest the appropriate prerequisite

Context-specific notes:
- **plan**: Prerequisite = suggest `/ds:new`. No confirmation needed for single change.
- **archive**: Prerequisite = "nothing to archive". No confirmation for single change.
- **drop**: Prerequisite = "nothing to drop". Confirm even with single change (destructive).
- **tasks**: Uses multi-change mode — if no name provided and multiple planned changes exist, process all in dependency order instead of asking. Prerequisite = suggest `/ds:plan`.

## Task 12: Update plan/SKILL.md to reference shared determine-change
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/plan/SKILL.md
- **Refs:** [Plan Change]

Replace the inline "## Step 1: Determine which change" section (lines 16-22) with:

1. Keep the `## Step 1: Determine which change` heading
2. Add reference: `See [determine-change.md](../_shared/determine-change.md) for the standard change resolution procedure.`
3. Add context note: `Prerequisite: suggest \`/ds:new\``

## Task 13: Update tasks/SKILL.md to reference shared determine-change
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/tasks/SKILL.md
- **Refs:** [Generate Tasks]

Replace the inline determination logic (lines 16-21) with:

1. Keep the `## Step 1: Determine which change(s)` heading
2. Add reference: `See [determine-change.md](../_shared/determine-change.md) for the standard change resolution procedure.`
3. Add context note: `For tasks, uses multi-change mode: if no name provided and multiple planned changes exist, process all in dependency order.`
4. Keep the full "### Multi-Change Mode" subsection (lines 23-52) — this is task-specific and stays inline

## Task 14: Update archive/SKILL.md to reference shared determine-change
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/archive/SKILL.md
- **Refs:** [Archive Change]

Replace the inline determination logic (lines 19-25) with:

1. Keep the step heading
2. Add reference: `See [determine-change.md](../_shared/determine-change.md) for the standard change resolution procedure.`
3. Add context note: `If none → nothing to archive.`

## Task 15: Update drop/SKILL.md to reference shared determine-change
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/drop/SKILL.md
- **Refs:** [Drop Change]

Replace the inline determination logic (lines 19-25) with:

1. Keep the step heading
2. Add reference: `See [determine-change.md](../_shared/determine-change.md) for the standard change resolution procedure.`
3. Add context note: `For drop: confirm with user even when only one change exists (destructive operation). If none → nothing to drop.`
