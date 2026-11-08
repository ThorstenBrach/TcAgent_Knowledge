---
description: Review the whole PLC project - checks over everything, deep reviews of the hot spots, a report
metadata:
  tcagent-category: Review
  tcagent-tags: review, project, handover, acceptance, release
  tcagent-requires-tcagent: ">=0.52.1"
---
Start the workflow project-review (tc_workflow action=start name=project-review). What the review is for: {input:Why the review?|handover|acceptance|before a release|a known problem}. Change nothing. Record each finding that should be acted on with tc_advisor action=record, with an order I can send to an agent.
