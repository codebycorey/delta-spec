# Proposal: validation-fixes

## Problem
The `scripts/validate-specs.sh` script has a bash strict mode bug that causes it to exit on the first warning or error found. The `((warnings++))` expression evaluates to 0 (falsy) when incrementing from 0, which returns exit code 1 under `set -e`. Additionally, the script lacks validation for several failure modes that surface during `/ds-archive`: duplicate requirement names, orphaned delta specs, and proposal/design format validation.

## Dependencies
None

## Changes
- Fix counter increment bug: replace `((warnings++))` and `((errors++))` with `warnings=$((warnings + 1))` or `: $((warnings++))` pattern
- Add validation check for duplicate requirement names within a spec file
- Add validation check for orphaned delta specs (referencing non-existent main specs)
- Add proposal format validation (required sections: Problem, Dependencies, Changes)
- Add design format validation (required sections: Context, Approach, Decisions)

## Capabilities

### Modified
- `validate-specs.sh` no longer exits prematurely on first finding
- Script catches duplicate requirements before they cause archive merge issues

### New
- Proposal format validation
- Design format validation
- Orphaned delta spec detection

## Out of Scope
- Post-edit hook integration (deferred per IMPROVEMENTS.md)
- Rewriting the script in a different language
- Validating archived change format

## Success Criteria
- `validate-specs.sh` runs to completion with `set -e` when warnings exist
- Duplicate requirement names within a single spec are flagged
- Delta specs referencing non-existent main specs are flagged
- Proposals missing required sections are flagged
- Script exits with appropriate exit codes (0 for clean, 1 for errors, 0 for warnings-only)
