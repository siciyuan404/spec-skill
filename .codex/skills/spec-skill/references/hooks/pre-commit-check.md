# Pre-Commit Check Hook

## Purpose

Validate code quality and release readiness before creating a commit.

## When to Use

- Before committing feature, refactor, or bugfix changes
- Before opening a pull request

## Execution Rules

1. Prefer repository-native commands first (for example `npm run lint`, `npm test`, `pnpm test`, `go test`, `pytest`).
2. Prefer built-in file/search tools over shell text processing when available.
3. Use shell commands as fallback when no specialized tool exists.
4. Report concrete pass/fail results, not generic statements.

## Steps

### 1) Inspect scope of change

- Check changed files and staged files.
- Identify whether docs, configs, API contracts, or migrations changed.

### 2) Run quality checks

Run the project's standard checks in this order:
1. Lint/static checks
2. Unit tests
3. Integration tests (if configured)
4. Build/type-check (if configured)

### 3) Verify security and hygiene

- Ensure no secrets/tokens/passwords are staged
- Ensure no debug leftovers (`console.log`, temporary prints, ad-hoc breakpoints)
- Ensure generated artifacts are intentionally tracked

### 4) Verify docs impact

If changed behavior affects users/developers, update relevant docs:
- API docs
- README/setup notes
- migration notes/changelog

### 5) Summarize results

Return:
- Checks executed
- Pass/fail per check
- Blocking issues
- Recommended next action

## Validation

This hook passes only if:
- Lint/static checks pass
- Required test suites pass
- Build/type-check passes (if required by repo)
- No secrets or unintended debug output are staged
- Required documentation updates are complete

## Cross-Platform Command Fallbacks (Optional)

Use these only when repo-native commands are unavailable.

### Search TODO/FIXME/HACK

Linux/macOS:
```bash
rg "TODO|FIXME|HACK" src
```

Windows PowerShell:
```powershell
rg "TODO|FIXME|HACK" src
```

### Search for common secret patterns in staged diff

Linux/macOS:
```bash
git diff --cached | rg -i "password|secret|api[_-]?key|token|private[_-]?key"
```

Windows PowerShell:
```powershell
git diff --cached | rg -i "password|secret|api[_-]?key|token|private[_-]?key"
```

### Search debug statements

Linux/macOS:
```bash
rg "console\.log|print\(|debugger" src
```

Windows PowerShell:
```powershell
rg "console\.log|print\(|debugger" src
```
