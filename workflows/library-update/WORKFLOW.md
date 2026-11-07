---
name: library-update
description: Change the version of a PLC library in a project - compare the interfaces, check the usages, compile, test, lock the versions. Use when a library or placeholder should get another version.
metadata:
  tcagent-gates: build-ok after the change
---
Follow the steps in order. Mark each one done with `tc_workflow action=step`; skip a step that does not apply with `skip=true`
(checkpoints cannot be skipped).

1. **state** – `tc_plc_references installed=true`: which version is used, which are installed, placeholders. Name the library, the
   old and the new version. If the new version is not installed, ask the user, it is not installed by the agent on its own.
2. **differences** – Read the release notes if there are any (`tc_docs`). Compare with `tc_lib_signatures` for the symbols the
   project uses (`tc_plc_search`, `tc_find_references`): changed inputs and outputs, removed members, other default values, changed
   behaviour. Done when each used symbol is marked same or changed.
3. **plan** – Show the user what has to change in the code, and what can change in behaviour without a compiler error. Wait for
   their agreement. Other libraries that depend on this one change too: name them.
4. **change** – `tc_library` for the new version. Adapt the code as planned.
5. **check** – `tc_check` until it is clean. Stop after 3 rounds without progress and report.
6. **build** (requires: build-ok) – `tc_build`.
7. **tests** – `tc_test_run`. For behaviour the tests do not cover, list what the user has to check at the machine.
8. **lock** – If the project uses a lock file, update it (`tc_library_lock`).
9. **save** – `tc_save`. Tell the user the versions, what changed, and that a library change needs an activation or a full load
   (workflow `safe-activation`). Keep the way back: the old version number.
