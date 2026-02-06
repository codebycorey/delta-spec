---
description: Quick start a change with minimal interaction. Use when fast-tracking a straightforward change that needs proposal, design, and tasks in one step.
argument-hint: '[name] ["description"]'
---

# /ds:quick [name] ["description"] - Quick start a change

Create a complete change setup (proposal, design, tasks) with a single confirmation point.

**Arguments:** If `$ARGUMENTS` is provided, use it as the `name` and optional `description` parameters. Otherwise, infer from conversation context.

## Step 0: Version Check

See [version-check.md](../_shared/version-check.md) for the standard version compatibility check procedure.

## Step 1: Parse arguments or infer from context

- If `name` and `description` provided → use them
- If only `name` provided → infer description from conversation context
- If neither provided → infer both from conversation context
- Generate a kebab-case name if inferring (e.g., "add-user-auth")

## Step 2: Check for existing change

- If `specs/.delta/<name>/` already exists:
  - Warn: "Change '<name>' already exists"
  - Ask: Continue with existing change, or pick a different name?
- If new → create `specs/.delta/<name>/` directory

## Step 3: Create proposal

Create `specs/.delta/<name>/proposal.md` using the standard template. See [proposal-template.md](../_shared/proposal-template.md).

Fill in sections based on the provided description and conversation context. Keep it concise but complete.

## Step 4: Show proposal and confirm

Display the generated proposal to the user, then ask:

> **Proceed with planning and task generation? [y/N]**

- On "y" or "yes" → continue to Step 5
- On "n", empty, or anything else → stop here
  - Tell user: "Proposal saved. You can refine it with `/ds:new <name>` or continue later with `/ds:plan`"

**Note:** Steps 5-7 run without additional prompts.

## Step 5: Run planning

Execute the planning phase without interaction:

1. **Explore the codebase** - Find relevant code, patterns, architecture
2. **Create design.md** - Document context, approach, decisions, files affected
3. **Create delta specs** - Generate `specs/.delta/<name>/specs/<domain>.md` files

## Step 6: Run task generation

Execute task generation without interaction:

1. **Analyze design and delta specs**
2. **Identify implementation tasks**
3. **Create tasks.md** with ordered, actionable tasks
4. **Check for test infrastructure** - include test tasks if tests exist

## Step 7: Output summary

Display a summary of everything created:

```
✓ Created proposal.md
✓ Created design.md
✓ Created specs/<domain>.md
✓ Created tasks.md (N tasks)

Ready to implement. Run `/ds:archive` when complete.
```

## Behavior Notes

- Designed for straightforward changes with well-understood scope
- For complex changes requiring discussion, use `/ds:new` → `/ds:plan` → `/ds:tasks`
- The proposal confirmation is the single gate — it must capture the intended scope
- Archive still requires separate confirmation (`/ds:archive`)
