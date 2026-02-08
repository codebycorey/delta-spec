# Tasks: adopt-plan

Generated: 2026-02-08

---

## Task 1: Create the `/ds:adopt` SKILL.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/adopt/SKILL.md
- **Refs:** [Adopt Existing Plan]

Create `skills/adopt/SKILL.md` with YAML frontmatter and the full skill definition. Follow the patterns established by `/ds:batch` and `/ds:quick`:

- Frontmatter: `description` with trigger phrases ("adopt this plan", "import plan", "capture this planning", "bring in the plan"), `argument-hint: "[name]"`
- Step 0: Version check (reference `_shared/version-check.md`)
- Step 1: Parse arguments — if `$ARGUMENTS` provided use as name hint, otherwise extract all changes from context
- Step 2: Extract changes from conversation context — read prior conversation to identify planned changes, extract name, problem, approach, files affected, and delta specs for each. Infer dependencies using the same signal patterns as `/ds:batch`
- Step 3: Detect cycles in inferred dependencies (reference `_shared/cycle-detection.md`, full resolution flow)
- Step 4: Display extracted changes — show summary of each change (name, problem, approach, files) and ask "Create these changes? [y/N]"
- Step 5: Handle conflicts — check for existing changes in `specs/.delta/`, offer skip/overwrite/rename
- Step 6: Create artifacts — for each change in dependency order, create `specs/.delta/<name>/` with `proposal.md` (reference `_shared/proposal-template.md`), `design.md`, and `specs/*.md` (reference `_shared/delta-format.md`)
- Step 7: Output summary — list created artifacts, suggest `/ds:tasks` as next step

## Task 2: Update `determine-change.md` shared file
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/_shared/determine-change.md
- **Refs:** [Change Inference]

Add a context-specific note for adopt, similar to the existing note for quick:
```
- **adopt**: Creates new changes from context; does not use this resolution procedure.
```

## Task 3: Update `specs/skills.md` with Adopt Existing Plan requirement
- **Status:** done
- **Owner:** (unassigned)
- **Files:** specs/skills.md
- **Refs:** [Adopt Existing Plan]

Apply the delta spec from `specs/.delta/adopt-plan/specs/skills.md`:
- Add the "Adopt Existing Plan" requirement with all 14 scenarios
- Update the "Change Inference" requirement (no changes to scenarios, but the requirement now covers adopt's context)

## Task 4: Update `specs/workflow.md` with adopt workflow
- **Status:** done
- **Owner:** (unassigned)
- **Files:** specs/workflow.md
- **Refs:** [Change Lifecycle]

Apply the delta spec from `specs/.delta/adopt-plan/specs/workflow.md`:
- Add "Adopt workflow" scenario to the Change Lifecycle requirement

## Task 5: Update CLAUDE.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** CLAUDE.md
- **Refs:** [Adopt Existing Plan]

Add `/ds:adopt` to:
- Skills table: `| /ds:adopt [name] | Adopt an existing plan from conversation into delta-spec |`
- Codebase map: add `│   ├── adopt/SKILL.md          # /ds:adopt [name]` under `skills/`
- Workflow section: add adopt as an alternative entry point

## Task 6: Update README.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** README.md
- **Refs:** [Adopt Existing Plan]

Add `/ds:adopt` to:
- Skills table (after `/ds:batch`): `| /ds:adopt [name] | Adopt an existing plan into delta-spec (skips codebase exploration) |`
- Workflow section: add adopt as an alternative path
- "Recommended: Add to CLAUDE.md" section: mention adopt in the workflow steps
