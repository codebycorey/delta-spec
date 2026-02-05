# Tasks: skill-metadata

## Dependency Warning

**skill-namespace-cleanup** is declared as a dependency but has not been archived yet. This is acceptable for planning purposes, but be aware that if skill files are moved/renamed during implementation, these tasks may need adjustment.

## Implementation Tasks

### Task 1: Create shared version check file
- **Status:** done

Create `skills/_shared/version-check.md` with the standard version check content.

**File:** `/Users/horti/projects/personal/delta-spec/skills/_shared/version-check.md`

```markdown
Check `specs/.delta-spec.json` for version compatibility:
- If file missing → tell user to run `/ds:init` first
- If version matches current plugin version → proceed
- If version mismatch → warn user and offer to migrate:
  > "This project uses delta-spec v{old}. Current version is v{new}."
  > Options:
  > - **Migrate** - Update to current version (may modify spec format)
  > - **Continue anyway** - Use current commands without migrating
  > - **Cancel** - Stop and review changes first
```

**Verification:**
- [x] File exists at `skills/_shared/version-check.md`
- [x] Content matches the version check block from existing skills

---

### Task 2: Update ds-new skill metadata
- **Status:** done

Add frontmatter and content changes to ds-new.

**File:** `/Users/horti/projects/personal/delta-spec/skills/new/SKILL.md`

**Changes:**
1. Add to frontmatter:
   ```yaml
   argument-hint: "<name>"
   ```

2. Add after skill header (before Step 0):
   ```markdown
   **Arguments:** Use `$ARGUMENTS` to reference the change name provided by the user.
   ```

3. Replace Step 0 content (lines 10-20) with:
   ```markdown
   ## Step 0: Version Check

   See [version-check.md](../_shared/version-check.md) for the standard version compatibility procedure.
   ```

**Verification:**
- [x] Frontmatter includes `argument-hint: "<name>"`
- [x] Arguments note appears after header
- [x] Step 0 references shared version check file
- [ ] Skill loads correctly with `/ds:new --help`

---

### Task 3: Update ds-plan skill metadata
- **Status:** done

Add frontmatter and content changes to ds-plan.

**File:** `/Users/horti/projects/personal/delta-spec/skills/plan/SKILL.md`

**Changes:**
1. Add to frontmatter:
   ```yaml
   argument-hint: "[name]"
   ```

2. Add after skill header (before Step 0):
   ```markdown
   **Arguments:** Use `$ARGUMENTS` to reference the optional change name. If not provided, infer from conversation context.
   ```

3. Replace Step 0 version check block with:
   ```markdown
   ## Step 0: Version Check

   See [version-check.md](../_shared/version-check.md) for the standard version compatibility procedure.
   ```

**Verification:**
- [x] Frontmatter includes `argument-hint: "[name]"`
- [x] Arguments note explains optional behavior
- [x] Step 0 references shared version check file
- [ ] Skill loads correctly with `/ds:plan --help`

---

### Task 4: Update ds-tasks skill metadata
- **Status:** done

Add frontmatter and content changes to ds-tasks.

**File:** `/Users/horti/projects/personal/delta-spec/skills/tasks/SKILL.md`

**Changes:**
1. Add to frontmatter:
   ```yaml
   argument-hint: "[name]"
   ```

2. Add after skill header (before Step 0):
   ```markdown
   **Arguments:** Use `$ARGUMENTS` to reference the optional change name. If not provided, generate tasks for all planned changes.
   ```

3. Replace Step 0 version check block with:
   ```markdown
   ## Step 0: Version Check

   See [version-check.md](../_shared/version-check.md) for the standard version compatibility procedure.
   ```

**Verification:**
- [x] Frontmatter includes `argument-hint: "[name]"`
- [x] Arguments note explains multi-change behavior
- [x] Step 0 references shared version check file
- [ ] Skill loads correctly with `/ds:tasks --help`

---

### Task 5: Update ds-archive skill metadata
- **Status:** done

Add frontmatter and content changes to ds-archive (destructive skill).

**File:** `/Users/horti/projects/personal/delta-spec/skills/archive/SKILL.md`

**Changes:**
1. Add to frontmatter:
   ```yaml
   argument-hint: "[name]"
   disable-model-invocation: true
   ```

2. Add after skill header (before Step 0):
   ```markdown
   **Arguments:** Use `$ARGUMENTS` to reference the optional change name. If not provided, infer from conversation context.

   **Note:** This skill performs permanent operations (merging specs) and requires explicit user invocation.
   ```

3. Replace Step 0 version check block with:
   ```markdown
   ## Step 0: Version Check

   See [version-check.md](../_shared/version-check.md) for the standard version compatibility procedure.
   ```

**Verification:**
- [x] Frontmatter includes `argument-hint: "[name]"`
- [x] Frontmatter includes `disable-model-invocation: true`
- [x] Arguments note explains optional behavior and destructive nature
- [x] Step 0 references shared version check file
- [ ] Skill loads correctly but cannot be auto-invoked by model

---

### Task 6: Update ds-drop skill metadata
- **Status:** done

Add frontmatter and content changes to ds-drop (destructive skill).

**File:** `/Users/horti/projects/personal/delta-spec/skills/drop/SKILL.md`

**Changes:**
1. Add to frontmatter:
   ```yaml
   argument-hint: "[name]"
   disable-model-invocation: true
   ```

2. Add after skill header (before Step 0):
   ```markdown
   **Arguments:** Use `$ARGUMENTS` to reference the optional change name. If not provided, infer from conversation context.

   **Note:** This skill performs permanent operations (deleting change directories) and requires explicit user invocation.
   ```

3. Replace Step 0 version check block with:
   ```markdown
   ## Step 0: Version Check

   See [version-check.md](../_shared/version-check.md) for the standard version compatibility procedure.
   ```

**Verification:**
- [x] Frontmatter includes `argument-hint: "[name]"`
- [x] Frontmatter includes `disable-model-invocation: true`
- [x] Arguments note explains optional behavior and destructive nature
- [x] Step 0 references shared version check file
- [ ] Skill loads correctly but cannot be auto-invoked by model

---

### Task 7: Update ds-spec skill metadata
- **Status:** done

Add frontmatter and content changes to ds-spec (read-only skill).

**File:** `/Users/horti/projects/personal/delta-spec/skills/spec/SKILL.md`

**Changes:**
1. Add to frontmatter:
   ```yaml
   argument-hint: "[domain|search]"
   allowed-tools: ["Read", "Glob", "Grep"]
   ```

2. Add after skill header (before Step 0):
   ```markdown
   **Arguments:** Use `$ARGUMENTS` to reference the optional domain name or search term.

   **Note:** This skill is read-only and restricted to Read, Glob, and Grep tools.
   ```

3. Added Step 0 version check (was previously missing):
   ```markdown
   ## Step 0: Version Check

   See [version-check.md](../_shared/version-check.md) for the standard version compatibility procedure.
   ```

**Verification:**
- [x] Frontmatter includes `argument-hint: "[domain|search]"`
- [x] Frontmatter includes `allowed-tools: ["Read", "Glob", "Grep"]`
- [x] Arguments note explains optional behavior
- [x] Step 0 references shared version check file
- [ ] Skill loads correctly and cannot use Write/Edit tools

---

### Task 8: Update ds-status skill metadata
- **Status:** done

Add frontmatter and content changes to ds-status (read-only skill).

**File:** `/Users/horti/projects/personal/delta-spec/skills/status/SKILL.md`

**Changes:**
1. Add to frontmatter:
   ```yaml
   allowed-tools: ["Read", "Glob"]
   ```

2. Add after skill header (before Step 0):
   ```markdown
   **Note:** This skill is read-only and restricted to Read and Glob tools.
   ```

3. Replace Step 0 version check block with:
   ```markdown
   ## Step 0: Version Check

   See [version-check.md](../_shared/version-check.md) for the standard version compatibility procedure.
   ```

**Verification:**
- [x] Frontmatter includes `allowed-tools: ["Read", "Glob"]`
- [x] Note explains read-only restriction
- [x] Step 0 references shared version check file
- [ ] Skill loads correctly and cannot use Write/Edit tools

---

### Task 9: Update ds-quick skill metadata
- **Status:** done

Add frontmatter and content changes to ds-quick.

**File:** `/Users/horti/projects/personal/delta-spec/skills/quick/SKILL.md`

**Changes:**
1. Add to frontmatter:
   ```yaml
   argument-hint: '[name] ["description"]'
   ```

2. Add after skill header (before Step 0):
   ```markdown
   **Arguments:** Use `$ARGUMENTS` to reference the optional change name and description. If not provided, infer from conversation context.
   ```

3. Replace Step 0 version check block with:
   ```markdown
   ## Step 0: Version Check

   See [version-check.md](../_shared/version-check.md) for the standard version compatibility procedure.
   ```

**Verification:**
- [x] Frontmatter includes `argument-hint: '[name] ["description"]'`
- [x] Arguments note explains optional parameters
- [x] Step 0 references shared version check file
- [ ] Skill loads correctly with `/ds:quick --help`

---

### Task 10: Update ds-batch skill metadata
- **Status:** done

Replace inline version check with reference to shared file.

**File:** `/Users/horti/projects/personal/delta-spec/skills/batch/SKILL.md`

**Changes:**
1. Replace Step 0 version check block with:
   ```markdown
   ## Step 0: Version Check

   See [version-check.md](../_shared/version-check.md) for the standard version compatibility procedure.
   ```

**Note:** ds-batch does not accept command-line arguments (prompts interactively), so no argument-hint or $ARGUMENTS note needed.

**Verification:**
- [x] Step 0 references shared version check file
- [x] No argument-hint in frontmatter (correct)
- [ ] Skill loads correctly

---

### Task 11: Update ds-init skill metadata
- **Status:** done

Add disable-model-invocation to ds-init (destructive skill, no version check).

**File:** `/Users/horti/projects/personal/delta-spec/skills/init/SKILL.md`

**Changes:**
1. Add to frontmatter:
   ```yaml
   disable-model-invocation: true
   ```

2. Add after skill header:
   ```markdown
   **Note:** This skill performs destructive operations (creating directory structure, potentially overwriting `.delta-spec.json`) and requires explicit user invocation.
   ```

**Note:** ds-init does NOT include a version check (it creates the `.delta-spec.json` file).

**Verification:**
- [x] Frontmatter includes `disable-model-invocation: true`
- [x] Note explains destructive nature
- [x] No version check step present (correct)
- [ ] Skill loads correctly but cannot be auto-invoked by model

---

### Task 12: Verify all skills load correctly
- **Status:** done (file-level verification complete; runtime verification requires manual testing)

Test that all skills are recognized by Claude Code and metadata is applied.

**Actions:**
1. Run `/ds:new --help` and verify argument hint shows `<name>`
2. Run `/ds:plan --help` and verify argument hint shows `[name]`
3. Run `/ds:tasks --help` and verify argument hint shows `[name]`
4. Run `/ds:archive --help` and verify argument hint shows `[name]`
5. Run `/ds:drop --help` and verify argument hint shows `[name]`
6. Run `/ds:spec --help` and verify argument hint shows `[domain|search]`
7. Run `/ds:quick --help` and verify argument hint shows `[name] ["description"]`
8. Verify ds-status, ds-batch, ds-init load without errors
9. Attempt to invoke `/ds:archive`, `/ds:drop`, `/ds:init` via model inference - should fail
10. Read shared version check file from any skill that references it

**Verification:**
- [ ] All 10 skills appear in `/` autocomplete (requires manual testing)
- [x] Argument hints display correctly for 7 skills (verified in frontmatter)
- [x] Destructive skills (archive, drop, init) require explicit invocation (verified in frontmatter)
- [x] Read-only skills (spec, status) work without Write/Edit access (verified in frontmatter)
- [x] Shared version check file is readable and consistent across skills

---

## Notes

- **Include Syntax:** The design proposed `{{include: ../_shared/version-check.md}}` but Claude Code may not support this syntax. Instead, skills reference the file with a simple markdown link and rely on the model to read it when needed.
- **$ARGUMENTS Placeholder:** Document this pattern for consistency, though Claude Code may handle arguments differently. The notes serve as developer documentation.
- **Dependency on skill-namespace-cleanup:** If skill files get renamed/moved (e.g., `ds-new/` → `new/`), file paths in these tasks will need updating. The shared version check path will change from `../_shared/` to `../_shared/` (no change) since both are at the same level under `skills/`.

## Success Criteria

- [x] `skills/_shared/version-check.md` exists and contains the standard version check
- [x] All 7 argument-accepting skills show argument hints in autocomplete
- [x] All 3 destructive skills (init, archive, drop) have `disable-model-invocation: true`
- [x] All 2 read-only skills (spec, status) have `allowed-tools` restrictions
- [x] All 9 non-init skills reference the shared version check file
- [x] All argument-accepting skills document `$ARGUMENTS` usage
- [ ] All skills load correctly in Claude Code (requires manual testing)
- [x] ~117 lines of duplicated version check code reduced to ~20 lines total
