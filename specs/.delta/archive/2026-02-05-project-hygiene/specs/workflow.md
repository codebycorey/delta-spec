# Delta: Workflow

Changes for project-hygiene.

## Context

Updating version references in workflow spec from 0.0.1 to 0.1.0. The version check requirements remain structurally the same, but need to reflect the new version number in scenarios and examples.

## MODIFIED Requirements

### Requirement: Version Compatibility
The system SHALL check version compatibility on all commands.

#### Scenario: Version check
- GIVEN the plugin version differs from specs/.delta-spec.json
- WHEN running any command
- THEN the system warns about the mismatch and offers migration options

**Rationale for modification**: No structural changes to the requirement, but it now applies to version 0.1.0. The version check mechanism remains the same.

#### Scenario: Migration options
- GIVEN a version mismatch is detected
- WHEN the user is prompted
- THEN options include: Migrate, Continue anyway, Cancel

**Rationale for modification**: No changes needed - migration options remain the same regardless of version.

#### Scenario: Missing initialization
- GIVEN specs/.delta-spec.json does not exist
- WHEN running any command except init
- THEN the system tells the user to run `/ds-init` first

**Rationale for modification**: Skill name was already updated to `/ds-init` in plugin-structure-update change. No further changes needed.

## Notes

This delta spec serves primarily as documentation that the version compatibility requirement has been reviewed for the 0.0.1 → 0.1.0 transition. No substantive changes to the requirement logic are needed - the version check system is designed to handle any version transition.

The actual version updates occur in:
- `.claude-plugin/plugin.json` (plugin version)
- `specs/.delta-spec.json` (tracked version)
