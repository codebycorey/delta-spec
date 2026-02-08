# Delta-Spec

A minimal, Claude Code-native system for spec-driven development.

## What is this?

Delta-Spec is a convention for managing software specifications that:

- **Uses delta specs** - Describe what's changing (ADDED/MODIFIED/REMOVED) rather than rewriting entire spec files
- **Works with Claude Code** - Integrates with plan mode, uses persistent task files
- **No CLI required** - Claude handles parsing and merging
- **Git-native** - Your commit history is your archive

## Installation

### Local Installation

Clone the repository and run Claude Code with the plugin directory:

```bash
git clone https://github.com/codebycorey/delta-spec.git
claude --plugin-dir /path/to/delta-spec
```

> **Note:** You must use `--plugin-dir` each time you launch Claude Code to load the plugin. This is required until the plugin is installed from the marketplace.

### Verify Installation

After installation, run `/skills` to see the `ds` plugin skills listed (e.g., `/ds:init`, `/ds:new`, `/ds:plan`).

> **Note:** Marketplace installation is not yet available. Once published, you will be able to install with `/plugin install ds`.

## Getting Started

1. Install delta-spec using one of the methods above
2. Run `/ds:init` to initialize the `specs/` directory
3. Run `/ds:new my-first-feature` to begin your first change

### Recommended: Add to CLAUDE.md

To ensure Claude consistently uses delta-spec for all feature work, add this to your project's `CLAUDE.md`:

````markdown
## REQUIRED: Use delta-spec for all changes

When the conversation shifts from discussion to implementation—phrases like:
- "let's add that"
- "make that change"
- "can you implement..."
- "go ahead and..."
- "update the code to..."

**STOP.** Before using Edit or Write on any project file, run `/ds:new <name>` first.

### Exceptions (direct edits OK)
- Fixing typos or formatting
- Changes already tracked by an active delta-spec change
- CLAUDE.md or README.md updates

### Workflow
1. `/ds:new <name>` - Create proposal
2. `/ds:plan` - Explore codebase, create design + delta specs
3. `/ds:tasks` - Generate implementation tasks
4. Implement the changes
5. `/ds:archive` - Merge specs when complete
````

This assertive pattern ensures Claude pauses and uses the spec-driven workflow instead of directly editing files.

## Skills

| Skill | Description |
|-------|-------------|
| `/ds:init` | Initialize delta-spec (optionally generate specs from existing code) |
| `/ds:new <name>` | Start a new change with a proposal |
| `/ds:quick [name] ["description"]` | Quick start: proposal, plan, and tasks with one confirmation |
| `/ds:batch` | Create multiple proposals from free-form feature descriptions |
| `/ds:adopt [name]` | Adopt an existing plan into delta-spec (skips codebase exploration) |
| `/ds:plan [name]` | Create design and delta specs |
| `/ds:tasks [name]` | Generate `tasks.md` file for one or all planned changes |
| `/ds:archive [name]` | Safely merge delta specs and archive change |
| `/ds:drop [name]` | Abandon a change and clean up dependencies |
| `/ds:spec [domain\|search]` | View, discuss, or search specifications |
| `/ds:status` | Show active changes with conflicts and task progress |

## Workflow

```
/ds:init               → Set up specs/ folder (once per repo)
/ds:new add-feature    → Work on proposal (problem, scope)
/ds:plan               → Explore codebase, create design + delta specs
/ds:tasks              → Create implementation tasks
[implement]
/ds:archive            → Merge deltas into specs, archive change
/ds:drop               → Abandon change (if no longer needed)

Alternative: Already planned in conversation?
/ds:adopt              → Import plan as proposals + designs + delta specs
/ds:tasks              → Create implementation tasks
[implement]
/ds:archive            → Merge deltas into specs, archive change
```

## Project Structure

```
specs/                        # Source of truth (visible)
├── .delta-spec.json          # Version and config
├── auth.md                   # Main specs by domain
├── payments.md
└── .delta/                   # Work in progress (hidden)
    ├── <change-name>/        # Current changes
    └── archive/              # Completed changes preserved
```

## How It Works

### 1. Write a Proposal

```markdown
# Proposal: add-auth

## Problem
Users can't log in to the application.

## Solution
Implement JWT-based authentication with login/logout endpoints.
```

### 2. Write Delta Specs

```markdown
## ADDED Requirements

### Requirement: User Login
The system SHALL authenticate users with email and password.

#### Scenario: Valid credentials
- GIVEN a registered user
- WHEN they submit valid credentials
- THEN a JWT token is returned
```

### 3. Implement

Run `/ds:tasks` to generate a `tasks.md` file with implementation tasks. Work through them, updating status as you go.

### 4. Archive

Run `/ds:archive` - Claude applies your deltas to the main specs.

### 5. Commit

```bash
git add .
git commit -m "feat(auth): add user authentication"
```

## Philosophy

- **Convention over tooling** - Simple formats, no complex CLI
- **Specs before code** - Agree on behavior, then implement
- **Deltas over rewrites** - Surgical changes, clear history
- **Trust the tools you have** - Git for history, Claude for intelligence

## Development

### Testing Locally

Run Claude Code with the plugin directory to test changes:

```bash
claude --plugin-dir /path/to/delta-spec
```

Then verify skills work:
- `/ds:status` - Should show active changes (or none)
- `/ds:spec` - Should list spec files
- `/ds:init` - Should detect if already initialized

### Validating Specs

Run the validation script to check spec format:

```bash
./scripts/validate-specs.sh
```

This checks for:
- Required sections (`## Purpose`, `## Requirements`)
- RFC 2119 keywords (SHALL, MUST, SHOULD, MAY)
- Scenarios for requirements
- Delta operation sections (ADDED/MODIFIED/REMOVED/RENAMED)

#### Limitations

The validation script performs basic structural checks but does **not** validate:
- **Requirement references** - Does not verify that MODIFIED or REMOVED operations reference existing requirements in main specs
- **Scenario completeness** - Does not enforce that all scenarios have GIVEN-WHEN-THEN structure
- **Cross-file consistency** - Does not check for duplicate requirement names across specs
- **Delta merge conflicts** - Does not detect when multiple changes modify the same requirement

For comprehensive validation, use `/ds:status` to detect conflicts and `/ds:archive` with pre-validation to ensure safe merging.

### Project Structure

```
delta-spec/
├── .claude-plugin/       # Plugin manifest
│   ├── plugin.json       # Plugin definition (name, version)
│   └── marketplace.json  # Marketplace metadata
├── skills/               # Skill implementations
├── scripts/              # Utility scripts
└── specs/                # Example specs directory
```

## Inspiration

Delta-Spec was inspired by [OpenSpec](https://github.com/Fission-AI/OpenSpec), a spec-driven development (SDD) framework for AI coding assistants by Fission AI.

## License

MIT
