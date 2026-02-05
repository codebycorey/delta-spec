# Delta: Skills

Changes for batch-consolidation.

## ADDED Requirements

### Requirement: Consolidate overlapping features in batch
The system SHALL detect and suggest consolidation of overlapping features during `/ds-batch` before dependency inference.

#### Scenario: Detect file overlap
- GIVEN multiple parsed features mention the same file path
- WHEN analyzing for overlap signals
- THEN the system identifies this as a strong signal for consolidation
- AND suggests grouping those features

#### Scenario: Detect keyword overlap
- GIVEN two features share 3 or more domain-specific terms
- WHEN analyzing for overlap signals
- THEN the system identifies this as a strong signal for consolidation
- AND suggests grouping those features

#### Scenario: Detect sequential phrasing
- GIVEN a feature description contains "then", "after that", "also", or "additionally"
- WHEN analyzing for overlap signals
- THEN the system treats this as a signal that it may extend the previous feature
- AND suggests grouping with the previous feature if other signals present

#### Scenario: Detect domain synonyms
- GIVEN features use synonyms for the same domain (e.g., "auth"/"authentication"/"login")
- WHEN analyzing for overlap signals
- THEN the system identifies this as a medium signal for consolidation
- AND may suggest grouping if combined with other signals

#### Scenario: Conservative grouping threshold
- GIVEN overlap signals are detected between features
- WHEN deciding whether to suggest consolidation
- THEN the system requires 2+ strong signals OR 1 strong + 2 medium signals
- AND does not suggest consolidation with only weak signals

#### Scenario: Display consolidation suggestions
- GIVEN overlapping features are detected
- WHEN presenting suggestions to the user
- THEN the system shows each group with:
  - Feature names to be merged
  - Specific overlap signals detected
  - Suggested merged name
- AND lists remaining features with no overlaps

#### Scenario: Consolidation prompt format
- GIVEN consolidation suggestions are displayed
- WHEN prompting for confirmation
- THEN the system asks "Accept suggested groupings? [y/N/c]"
- AND explains: "y" applies all, "N" keeps separate, "c" chooses per-group

#### Scenario: Accept all consolidations
- GIVEN the user responds "y" to the consolidation prompt
- WHEN applying consolidations
- THEN the system merges all suggested groups
- AND uses the first feature's name in each group as the base name
- AND combines descriptions preserving unique details
- AND proceeds to dependency inference with the consolidated list

#### Scenario: Reject all consolidations
- GIVEN the user responds "N" or empty input to the consolidation prompt
- WHEN handling rejection
- THEN the system keeps all features separate
- AND proceeds to dependency inference with the original parsed list

#### Scenario: Choose per-group consolidation
- GIVEN the user responds "c" to the consolidation prompt
- WHEN presenting individual groups
- THEN the system asks "Group N (...): Merge? [y/N]" for each group
- AND applies consolidation only for groups the user confirms with "y"
- AND keeps other features separate

#### Scenario: Merge feature descriptions
- GIVEN two features are consolidated
- WHEN creating the merged feature
- THEN the system combines descriptions intelligently
- AND removes redundant phrases
- AND preserves unique details from both original descriptions

#### Scenario: No overlaps detected
- GIVEN parsed features have no overlap signals
- WHEN checking for consolidation
- THEN the system skips Step 2.5 entirely
- AND proceeds directly from Step 2 (parsing) to Step 3 (dependency inference)

#### Scenario: Consolidation before dependency inference
- GIVEN consolidation suggestions are confirmed
- WHEN the workflow continues
- THEN dependency inference (Step 3) works on the consolidated feature list
- AND dependency keywords reference the merged feature names

#### Scenario: Consolidation may eliminate cycles
- GIVEN features A and B depend on each other
- WHEN consolidation merges A and B into a single feature
- THEN the cycle is eliminated
- AND cycle detection (Step 3.5) operates on the consolidated graph

#### Scenario: Display signals in suggestions
- GIVEN a consolidation suggestion is shown
- WHEN displaying the group
- THEN the system lists specific signals detected
- AND shows example evidence (e.g., "both mention 'auth.ts'", "shared terms: authentication, JWT, user")

#### Scenario: Normalize file paths for comparison
- GIVEN features mention file paths with varying formats
- WHEN comparing paths for overlap
- THEN the system normalizes paths (removes leading `./`, trailing `/`)
- AND treats `auth.ts`, `./auth.ts`, and `src/auth.ts` as potential overlaps

#### Scenario: Stop word filtering in keyword analysis
- GIVEN feature descriptions contain common words like "the", "a", "and"
- WHEN extracting keywords for overlap analysis
- THEN the system filters out stop words
- AND focuses on domain-specific terms (nouns, technical terms)

#### Scenario: Consolidation step numbering
- GIVEN Step 2.5 is added to the workflow
- WHEN documenting the skill
- THEN existing steps remain numbered: 0, 1, 2, 3, 3.5, 4, 5, 6
- AND the new step is inserted as Step 2.5 (between 2 and 3)
- AND all references to subsequent steps remain unchanged

## MODIFIED Requirements

### Requirement: Batch Feature Planning (updated step order)
The system SHALL provide a `/ds-batch` skill that creates multiple proposals from a single free-form description, with feature consolidation, dependency inference, and cycle detection.

#### Scenario: Step order with consolidation
- GIVEN the batch workflow includes consolidation
- WHEN executing `/ds-batch`
- THEN the system follows this order:
  1. Step 0: Version check
  2. Step 1: Prompt for features
  3. Step 2: Parse and extract features
  4. Step 2.5: Consolidate overlapping features (if overlaps found)
  5. Step 3: Infer dependencies
  6. Step 3.5: Detect and resolve cycles (if cycles found)
  7. Step 4: Display dependency graph
  8. Step 5: Confirm and create proposals
  9. Step 6: Offer batch planning
