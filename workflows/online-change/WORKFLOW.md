---
name: online-change
description: Load a PLC code change into a running PLC without stopping it - check whether that is safe, get the user's release, load, check that it really arrived. Use when a change should go onto a running machine by online change.
metadata:
  tcagent-requires-module: runtime
  tcagent-gates: build-ok before the load
---
An online change takes effect in the next cycles of a running machine: instances keep running with new code. Every change on
the target needs the user's confirmation. `tc_test_run` does not belong in this workflow on the target: with changed code it
activates and resets the PLC, which is a full load. Follow the steps in order. Mark each one done with `tc_workflow action=step`;
skip a step that does not apply with `skip=true` (checkpoints cannot be skipped).

1. **target** – `tc_status`, `tc_plc_state`, `tc_policy`: which target, is it running, is it approved? Stop if not.
2. **changes** – List the changed objects and read them (`tc_plc_read`). Done when each change is on the list. A change of comments
   only creates no code, there is nothing to load.
3. **risks** – Look for what an online change does not handle well, and name each hit:
   - a running state machine or sequence: can a changed or removed step or state be active right now (`ads_read`)?
   - new or moved variables of running instances: they start with their initial value, what depends on them?
   - renamed or removed variables, changed types, changed `PERSISTENT` or `RETAIN` data;
   - changed `FB_init` or initial values: they do not run again for existing instances;
   - pointers and references to moved data, timers and edges in changed code;
   - changes to tasks, I/O links or libraries: these need an activation, use the workflow `safe-activation`.
   If a risk cannot be excluded, recommend stopping the machine and a normal load.
4. **build** (requires: build-ok) – `tc_check`, then `tc_build`, both clean. Tests only if they run on another system than the target.
5. **before** – Note the values to compare: `OnlineChangeCnt` and `AppTimestamp` of the application (`ads_symbols`, `ads_read`), and the
   states the change touches.
6. **release** – Ask the user with `tc_ask_user`: state of the machine, what is running, the risks of step 3, the way back. Go on
   only with an explicit yes for this change on this target.
7. **load** – `tc_plc_online login=true`. The IDE shows a dialog for the online change: a person has to confirm it there,
   `tc_dialogs` can only cancel. Ask the user to do so, then `logout=true`. If it offers a full download, stop: that stops the PLC,
   and it was not released.
8. **verify** – `OnlineChangeCnt` must be higher than in step 5, otherwise nothing was loaded: say so, and do not call it done. Then
   `tc_plc_state`, a rising cycle count, and the states the change touches. If not as expected, stop and ask, do not load again.
9. **save** – `tc_save`. Tell the user what was loaded, the risks that stay, and what to watch at the machine.
