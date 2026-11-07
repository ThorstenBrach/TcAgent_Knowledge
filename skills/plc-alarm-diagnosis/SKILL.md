---
name: plc-alarm-diagnosis
description: Find the likely fault from an alarm or event log - cleaned timeline, first cause, match with known fault patterns, a result with evidence. Use when the user gives an alarm export or event log and asks what happened.
metadata:
  tcagent-inspired-by: the open-source pattern of log-based, advisory fault diagnosis (read only, evidence for every claim)
  tcagent-version: "1"
---
# Alarm diagnosis

Read only. This works on an exported log, not on the machine. The result is a proposal: a person decides.

## Steps

1. **Read the log** (CSV or text with time and alarm text or number). Name its time span, the number of entries, and the source. If
   columns are unclear, ask. Done when each entry has a time and a name.
2. **Clean up**: remove exact repeats, and keep the count. Separate coming, going and acknowledged, if the log has them. Note
   gaps in time, a restart of the PLC, and clock changes: they break the order.
3. **Build the timeline**: group what happens within seconds. In a group, the **first** alarm is the likely cause, what follows is
   often a consequence, such as a stopped conveyor after a jam. Do not rank by the number of alarms: a flood says little.
4. **Compare with known patterns**, if the project has them. Keep them in the project as a Markdown or JSON file: per pattern a name,
   the alarms that make it up, and the usual cause and remedy. Also search `tc_lessons action=search`.
5. **Connect to the code**, if the project is open: find where the alarm is set (`tc_plc_search`), and which condition sets it.
6. **Write the result** in the form below. Do not state a cause without an alarm that supports it, and say when nothing fits.

## Result

For each possible fault, most likely first:

| Field | Content |
|---|---|
| Fault | Short name |
| Confidence | high, medium or low, with the reason |
| Alarms | The entries that support it, with time |
| Evidence | The pattern that matched, or the condition in the code |
| Against it | What does not fit |
| Next check | What a person should look at |

Also name what is not explained, and what could not be checked with the log alone.

## After the fault is solved

Offer to add the case to the patterns or as a lesson (`tc_lessons action=add`, after the user agreed). This is how the
diagnosis gets better with each case.
