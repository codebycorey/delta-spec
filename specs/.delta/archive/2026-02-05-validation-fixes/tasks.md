# Tasks: validation-fixes

Implementation tasks for fixing validation script bugs and adding new validations.

## Status

- [x] 1. Fix counter increment patterns
- [x] 2. Add duplicate requirement name validation
- [x] 3. Add orphaned delta spec validation
- [x] 4. Add proposal format validation
- [x] 5. Add design format validation
- [x] 6. Update main script to call new validation functions
- [x] 7. Test script with set -e

## Task 1: Fix counter increment patterns

**File:** `/Users/horti/projects/personal/delta-spec/scripts/validate-specs.sh`

Replace all `((counter++))` patterns with `counter=$((counter + 1))` to prevent premature exit under `set -e`.

**Locations to fix:**
- Line 26: `((warnings++))` → `warnings=$((warnings + 1))`
- Line 32: `((errors++))` → `errors=$((errors + 1))`
- Line 41: `((warnings++))` → `warnings=$((warnings + 1))`
- Line 47: `((warnings++))` → `warnings=$((warnings + 1))`
- Line 60: `((errors++))` → `errors=$((errors + 1))`
- Line 68: `((warnings++))` → `warnings=$((warnings + 1))`

**Success criteria:**
- All 6 instances of `((counter++))` are replaced
- Script does not exit prematurely when incrementing from 0

## Task 2: Add duplicate requirement name validation

**File:** `/Users/horti/projects/personal/delta-spec/scripts/validate-specs.sh`

Add duplicate requirement name detection to `validate_spec()` function.

**Implementation:**
- After line 48 (after RFC 2119 check), add duplicate name check
- Extract requirement names: `grep "^### Requirement:" "$file" | sed 's/^### Requirement: //'`
- Find duplicates: `sort | uniq -d`
- If duplicates exist, error for each duplicate found
- Increment `errors` counter for each duplicate

**Error message format:**
```
  ERROR: Duplicate requirement name: <name>
```

**Success criteria:**
- Duplicate requirement names within a spec are detected
- Each duplicate is reported with clear error message
- Errors counter is incremented for duplicates

## Task 3: Add orphaned delta spec validation

**File:** `/Users/horti/projects/personal/delta-spec/scripts/validate-specs.sh`

Add orphaned delta spec detection to `validate_delta()` function.

**Implementation:**
- After line 70 (after ADDED requirements check), add orphan check
- Extract base spec name from delta path: `basename "$file"`
- Construct expected main spec path: `specs/<basename>`
- Check if main spec exists: `[ ! -f "specs/$basename" ]`
- If main spec does not exist, error with both paths
- Increment `errors` counter

**Error message format:**
```
  ERROR: Orphaned delta spec - main spec not found
         Expected: specs/<basename>
```

**Success criteria:**
- Delta specs referencing non-existent main specs are detected
- Error shows both the delta file and expected main spec path
- Errors counter is incremented

## Task 4: Add proposal format validation

**File:** `/Users/horti/projects/personal/delta-spec/scripts/validate-specs.sh`

Add new `validate_proposal()` function to check for required sections.

**Implementation:**
- Add function after `validate_delta()` (after line 71)
- Function signature: `validate_proposal() { local file="$1"; ... }`
- Required sections array: `Problem`, `Dependencies`, `Changes`, `Capabilities`, `Out of Scope`, `Success Criteria`
- For each required section, check if `## <section>` exists in file
- If missing, error with section name
- Increment `errors` counter for each missing section

**Function structure:**
```bash
validate_proposal() {
    local file="$1"
    local filename=$(basename "$file")

    echo "Checking proposal: $filename..."

    # Required sections
    local required_sections=("Problem" "Dependencies" "Changes" "Capabilities" "Out of Scope" "Success Criteria")

    for section in "${required_sections[@]}"; do
        if ! grep -q "^## $section" "$file"; then
            echo -e "  ${RED}ERROR: Missing '## $section' section${NC}"
            errors=$((errors + 1))
        fi
    done
}
```

**Success criteria:**
- Function validates all 6 required sections
- Missing sections are reported with clear error messages
- Errors counter is incremented for each missing section

## Task 5: Add design format validation

**File:** `/Users/horti/projects/personal/delta-spec/scripts/validate-specs.sh`

Add new `validate_design()` function to check for required sections.

**Implementation:**
- Add function after `validate_proposal()` function
- Function signature: `validate_design() { local file="$1"; ... }`
- Required sections array: `Context`, `Approach`, `Decisions`, `Files Affected`, `Risks`
- For each required section, check if `## <section>` exists in file
- If missing, error with section name
- Increment `errors` counter for each missing section

**Function structure:**
```bash
validate_design() {
    local file="$1"
    local filename=$(basename "$file")

    echo "Checking design: $filename..."

    # Required sections
    local required_sections=("Context" "Approach" "Decisions" "Files Affected" "Risks")

    for section in "${required_sections[@]}"; do
        if ! grep -q "^## $section" "$file"; then
            echo -e "  ${RED}ERROR: Missing '## $section' section${NC}"
            errors=$((errors + 1))
        fi
    done
}
```

**Success criteria:**
- Function validates all 5 required sections
- Missing sections are reported with clear error messages
- Errors counter is incremented for each missing section

## Task 6: Update main script to call new validation functions

**File:** `/Users/horti/projects/personal/delta-spec/scripts/validate-specs.sh`

Add calls to new validation functions in the main script loop.

**Implementation:**
- After main specs validation loop (after line 82), add proposal validation loop:
  ```bash
  # Validate proposals in active changes
  if [ -d "$SPECS_DIR/.delta" ]; then
      for change_dir in "$SPECS_DIR/.delta"/*/; do
          [ -d "$change_dir" ] || continue
          # Skip archive directory
          [[ "$change_dir" == *"/archive/"* ]] && continue
          proposal="$change_dir/proposal.md"
          [ -f "$proposal" ] && validate_proposal "$proposal"
      done
  fi
  ```

- After proposal validation, add design validation loop:
  ```bash
  # Validate designs in active changes
  if [ -d "$SPECS_DIR/.delta" ]; then
      for change_dir in "$SPECS_DIR/.delta"/*/; do
          [ -d "$change_dir" ] || continue
          # Skip archive directory
          [[ "$change_dir" == *"/archive/"* ]] && continue
          design="$change_dir/design.md"
          [ -f "$design" ] && validate_design "$design"
      done
  fi
  ```

- Delta specs validation remains in place (currently lines 85-95)

**Script flow order:**
1. Main specs validation
2. Proposal validation (NEW)
3. Design validation (NEW)
4. Delta specs validation (existing)
5. Summary and exit

**Success criteria:**
- Proposals are validated before designs
- Designs are validated before delta specs
- Archive directory is skipped in all loops
- Only existing files are validated (no errors for missing files)

## Task 7: Test script with set -e

**File:** `/Users/horti/projects/personal/delta-spec/scripts/validate-specs.sh`

Run the script to verify it completes without premature exit.

**Test cases:**
1. Run on clean specs (should complete, report 0 errors/warnings)
2. Introduce a warning (e.g., remove Purpose section from a spec)
   - Script should report warning and continue
   - Exit code 0
3. Introduce an error (e.g., remove Requirements section)
   - Script should report error and continue to check other files
   - Exit code 1
4. Test all new validations:
   - Create duplicate requirement names → should error
   - Create orphaned delta spec → should error
   - Create incomplete proposal → should error
   - Create incomplete design → should error

**Command:**
```bash
cd /Users/horti/projects/personal/delta-spec
./scripts/validate-specs.sh
```

**Success criteria:**
- Script runs to completion under `set -e` in all test cases
- Multiple warnings do not cause premature exit
- Multiple errors are all reported before exit
- Exit codes match expectations (0 for clean/warnings, 1 for errors)
- All new validation functions execute without errors

## Dependencies

Tasks must be completed in order:
- Task 1 must complete before Task 7 (fixes the bug preventing completion)
- Tasks 2-5 can be done in parallel after Task 1
- Task 6 depends on Tasks 4-5 (needs functions to exist before calling them)
- Task 7 depends on all previous tasks (final integration test)
