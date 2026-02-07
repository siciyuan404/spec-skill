# Documentation Generator Hook

## Purpose

Create or update documentation required by code changes, with emphasis on behavior changes and operational impact.

## When to Use

- After implementing new features
- After changing API contracts or data models
- After introducing non-obvious logic or migration steps

## Execution Rules

1. Document behavior and contracts first, internal details second.
2. Prefer minimal, accurate updates over large speculative rewrites.
3. Keep docs traceable to requirements/design IDs when available (`RQ-*`, `DSN-*`, `TASK-*`).

## Steps

### 1) Analyze doc impact

- Identify changed surfaces: API, config, CLI, schema, UI behavior, workflows.
- Classify impact: user-facing, developer-facing, operator-facing.

### 2) Update required docs

Common targets:
- `README` or setup docs for usage changes
- API docs for endpoint/request/response changes
- migration/deployment notes for incompatible changes
- architecture or module docs for new components

### 3) Add concise code-level docs

- Add function/class comments only for non-obvious behavior
- Document invariants, edge-case handling, and failure modes
- Avoid repeating what code already states clearly

### 4) Provide examples

For changed APIs/commands, include at least one realistic example:
- Request + response (or input + output)
- Expected error example when relevant

### 5) Report updates

Return:
- Files updated
- What changed in each file
- Remaining doc gaps (if any)

## Validation

This hook passes only if:
- All behavior/contract changes are reflected in docs
- Breaking changes include migration guidance
- Examples are syntactically and semantically consistent with implementation
