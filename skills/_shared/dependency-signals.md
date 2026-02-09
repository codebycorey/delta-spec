Scan each feature description for dependency keywords:

### Dependency Keywords

| Pattern | Example | Meaning |
|---------|---------|---------|
| `needs X` | "needs auth" | Depends on feature matching "auth" |
| `requires X` | "requires authentication" | Depends on feature matching "authentication" |
| `uses X` | "uses the permissions system" | Depends on feature matching "permissions" |
| `builds on X` | "builds on auth" | Depends on feature matching "auth" |
| `after X` | "after auth is done" | Depends on feature matching "auth" |
| `depends on X` | "depends on user model" | Depends on feature matching "user model" |
| `(requires X)` | "(requires auth)" | Parenthetical dependency hint |

### Matching Feature Names

When a dependency keyword is found:
1. Extract the referenced term (e.g., "auth" from "needs auth")
2. Fuzzy match against other feature names in the batch
3. Match if the term appears in the feature name or description

### Confidence Levels

**High confidence** (proceed automatically):
- Exact name match: "needs user-auth" matches feature named `user-auth`
- Clear substring: "needs auth" matches `user-auth`
- Single possible match in the batch

**Low confidence** (ask for clarification):
- Multiple possible matches: "needs users" could match `user-auth` or `user-profile`
- No matches found but dependency keyword present
- Ambiguous reference

If uncertain, ask:

> Feature "admin-dashboard" mentions "needs permissions". Did you mean:
> 1. `role-permissions` - Role-based permissions system
> 2. Something not in this batch (will be added to Dependencies as external)
> 3. No dependency intended
