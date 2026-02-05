# Design: quick-workflow

## Context

Existing skills follow a consistent pattern:
- Frontmatter with `name` and `description`
- Step 0: Version check
- Subsequent steps for the skill's logic
- Skills are auto-discovered from `skills/<name>/SKILL.md`

The workflow `/ds-new` → `/ds-plan` → `/ds-tasks` requires 3 separate invocations with confirmations. Each skill is designed to be interactive.

## Approach

Create a new `/ds-quick` skill that:
1. Combines the logic of new, plan, and tasks into one flow
2. Accepts optional `[name]` and `["description"]` arguments
3. Infers from conversation context when args are omitted
4. Has a single confirmation point after generating the proposal
5. After confirmation, runs plan and tasks logic without prompts

The skill will reference the same templates and formats as the individual skills but skip the interactive/confirmation steps after the initial proposal approval.

## Decisions

### Single skill vs. orchestration
**Choice:** Single skill that contains the combined logic
**Why:** Keeps implementation simple; skill instructions can reference "do what ds-plan does" without needing actual skill chaining
**Trade-offs:** Some duplication of concepts, but skills are prompts so this is fine

### Confirmation after proposal only
**Choice:** Show proposal, ask "Proceed?", then auto-run remaining steps
**Why:** Proposal defines scope—if that's wrong, everything else is wrong. Design and tasks are derived, lower risk.
**Trade-offs:** Can't review design before tasks, but user can always use individual skills for more control

### Context inference
**Choice:** If no args, infer name and description from conversation
**Why:** Natural flow from discussion to implementation without re-stating intent
**Trade-offs:** May occasionally infer incorrectly, but confirmation step catches this

## Files Affected

- `skills/ds-quick/SKILL.md` - New skill file (create)
- `specs/skills.md` - Add requirement for Quick Start skill

## Risks

- Context inference might not capture user intent accurately (mitigated by proposal confirmation)
- Users might expect auto-archive (explicitly out of scope, documented)
