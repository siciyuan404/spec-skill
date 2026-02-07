# Changelog

All notable changes to this project are documented in this file.

The format follows Keep a Changelog, and this project uses date-based release notes in practice.

## [Unreleased]

### Added
- Reserved for upcoming changes.

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
