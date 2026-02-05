# Design: readme-improvements

## Overview

Enhance README.md to improve the user onboarding experience and accuracy. This includes:
1. Verification step in installation section
2. Clarification that `--plugin-dir` is required on every launch
3. Marketplace installation placeholder
4. Stronger CLAUDE.md recommendation using the assertive "STOP" pattern
5. Documentation of validate-specs.sh limitations

## Changes by Section

### 1. Installation Section (lines 14-29)

**Current state:**
- Instructions end with just the command to run Claude
- Verification step mentions running `/skills` but is a separate section
- No mention that `--plugin-dir` is needed on every launch
- Marketplace note says "will be available once published"

**Changes:**

#### Add persistence note after command
After line 22 (the `claude --plugin-dir` command), add a note:
```markdown
> **Note:** You must use `--plugin-dir` each time you launch Claude Code to load the plugin. This is required until the plugin is installed from the marketplace.
```

#### Keep verification section as-is
The "Verify Installation" section (lines 26-28) is fine - just ensure it flows after the persistence note.

#### Update marketplace note
Replace line 29 with:
```markdown
> **Note:** Marketplace installation is not yet available. Once published, you will be able to install with `/plugin install ds`.
```

### 2. CLAUDE.md Recommendation Section (lines 37-53)

**Current state:**
- Presents a soft recommendation with example snippet
- Does not emphasize the STOP pattern
- The example is descriptive but not prescriptive

**Changes:**

Replace the entire section (lines 37-53) with a stronger recommendation:

```markdown
### Recommended: Add to CLAUDE.md

To ensure Claude consistently uses delta-spec for all feature work, add this to your project's `CLAUDE.md`:

```markdown
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
```

This assertive pattern ensures Claude pauses and uses the spec-driven workflow instead of directly editing files.
```

**Rationale:**
- The "STOP" pattern from CLAUDE.md is proven to work
- Shows the actual recommended snippet users should copy
- Emphasizes the requirement rather than soft suggestion
- Includes exceptions to avoid unnecessary friction
- Provides complete workflow context

### 3. Validating Specs Section (lines 159-172)

**Current state:**
- Shows what the script checks for
- No mention of limitations or what it doesn't validate

**Changes:**

After the bulleted list (line 172), add a new subsection:

```markdown
#### Limitations

The validation script performs basic structural checks but does **not** validate:
- **Requirement references** - Does not verify that MODIFIED or REMOVED operations reference existing requirements in main specs
- **Scenario completeness** - Does not enforce that all scenarios have GIVEN-WHEN-THEN structure
- **Cross-file consistency** - Does not check for duplicate requirement names across specs
- **Delta merge conflicts** - Does not detect when multiple changes modify the same requirement

For comprehensive validation, use `/ds-status` to detect conflicts and `/ds-archive` with pre-validation to ensure safe merging.
```

**Rationale:**
- Sets correct expectations about script capabilities
- Points users to more robust validation via skills
- Prevents confusion when script passes but archive fails

## Technical Approach

These are documentation-only changes with no code or spec modifications. The changes will be made directly to README.md as a single edit operation.

### File Changes
- `/Users/horti/projects/personal/delta-spec/README.md` - Apply all three section changes

### No Delta Specs Required
This change does not affect any specification requirements. The skills.md spec has a "README Synchronization" learning (line 143-151 in CLAUDE.md) but no formal requirement about documentation content. Therefore, no delta spec is needed.

## Dependencies

- **skill-namespace-cleanup** - Ensures skill names in README match actual invocation (e.g., `/ds-init` vs `/ds:init`)
- **skill-metadata** - Ensures plugin metadata (name, version) is correct for marketplace references

Both dependencies are planned but not yet archived. This is acceptable for planning phase per the documented workflow pattern.

## Success Criteria

1. Installation section clearly states `--plugin-dir` is needed on every launch
2. Marketplace note includes the future installation command
3. CLAUDE.md recommendation section uses the assertive "STOP" pattern
4. validate-specs.sh limitations are documented
5. All changes maintain existing README structure and flow
