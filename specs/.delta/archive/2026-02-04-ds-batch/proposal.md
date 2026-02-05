# Proposal: ds-batch

## Problem
When planning multiple related features, users must manually run `/ds-new` for each one sequentially. This is tedious for larger planning sessions where you want to sketch out several features at once, especially when they have interdependencies.

## Dependencies
None

## Changes
- Add new `/ds-batch` skill that accepts multiple feature descriptions
- Parse features and infer dependencies from natural language
- Create proposals for each feature
- Offer to run `/ds-plan` for all with single confirmation

## Capabilities

### New
- **Free-form input** - Describe features in natural language prose or lists
- **Smart dependency inference** - Automatically detect relationships from descriptions (e.g., "permissions system that uses auth" → depends on auth). Only ask user if confidence is low.
- **Dependency graph display** - Show parsed features and their relationships before creating
- **Batch proposal creation** - Create all proposals after single confirmation
- **Optional batch planning** - After proposals created, single yes/no: "Run `/ds-plan` for all?"

### Modified
- None (this is additive)

## Out of Scope
- Parallel subagent execution (skills run in main context)
- Automatic implementation (still requires `/ds-tasks` and coding)
- Complex configuration options

## Success Criteria
- User can describe multiple features in free-form prose
- Dependencies are correctly inferred without asking (unless uncertain)
- All proposals created with proper structure
- Single confirmation gate for batch planning
