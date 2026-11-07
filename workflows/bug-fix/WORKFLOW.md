---
name: bug-fix
description: Fix a malfunction in the PLC project - from a measurement that shows the fault over the proven cause to a fix that makes the same measurement good. Use when a known fault should be repaired in the code; to only find the cause use the skill plc-debugging.
metadata:
  tcagent-gates: build-ok after the fix; tc_activate only after a build with 0 errors (always)
---
Follow the steps in order. Mark each one done with `tc_workflow action=step`; skip a step that does not apply with
`skip=true` (checkpoints cannot be skipped).

1. **symptom** – Pin down what is wrong: which variable or output, expected and actual value, when it happens, since when.
   Search known problems first (`tc_lessons action=search`). Done when you can say the fault in one sentence with a value.
2. **fault-signal** – Before any theory, create a signal that shows exactly this fault: best a TcUnit test that fails
   (`tc_test_skeleton`, `tc_test_run`), otherwise a value read with `ads_read` or a recording with `tc_scope`. Done when you
   have run it once and it shows the fault. If no signal is possible, say so, list what you tried and ask the user for
   access or a recording. Do not go on with a guess.
3. **cause** – Load the skill `plc-debugging`. Name one concrete cause and prove it by a measurement or by reading the code.
   Done when the signal and the code explain each other. Show the cause to the user before you change anything.
4. **fix** – Make the smallest change that removes the cause, following the coding rules (`tc_coding_rules`). No
   reformatting and no other improvements in the same change.
5. **check** – `tc_check` until it is clean. Stop after 3 rounds without progress, or when the same error comes back: tell
   the user what you tried and what is still wrong.
6. **build** (requires: build-ok) – `tc_build` once the check is clean.
7. **signal-good** – Repeat the signal of step 2. A test becomes part of the project. Writing to the PLC, activating and
   starting need the user's confirmation. Done when the same signal shows the correct behaviour; if it can only be
   checked at the machine, say so and name what the user has to look at.
8. **tests** – Run the tests of the area (`tc_test_run`), nothing else may have broken. Skip this step when the project has
   no tests, and say so.
9. **review** – Load the skill `plc-code-review` and check the change. Look for the same fault in similar places
   (`tc_plc_search`).
10. **save** – `tc_save`. Tell the user the cause, the change, how it was proven, and what was not tested. Record a lesson if
    the cause was not obvious (`tc_lessons action=add`, after the user agreed).
