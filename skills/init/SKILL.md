---
description: Initialize delta-spec in a repository. Use when setting up delta-spec for the first time, creating specs/ directory structure, or generating specs from existing code.
disable-model-invocation: true
---

# /ds:init - Initialize delta-spec

Set up the specs directory structure and optionally generate initial specifications from existing codebase code.

**Note:** This skill performs destructive operations (creating directory structure, potentially overwriting `.delta-spec.json`) and requires explicit user invocation.

## Directory Structure

```
specs/                        # Source of truth
├── .delta-spec.json          # Version and config
├── auth.md                   # Main specs by domain
├── payments.md
└── .delta/                   # Work in progress
    ├── <change-name>/        # Current changes
    └── archive/              # Completed changes
```

## Steps

**Step 1: Create directory structure**
- Create `specs/` directory
- Create `specs/.delta/` directory
- Create `specs/.delta/archive/` directory
- Create `specs/.delta-spec.json` with the current plugin version (read from `.claude-plugin/plugin.json`):
  ```json
  {
    "version": "<version from .claude-plugin/plugin.json>",
    "initialized": "YYYY-MM-DD"
  }
  ```

**Step 2: Ask about existing code**
Ask the user:
> "Would you like me to explore the codebase and generate initial specs based on existing code?"
>
> Options:
> - **Yes, generate specs** - I'll analyze the codebase and create spec files for each domain I discover
> - **No, start fresh** - Just create the empty folder structure

**If user chooses "generate specs":**

**Step 3: Explore the codebase**
- Identify major domains/bounded contexts (auth, payments, api, etc.)
- Find key behaviors, business rules, and requirements
- Look at existing tests for behavioral expectations
- Examine API routes, models, services for structure

**Step 4: Generate specs per domain**
For each domain discovered:
- Create `specs/<domain>.md` with frontmatter indicating it was generated:
  ```yaml
  ---
  generated: true
  generated_at: YYYY-MM-DD
  ---
  ```
- Document existing behavior as requirements
- Use the standard spec format with Requirements and Scenarios
- User can remove frontmatter after reviewing/refining the spec

**Step 5: Summary**
- List all spec files created
- Note any areas that need manual review
- Suggest running `/ds:status` to see the result

**If user chooses "start fresh":**
- Just confirm the directories were created
- Suggest running `/ds:new <name>` to start their first change

**Idempotency:**
- If `specs/` already exists, skip creation and note it
- If specs already exist, ask before overwriting
- Safe to run multiple times

## Spec Format

See [spec-format.md](../_shared/spec-format.md) for the standard spec format and writing guidelines.
