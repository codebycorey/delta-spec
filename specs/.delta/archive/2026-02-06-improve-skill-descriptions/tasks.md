# Tasks: improve-skill-descriptions

Generated: 2026-02-06

---

## Task 19: Update descriptions for all 7 model-invocable skills
- **Status:** done
- **Owner:** assistant
- **Files:** skills/new/SKILL.md, skills/plan/SKILL.md, skills/tasks/SKILL.md, skills/spec/SKILL.md, skills/status/SKILL.md, skills/quick/SKILL.md, skills/batch/SKILL.md
- **Refs:** [Start New Change], [Plan Change], [Generate Tasks], [View Specifications], [Show Status], [Quick Start Change], [Batch Feature Planning]

Update the `description` field in YAML frontmatter for each skill. Use the format: what it does + "Use when..." trigger context. Keep under ~200 characters.

Suggested descriptions:

1. **new**: `"Start a new change with a proposal. Use when starting a feature, creating a proposal, or beginning planned work."`

2. **plan**: `"Create design and delta specs from a proposal. Use when planning implementation, exploring codebase for approach, or creating a design."`

3. **tasks**: `"Generate implementation tasks from design and delta specs. Use when creating a task list, breaking down work, or preparing to implement."`

4. **spec**: `"View, discuss, or search specifications. Use when checking current specs, searching requirements, or understanding system behavior."`

5. **status**: `"Show active changes with progress, dependencies, and next steps. Use when checking status, viewing active work, or reviewing the dependency graph."`

6. **quick**: `"Quick start a change with minimal interaction. Use when fast-tracking a straightforward change that needs proposal, design, and tasks in one step."`

7. **batch**: `"Create multiple proposals from free-form feature descriptions. Use when planning several features at once, batch creating proposals, or setting up related changes."`
