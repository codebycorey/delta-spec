# Design: test-task-generation

## Context

The `/ds-tasks` skill currently has a "Step 3: Explore the codebase" that identifies files, functions, and integration points. However, it doesn't mention checking for test infrastructure.

Step 4 creates the task file but doesn't mention including test tasks.

The skill is a prompt-based instruction file—Claude interprets it and generates tasks accordingly. Adding guidance about tests is a matter of adding two bullet points.

## Approach

Add minimal guidance to the existing steps:
1. In Step 3, add a bullet to check for test infrastructure
2. In Step 4, add a bullet to include test tasks when tests exist

Claude will infer the rest from context—what testing framework, what patterns, whether unit/integration tests are appropriate.

## Decisions

### Keep it minimal
**Choice:** Two bullet points, no new sections or configuration
**Why:** The skill is prompt-based; Claude is smart enough to figure out details from context
**Trade-offs:** Less explicit control, but avoids over-specification

### No framework-specific guidance
**Choice:** Don't mention specific frameworks (Jest, pytest, etc.)
**Why:** Claude detects this during exploration anyway; listing frameworks would become outdated
**Trade-offs:** None—this is strictly better

## Files Affected

- `skills/ds-tasks/SKILL.md` - Add two bullets (Step 3 and Step 4)
- `specs/skills.md` - Add scenario for test task generation

## Risks

- None significant. This is additive behavior that only activates when tests exist.
