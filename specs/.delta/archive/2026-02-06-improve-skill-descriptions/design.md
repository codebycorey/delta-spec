# Design: improve-skill-descriptions

## Context

7 skills lack `disable-model-invocation: true`, meaning they are candidates for automatic model invocation. Their current descriptions use imperative form ("Start a new change...") rather than the recommended "This skill should be used when..." pattern with trigger phrases.

Skills to update (model-invocable):
- `new/SKILL.md` — "Start a new change with a proposal..."
- `plan/SKILL.md` — "Create design and delta specs..."
- `tasks/SKILL.md` — "Generate implementation tasks..."
- `spec/SKILL.md` — "View, discuss, or search specifications."
- `status/SKILL.md` — "Show active changes with progress..."
- `quick/SKILL.md` — "Quick start a change with minimal interaction..."
- `batch/SKILL.md` — "Create multiple proposals from free-form..."

Skills NOT updated (disabled invocation):
- `init/SKILL.md` — `disable-model-invocation: true`
- `archive/SKILL.md` — `disable-model-invocation: true`
- `drop/SKILL.md` — `disable-model-invocation: true`

Note: Since these are namespace-prefixed skills (`/ds:*`), model invocation via natural language is less common than for general-purpose skills. Still, improved descriptions help Claude understand when to suggest these skills.

## Approach

Update the `description` field in YAML frontmatter for each of the 7 skills. Each new description:
1. Starts with what the skill does (concise)
2. Adds "Use when..." trigger context
3. Includes 2-3 natural language trigger phrases

Keep descriptions under ~200 characters to avoid bloating the skill listing.

## Decisions

### Concise trigger format, not "This skill should be used when..."
**Choice:** Use "Use when..." instead of "This skill should be used when..."
**Why:** The latter is verbose for namespace-prefixed skills that are primarily invoked explicitly. "Use when..." is more concise while still providing trigger context.
**Trade-offs:** Slightly less formal, but better density

### Don't change disabled skills
**Choice:** Leave init, archive, drop descriptions as-is
**Why:** They can't be model-invoked, so trigger phrases add no value
**Trade-offs:** Inconsistency between disabled and enabled skill description styles, but this is intentional

## Files Affected
- `skills/new/SKILL.md` — Update description in frontmatter
- `skills/plan/SKILL.md` — Update description in frontmatter
- `skills/tasks/SKILL.md` — Update description in frontmatter
- `skills/spec/SKILL.md` — Update description in frontmatter
- `skills/status/SKILL.md` — Update description in frontmatter
- `skills/quick/SKILL.md` — Update description in frontmatter
- `skills/batch/SKILL.md` — Update description in frontmatter

## Risks
- Descriptions that are too long may get truncated in skill listings
- Trigger phrases may cause false-positive invocations if too broad
