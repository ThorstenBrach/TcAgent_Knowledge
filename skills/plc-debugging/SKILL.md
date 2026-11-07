---
name: plc-debugging
description: Find the cause of a PLC malfunction before changing code - pin down the symptom, reproduce and measure online, name the root cause, then fix and verify. Use when the user reports wrong behaviour, a fault, a hanging sequence, a wrong value or an exception at runtime.
metadata:
  tcagent-inspired-by: the open-source "systematic debugging" method (no fix without a root cause)
  tcagent-version: "2"
---
# PLC debugging

Rule: **no code change before the cause is named and backed by a measurement.**

## 1. Pin down the symptom

- What exactly is wrong: which variable or output, expected vs. actual value, when (state, step, operating mode).
- Since when, after which change, always or sometimes.
- Search known problems first: `tc_lessons action=search query=<symptom or error code>`.

## 2. Reproduce and measure

First get a signal that shows exactly this fault: a failing TcUnit test, a value, or a scope recording. It must be able to
show the fault and the correct behaviour, so "nothing crashed" does not count. This is the main work of the search: with a
good signal the cause follows, and without one every theory is a guess. If you cannot get one, say so, list what you tried and
ask the user for access or a recording. For a fault that comes rarely, aim at making it come more often.

- Runtime state: `tc_plc_state`; messages of the runtime: `tc_errors kind=runtime`.
- Current values: `ads_read` of the involved variables (state, step, inputs, outputs, timers).
- Fast or intermittent effects: record with the scope (`tc_scope`) instead of single reads.
- Read the code path that sets the wrong value: `tc_plc_read`, `tc_find_references` (who writes it – also from other
  tasks?).

## 3. Hypothesis and proof

- Name one concrete cause ("step 30 waits for bDone, but bDone is reset in the same cycle by …").
- Prove it with a measurement or by reading the code – not by trying a fix.
- If the proof fails, go back to step 2 with the new information.

## 4. Fix and verify

- Smallest change that removes the cause; follow the coding rules. Check with `tc_check`.
- Writing values online (`ads_write`), activating or starting the PLC need the user's confirmation – on real hardware
  ask first.
- Verify with the same measurement that showed the error. If a TcUnit test can show the error, add it.

## 5. Keep the knowledge

If the cause was not obvious, save it: `tc_lessons action=add` with symptom, cause and solution.
