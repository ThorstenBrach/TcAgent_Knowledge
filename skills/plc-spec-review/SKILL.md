---
name: plc-spec-review
description: Check written PLC logic against the requirement before the first test - coverage of inputs and outputs, limits, priorities, behaviour over cycles. Use after writing or changing logic with several conditions, a state machine or a sequence, before it is built or tested.
metadata:
  tcagent-inspired-by: the open-source self-check of generated PLC logic (a program that compiles can still miss the requirement)
  tcagent-version: "1"
---
# PLC spec review

A program that compiles can still be wrong. This check takes minutes, and a logic error found on the machine takes hours.
Compare the code with the requirement only. Do not read it as "looks fine": go through the list, and give each point a
result: passed, or changed.

## 1. Write down the contract

From the requirement, list all inputs, all outputs, every mode, state or branch it names, and every limit and time. If the
requirement leaves something open, ask (skill `requirements-interview`) instead of deciding it in the code.

## 2. Coverage

- Is every input used? An input that is declared but not used means a missing function.
- Does every output have an assignment on every path? An output nobody writes compiles and keeps its start value.
- Is every named state or branch implemented, and can every state be reached and left?

## 3. Limits

- For each limit decide `<` or `<=`, and which side the equal value belongs to.
- What happens at 0, at a negative value, at the upper limit, on an overflow?
- "Otherwise" in the requirement: does it really catch everything that is left?
- Does every `CASE` have an `ELSE`? Without it an unexpected value does nothing, and the outputs keep their last state.

## 4. Priorities and exclusions

- Stop and error conditions come first and win over everything after them.
- Outputs that exclude each other really do, also when several inputs are `TRUE` at once.
- Safety functions are not implemented here: only the interfaces to them are read.

## 5. Behaviour over cycles

- What must be kept over cycles (counters, latches, states) has a correct reset condition.
- What is calculated anew every cycle gets its value at the start of the code: a `VAR` initial value is only set once.
- Timers and edge detection are called in every cycle, not inside a condition that can be skipped.
- After a restart or a cancelled sequence: which state does it start from?

## 6. Nothing extra

No state, latch or edge the requirement does not ask for: logic that should follow the input directly must stay direct.

## Result

List each change you made because of this check, and each point you could not decide. Then go on with build and tests.
