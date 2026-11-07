---
name: plc-multi-review
description: Review important PLC code from several separate views - safety of the machine, runtime behaviour, standards - and bring the findings together. Costs more than a normal review. Use only when the user asks for it, or for a critical change before release.
metadata:
  tcagent-inspired-by: the open-source multi-perspective review pattern (separate views, then one result)
  tcagent-version: "1"
---
# Review from several views

One reviewer tends to find one kind of problem. Here each view looks at the same code alone. If your client can run subagents, give
each view its own one with a fresh context, otherwise do the views one after the other and finish each before you start the next.

## Views

Each view reads the objects (`tc_plc_read`), and the skill `plc-code-review` for the general list, then looks only at its own question:

- **Machine safety**: what can move or stay on when it should not? States on error, stop and restart, timeouts, interlocks, outputs
  to a safe state. Interfaces to safety logic only: the safety logic itself is not reviewed or changed here.
- **Runtime**: tasks and cycle time, access from several tasks, online change, persistence, memory, communication that can hang.
- **Standards**: coding rules (`tc_coding_rules`), risk rules (`tc_doc action=risks`), names, comments, tests, the requirement.

## Bring it together

1. Merge findings about the same place, and keep the highest severity.
2. Check each finding in the code before you keep it. Drop what does not hold, and say so.
3. Show where the views disagree instead of voting it away: it is usually a real trade-off for the user.
4. Report as in `plc-code-review`, with the view that found each point.

This review supports people, it does not replace the verification a safety standard requires. Change nothing without consent.
