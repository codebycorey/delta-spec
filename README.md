# Delta-Spec

A minimal, Claude Code-native system for spec-driven development.

## What is this?

Delta-Spec is a convention for managing software specifications that:

- **Uses delta specs** - Describe what's changing (ADDED/MODIFIED/REMOVED) rather than rewriting entire spec files
- **Works with Claude Code** - Leverages native task tracking and plan mode
- **No CLI required** - Claude handles parsing and merging
- **Git-native** - Your commit history is your archive

## Installation

### Manual (recommended)

Clone or copy this repository to `.claude/plugins/delta-spec` in your project:

```bash
git clone https://github.com/YOUR_USER/delta-spec .claude/plugins/delta-spec
```

Or add as a git submodule:

```bash
git submodule add https://github.com/YOUR_USER/delta-spec .claude/plugins/delta-spec
```

## Getting Started

1. Install delta-spec using one of the methods above
2. Run `/ds:init` to initialize the `specs/` directory
3. Run `/ds:new my-first-feature` to begin your first change

## Commands

| Command | Description |
|---------|-------------|
| `/ds:init` | Initialize delta-spec in a repository |
| `/ds:new <name>` | Start a new change with a proposal |
| `/ds:plan [name]` | Create design and delta specs |
| `/ds:tasks [name]` | Create implementation tasks |
| `/ds:archive [name]` | Merge delta specs and archive change |
| `/ds:spec [domain]` | View and discuss specifications |
| `/ds:status` | Show active changes |

## Workflow

```
/ds:init               → Set up specs/ folder (once per repo)
/ds:new add-feature    → Work on proposal (problem, scope)
/ds:plan               → Explore codebase, create design + delta specs
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

## License

MIT
