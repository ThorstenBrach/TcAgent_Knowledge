---
name: plc-traceability
description: Connect requirements with code and tests - numbered requirements, a test per requirement, a coverage table as proof. Use when a function needs a documented proof of what was required and tested, or when the user asks which requirement is covered.
metadata:
  tcagent-inspired-by: the open-source practice of spec-driven development (stable requirement ids, one test per requirement)
  tcagent-version: "1"
---
# Traceability

Keep it small: one file per function, in the project. It should help to answer "was this required, and was it tested?".

## Steps

1. **Number the requirements**: take them from the specification or from the skill `requirements-interview`. Each gets an id that
   never changes, such as `R1`, `R2`, and one testable sentence with a value where there is one: "The clamp opens within 2 s
   after Release". Split sentences that hold two requirements. Ask about the ones that cannot be tested.
2. **Link the code**: name the object for each requirement (`tc_plc_search`). Put the id into the comment of the method or step
   only if the coding rules allow it.
3. **Link the tests**: at least one test per requirement (`tc_test_skeleton`, prompt `/test-fb`), with the id in the
   `///` comment of the test. What cannot be tested in TcUnit gets a named manual test at the machine.
4. **Run**: `tc_test_run`, and take the results from it, not from memory.
5. **Write the table**, and keep it next to the solution:

| Id | Requirement | Code | Test | Result | Date |
|---|---|---|---|---|---|
| R1 | Clamp opens within 2 s after Release | `FB_Clamp.Run` | `FB_Clamp_Test.WhenReleasedExpectOpenIn2s` | passed | 2026-11-07 |

6. **Check the table**: name each requirement without a test, each test without a requirement, and each failed test. Done when each
   row has a result or a reason why not.

## When something changes

A changed requirement keeps its id and gets a new date; a removed one stays marked as removed, ids are not reused. Run the tests
of the rows that are touched. Safety requirements are not proven this way: they follow the safety process of the project.
