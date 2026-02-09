Task files use this format:

```markdown
# Tasks: <change-name>

Generated: YYYY-MM-DD

---

## Task 1: <title>
- **Status:** pending
- **Owner:** (unassigned)
- **Files:** path/to/file.ts
- **Refs:** [Requirement Name]

<description of what to do>

## Task 2: <title>
- **Status:** pending
- **Owner:** (unassigned)
- **Files:** path/to/other.ts
- **Refs:** [Another Requirement]

<description>
```

### Task Fields

| Field | Required | Values |
|-------|----------|--------|
| Status | Yes | `pending`, `in_progress`, `done` |
| Owner | Yes | Agent identifier or `(unassigned)` |
| Files | No | Primary file(s) affected |
| Refs | No | Links to requirements |

### Updating Tasks

Agents update tasks by editing the file directly:

1. **Claim task:** Set `Status: in_progress` and `Owner: <agent-id>`
2. **Complete task:** Set `Status: done` (keep owner for attribution)
3. **Unclaim task:** Set `Status: pending` and `Owner: (unassigned)`
