Determine which change to operate on:

1. If `name` provided in arguments → use `specs/.delta/<name>/`
2. If inferable from conversation context (e.g., user just ran another skill for a specific change) → use it
3. If only one active change in `specs/.delta/` (excluding `archive/`) → use it
4. If multiple and not inferable → use AskUserQuestion to let user pick
5. If none → suggest the appropriate prerequisite (varies by skill)

### Context-specific notes

- **plan**: Prerequisite = suggest `/ds:new`. No confirmation for single change.
- **archive**: If none → "nothing to archive". No confirmation for single change.
- **drop**: If none → "nothing to drop". Confirm even with single change (destructive operation).
- **tasks**: Uses multi-change mode — if no name and multiple planned changes, process all in dependency order. Prerequisite = suggest `/ds:plan`.
