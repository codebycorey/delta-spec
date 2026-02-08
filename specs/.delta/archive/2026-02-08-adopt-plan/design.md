# Design: adopt-plan

## Context

Delta-spec currently has two paths to get from "idea" to "ready to implement":

1. **Standard**: `/ds:new` → `/ds:plan` → `/ds:tasks` — interactive, explores codebase during plan
2. **Quick**: `/ds:quick` — single confirmation, but still explores codebase during plan
3. **Batch**: `/ds:batch` — multiple features, but re-prompts for descriptions and re-explores during plan

All three paths assume planning starts inside delta-spec. When users do planning externally (Claude Code plan mode, conversation discussion), they've already done the codebase exploration and made design decisions. Funneling that through `/ds:batch` or `/ds:plan` forces redundant exploration.

The codebase follows consistent patterns:
- Skills live in `skills/<name>/SKILL.md` with YAML frontmatter
- Shared logic lives in `skills/_shared/*.md`
- Specs use the delta format (ADDED/MODIFIED/REMOVED) in `specs/.delta/<name>/specs/`
- Proposals use the shared template from `_shared/proposal-template.md`
- Skills that create proposals reference the shared template
- Skills that take optional args use `argument-hint` in frontmatter

## Approach

Create a `/ds:adopt` skill that:

1. Reads the conversation context (plan mode output, discussion) — no user re-prompting
2. Extracts one or more changes from that context
3. For each change: creates proposal + design + delta specs directly (no codebase exploration)
4. Shows the extracted changes for confirmation before writing
5. Drops the user at `/ds:tasks` as the next step

The skill is closest to `/ds:batch` in structure (multi-change from context) but skips the exploration phase of `/ds:plan`. It also borrows from `/ds:quick` (minimal interaction, infer from context).

### Key difference from batch
- `/ds:batch` prompts for feature descriptions, then explores during `/ds:plan`
- `/ds:adopt` reads existing context, writes proposals + designs + deltas directly

### Key difference from quick
- `/ds:quick` infers one change from context, then explores codebase
- `/ds:adopt` infers one or more changes from context, skips exploration entirely

## Decisions

### Single skill vs. mode on existing skill
**Choice:** New standalone `/ds:adopt` skill
**Why:** The workflow is distinct enough — it skips exploration entirely and writes designs directly from context. Adding a mode flag to `/ds:batch` or `/ds:quick` would complicate their already well-defined flows.
**Trade-offs:** One more skill to maintain, but it's self-contained.

### Show changes for confirmation before writing
**Choice:** Show extracted proposals and ask "Create these changes? [y/N]" before writing any files
**Why:** Extracting structured changes from conversation is an interpretation step. The user should verify the extraction is correct before committing to it.
**Trade-offs:** One extra confirmation step, but it prevents incorrect extractions from silently creating wrong specs.

### Write designs directly (skip exploration)
**Choice:** Write `design.md` and delta specs from conversation context, not from codebase exploration
**Why:** This is the whole point — the user already explored the codebase. Re-exploring wastes time and may even produce different (worse) results than the planning the user already validated.
**Trade-offs:** If the conversation context is thin, the designs may be less thorough than `/ds:plan` would produce. This is acceptable — users can always run `/ds:plan` instead if they want exploration.

### Support both single and multi-change
**Choice:** Handle both single-change and multi-change plans in one skill
**Why:** Plans from plan mode can be either — one focused feature or a multi-feature roadmap. The skill should handle both naturally.
**Trade-offs:** Slightly more complex extraction logic, but `/ds:batch` already solved the multi-change display pattern.

### Dependency inference from context
**Choice:** Infer dependencies from the plan context (same as `/ds:batch` does from descriptions)
**Why:** Plans often describe dependencies explicitly ("X needs Y first"). Reuse the same dependency signal patterns from batch.
**Trade-offs:** None significant — this is proven logic.

## Files Affected
- `skills/adopt/SKILL.md` — **new** — the adopt skill definition
- `specs/skills.md` — **modified** — add Adopt Plan requirement
- `specs/workflow.md` — **modified** — add adopt to Change Lifecycle
- `skills/_shared/determine-change.md` — **modified** — note adopt doesn't use this (like quick)
- `CLAUDE.md` — **modified** — add adopt to skills table and codebase map
- `README.md` — **modified** — add adopt to skills table and workflow

## Risks
- Conversation context may not always have enough detail for good delta specs — mitigated by the confirmation step and the option to fall back to `/ds:plan`
- Users might be confused about when to use `/ds:adopt` vs `/ds:batch` — mitigated by clear description triggers in frontmatter
