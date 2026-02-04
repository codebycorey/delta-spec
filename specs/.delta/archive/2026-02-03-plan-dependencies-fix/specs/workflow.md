# Delta: Workflow

Changes for plan-dependencies-fix.

## MODIFIED Requirements

### Requirement: Dependency Enforcement
The system SHOULD warn when proceeding with unsatisfied dependencies, but only at phases where it matters.

#### Scenario: Planning with unsatisfied dependencies
- GIVEN a change that depends on another unarchived change
- WHEN running `/ds:plan`
- THEN the system notes the dependency exists
- AND proceeds without asking for confirmation

#### Scenario: Tasks with unsatisfied dependencies
- GIVEN a change that depends on another unarchived change
- WHEN running `/ds:tasks`
- THEN the system warns about unsatisfied dependencies
- AND asks whether to proceed or defer

#### Scenario: Archive with unsatisfied dependencies
- GIVEN a change that depends on another unarchived change
- WHEN running `/ds:archive`
- THEN the system warns about unsatisfied dependencies
- AND asks whether to proceed or archive dependencies first

#### Scenario: Dependency phases rationale
- GIVEN the dependency enforcement design
- WHEN determining where to enforce
- THEN planning is informational (safe to proceed)
- AND tasks warns (implementation order matters)
- AND archive warns (merge order matters)
