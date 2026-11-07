# Changelog

The knowledge has its own version numbers, independent of TcAgent. Every version names the TcAgent version it needs, because skills
and prompts use tools by name. Changes to `high` risk rules have their own section: they can fail a pipeline with `--fail-on high`.

## [Unreleased]

Needs TcAgent 0.52.0 or later.

### Added
- Workflows: `bug-fix` (a signal that shows the fault, proven cause, fix, the same signal good), `safe-activation` (changes,
  backup, release by the user, load, check of the state), `online-change`, `refactoring`, `library-update`, `io-commissioning`.
- Skills: `plc-spec-review` (logic against the requirement before the first test), `plc-fix-compile`, `plc-alarm-diagnosis`,
  `plc-traceability`, `plc-multi-review`, `plc-st-patterns` (8 patterns that compile), `plc-skill-authoring`, `plc-retro` (what would make the next session
  better).
- Prompts: `activate-safely`, `check-logic`, `commission-io`, `diagnose-alarms`, `fix-bug`, `fix-compile`, `new-skill`, `online-change`,
  `refactor-safely`, `retro`, `review-multi`, `st-pattern`, `trace-requirements`, `update-library`.

### Changed
- `plc-debugging`: first a signal that shows exactly this fault, then the theory.
- `plc-code-review`: standards and requirement are checked and reported separately.
- `new-feature`: points to `plc-spec-review`, `plc-st-patterns` and `plc-fix-compile`, the steps stay the same.

## [1.0.0] - 2026-11-04

Needs TcAgent 0.52.0 or later.

### Added
- Skills: `plc-code-review`, `plc-debugging`, `requirements-interview`.
- Workflow: `new-feature`.
- Prompts: `check-coding-rules`, `commissioning-checklist`, `explain-object`, `review-object`, `test-fb`, `test-report`, `where-used`.
- Risk rules: `twincat-general` with 11 rules and 21 agent checks, several checks based on the Top 20 Secure PLC Coding Practices.

### High risk rules
- New: `hardcoded-credential`, `new-without-delete`.
