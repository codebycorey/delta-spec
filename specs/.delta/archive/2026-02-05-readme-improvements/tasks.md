# Tasks: readme-improvements

**WARNING:** Dependencies `skill-namespace-cleanup` and `skill-metadata` are not yet archived. This change depends on their completion. Proceed with planning but defer implementation until dependencies are satisfied.

## Status

- [x] 1. Update installation section with persistence note
- [x] 2. Update installation section with marketplace placeholder
- [x] 3. Update installation verification instructions
- [x] 4. Replace CLAUDE.md recommendation with assertive STOP pattern
- [x] 5. Add validate-specs.sh limitations section
- [x] 6. Update skills table to use /ds:* notation (blocked by skill-namespace-cleanup)
- [x] 7. Final review pass for consistency

---

## 1. Update installation section with persistence note

**File:** `/Users/horti/projects/personal/delta-spec/README.md`

**Location:** After line 22 (the `claude --plugin-dir` command)

**Action:** Add a note explaining that `--plugin-dir` must be specified on every launch.

**Changes:**
After the code block showing the installation command (lines 20-23), add:

```markdown
> **Note:** You must use `--plugin-dir` each time you launch Claude Code to load the plugin. This is required until the plugin is installed from the marketplace.
```

**Status:** `[ ]`

---

## 2. Update installation section with marketplace placeholder

**File:** `/Users/horti/projects/personal/delta-spec/README.md`

**Location:** Line 29 (current marketplace note)

**Action:** Replace the existing marketplace note with clearer wording and future installation command.

**Changes:**
Replace line 29:
```markdown
> **Note:** Marketplace installation will be available once the plugin is published. For now, use the local installation method above.
```

With:
```markdown
> **Note:** Marketplace installation is not yet available. Once published, you will be able to install with `/plugin install ds`.
```

**Status:** `[ ]`

---

## 3. Update installation verification instructions

**File:** `/Users/horti/projects/personal/delta-spec/README.md`

**Location:** Lines 25-27 (Verify Installation section)

**Action:** Ensure verification section clearly states what to look for.

**Changes:**
Review lines 25-27. Current text says "run `/skills` to see the `ds-*` skills listed."

After task 6 is complete (skill names updated to `/ds:*` notation), update this to:
```markdown
### Verify Installation

After installation, run `/skills` to see the `ds` plugin skills listed (e.g., `/ds:init`, `/ds:new`, `/ds:plan`).
```

**Dependency:** Task 6 (skills table update)

**Status:** `[ ]`

---

## 4. Replace CLAUDE.md recommendation with assertive STOP pattern

**File:** `/Users/horti/projects/personal/delta-spec/README.md`

**Location:** Lines 37-53 (entire "Recommended: Add to CLAUDE.md" section)

**Action:** Replace the current soft recommendation with the proven assertive pattern from the project's own CLAUDE.md.

**Changes:**
Replace lines 37-53 with:

```markdown
### Recommended: Add to CLAUDE.md

To ensure Claude consistently uses delta-spec for all feature work, add this to your project's `CLAUDE.md`:

\```markdown
## REQUIRED: Use delta-spec for all changes

When the conversation shifts from discussion to implementation—phrases like:
- "let's add that"
- "make that change"
- "can you implement..."
- "go ahead and..."
- "update the code to..."

**STOP.** Before using Edit or Write on any project file, run `/ds-new <name>` first.

### Exceptions (direct edits OK)
- Fixing typos or formatting
- Changes already tracked by an active delta-spec change
- CLAUDE.md or README.md updates

### Workflow
1. `/ds-new <name>` - Create proposal
2. `/ds-plan` - Explore codebase, create design + delta specs
3. `/ds-tasks` - Generate implementation tasks
4. Implement the changes
5. `/ds-archive` - Merge specs when complete
\```

This assertive pattern ensures Claude pauses and uses the spec-driven workflow instead of directly editing files.
```

**Rationale:** The "STOP" pattern from the project's own CLAUDE.md is proven to work and is more effective than a soft suggestion.

**Status:** `[ ]`

---

## 5. Add validate-specs.sh limitations section

**File:** `/Users/horti/projects/personal/delta-spec/README.md`

**Location:** After line 172 (end of the validation bulleted list)

**Action:** Add a new "Limitations" subsection documenting what the script doesn't validate.

**Changes:**
After the bulleted list that ends on line 172, add:

```markdown
#### Limitations

The validation script performs basic structural checks but does **not** validate:
- **Requirement references** - Does not verify that MODIFIED or REMOVED operations reference existing requirements in main specs
- **Scenario completeness** - Does not enforce that all scenarios have GIVEN-WHEN-THEN structure
- **Cross-file consistency** - Does not check for duplicate requirement names across specs
- **Delta merge conflicts** - Does not detect when multiple changes modify the same requirement

For comprehensive validation, use `/ds-status` to detect conflicts and `/ds-archive` with pre-validation to ensure safe merging.
```

**Rationale:** Sets correct expectations about script capabilities and points users to more robust validation.

**Status:** `[ ]`

---

## 6. Update skills table to use /ds:* notation (blocked by skill-namespace-cleanup)

**File:** `/Users/horti/projects/personal/delta-spec/README.md`

**Location:** Lines 57-68 (Skills table)

**Action:** Update skill invocation format from `/ds-init` to `/ds:init` throughout the README.

**BLOCKED:** This task depends on the `skill-namespace-cleanup` change being completed and archived first. The namespace cleanup will rename skill directories and update the plugin configuration to expose skills with the `/ds:*` notation.

**Changes (once unblocked):**
Replace all skill references in the table (lines 57-68) and throughout the README:
- `/ds-init` → `/ds:init`
- `/ds-new` → `/ds:new`
- `/ds-quick` → `/ds:quick`
- `/ds-batch` → `/ds:batch`
- `/ds-plan` → `/ds:plan`
- `/ds-tasks` → `/ds:tasks`
- `/ds-archive` → `/ds:archive`
- `/ds-drop` → `/ds:drop`
- `/ds-spec` → `/ds:spec`
- `/ds-status` → `/ds:status`

Also update:
- Line 27 (Verify Installation section)
- Lines 34-35 (Getting Started section)
- Lines 72-78 (Workflow diagram)
- Lines 124, 155-157 (Testing Locally section)
- Any other skill references in examples

**Dependency:** `skill-namespace-cleanup` must be archived

**Status:** `[ ]` (blocked)

---

## 7. Final review pass for consistency

**File:** `/Users/horti/projects/personal/delta-spec/README.md`

**Action:** Review the entire README to ensure all changes are consistent and flow well together.

**Checklist:**
- [ ] Installation section flows logically (install → note → verify → marketplace)
- [ ] CLAUDE.md recommendation uses exact syntax from project's CLAUDE.md
- [ ] Validation limitations section is clear and actionable
- [ ] Skills notation is consistent throughout (`/ds:*` format)
- [ ] No broken markdown formatting
- [ ] All code blocks are properly fenced
- [ ] Tone is consistent across all new sections

**Dependency:** All previous tasks complete

**Status:** `[ ]`

---

## Implementation Order

1. Tasks 1, 2, 4, 5 can be done immediately (no dependencies)
2. Task 6 must wait for `skill-namespace-cleanup` to be archived
3. Task 3 should be done after Task 6 (references new skill notation)
4. Task 7 should be done last (final review)

**Recommended sequence:**
1. Complete independent tasks (1, 2, 4, 5)
2. Wait for `skill-namespace-cleanup` to complete
3. Complete Task 6 (update skill notation)
4. Complete Task 3 (update verification)
5. Complete Task 7 (final review)
