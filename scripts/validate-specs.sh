#!/bin/bash

# Delta-Spec Validation Script
# Checks spec files for common format issues

set -e

SPECS_DIR=".specs"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

errors=0
warnings=0

validate_spec() {
    local file="$1"
    local filename=$(basename "$file")

    echo "Checking $filename..."

    # Check for Purpose section
    if ! grep -q "^## Purpose" "$file"; then
        echo -e "  ${YELLOW}WARNING: Missing '## Purpose' section${NC}"
        ((warnings++))
    fi

    # Check for Requirements section
    if ! grep -q "^## Requirements" "$file"; then
        echo -e "  ${RED}ERROR: Missing '## Requirements' section${NC}"
        ((errors++))
    fi

    # Check that requirements have scenarios
    local req_count=$(grep -c "^### Requirement:" "$file" || echo 0)
    local scenario_count=$(grep -c "^#### Scenario:" "$file" || echo 0)

    if [ "$req_count" -gt 0 ] && [ "$scenario_count" -eq 0 ]; then
        echo -e "  ${YELLOW}WARNING: $req_count requirement(s) but no scenarios${NC}"
        ((warnings++))
    fi

    # Check for RFC 2119 keywords
    if ! grep -qE "(SHALL|MUST|SHOULD|MAY)" "$file"; then
        echo -e "  ${YELLOW}WARNING: No RFC 2119 keywords (SHALL/MUST/SHOULD/MAY) found${NC}"
        ((warnings++))
    fi
}

validate_delta() {
    local file="$1"
    local filename=$(basename "$file")

    echo "Checking delta: $filename..."

    # Check for at least one operation section
    if ! grep -qE "^## (ADDED|MODIFIED|REMOVED|RENAMED) Requirements" "$file"; then
        echo -e "  ${RED}ERROR: No operation sections (ADDED/MODIFIED/REMOVED/RENAMED)${NC}"
        ((errors++))
    fi

    # Check ADDED/MODIFIED have requirement content
    if grep -q "^## ADDED Requirements" "$file"; then
        local added_reqs=$(sed -n '/^## ADDED Requirements/,/^## /p' "$file" | grep -c "^### Requirement:" || echo 0)
        if [ "$added_reqs" -eq 0 ]; then
            echo -e "  ${YELLOW}WARNING: ADDED section has no requirements${NC}"
            ((warnings++))
        fi
    fi
}

echo "=== Delta-Spec Validation ==="
echo ""

# Validate main specs
for spec in "$SPECS_DIR"/*.md; do
    [ -f "$spec" ] || continue
    validate_spec "$spec"
done

# Validate delta specs in changes
if [ -d "$SPECS_DIR/changes" ]; then
    for change_dir in "$SPECS_DIR/changes"/*/; do
        [ -d "$change_dir" ] || continue
        for delta in "$change_dir"delta-*.md; do
            [ -f "$delta" ] || continue
            validate_delta "$delta"
        done
    done
fi

echo ""
echo "=== Summary ==="
echo -e "Errors: ${RED}$errors${NC}"
echo -e "Warnings: ${YELLOW}$warnings${NC}"

if [ $errors -gt 0 ]; then
    echo -e "${RED}Validation failed${NC}"
    exit 1
else
    echo -e "${GREEN}Validation passed${NC}"
    exit 0
fi
