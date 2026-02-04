# Delta-Spec

A minimal, Claude Code-native system for spec-driven development.

## What is this?

Delta-Spec is a convention for managing software specifications that:

- **Uses delta specs** - Describe what's changing (ADDED/MODIFIED/REMOVED) rather than rewriting entire spec files
- **Works with Claude Code** - Leverages native task tracking and plan mode
- **No CLI required** - Claude handles parsing and merging
- **Git-native** - Your commit history is your archive

## Installation

### Local Installation

Clone the repository and run Claude Code with the plugin directory:

```bash
git clone https://github.com/codebycorey/delta-spec.git
claude --plugin-dir /path/to/delta-spec
```

### Verify Installation

After installation, run `/help` to see the `ds:` commands listed under plugin commands.

> **Note:** Marketplace installation will be available once the plugin is published. For now, use the local installation method above.

## Getting Started

1. Install delta-spec using one of the methods above
2. Run `/ds:init` to initialize the `specs/` directory
3. Run `/ds:new my-first-feature` to begin your first change

### Recommended: Add to AGENTS.md

To ensure Claude consistently uses delta-spec for planning and feature work, add this to your project's `AGENTS.md`:

```markdown
## Development Workflow

This project uses delta-spec for spec-driven development.

- Before implementing new features, run `/ds:new <feature-name>` to create a proposal
- Use `/ds:plan` to explore the codebase and create design specs before coding
- Run `/ds:tasks` to generate implementation tasks
- After completing work, run `/ds:archive` to merge specs
- Check `/ds:status` to see active changes and their progress
```

This gives Claude context about your preferred workflow so it proactively uses the spec-driven approach when planning new features.

## Commands

| Command | Description |
|---------|-------------|
| `/ds:init` | Initialize delta-spec (optionally generate specs from existing code) |
| `/ds:new <name>` | Start a new change with a proposal |
| `/ds:plan [name]` | Create design and delta specs |
| `/ds:tasks [name]` | Create tasks for one or all planned changes |
| `/ds:archive [name]` | Safely merge delta specs and archive change |
| `/ds:drop [name]` | Abandon a change and clean up dependencies |
| `/ds:spec [domain\|search]` | View, discuss, or search specifications |
| `/ds:status` | Show active changes with conflicts and progress |

## Workflow

```
/ds:init               → Set up specs/ folder (once per repo)
/ds:new add-feature    → Work on proposal (problem, scope)
/ds:plan               → Explore codebase, create design + delta specs
/ds:tasks              → Create implementation tasks
[implement]
/ds:archive            → Merge deltas into specs, archive change
/ds:drop               → Abandon change (if no longer needed)
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

Claude creates tasks from your specs. Work through them.

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

### Project Structure

```
delta-spec/
├── .claude-plugin/       # Plugin manifest
│   ├── plugin.json       # Plugin definition (name, version)
│   └── marketplace.json  # Marketplace metadata
├── commands/ds/          # Slash command entry points
├── skills/               # Detailed skill implementations
├── scripts/              # Utility scripts
└── specs/                # Example specs directory
```

## Inspiration

Delta-Spec was inspired by [OpenSpec](https://github.com/Fission-AI/OpenSpec), a spec-driven development (SDD) framework for AI coding assistants by Fission AI.

## License

MIT
