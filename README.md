# Delta-Spec

A minimal, Claude Code-native system for spec-driven development.

## What is this?

Delta-Spec is a convention for managing software specifications that:

- **Uses delta specs** - Describe what's changing (ADDED/MODIFIED/REMOVED) rather than rewriting entire spec files
- **Works with Claude Code** - Leverages native task tracking and plan mode
- **No CLI required** - Claude handles parsing and merging
- **Git-native** - Your commit history is your archive

## Getting Started

1. Clone this repo or copy the `.claude/` and `.specs/` folders to your project
2. Start Claude Code in your project
3. Run `/new-change my-first-feature` to begin

## Commands

| Command | Description |
|---------|-------------|
| `/spec` | View and discuss specifications |
| `/new-change <name>` | Start a new change |
| `/merge` | Merge delta specs into main specs |
| `/spec-status` | Show active changes |

## How It Works

### 1. Write a Proposal

```markdown
# Add User Authentication

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

### 4. Merge

Run `/merge` - Claude applies your deltas to the main specs.

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
