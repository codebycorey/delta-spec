# Design: batch-consolidation

## Context

The current `/ds-batch` workflow:
1. Prompts for feature descriptions
2. Parses individual features (Step 2) - extracts names, descriptions
3. Infers dependencies (Step 3) - detects relationship keywords
4. Detects/resolves cycles (Step 3.5) - breaks circular dependencies
5. Displays dependency graph (Step 4)
6. Confirms and creates proposals (Step 5)
7. Offers batch planning (Step 6)

**Gap**: When users describe multiple features in free-form prose, they may inadvertently describe overlapping or redundant functionality. For example:
- "Add user authentication" and "JWT login system" might be the same feature
- "Admin dashboard" and "management UI" could overlap
- "API rate limiting" and "request throttling" are likely duplicates

The system currently creates separate proposals for each parsed item, which can lead to:
- Duplicate work during planning/implementation
- Confusing dependency relationships (both items depending on the same thing)
- Merge conflicts when archiving
- Wasted effort exploring the same code areas

**User impact**: Users must manually recognize overlaps, drop redundant changes, or merge them after the fact.

## Approach

Add **Step 2.5: Consolidation** between parsing (Step 2) and dependency inference (Step 3).

### Consolidation Algorithm

After parsing features, before inferring dependencies:

1. **Analyze for overlap signals** across all parsed features:
   - **File/directory mentions**: "auth.ts", "src/auth/", "authentication module"
   - **Domain keywords**: "authentication", "auth", "login", "user", etc.
   - **Sequential phrasing**: "then add X", "after that Y" (implies same feature)
   - **Modifier patterns**: "also include", "with support for" (extends prior feature)

2. **Generate grouping suggestions**:
   - Group features with 2+ strong signals
   - Strong signals: same file mentioned, exact keyword match, sequential markers
   - Weak signals: related domain terms, similar verbs
   - Conservative threshold: Don't suggest unless confidence is high

3. **Display suggestions** in this format:
   ```
   Parsed 5 features, found potential overlap:

   Group 1: user-auth + jwt-login
     Signals: both mention "authentication", "auth.ts", "JWT"
     Suggestion: Merge into "user-auth"?

   Group 2: admin-dashboard + management-ui
     Signals: both mention "admin", "UI", "dashboard"
     Suggestion: Merge into "admin-dashboard"?

   Remaining: api-rate-limiting (no overlaps)
   ```

4. **User confirmation**:
   ```
   Accept suggested groupings? [y/N/c]
   - y: Apply all suggestions
   - N: Keep features separate
   - c: Choose per-group
   ```

5. **On "c" (custom)**:
   ```
   Group 1 (user-auth + jwt-login): Merge? [y/N]
   Group 2 (admin-dashboard + management-ui): Merge? [y/N]
   ```

6. **After consolidation**, proceed to Step 3 (dependency inference) with the consolidated feature list.

### Overlap Detection Details

**File/directory overlap**:
- Extract file paths from descriptions: `auth.ts`, `src/auth/`, `authentication module`
- Normalize paths (strip leading `./`, trailing `/`)
- Exact match = strong signal
- Same directory = medium signal

**Keyword overlap**:
- Tokenize descriptions, remove stop words ("the", "a", "and", etc.)
- Extract domain terms (nouns, technical terms)
- Count shared terms between feature pairs
- 3+ shared terms = strong signal
- 2 shared terms = medium signal

**Sequential phrasing**:
- Detect: "then", "after that", "next", "also", "additionally", "with"
- If feature B mentions "also add X" immediately after feature A, suggest merging into A

**Domain matching**:
- Build a dictionary of common domain synonyms:
  - auth/authentication/login/signin
  - dashboard/panel/UI/interface
  - rate-limiting/throttling/quota
- If features use synonyms for the same domain, suggest merging

### Consolidation Rules

**When to suggest merging**:
- 2+ strong signals (file overlap + keyword overlap)
- 1 strong + 2 medium signals
- Sequential phrasing + 1 other signal

**When NOT to suggest**:
- Only 1 weak signal
- Features have different domains (e.g., "auth" and "payments")
- Features mention different files with no overlap

**Merged feature handling**:
- Use the first feature's name as the base (user can rename later)
- Combine descriptions: "User authentication with JWT + JWT login system" → "User authentication with JWT login system"
- Preserve unique details from both descriptions

## Decisions

### Decision: Conservative vs Aggressive Grouping
**Choice:** Conservative (high confidence threshold)
**Why:** False positives (incorrect merges) are more disruptive than false negatives (missed overlaps). Users can manually recognize obvious duplicates, but unmerging incorrectly grouped features requires dropping and recreating.
**Trade-offs:** May miss some overlaps, but reduces frustration from bad suggestions.

### Decision: Placement in workflow
**Choice:** Step 2.5 (after parsing, before dependency inference)
**Why:**
- Consolidation must happen before dependencies are inferred, since merged features will have different dependency relationships
- Parsing must be complete to analyze all features for overlap
- Placing before Step 3 means dependency inference works on the consolidated list
**Trade-offs:** Adds another step to the workflow, but it's skippable if no overlaps found.

### Decision: User interaction model
**Choice:** Show suggestions, require explicit confirmation
**Why:**
- Automatic merging without confirmation could surprise users
- Showing suggestions educates users about potential overlap
- Batch confirmation ("y" for all) makes it fast for obvious cases
- Per-group confirmation ("c") gives fine-grained control
**Trade-offs:** Adds interaction, but only when overlaps are detected.

### Decision: Skip step if no overlaps
**Choice:** Don't show Step 2.5 if no overlaps detected
**Why:** Streamlines the common case (no overlaps) while only adding steps when needed.
**Trade-offs:** None—this is strictly better than always showing the step.

### Decision: Handling disagreement
**Choice:** On "N" (reject all) or "n" to individual group, keep features separate and proceed
**Why:**
- User knows their intent better than the algorithm
- Worst case: user manually drops duplicate later (same as current state)
- Best case: system catches a mistake the user made
**Trade-offs:** Rejected suggestions don't block workflow progress.

### Decision: Consolidation vs cycle detection order
**Choice:** Consolidation (2.5) happens before cycle detection (3.5)
**Why:**
- Merging overlapping features may eliminate cycles (e.g., A and B both depend on each other, but are actually the same feature)
- Dependency inference (Step 3) needs the consolidated list
- Cycle detection (Step 3.5) works on the inferred dependency graph
**Trade-offs:** None—this is the logical order.

## Files Affected

- `skills/ds-batch/SKILL.md` - Add Step 2.5 with consolidation algorithm, update step numbers for subsequent steps
- `specs/skills.md` - Add requirements for consolidation step (via delta spec)

## Risks

### Risk: False positives in overlap detection
**Likelihood:** Medium
**Impact:** Medium (user frustration, incorrect merges)
**Mitigation:**
- Use conservative threshold
- Always require user confirmation
- Allow per-group acceptance/rejection

### Risk: Complex consolidation UI
**Likelihood:** Low
**Impact:** High (users confused, skip the step)
**Mitigation:**
- Clear formatting (group features visually)
- Show specific signals (not just "overlap detected")
- Provide examples in SKILL.md

### Risk: Performance with many features
**Likelihood:** Low (batch typically <10 features)
**Impact:** Low (O(n²) comparison is fine for small n)
**Mitigation:** None needed—n² is acceptable for n<20

### Risk: Breaking existing batch workflow
**Likelihood:** Low
**Impact:** High (users rely on current behavior)
**Mitigation:**
- Only trigger Step 2.5 if overlaps detected
- If no overlaps, workflow is identical to current
- Consolidation is optional (user can say "N")
