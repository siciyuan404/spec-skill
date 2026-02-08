# Changelog

All notable changes to this project are documented in this file.

The format follows Keep a Changelog, and this project uses date-based release notes in practice.

## [Unreleased]

### Added
- Reserved for upcoming changes.

## [2026-02-08b]

### Fixed
- **[CRITICAL]** Fixed `spec-skill-ops.ps1` `gate.requirements` — `-SimpleMatch` flag was used with regex pattern, causing requirement heading validation to silently never match. Replaced with proper `Where-Object -match` logic that also reports missing headings.
- **[CRITICAL]** Fixed `package_skill.py` import path — `from quick_validate import validate_skill` failed when script was run from outside its directory. Added `sys.path.insert` for sibling module resolution.
- Fixed `spec-skill-ops.ps1` `Run-ModeSwitch` — warnings were joined into a single multi-line string instead of separate array elements, causing malformed mode file output.
- Fixed `quick_validate.py` — frontmatter regex `\n` did not match Windows `\r\n` line endings. Added `content.replace('\r\n', '\n')` normalization.
- Fixed `quick_validate.py` — YAML field detection used naive substring check (`'name:' not in`) which could produce false positives. Replaced with `re.search(r'^name:', ..., re.MULTILINE)`.
- Fixed `quick_validate.py` — `read_text()` lacked explicit `encoding='utf-8'`, failing on Windows systems with non-UTF-8 default encoding.
- Fixed `install-opencode-skill.ps1` — added `try/finally` block for temp directory cleanup (matching bash version's `trap`), replaced forward-slash paths with `Join-Path`, and added clone failure detection.
- Fixed `init_skill.py` — added `validate_skill_name()` with format checks (hyphen-case, max 40 chars, no path separators) before directory creation. Guarded `chmod(0o755)` with `os.name != 'nt'` check for Windows compatibility.
- Fixed `README-zh.md` — multiple code blocks had opening triple backticks on the same line as preceding text, preventing proper Markdown rendering.

### Changed
- Removed four outdated English-only docs (`README.md`, `INSTALLATION_GUIDE.md`, `PROJECT_SUMMARY.md`, `TECHNICAL_DOCUMENTATION.md`) from `.claude/skills/spec-skill/` — they described v1.0.0 and lacked all 2026-02-08 features (queue, modes, gates, traceability). Chinese docs (`SKILL.md`, `README-zh.md`) are the maintained source.
- Updated `README-zh.md` directory tree, hook list, and template list to include previously missing `batch-task-queue.md` and `task-queue-template.md`.
- Added `.codex/skills/spec-skill` to sync and verification scripts (`sync-spec-skill.ps1`, `verify-spec-skill-consistency.ps1`), matching the distribution target documented in `CROSS-RUNTIME-COMPATIBILITY-zh.md`.
- Removed dead code in `spec-skill-ops.ps1` `Run-GateRequirements` (unused `$start` variable loop).

## [2026-02-08]

### Added
- Added executable spec governance helper script `scripts/spec-skill-ops.ps1`:
  - stage gates: `gate.requirements`, `gate.design`, `gate.tasks`
  - queue helpers: `queue.validate`, `queue.sync`, `queue.status`
  - anti-over-planning guard: `plan.cap`
  - explicit mode controls: `mode.status`, `mode.switch`
- Added `Completion Evidence` fields in task template to support auditable `completed` status.
- Added queue helper command examples and anti-over-planning constraints in queue template/hook.

### Changed
- Updated skill documentation to include executable gate commands and planning/execution mode guidance.
- Unified Chinese documentation naming to `SKILL.md` references.

### Docs
- Added `docs/INSTALL-zh.md` as installation entry with raw link for direct consumption.
- Added `docs/CROSS-RUNTIME-COMPATIBILITY-zh.md` for cross-runtime compatibility strategy and smoke matrix.

### Migration
- If you are upgrading from older versions:
  1. Re-sync skill distribution directories from source:
     - `powershell -ExecutionPolicy Bypass -File scripts/sync-spec-skill.ps1 -ChineseOnly`
  2. Run consistency verification:
     - `powershell -ExecutionPolicy Bypass -File scripts/verify-spec-skill-consistency.ps1`
  3. If using queue execution, adopt the new helper commands and template fields.

### Breaking Changes
- No known hard breaking changes in this release.
- Operational note: teams using custom task/queue templates should merge `Completion Evidence` and queue planning-cap fields.

## [2026-02-07]

### Added
- Initial public baseline with:
  - three-phase spec workflow (`requirements` / `design` / `tasks`)
  - steering templates and references
  - command-style hooks
  - multi-runtime distribution and synchronization scripts
