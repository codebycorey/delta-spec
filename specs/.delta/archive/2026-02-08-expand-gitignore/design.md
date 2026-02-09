# Design: expand-gitignore

## Context
Current `.gitignore` has only 2 entries:
```
.DS_Store
*.log
```

Contributors using different toolchains (Node.js, Python, etc.) may accidentally commit artifacts.

## Approach
Add common development artifact patterns to `.gitignore`, grouped by category.

## Decisions

### Keep additions minimal and universal
**Choice:** Only add entries that apply broadly across toolchains
**Why:** This is a Claude Code plugin, not a Node.js or Python project — keep ignores generic
**Trade-offs:** May need to add more specific entries later if the project adopts a build step

## Files Affected
- `.gitignore` - Add `node_modules/`, `.env`, `*.tmp`

## Risks
- None — additive change to gitignore
