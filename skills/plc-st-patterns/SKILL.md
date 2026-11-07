---
name: plc-st-patterns
description: Proven Structured Text patterns for recurring control logic - latch with priority, edge counter, hysteresis, debounce, wait with timeout, timed sequence, shift register, asynchronous call. Use when writing such logic, to start from a compiled pattern instead of from nothing.
metadata:
  tcagent-inspired-by: the open-source idea of verified skeletons for generated PLC logic
  tcagent-version: "1"
---
# ST patterns

Starting points, not finished blocks: small function blocks that compile in TwinCAT, in `references\<name>.st` next to this file.
Each file has the declaration, then the line `// --- implementation ---`, then the code.

The coding rules of the project come first (`tc_coding_rules`): adapt names, comments and structure. If the project already has a
block for it, or a library has one, use that instead. Show the user which pattern you start from.

| File | For | Watch out for |
|---|---|---|
| `latch_priority.st` | Start/stop of a motor or valve | Stop wins over start, and a stop signal should be wire-break safe (`TRUE` = running allowed) |
| `edge_counter.st` | Counting parts or events | Count on the edge, not on the level; a reset wins over counting |
| `hysteresis.st` | Two-point control of level or temperature | Keep the state between the limits; `Low < High` |
| `debounce.st` | Noisy inputs | The delay adds to the reaction time |
| `wait_timeout.st` | Waiting for a signal in a sequence | Every wait has a timeout and a defined error |
| `timed_sequence.st` | Step sequence with an error state | `ELSE` catches invalid steps; every step can be left |
| `shift_register.st` | Tracking parts on a conveyor | Shift on the edge of the clock; check the array bounds |
| `async_call.st` | Calling a block with Execute, Busy, Done, Error | Execute stays `TRUE` until Done or Error, one clean edge per job |

After adapting a pattern go through the skill `plc-spec-review`, then `tc_check`.
