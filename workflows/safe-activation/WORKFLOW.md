---
name: safe-activation
description: Bring a change onto a target system step by step - what changes, a backup, the user's release, loading and a check of the state afterwards. Use when a configuration is activated or a PLC program is loaded on a target.
metadata:
  tcagent-requires-module: runtime
  tcagent-gates: build-ok before the release; tc_activate only after a build with 0 errors (always)
---
Activating and loading can move machines and can endanger people. The agent never decides this alone: every step that
changes the target needs the user's confirmation, also when an earlier run had it. Nothing before step 5 touches the target, so
`tc_test_run` does not belong there: it builds, activates and resets the PLC. Follow the steps in order. Mark each one done with
`tc_workflow action=step`; skip a step that does not apply with `skip=true` (checkpoints cannot be skipped).

1. **target** – `tc_status`, `tc_plc_state`, `tc_policy` (approved targets). Is it a real machine or a simulation? Say which, and
   stop if the target is not approved. If the target of the project differs from the wanted one, say so: `tc_activate` with
   `netId` changes the target of the project. Done when target and kind are named.
2. **changes** – List what changes: PLC code, I/O links, tasks, cycle times, libraries, licenses. No tool compares the project with
   what runs on the target, so take it from version control or from the user, and say when it stays unknown. Say whether an online
   change is possible (workflow `online-change`) or the PLC has to stop.
3. **build** (requires: build-ok) – `tc_check`, then `tc_build`, both clean.
4. **backup** – Back up what can be lost: `tc_archive` for the project, in a place the user agreed on; persistent data if the change
   touches it (`tc_backup` is experimental, say so). Name where the backup is and how to go back.
5. **release** – Ask the user with `tc_ask_user`. At a machine: its state, who is near it, what will happen, what stops (outputs,
   axes, running sequences). In a simulation it is enough to name the target and what is loaded. Go on only with an explicit
   yes. Done when the user released this change on this target.
6. **load** – `tc_activate` or `tc_plc_online` for what was released, nothing else. The target needs some seconds after an
   activation: read the state again if the first read fails.
7. **verify** – Read `tc_plc_state`, and with `ads_read` values that show the program runs and is the new one: a rising cycle count,
   the states the change touches. Read `tc_errors kind=runtime` before and after: it has no reliable order. Done when the values
   are as expected; report them. If not, stop and ask, do not try a second load.
8. **tests** – In a simulation or on a test system run the tests (`tc_test_run`) if the user wants: it resets the PLC. Not on a machine
   without a new release.
9. **report** – `tc_save`. Tell the user what was loaded, the version or commit, the backup, and what they should check.
