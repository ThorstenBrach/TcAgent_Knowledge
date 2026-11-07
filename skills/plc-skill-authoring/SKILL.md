---
name: plc-skill-authoring
description: Write or improve a skill, workflow or prompt for TcAgent so that agents really follow it, and test it. Use when the user wants to create or change one of them.
metadata:
  tcagent-inspired-by: open-source guides on writing for agents and on testing skills (see the failure first, clear completion criteria)
  tcagent-version: "1"
---
# Writing skills and workflows

## Which kind

| Kind | Use for |
|---|---|
| Coding rule | What the code must look like |
| Risk rule | What a fixed pattern can find: a check always works, an instruction has to be remembered |
| Skill | How a kind of task is done, loaded when the task fits |
| Workflow | Steps that must always happen, with checkpoints |
| Prompt | A prepared request for a person, it stays short and points to a skill or workflow |
| Lesson | One hard-won fact |

Choose the first one that can do the job.

## Writing

- **The description decides whether it is used**: say what it does and name each situation that should trigger it.
- **Every step ends on a criterion** the agent can check: "each input is marked ok, wrong or not tested", not "check the inputs".
- **Say what to do in the failure case**: what stops the work, and what the user is told.
- **Name real tools** with their arguments, and check that they exist (`tc_version`, `docs/TOOLS.md`).
- **Short**: cut what an agent does anyway. Move long references into a file next to `SKILL.md`, and point to it.
- **Give the reason** for a rule that looks odd: an agent then handles the edge case correctly.
- Anything that can harm a machine or a person needs an explicit release by the user in the step itself.
- If it needs a plugin or a TcAgent version, say so: `tcagent-requires-plugin`, `tcagent-requires-tcagent`.

## Testing

1. **Before writing**: run the task without the skill and note what goes wrong. If nothing goes wrong, the skill is not needed.
2. Write 2 to 3 test tasks, one of them a tempting shortcut ("just change it quickly").
3. Run them with the skill, in a fresh session. Compare with step 1.
4. Each wrong turn leads to one change in the text, then test again.
5. Check the trigger: does a task that fits load it, and does a task that does not fit leave it alone?

Done when the test tasks go right without help, and the user has read the text.
