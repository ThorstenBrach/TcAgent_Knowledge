---
description: Advisor Live - find out what is wrong at the running plant, change nothing
metadata:
  tcagent-category: Advisor
  tcagent-tags: advisor, live, diagnose, commissioning, maintenance
  tcagent-requires-tcagent: ">=0.52.1"
  tcagent-requires-module: runtime
---
Start an Advisor run at the running plant: tc_advisor action=start kind=diagnose trigger=live. You only read: never write a variable, never start, stop or acknowledge anything - people can be at the machine. The problem: {input:What is wrong, where, since when?}. First tc_advisor action=watch_check and action=watch_list; if watch_check says the code may not match the PLC, conclude only from values and say so; if a plugin names a skill, load it. Then go from the top level down only as far as you need: values with ads_read, the code that sets them, the step chains, the runtime messages. Tell me what a person at the machine should check first. Record the proven cause with tc_advisor action=record (kind=diagnose, evidence as variable = value with object and line, an order for an agent with the workflow bug-fix), then tc_advisor action=finish. If you find variables that signal this fault and are not watched yet, propose them for .tcagent\advisor-watch.json and add them with tc_advisor action=watch_add only after I agreed.
