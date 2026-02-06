---
description: Start a new change with a proposal. Use when starting a feature, creating a proposal, or beginning planned work.
argument-hint: "<name>"
---

# /ds:new <name> - Start a new change

Start a new change by creating a proposal.

**Arguments:** If `$ARGUMENTS` is provided, use it as the `name` parameter. Otherwise, ask the user for a change name.

## Step 0: Version Check

See [version-check.md](../_shared/version-check.md) for the standard version compatibility check procedure.

## Step 1: Create change directory

Create `specs/.delta/<name>/` directory.

Names should be kebab-case (e.g., `add-user-auth`, `fix-login-bug`). If the user provides a name with spaces or other formatting, convert to kebab-case and confirm.

## Step 2: Create proposal from template

Create `proposal.md` using the standard template. See [proposal-template.md](../_shared/proposal-template.md).

## Step 3: Work with user on proposal

Work with the user to flesh out the proposal interactively:

1. **Problem** — Ask what problem this solves and why it matters. This grounds the entire change.
2. **Changes** — Ask what specific changes are needed. Probe for concrete details.
3. **Success Criteria** — Ask how they'll know it's complete. This defines "done."
4. **Dependencies** — Ask if this depends on other changes being completed first.
5. **Out of Scope** — Suggest reasonable boundaries based on the discussion.
6. **Capabilities** — Infer new/modified capabilities from the changes discussed.

The proposal is complete when Problem, Changes, and Success Criteria have substantive content. Other sections can use reasonable defaults.

## Step 4: Check for cycles

After the proposal is complete (especially the Dependencies section), check if the declared dependencies create a cycle with existing changes.

See [cycle-detection.md](../_shared/cycle-detection.md) for the cycle detection algorithm. Follow the **Full resolution** flow.
