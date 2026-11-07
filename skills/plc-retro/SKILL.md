---
name: plc-retro
description: Look back at a work session and propose what would make the next one better - a missing check, a rule, a lesson, a skill. Use when the user asks for a retrospective or what should be improved after a task.
metadata:
  tcagent-inspired-by: the open-source session retrospective for coding agents (improve the environment, not only the code)
  tcagent-version: "1"
---
# PLC retro

Look at the session as it happened, not as it should have gone. The goal is the setup around the agent: the next run should
not have the same problem. Change nothing: only propose, the user decides.

## Steps

1. Go through the session: where was time lost, what failed more than once, what did the user have to correct, which tool
   calls were long or useless?
2. Sort each finding into the place that would have prevented it:

| Place | Use when | How |
|---|---|---|
| Automatic check | a mistake a fixed rule can find | risk rule (`tc_risk_rules`), tests |
| Coding rule | the user corrected the style or structure | `tc_coding_rules_add` |
| Lesson | a cause was hard to find | `tc_lessons action=add` |
| Skill or workflow | a way of working was missing or a step was forgotten | `tc_skills action=add`, `tc_improve` |
| Project documentation | information was hard to find | `tc_doc` |
| Tool | a tool failed or was missing | `tc_feedback` |

Prefer the top of the table: a check always works, an instruction has to be remembered.

3. Also look for what can go: rules and instructions that changed nothing in this session.
4. Show the proposals to the user, most useful first, each with what happened, what to change and where. Write only what the
   user agreed to.
