# Tasks: extract-cycle-detection

Generated: 2026-02-06

---

## Task 1: Create shared cycle-detection.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/_shared/cycle-detection.md
- **Refs:** [Shared Cycle Detection]

Create `skills/_shared/cycle-detection.md` with the canonical cycle detection procedure. Structure it with these labeled sections:

1. **Core Algorithm** — DFS with path tracking. Build dependency graph from all active changes in `specs/.delta/` (excluding `archive/`). Parse Dependencies from each proposal. For each change, follow dependencies and detect if a path leads back to a visited node. Return the cycle path (e.g., `[auth, permissions, admin, auth]`).

2. **Analysis Procedure** — For skills that need full resolution (new, batch): Collect descriptions from all changes in the cycle. Tokenize descriptions, filter stop words, find common terms. Suggest a base change name from the most common concept.

3. **Resolution: Full (new, batch)** — Show the `⚠️ Cycle detected:` prompt with analysis, suggested extraction, list of artifacts to remove. On confirm: create base proposal, update dependencies, delete invalidated design.md/tasks.md, run `/ds:plan` in dependency order. On decline: ask user which dependency to remove.

4. **Resolution: Warn-only (status)** — Show `⚠️ Cycle detected:` warning with the cycle path. Suggest running `/ds:new` or `/ds:batch` to resolve. Display only, no action.

5. **Resolution: Warn with override (archive)** — Show warning + "Proceed anyway? [y/N]". Note that archiving may break the cycle. On "y": proceed. On "n"/empty: stop.

Match the reference style of `_shared/version-check.md`.

## Task 2: Update new/SKILL.md to reference shared cycle detection
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/new/SKILL.md
- **Refs:** [Start New Change]

Replace the inline cycle detection in `skills/new/SKILL.md` (lines 53-102, from "## Step 4: Check for cycles" through "On Decline" section) with:

1. Keep the `## Step 4: Check for cycles` heading
2. Add brief context: "After the proposal is complete, check if declared dependencies create a cycle with existing changes."
3. Add reference: `See [cycle-detection.md](../_shared/cycle-detection.md) for the cycle detection algorithm. Follow the **Full resolution** flow.`
4. Keep the `## Behavior` section unchanged

## Task 3: Update batch/SKILL.md to reference shared cycle detection
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/batch/SKILL.md
- **Refs:** [Batch Feature Planning]

Replace the inline cycle detection in `skills/batch/SKILL.md` (lines 229-302, "## Step 3.5: Detect and resolve cycles" through the "On Decline" section) with:

1. Keep the `## Step 3.5: Detect and resolve cycles` heading
2. Add context note: "Consolidation (Step 2.5) happens before this step. Merging overlapping features may eliminate some cycles."
3. Add reference: `See [cycle-detection.md](../_shared/cycle-detection.md) for the cycle detection algorithm. Follow the **Full resolution** flow.`
4. Add note: "After resolution, continue to Step 4 with the resolved graph."

## Task 4: Update archive/SKILL.md to reference shared cycle detection
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/archive/SKILL.md
- **Refs:** [Archive Change]

Replace the inline cycle detection in `skills/archive/SKILL.md` (lines 35-53, "### Step 2.1: Check for cycles" section) with:

1. Keep the step heading (will be renumbered later by normalize-step-numbering)
2. Add brief context: "Check if this change is part of a circular dependency."
3. Add reference: `See [cycle-detection.md](../_shared/cycle-detection.md) for the cycle detection algorithm. Follow the **Warn with override** flow (archiving may break the cycle).`

## Task 5: Update status/SKILL.md to reference shared cycle detection
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/status/SKILL.md
- **Refs:** [Show Status]

Replace the inline cycle detection in `skills/status/SKILL.md` (lines 57-68, "### Step 5.1: Detect Cycles" section) with:

1. Keep the `### Step 5.1: Detect Cycles` heading
2. Add reference: `See [cycle-detection.md](../_shared/cycle-detection.md) for the cycle detection algorithm. Follow the **Warn-only** flow.`
3. Keep the "### Step 5.2: Render Graph" section unchanged
