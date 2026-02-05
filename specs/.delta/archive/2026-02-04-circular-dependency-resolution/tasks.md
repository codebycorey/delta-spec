# Tasks: circular-dependency-resolution

Generated: 2026-02-04

---

## Task 1: Add cycle detection + resolution to ds-batch
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-batch/SKILL.md
- **Refs:** [Batch Feature Planning - Cycle detection, Cycle analysis, Cycle resolution]

Add Step 3.5 between dependency inference and graph display:

1. Add "Step 3.5: Detect and resolve cycles" section
2. Document cycle detection algorithm (DFS with path tracking)
3. Document cycle analysis (find common terms in descriptions)
4. Document resolution flow:
   - Show cycle path
   - Suggest base change name
   - List artifacts to be removed
   - Ask "Extract '<name>' as base change? [y/N]"
5. On confirm: create base proposal, update deps, delete artifacts, re-plan
6. On decline: ask user which dependency to remove manually
7. Update "Circular Dependencies" edge case to reference Step 3.5

## Task 2: Add cycle detection + resolution to ds-new
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-new/SKILL.md
- **Refs:** [Start New Change - Cycle detection, Cycle resolution]

Add cycle detection after proposal is created:

1. Add "Step 3: Check for cycles" section after proposal creation
2. When Dependencies section is filled, check against existing changes
3. If cycle detected:
   - Show cycle path
   - Analyze descriptions (new + existing) for common concept
   - Suggest extraction
   - List existing proposals with artifacts to remove
   - Ask "Extract '<name>' as base change? [y/N]"
4. On confirm: create base, update new and existing proposals, clean artifacts, re-plan
5. On decline: ask user to remove a dependency from their proposal

## Task 3: Add cycle warning to ds-status
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-status/SKILL.md
- **Refs:** [Show Status - Cycle detection in status]

Add cycle detection to dependency graph display:

1. Add "Step 5.5: Detect cycles" before rendering graph
2. If cycle found, display warning:
   ```
   ⚠️  Cycle detected: auth → permissions → admin → auth
       Run /ds-new or /ds-batch to resolve.
   ```
3. Still show the dependency graph (with cycle visible)
4. Include cycle in "next steps" recommendations

## Task 4: Add cycle warning to ds-tasks
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-tasks/SKILL.md
- **Refs:** [Generate Tasks - Cycle detection in tasks]

Update cycle detection in multi-change mode:

1. In "Multi-Change Mode" section, step 4 "Detect cycles"
2. Change from "warn and ask user to resolve" to:
   - Show cycle path
   - Suggest: "Run /ds-new or /ds-batch to resolve"
   - Do not proceed until cycle is resolved (hard block)
3. For single-change mode, no cycle check needed (single change can't cycle with itself)

## Task 5: Add cycle warning to ds-archive
- **Status:** done
- **Owner:** claude
- **Files:** skills/ds-archive/SKILL.md
- **Refs:** [Archive Change - Cycle detection in archive]

Add cycle detection to dependency check:

1. In "Step 2: Check dependencies", add cycle detection
2. If this change is part of a cycle:
   - Show cycle path
   - Warn: "This change is part of a cycle"
   - Suggest: "Run /ds-new or /ds-batch to resolve"
   - Ask: "Proceed anyway? [y/N]" (allow override since archiving might break the cycle)

## Task 6: Update README.md
- **Status:** done
- **Owner:** claude
- **Files:** README.md
- **Refs:** [README Synchronization]

Document cycle resolution in README if not already covered. Check if workflow section or skills table needs updates to mention cycle handling.
