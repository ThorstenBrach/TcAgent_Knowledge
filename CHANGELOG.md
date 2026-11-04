# Changelog

The knowledge has its own version numbers, independent of TcAgent. Every version names the TcAgent version it needs, because skills
and prompts use tools by name. Changes to `high` risk rules have their own section: they can fail a pipeline with `--fail-on high`.

## [1.0.0] - 2026-11-04

Needs TcAgent 0.52.0 or later.

### Added
- Skills: `plc-code-review`, `plc-debugging`, `requirements-interview`.
- Workflow: `new-feature`.
- Prompts: `check-coding-rules`, `commissioning-checklist`, `explain-object`, `review-object`, `test-fb`, `test-report`, `where-used`.
- Risk rules: `twincat-general` with 11 rules and 21 agent checks, several checks based on the Top 20 Secure PLC Coding Practices.

### High risk rules
- New: `hardcoded-credential`, `new-without-delete`.
