---
name: plc-fix-compile
description: Fix compiler errors of a TwinCAT PLC project step by step, with a limit of rounds. Use when tc_check or tc_build reports errors and the user asked for the code to be fixed.
metadata:
  tcagent-inspired-by: the open-source repair loop for generated PLC code (first error first, limited rounds)
  tcagent-version: "1"
---
# Fix compile errors

Fix only what the user asked to change. If you came across the errors while doing something else, report them and ask.

## Loop

1. Run `tc_check`. Sort the errors by object and line.
2. Take the **first** error only. Later ones often follow from it, such as everything after a missing `END_IF`.
3. Read the place (`tc_plc_read`) and the declaration of what it names (`tc_goto_definition`), not only the message.
4. Fix the cause with the smallest change. Do not comment code out, and do not change a type or an interface just to silence the
   compiler: that hides the error from the compiler, not from the machine.
5. Run `tc_check` again and compare.

**Stop** after 3 rounds without fewer errors, or when the same error comes back. Tell the user the error, what you tried, and your
best guess. Check known cases first: `tc_lessons action=search query=<error code>`.

## Common causes

| Message is about | Look for |
|---|---|
| Unknown identifier or type | A typo, a missing `VAR` entry, a library that is not referenced (`tc_plc_references`), a missing namespace |
| Type mismatch | An explicit conversion such as `INT_TO_REAL`, or the wrong variable; check the range before narrowing |
| Assignment to an output of a call | `=>` for outputs of a call, `:=` for inputs |
| Syntax near `END_IF`, `END_CASE`, `END_FOR` | A missing `;`, `THEN` or `DO`, or `ELSE IF` where `ELSIF` is meant |
| A method or interface is missing | The signature differs from the interface: compare it with the declaration |
| Duplicate definition | The same name twice, or a variable with the name of a global |
| Errors only in an unused POU | `tc_check` checks all objects: decide with the user whether the POU stays |

## Done

Done when `tc_check` shows 0 errors. Name the warnings that are new, and what you changed and why.
