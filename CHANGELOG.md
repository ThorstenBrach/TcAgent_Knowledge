# Changelog

The knowledge has its own version numbers, independent of TcAgent. Every version names the TcAgent version it needs, because skills
and prompts use tools by name. Changes to `high` risk rules have their own section: they can fail a pipeline with `--fail-on high`.

## [1.1.0] - 2026-11-08

Needs TcAgent 0.53.0 or later (`tc_advisor`, `tcagent-requires-module`, the checkpoint `spec-ok`).

### Added
- Advisor: prompts `advise` (a run in the chat - read, advise, hand over an order) and `advise-live` (at the running plant,
  read only; concludes only from values when the code may not match the PLC).
- Workflow `project-review` and prompt `review-prj`: the review of a whole PLC project - checks over everything, the hotspots
  confirmed by the user, deep reviews, a report; the findings become advice.
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
- `new-feature`: points to `plc-spec-review`, `plc-st-patterns` and `plc-fix-compile`. The specification is the checkpoint
  `spec-ok` (the user confirms it or skips it), and tests are always proposed, the user decides.
- Items that cannot work without a module name it (`tcagent-requires-module`), so they pause while it is switched off.
- Workflows after test runs with an agent on a local runtime: order of release and tests, the online change really arrived,
  Config mode for the I/O scan, library versions with `source=doc`.

## [1.0.0] - 2026-11-04

Needs TcAgent 0.52.0 or later.

### Added
- Skills: `plc-code-review`, `plc-debugging`, `requirements-interview`.
- Workflow: `new-feature`.
- Prompts: `check-coding-rules`, `commissioning-checklist`, `explain-object`, `review-object`, `test-fb`, `test-report`, `where-used`.
- Risk rules: `twincat-general` with 11 rules and 21 agent checks, several checks based on the Top 20 Secure PLC Coding Practices.

### High risk rules
- New: `hardcoded-credential`, `new-without-delete`.
