---
name: safe-activation
description: Bring a change onto a target system step by step - what changes, a backup, the user's release, loading and a check of the state afterwards. Use when a configuration is activated or a PLC program is loaded on a real target.
metadata:
  tcagent-gates: build-ok before the release; tc_activate only after a build with 0 errors (always)
---
Activating and loading can move machines and can endanger people. The agent never decides this alone: every step that
changes the target needs the user's confirmation, also when an earlier run had it. Follow the steps in order. Mark each one
done with `tc_workflow action=step`; skip a step that does not apply with `skip=true` (checkpoints cannot be skipped).

1. **target** – Name the target and how the change gets there: `tc_status`, `tc_plc_state`, `tc_policy` (approved targets).
   Is it a real machine or a simulation? Say which, and stop if the target is not approved.
2. **changes** – List what changes compared to what runs: PLC code, I/O links, tasks, cycle times, libraries, licenses. Say
   whether an online change is possible or the PLC has to stop. Read outstanding warnings (`tc_errors`).
3. **build** (requires: build-ok) – `tc_check`, then `tc_build`, both clean.
4. **tests** – Run the tests that exist (`tc_test_run`). A failed test ends the run, unless the user decides otherwise.
5. **backup** – Back up what can be lost: `tc_archive` for the project; persistent data if the change touches it (`tc_backup`
   is experimental, say so). Name where the backup is and how to go back.
6. **release** – Ask the user with `tc_ask_user`: state of the machine, who is near it, what will happen, what stops
   (outputs, axes, running sequences). Go on only with an explicit yes. Done when the user released this change on this
   target.
7. **load** – `tc_activate` or `tc_plc_online` for what was released, nothing else.
8. **verify** – Read the state: `tc_plc_state`, `tc_errors kind=runtime`, the states of the main objects with `ads_read`. Done
   when the values show the expected state; report them. If it is not as expected, stop and ask, do not try a second load.
9. **save** – Tell the user what was loaded, the version or commit, the backup, and what they should check at the machine.
