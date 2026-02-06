# Design: extract-cycle-detection

## Context

Cycle detection logic currently exists in 4 skills with varying levels of detail:

- **new/SKILL.md** (lines 57-102): Full implementation — DFS algorithm, description analysis, common concept extraction, extraction suggestion prompt, confirm/decline flows
- **batch/SKILL.md** (lines 229-302): Nearly identical to new — same DFS, analysis, extraction, confirm/decline, but adds "delete invalidated artifacts" and "run /ds:plan for affected"
- **archive/SKILL.md** (lines 35-53): Lighter variant — build graph, detect cycle, warn + "proceed anyway?" (since archiving may break the cycle)
- **status/SKILL.md** (lines 57-68): Lightest — DFS detection only, display warning, suggest resolution commands

The existing shared pattern (`_shared/version-check.md`) is referenced via relative path `See [version-check.md](../_shared/version-check.md)`. Skills include a brief contextual note and point to the shared file.

## Approach

Create `skills/_shared/cycle-detection.md` that contains:

1. **Core algorithm** — DFS with path tracking (shared by all 4 skills)
2. **Analysis procedure** — Description tokenization, common concept extraction, base name suggestion (shared by new + batch)
3. **Resolution prompt template** — The `⚠️ Cycle detected:` format (shared by all, with parameters)
4. **Context-specific behavior markers** — Clearly labeled sections so each skill knows which parts to follow

Each skill replaces its inline logic with:
- A brief contextual sentence (why cycle detection matters here)
- A reference to the shared file: `See [cycle-detection.md](../_shared/cycle-detection.md)`
- Context-specific behavior notes (1-3 lines) explaining what to do after detection

## Decisions

### Structure: Single file with labeled sections
**Choice:** One `_shared/cycle-detection.md` file with clearly labeled sections for different contexts
**Why:** The algorithm is the same everywhere; only the response to a detected cycle varies. Labeled sections (e.g., "### Resolution: Full (new, batch)" vs "### Resolution: Warn-only (archive, status)") let each skill reference the relevant section.
**Trade-offs:** Slightly longer shared file, but eliminates all duplication

### Reference style: Match version-check pattern
**Choice:** Use the same `See [file](path)` pattern as version-check.md
**Why:** Consistency with existing shared file convention
**Trade-offs:** None — proven pattern

## Files Affected
- `skills/_shared/cycle-detection.md` - New shared file with canonical cycle detection
- `skills/new/SKILL.md` - Replace lines 57-102 with reference + context note
- `skills/batch/SKILL.md` - Replace lines 229-302 with reference + context note
- `skills/archive/SKILL.md` - Replace lines 35-53 with reference + context note
- `skills/status/SKILL.md` - Replace lines 57-68 with reference + context note

## Risks
- Skills currently have slightly different wording in their prompts; the shared version must be general enough to cover all contexts while remaining clear
- The batch skill's cycle detection is interleaved with consolidation notes (line 231) — the reference needs to preserve that context
