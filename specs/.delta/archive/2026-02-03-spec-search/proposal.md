# Proposal: spec-search

## Problem
Users cannot easily find which specification defines a particular behavior. With multiple domain specs, locating a requirement by keyword requires manually reading each file.

## Dependencies
None

## Changes
- Extend `/ds:spec` command to accept search patterns
- When given a search term, scan all specs for matching requirements
- Display results with file, requirement name, and matching context

## Capabilities

### New
- **Search by keyword** - `/ds:spec "authentication"` finds all requirements mentioning authentication
- **Search by requirement name** - `/ds:spec "User Login"` finds that specific requirement
- **Cross-domain results** - Search spans all spec files, showing which domain each result is from

### Modified
- `/ds:spec` - Detect when argument is a search term vs. domain name

## Out of Scope
- Regex search (plain text matching is sufficient)
- Searching within archived changes
- Searching delta specs (only searches main specs)

## Success Criteria
- User can find any requirement by keyword in a single command
- Results clearly show which spec file contains each match
- Existing `/ds:spec` behavior (list all, view domain) still works
