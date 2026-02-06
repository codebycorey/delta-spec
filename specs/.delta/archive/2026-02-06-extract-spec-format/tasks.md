# Tasks: extract-spec-format

Generated: 2026-02-06

---

## Task 6: Create shared spec-format.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/_shared/spec-format.md
- **Refs:** [Shared Spec Format]

Create `skills/_shared/spec-format.md` combining the base spec format template and writing guidelines:

```markdown
## Spec Format

Specs use this format:

\`\`\`markdown
# <Domain> Specification

## Purpose
Brief description of what this domain covers.

## Requirements

### Requirement: <Name>
The system [SHALL|MUST|SHOULD|MAY] <behavior description>.

#### Scenario: <Scenario Name>
- GIVEN <precondition>
- WHEN <action>
- THEN <expected outcome>
\`\`\`

## Writing Guidelines

- Use RFC 2119 keywords: SHALL/MUST (required), SHOULD (recommended), MAY (optional)
- Each requirement should be testable
- Scenarios use Given/When/Then format
- Keep requirements atomic - one behavior per requirement
- Name requirements clearly - they're referenced in deltas
```

## Task 7: Create shared delta-format.md
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/_shared/delta-format.md
- **Refs:** [Shared Spec Format]

Create `skills/_shared/delta-format.md` with the delta spec format extracted from plan/SKILL.md (lines 89-122):

Include the full delta format template with ADDED, MODIFIED, REMOVED, and RENAMED sections, with examples and the note about MODIFIED being a complete replacement.

## Task 8: Update init/SKILL.md to reference shared spec format
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/init/SKILL.md
- **Refs:** [Initialize Repository]

Replace the inline "## Spec Format" section (lines 81-100) with:

1. Keep the `## Spec Format` heading
2. Replace content with: `See [spec-format.md](../_shared/spec-format.md) for the standard spec format and writing guidelines.`

## Task 9: Update spec/SKILL.md to reference shared spec format
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/spec/SKILL.md
- **Refs:** [View Specifications]

Replace both inline sections (lines 56-84, "## Spec Format Reference" and "## Spec Writing Guidelines") with:

1. Keep the `## Spec Format Reference` heading
2. Replace content with: `See [spec-format.md](../_shared/spec-format.md) for the standard spec format and writing guidelines.`
3. Remove the separate "## Spec Writing Guidelines" section (now included in shared file)

## Task 10: Update plan/SKILL.md to reference shared delta format
- **Status:** done
- **Owner:** (unassigned)
- **Files:** skills/plan/SKILL.md
- **Refs:** [Plan Change]

Replace the inline "## Delta Format" section (lines 89-122) with:

1. Keep the `## Delta Format` heading (or rename to `## Step 7: Delta Format Reference`)
2. Replace content with: `See [delta-format.md](../_shared/delta-format.md) for the delta spec format.`
