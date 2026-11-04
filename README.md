# TcAgent Knowledge

The built-in knowledge of [TcAgent](https://github.com/ThorstenBrach/TcAgent): skills, prompts, workflows and risk rules for working on
TwinCAT 3 projects with AI agents.

| Folder | What it holds |
|---|---|
| `skills/<name>/SKILL.md` | How the agent does a kind of task, in the Agent Skills format |
| `prompts/<name>.md` | Prepared requests, chosen with `/` in the TcAgent Chat |
| `workflows/<name>/WORKFLOW.md` | Steps with checkpoints |
| `risk-rules/<topic>.md` | What the risk analysis checks in every project |

TcAgent includes this repository as a Git submodule in `knowledge/`, so every TcAgent version ships a known state of it. The format
of the files is described in
[KNOWLEDGE_LAYERS.md](https://github.com/ThorstenBrach/TcAgent/blob/main/docs/KNOWLEDGE_LAYERS.md).

Your own rules, skills and prompts do not belong here: they live on the company, team, user and project levels of TcAgent, and a
later level replaces a file of the same name.

Skills and prompts are instructions to an AI agent. Review a change here as carefully as a change to the code of TcAgent.

## License

[MIT](LICENSE)
