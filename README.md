# Delta-Spec

A minimal, Claude Code-native system for spec-driven development.

## What is this?

Delta-Spec is a convention for managing software specifications that:

- **Uses delta specs** - Describe what's changing (ADDED/MODIFIED/REMOVED) rather than rewriting entire spec files
- **Works with Claude Code** - Leverages native task tracking and plan mode
- **No CLI required** - Claude handles parsing and merging
- **Git-native** - Your commit history is your archive

## Installation

### Via OpenSkills (recommended)
```bash
npx openskills install YOUR_USER/delta-spec
npx openskills sync
```

### Via Claude Code Plugin
```bash
/plugin marketplace add YOUR_USER/delta-spec
/plugin install delta-spec
```

### Manual
Copy `SKILL.md` to `.claude/skills/delta-spec.md` in your project.

## Getting Started

1. Install delta-spec using one of the methods above
2. Create `.specs/` directory in your project
3. Run `/ds:new-change my-first-feature` to begin

## Commands

| Command | Description |
|---------|-------------|
| `/ds:spec` | View and discuss specifications |
| `/ds:new-change <name>` | Start a new change |
| `/ds:merge` | Merge delta specs into main specs |
| `/ds:status` | Show active changes |

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

Run `/ds:merge` - Claude applies your deltas to the main specs.

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
