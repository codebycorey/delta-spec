Delta specs use this format:

```markdown
# Delta: <Domain>

Changes for <change-name>.

## ADDED Requirements

### Requirement: <New Requirement>
The system SHALL <new behavior>.

#### Scenario: <Name>
- GIVEN <precondition>
- WHEN <action>
- THEN <outcome>

## MODIFIED Requirements

### Requirement: <Existing Requirement>
The system SHALL <updated behavior>.
(Completely replaces the requirement with this name)

## REMOVED Requirements

### Requirement: <Requirement To Remove>
**Reason:** [Why this is being removed]
**Migration:** [What replaces it, if anything]

## RENAMED Requirements

- FROM: `Old Name`
- TO: `New Name`
```
