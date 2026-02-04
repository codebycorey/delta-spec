---
description: Create implementation tasks for one or all planned changes
argument-hint: [name]
---

Create actionable implementation tasks for a single change or all planned changes in dependency order.

**Input**: $ARGUMENTS (optional change name; if omitted, processes all planned changes)

Reads the proposal, design, and delta specs, then creates tasks using Claude Code's native TaskCreate tool. When processing multiple changes, tasks are created in dependency order with sequential numbering.

Use the tasks skill to execute this workflow.
