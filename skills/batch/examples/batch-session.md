# Batch Session Examples

## Example Session

```
User: /ds:batch

Claude: Describe the features you want to plan:

User: I need JWT authentication for users, then a permissions
layer that uses auth to control access. Also want webhooks
for external integrations - that's separate. And finally
an admin panel that needs permissions to manage users.

Claude: Parsed 4 features:

  jwt-auth ──→ permissions ──→ admin-panel

  webhooks (independent)

Features:
  1. jwt-auth - JWT authentication for users
  2. permissions - Permissions layer for access control
     └─ depends on: jwt-auth
  3. webhooks - Webhooks for external integrations
  4. admin-panel - Admin panel for user management
     └─ depends on: permissions

Create these proposals? [y/N]

User: y

Claude:
Created specs/.delta/jwt-auth/proposal.md
Created specs/.delta/permissions/proposal.md
Created specs/.delta/webhooks/proposal.md
Created specs/.delta/admin-panel/proposal.md

Created 4 proposals. Run /ds:plan for all? [y/N]

User: y

Claude:
Planning 1/4: jwt-auth...
  ✓ Created design.md
  ✓ Created specs/auth.md

Planning 2/4: permissions...
  ✓ Created design.md
  ✓ Created specs/auth.md (delta)

Planning 3/4: webhooks...
  ✓ Created design.md
  ✓ Created specs/integrations.md

Planning 4/4: admin-panel...
  ✓ Created design.md
  ✓ Created specs/admin.md

Done! 4 changes planned. Run /ds:tasks to generate implementation tasks.
```

## Example: Consolidation Detected

```
User: /ds:batch

Claude: Describe the features you want to plan:

User: Add argument-hint support to all skills. Also add
disable-model-invocation flags to skills. And update the
skills README with new frontmatter fields.

Claude: Parsed 3 features, found potential overlap:

Group 1: argument-hint-support + disable-invocation-flags
  Signals: both mention "skills", "frontmatter", "SKILL.md"
  Suggestion: Merge into "argument-hint-support"?

Remaining: skills-readme-update (no overlaps)

Accept suggested groupings? [y/N/c]

User: c

Claude: Group 1 (argument-hint-support + disable-invocation-flags): Merge? [y/N]

User: y

Claude: Consolidated to 2 features:

  skill-frontmatter-fields (independent)

  skills-readme-update (independent)

Features:
  1. skill-frontmatter-fields - Add argument-hint and disable-model-invocation support to all skills
  2. skills-readme-update - Update skills README with new frontmatter fields

Create these proposals? [y/N]

User: y

Claude:
Created specs/.delta/skill-frontmatter-fields/proposal.md
Created specs/.delta/skills-readme-update/proposal.md

Created 2 proposals. Run /ds:plan for all? [y/N]
```
