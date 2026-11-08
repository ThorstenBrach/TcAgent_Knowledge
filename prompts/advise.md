---
description: Advisor - read, advise and hand over an order, change nothing
metadata:
  tcagent-category: Advisor
  tcagent-tags: advisor, review, shadow, findings
  tcagent-requires-tcagent: ">=0.52.1"
---
Start an Advisor run: tc_advisor action=start kind={input:What kind of advice?|review|diagnose|cause} trigger=chat. From now on you change nothing - TcAgent refuses it. Look at {input:What should the Advisor look at?|the open object|the changes of today|the whole project}. Prove every finding with tool outputs, and record each real one with tc_advisor action=record: finding, evidence with object and line, proposal, confidence, and an order - a self-contained prompt I can send to an agent to act on it, naming the workflow. Few findings that matter beat many small ones. End with tc_advisor action=finish and a short list of what you recorded.
