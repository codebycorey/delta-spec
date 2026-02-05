# Proposal: readme-improvements

## Problem
The README.md has several gaps: the installation section doesn't explain how to verify the plugin loaded or that `--plugin-dir` must be specified each launch. The recommended CLAUDE.md snippet is a soft suggestion when the project's own CLAUDE.md uses a stronger "STOP" pattern that's more effective. The validate-specs.sh documentation doesn't mention its limitations or the bash strict mode issue.

## Dependencies
- `skill-namespace-cleanup` - README must reflect final skill names (`/ds:*` format)
- `skill-metadata` - README skills table must reflect final argument hints and metadata

## Changes
- Add verification step to installation section (`/skills` to check ds-* skills listed)
- Add note that `--plugin-dir` must be specified every time Claude Code is launched
- Add placeholder for marketplace installation when published
- Strengthen the recommended CLAUDE.md snippet with the assertive "STOP" pattern as default
- Document validate-specs.sh limitations and the bash strict mode caveat
- Update skills table to reflect any naming changes from namespace cleanup

## Capabilities

### Modified
- Installation section includes verification and caveats
- Recommended CLAUDE.md snippet uses the proven assertive pattern
- Validate script documentation is accurate

## Out of Scope
- Restructuring the README layout
- Adding screenshots or diagrams
- Writing a contributing guide
- Changes to non-README documentation

## Success Criteria
- New users can verify plugin installation using README instructions
- Recommended CLAUDE.md snippet matches the project's own CLAUDE.md pattern
- Validate script section accurately describes capabilities and known limitations
- Skills table uses correct naming convention
