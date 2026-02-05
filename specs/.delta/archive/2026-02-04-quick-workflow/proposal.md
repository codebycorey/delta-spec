# Proposal: quick-workflow

## Problem

The current delta-spec workflow requires multiple skill invocations with confirmations at each step:
1. `/ds-new` - interactive proposal creation
2. `/ds-plan` - design and delta specs
3. `/ds-tasks` - implementation tasks

For straightforward changes where the user already knows what they want, this is tedious. Users want to go from idea to ready-to-implement with a single command.

## Dependencies

None

## Changes

- Add new `/ds-quick` skill that chains: proposal → plan → tasks
- Accepts optional name and description as arguments
- If arguments omitted, infers from conversation context
- Shows generated proposal and asks for confirmation before proceeding
- After confirmation, runs plan → tasks without further prompts
- Stops before implementation (user still implements and runs `/ds-archive`)

## Capabilities

### New

- `/ds-quick [name] ["description"]` - Single command to create proposal, design, and tasks
- Context-aware: infers name and description from conversation if not provided
- Single confirmation point: approve the proposal, then auto-runs remaining steps

### Modified

- None (additive change)

## Out of Scope

- Auto-archiving (that should remain a deliberate, confirmed action)
- Making existing skills non-interactive
- Config-based interactivity settings

## Success Criteria

- `/ds-quick my-feature "Add X to Y"` creates proposal.md, shows it, asks confirmation, then creates design.md, specs/, and tasks.md
- `/ds-quick` (no args) infers from conversation context
- Single confirmation point: after proposal, before plan
- After confirmation, plan and tasks run without prompts
- Output summarizes what was created
- Archive workflow unchanged (still requires confirmation)
