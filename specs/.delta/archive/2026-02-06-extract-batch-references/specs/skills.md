# Delta: Skills

Changes for extract-batch-references.

## MODIFIED Requirements

### Requirement: Consolidate overlapping features in batch
The system SHALL detect and suggest consolidation of overlapping features during `/ds:batch` before dependency inference.

#### Scenario: Progressive disclosure for consolidation
- GIVEN the consolidation algorithm is detailed (~130 lines)
- WHEN the batch skill SKILL.md is defined
- THEN the main SKILL.md contains a brief summary of Step 2.5 (3-4 lines)
- AND references `references/consolidation.md` for the full algorithm
- AND the reference file contains the complete overlap detection, grouping, prompting, merging, and edge case logic

#### Scenario: Detect file overlap
- GIVEN multiple parsed features mention the same file path
- WHEN analyzing for overlap signals
- THEN the system identifies this as a strong signal for consolidation
- AND follows the full procedure in `references/consolidation.md`

#### Scenario: Conservative grouping threshold
- GIVEN overlap signals are detected between features
- WHEN deciding whether to suggest consolidation
- THEN the system follows the threshold rules in `references/consolidation.md`

#### Scenario: No overlaps detected
- GIVEN parsed features have no overlap signals
- WHEN checking for consolidation
- THEN the system skips Step 2.5 entirely
- AND proceeds directly from Step 2 (parsing) to Step 3 (dependency inference)

### Requirement: Batch Feature Planning
The system SHALL provide a `/ds:batch` skill that creates multiple proposals from a single free-form description, with feature consolidation, dependency inference, and cycle detection and resolution.

#### Scenario: Example sessions as reference
- GIVEN the batch skill includes example sessions
- WHEN the skill SKILL.md is defined
- THEN example sessions are stored in `examples/batch-session.md`
- AND the main SKILL.md references the examples file
- AND examples include both basic workflow and consolidation detected scenarios

#### Scenario: Skill word count within guidelines
- GIVEN the batch SKILL.md was ~2,500 words
- WHEN consolidation detail and examples are extracted
- THEN the main SKILL.md is ~1,300 words
- AND well within the 3,000-word guideline
