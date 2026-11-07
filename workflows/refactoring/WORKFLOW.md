---
name: refactoring
description: Change the structure of PLC code without changing what it does - with a safety net of tests before, and proof after. Use when code should be renamed, split, moved or simplified.
metadata:
  tcagent-gates: build-ok at the end
---
Refactoring changes the form, not the behaviour. A change of behaviour is a different task: do it before or after, not in
between. Follow the steps in order. Mark each one done with `tc_workflow action=step`; skip a step that does not apply with
`skip=true` (checkpoints cannot be skipped).

1. **goal** – Agree what gets better and what stays the same. Show the user the planned steps. Done when the user agreed.
2. **usages** – `tc_find_references` for every name that changes, `tc_plc_search` for strings that carry it: HMI bindings, I/O
   links, ADS symbols, `PERSISTENT` data. No tool sees external programs: ask the user about them. Names that are used outside the
   PLC project are an interface: say so, renaming them breaks other systems without a compiler error.
3. **net** – Run the tests of the area (`tc_test_run`), and note the result: a test that fails by design fails again later, that is
   fine. `tc_test_run` activates and resets the PLC: on a real machine ask first. Look at what the tests really exercise: name
   what they would not notice. If the area has no tests, add characterization tests that record what the code does today
   (`tc_test_skeleton`), or tell the user what is not covered and let them decide.
4. **change** – Small steps, each one compilable. Names and comments with `tc_refactor`, where a person confirms each change;
   without a person use `tc_plc_write` with `dryRun=true` first, and show the diff. Check after each step with `tc_check`; stop
   after 3 rounds without progress.
5. **build** (requires: build-ok) – `tc_build`.
6. **proof** – Run the same tests as in step 3. Done when the result is the same, with no test changed except for new names. A
   diff that shows only the planned lines is good proof too.
7. **review** – Load the skill `plc-code-review`. Check especially what the compiler cannot see: step 2, and the effect on an
   online change.
8. **save** – `tc_save`. Tell the user what changed, what stayed the same, and that this change needs a full load if it does.
