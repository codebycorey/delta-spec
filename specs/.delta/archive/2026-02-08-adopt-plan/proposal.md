# Proposal: adopt-plan

## Problem
When users do thorough planning in Claude Code's plan mode (or through conversation), there's no way to bring that planning into delta-spec without re-doing it. Running `/ds:batch` or `/ds:new` → `/ds:plan` forces a full codebase re-exploration and re-planning phase, duplicating work that's already been done well. The real value users want at that point is spec tracking (delta format, archiving, tasks) — not re-planning.

## Dependencies
None

## Changes
- Add new `/ds:adopt` skill that captures existing planning context into delta-spec's format
- Extract proposals from conversation/plan context without re-exploring the codebase
- Write delta specs directly from the plan (skip `/ds:plan`'s exploration phase)
- Drop users at the tasks step so they can proceed to implementation
- Update plugin manifest, specs, README, and CLAUDE.md

## Capabilities

### New
- `/ds:adopt` skill — imports an existing plan into delta-spec as proposals + delta specs, ready for `/ds:tasks`

### Modified
- `skills.md` spec — add adopt skill requirements
- Plugin discovery — register new skill

## Out of Scope
- Modifying how `/ds:plan` works (it stays as-is for when exploration is needed)
- Auto-detecting that a plan exists and suggesting adopt (could be future work)
- Importing plans from external tools or files (conversation context only)

## Success Criteria
- User can run `/ds:adopt` after planning in conversation/plan mode
- Planning context is captured as structured proposals with delta specs
- No redundant codebase exploration happens
- User lands at `/ds:tasks` as next step
- Works for single-change and multi-change plans
