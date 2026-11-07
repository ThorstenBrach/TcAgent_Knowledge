---
name: online-change
description: Load a PLC code change into a running PLC without stopping it - check whether that is safe, get the user's release, load, check the state. Use when a change should go onto a running machine by online change.
metadata:
  tcagent-gates: build-ok before the load
---
An online change takes effect in the next cycles of a running machine: instances keep running with new code. Every change on
the target needs the user's confirmation. Follow the steps in order. Mark each one done with `tc_workflow action=step`; skip a
step that does not apply with `skip=true` (checkpoints cannot be skipped).

1. **target** – `tc_status`, `tc_plc_state`, `tc_policy`: which target, is it running, is it approved? Stop if not.
2. **changes** – List the changed objects and read them (`tc_plc_read`). Done when each change is on the list.
3. **risks** – Look for what an online change does not handle well, and name each hit:
   - a running state machine or sequence: can a changed or removed step or state be active right now (`ads_read`)?
   - new or moved variables of running instances: they start with their initial value, what depends on them?
   - renamed or removed variables, changed types, changed `PERSISTENT` or `RETAIN` data;
   - changed `FB_init` or initial values: they do not run again for existing instances;
   - pointers and references to moved data, timers and edges in changed code;
   - changes to tasks, I/O links or libraries: these need an activation, use the workflow `safe-activation`.
   If a risk cannot be excluded, recommend stopping the machine and a normal load.
4. **build** (requires: build-ok) – `tc_check`, then `tc_build`, both clean. Run the tests that exist (`tc_test_run`).
5. **release** – Ask the user with `tc_ask_user`: state of the machine, what is running, the risks of step 3, the way back. Go on
   only with an explicit yes for this change on this target.
6. **load** – `tc_plc_online login=true`, confirm the online change in the dialog of the IDE with the user, then
   `logout=true`. If the IDE offers only a full download, stop: that stops the PLC, and it was not released.
7. **verify** – `tc_plc_state`, `tc_errors kind=runtime`, and with `ads_read` the states the change touches. Done when the values
   are as expected. If not, stop and ask, do not load a second time.
8. **save** – `tc_save`. Tell the user what was loaded, the risks that stay, and what to watch at the machine.
