---
name: io-commissioning
description: Check the I/Os of a machine signal by signal and keep a record - devices, links, inputs, outputs. Use when I/Os are commissioned, or checked after a hardware change.
metadata:
  tcagent-gates: every output is switched by a person or after an explicit release per signal
---
Switching an output can move a machine. The agent never sets an output on its own: a person does it, or the user releases that
one signal with the machine in a safe state. Safety signals are checked by the responsible person with the safety tools, they are
only recorded here. Follow the steps in order. Mark each one done with `tc_workflow action=step`; skip a step that does not apply with
`skip=true` (checkpoints cannot be skipped).

1. **devices** – Read the project with `tc_tree path=TIID`. A scan of the hardware with `tc_io_scan` only works in Config mode, which
   stops the PLC: ask the user first, and bring the PLC back afterwards (`tc_runtime_mode`, wait until `tc_plc_state` shows it). In Run
   it reports nothing, which does not mean there are no devices. Does the hardware match the project? List what is missing,
   additional or of another type.
2. **list** – Make the signal list from the project (`tc_io_vars`, variables with `AT %I` and `AT %Q`): name, address, type, comment,
   and from the circuit diagram what the user provides. Done when each signal is on the list. If the project has no signals,
   say so and end with `tc_workflow action=finish abort=true`.
3. **links** – Read the links (`tc_mapping_export`). Look for variables without a link and links to the wrong type or channel. Propose
   the corrections, and change them with `tc_link` only after the user agreed.
4. **inputs** – For each input: the person at the machine triggers it, you read it with `ads_read`, the record says expected and
   seen. Do them in groups the person can walk through. Done when each input is marked ok, wrong or not tested in the record; "not
   tested" lives there, the step is still marked done.
5. **analog** – For analog signals read the value at two known points, and compare range and scaling.
6. **outputs** – Only with the machine in a safe state. Ask with `tc_ask_user` per output or per group: who switches it, what moves,
   who is near it. Mark each one ok, wrong or not tested. Writing a value (`ads_write`) needs the release of that signal.
7. **record** – Write the record as a table: signal, address, expected, seen, result, tester, date. Name open points. It stays in the
   project, for example as a document next to the solution.
8. **save** – `tc_save` if something was changed. Tell the user what is open and what has to be repeated.
