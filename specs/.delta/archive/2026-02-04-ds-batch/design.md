# Design: ds-batch

## Context

The existing skill structure follows a consistent pattern:
- Each skill is a `SKILL.md` file in `skills/ds-<name>/`
- Frontmatter has `name` and `description`
- Skills follow numbered steps with clear behavior
- Version checking is Step 0 for all skills
- Change inference is a common pattern (single change → use it, multiple → ask)

Related skills:
- `/ds-new` - Creates single proposal, works interactively
- `/ds-quick` - Creates proposal + design + tasks with single confirmation
- `/ds-plan` - Plans single change, explores codebase
- `/ds-tasks` - Already supports batch mode (processes all planned changes)

The proposal template has a Dependencies section that supports declaring dependencies on other changes.

## Approach

Create a new `/ds-batch` skill that:
1. Prompts for free-form feature descriptions
2. Parses descriptions into named features with dependencies
3. Shows dependency graph for confirmation
4. Creates all proposal.md files in batch
5. Offers to run `/ds-plan` for all

Key insight: We don't need to call `/ds-new` as a sub-skill. We can directly create the proposal files using the same template, which is simpler and avoids the interactive nature of `/ds-new`.

## Decisions

### Direct Proposal Creation vs Calling /ds-new
**Choice:** Create proposal files directly
**Why:** `/ds-new` is interactive (asks clarifying questions). For batch mode, we want to infer everything from the free-form description and create all at once.
**Trade-offs:** Less refinement per proposal, but user can always edit or run `/ds-new <name>` to refine later.

### Dependency Inference Approach
**Choice:** Use keyword matching and relationship phrases
**Why:** Simple to implement, catches common patterns like "needs X", "requires X", "uses X", "builds on X", "after X"
**Trade-offs:** May miss complex relationships. If uncertain, we ask.

### Graph Display Format
**Choice:** ASCII tree/arrows similar to `/ds-status` dependency graph
**Why:** Consistent with existing patterns, works in terminal
**Trade-offs:** Limited for very complex graphs, but batch is unlikely to have 10+ features.

### Batch Planning Flow
**Choice:** After proposals created, single yes/no for running `/ds-plan` on all
**Why:** User requested minimal interaction. Planning is safe (doesn't modify code).
**Trade-offs:** Can't selectively plan some features. But user can decline and run `/ds-plan <name>` individually.

## Files Affected
- `skills/ds-batch/SKILL.md` - New file (the skill definition)
- `.claude-plugin/marketplace.json` - No change needed (auto-discovers from skills/)
- `specs/skills.md` - Delta spec will add requirement

Wait - per memory, skills must be explicitly listed. Let me check marketplace.json structure again.

Actually, looking at marketplace.json, it uses `plugins` to point to the plugin directory, and the plugin's internal discovery finds skills. The memory note about explicit listing was for a different structure. Current setup should auto-discover from `skills/` folder.

## Risks
- Dependency inference may be wrong for ambiguous descriptions
- Large batches (10+ features) may overwhelm the UI
- Planning failures in batch mode need clear error handling
