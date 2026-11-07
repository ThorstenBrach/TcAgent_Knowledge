---
name: new-feature
description: Add a new machine function or extend an existing one in the PLC project - from the clarified requirement over a change plan to code that passes tc_check and then builds with 0 errors, and is reviewed. Use it when the user asks for a new function, a new FB or a larger extension.
metadata:
  tcagent-gates: spec-ok before any code (the user confirms or skips); build-ok (after a clean tc_check) before review; tc_activate only after a build with 0 errors (always)
  tcagent-requires-tcagent: ">=0.52.1"
---
Follow the steps in order. Mark each one done with `tc_workflow action=step`; skip a step that does not apply with
`skip=true` (checkpoints cannot be skipped).

1. **requirements** (requires: spec-ok) – Clarify what the function must do before any code: load the skill `requirements-interview`
   (`tc_skills action=show name=requirements-interview`) and follow it. If the user already gave a complete specification
   (inputs, outputs, states, error handling, limits), do not ask again. Then `tc_workflow action=step`, with the short specification
   as `note`: TcAgent asks the user to confirm it. If the user does not want an interview, `skip=true`: TcAgent asks them too.
   No PLC code can be written before that.
2. **change-plan** – Read the coding rules (`tc_coding_rules`) and the affected code (`tc_plc_read`, `tc_plc_search`,
   `tc_find_references`). Show the user a short plan: which POUs, methods, DUTs and GVLs are new or changed, which
   interfaces change, which I/Os or tasks are touched. Wait for the user's agreement before writing code.
3. **code** – Write the code with `tc_plc_write` / `tc_plc_create`, following the coding rules (names, comments, structure).
   For logic with several conditions, check it with the skill `plc-spec-review` before you go on; for recurring logic see `plc-st-patterns`.
   Keep the change as small as the plan; no unrelated reformatting.
4. **check** – Pre-compile with `tc_check` first: it is fast and generates no code. Fix every compiler error it reports and
   repeat until it is clean - fix the cause, not the symptom. Stop after 3 rounds without progress (skill `plc-fix-compile`).
5. **build** (requires: build-ok) – `tc_build` once the check is clean; it must end with 0 errors. If it fails, go back to
   `tc_check` for the fixes instead of building again and again (a build generates the executable code and takes longer).
6. **tests** – If the project has TcUnit tests for this area, add or extend a test and run it (`tc_test_run`). Recommended,
   not a checkpoint - skip it when the project has no tests.
7. **review** – Load the skill `plc-code-review` and review the change against it. Fix the findings that are clearly
   wrong; list the others for the user.
8. **save** – `tc_save`. Summarize for the user what was changed, what was not tested, and what they should check on the
   machine. If something was hard to find, record a lesson (`tc_lessons action=add`, after the user agreed).
