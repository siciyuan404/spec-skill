# Test Generator Hook

## Purpose

Generate focused tests from requirements and implementation changes.

## When to Use

- New behavior is introduced
- Bug fixes are implemented
- API contracts or data transformations change

## Execution Rules

1. Derive test cases from acceptance criteria first (prefer `RQ-*` mapping).
2. Prioritize high-signal tests over high-volume boilerplate.
3. Include negative and edge scenarios, not only happy paths.
4. Reuse existing test patterns and fixtures in the repo.

## Steps

### 1) Select test targets

- Identify modified modules and public behavior changes.
- Map each behavior change to one or more test cases.

### 2) Build test matrix

For each target, include:
- Success path
- Validation failures
- Error handling/retry/fallback behavior
- Boundary conditions

### 3) Generate tests by level

- Unit tests for pure logic and local behavior
- Integration tests for module/API interactions
- End-to-end tests only for critical user flows

### 4) Add regression tests for bug fixes

- Add a test that fails on the old behavior and passes with the fix.

### 5) Run and report

- Execute relevant test suites
- Return pass/fail and coverage delta if available

## Validation

This hook passes only if:
- New behavior has explicit automated tests
- Bug fixes include regression tests
- Tests fail before fix (or are provably new behavior) and pass after changes
- Tests are deterministic and not timing-flaky
