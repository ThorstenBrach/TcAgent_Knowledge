---
name: project-review
description: Review a whole PLC project - deterministic checks over everything first, then the structure, then deep reviews of the hot spots only, and a report with a traffic light per area. Use for a handover, an acceptance, before a release, or when the user asks to review the whole project.
metadata:
  tcagent-gates: none - the review changes nothing
  tcagent-requires-tcagent: ">=0.52.1"
---
The review changes nothing: it reads, proves and reports. Going object by object does not scale; look at everything with the
tools first and spend the deep reading on the few places that matter. Follow the steps in order. Mark each one done with
`tc_workflow action=step`; skip a step that does not apply with `skip=true`.

1. **goal** – Agree with the user what the review is for (handover, acceptance, release, a known problem) and what is left out
   (libraries, generated code, test code). Done when the scope is clear in one sentence.
2. **deterministic** – Run the checks that need no AI over the whole scope: `tc_check`, `tc_doc action=risks`, the coding rules
   (`tc_coding_rules`) with the checks of `tc_risk_rules action=show`, and `tc_static_analysis` if the license is there. Keep the counts per object;
   do not read the objects yet.
3. **structure** – `tc_doc action=outline` and `tc_task action=list`: tasks and cycle times, which program runs where, the call
   hierarchy. Find data written from more than one task, `PERSISTENT` and `RETAIN` data, the I/O mapping (`tc_io_vars`), the
   interfaces to safety and HMI. Note what looks inconsistent: naming, structure, error handling done in different ways.
4. **hotspots** – Choose at most 10 objects for a deep review: the most risks and findings, large or complex, written to from
   several tasks, without tests (`tc_test_run action=list`), or central in the call graph. Ask with `tc_ask_user`: the list
   with the reason for each, options "as proposed" and "change it" - wait for the answer before step 5. Without a person (a
   run without a window) choose them yourself and name them in the report.
5. **deep** – Review each hotspot with the skill `plc-code-review`, one object at a time, with what step 3 found about it.
   Prove each finding with code and place; stop after 3 rounds without new findings per object.
6. **cross-cutting** – Check across the project: online change (`PERSISTENT`, pointers and references, instance data that
   moves), error handling and acknowledging, operating modes and their transitions, start-up after a power cycle, the
   structure the coding rules ask for.
7. **report** – Write the report: the scope, the counts of step 2 per area, a traffic light per area (structure, code
   quality, risks, tests, online change, interfaces) with one sentence why, and the findings most severe first. Record each
   finding that should be acted on with `tc_advisor action=record` (kind review, evidence with object and line, an order for an
   agent naming the workflow). Name what was not looked at.
