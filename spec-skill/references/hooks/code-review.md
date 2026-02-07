# Code Review Hook

## Purpose

Review code changes for correctness, maintainability, security, and spec alignment.

## When to Use

- Before creating a PR
- After significant feature or refactor work
- After addressing review feedback

## Execution Rules

1. Review against requirements/design first, style second.
2. Call out concrete issues with file paths and evidence.
3. Separate blockers from non-blocking suggestions.

## Steps

### 1) Understand change intent

- Read related `requirements.md`, `design.md`, `tasks.md` when available.
- Identify expected behavior and constraints.

### 2) Review for correctness

- Logic correctness and edge handling
- Error handling and fallback behavior
- Backward compatibility and migration impact

### 3) Review for maintainability

- Naming clarity and structure
- Complexity hotspots and duplication
- Testability and modular boundaries

### 4) Review for security/performance

- Input validation and output safety
- Secret handling and auth checks
- Obvious performance regressions in hot paths

### 5) Review tests and docs

- Ensure tests cover new behavior and regressions
- Ensure docs reflect behavior and contract changes

### 6) Report findings

Use severity levels:
- Blocker: must fix before merge
- Major: should fix before merge
- Minor: optional improvement

Include:
- Issue summary
- Evidence (`path:line`)
- Suggested fix direction

## Validation

This hook passes only if:
- No blocker issues remain
- Major issues are addressed or explicitly accepted
- Behavior is aligned with requirements/design intent
