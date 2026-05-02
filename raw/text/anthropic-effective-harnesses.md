# Effective harnesses for long-running agents

**Source:** Anthropic Engineering Blog
**URL:** https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
**Fetched:** 2026-05-02

---

As AI agents become more capable, developers are increasingly asking them to take on complex tasks requiring work that spans hours, or even days. However, getting agents to make consistent progress across multiple context windows remains an open problem.

## The long-running agent problem

The Claude Agent SDK is a powerful, general-purpose agent harness adept at coding, as well as other tasks that require the model to use tools to gather context, plan, and execute. It has context management capabilities such as compaction, which enables an agent to work on a task without exhausting the context window. Theoretically, given this setup, it should be possible for an agent to continue to do useful work for an arbitrarily long time.

However, compaction isn't sufficient. Out of the box, even a frontier coding model like Opus 4.5 running on the Claude Agent SDK in a loop across multiple context windows will fall short of building a production-quality web app if it's only given a high-level prompt, such as "build a clone of claude.ai."

Claude's failures manifested in two patterns:

1. **One-shotting:** The agent tried to do too much at once — essentially attempting to complete the entire app in one go. This often led to running out of context in the middle of implementation, leaving the next session to start with a feature half-implemented and undocumented.

2. **Premature completion:** After some features were built, a later agent instance would look around, see progress, and declare the job done.

This decomposes the problem into two parts:

- **Setup:** An initial environment that lays the foundation for all required features, setting up the agent to work step-by-step and feature-by-feature.
- **Incremental progress:** Each agent must make incremental progress toward its goal while leaving the environment in a clean state at the end of a session — code appropriate for merging to main (no major bugs, well-documented, clean).

The solution uses a two-part agent architecture:

- **Initializer agent:** The very first agent session uses a specialized prompt to set up the initial environment: an `init.sh` script, a `claude-progress.txt` file for logging, and an initial git commit showing what files were added.
- **Coding agent:** Every subsequent session asks the model to make incremental progress, then leave structured updates.

## Environment management

### Feature list

To address one-shotting and premature completion, the initializer agent writes a comprehensive file of feature requirements expanding on the user's initial prompt. In the claude.ai clone example, this meant over 200 features, all initially marked as "failing."

```json
{
  "category": "functional",
  "description": "New chat button creates a fresh conversation",
  "steps": [
    "Navigate to main interface",
    "Click the 'New Chat' button",
    "Verify a new conversation is created",
    "Check that chat area shows welcome state",
    "Verify conversation appears in sidebar"
  ],
  "passes": false
}
```

Coding agents are prompted to edit this file only by changing the `passes` field. Strongly-worded instructions prevent removing or editing tests. JSON was chosen over Markdown because models are less likely to inappropriately change JSON files.

### Incremental progress

With the initial environment scaffolding in place, the coding agent is asked to work on only one feature at a time. This incremental approach was critical to addressing the tendency to do too much at once.

The best way to elicit clean state behavior was to ask the model to:
- Commit progress to git with descriptive messages
- Write summaries of progress in a progress file

### Testing

A major failure mode was Claude marking features as complete without proper testing. It tended to make code changes and do basic testing but failed to recognize that features didn't work end-to-end.

The solution was explicit prompting to use browser automation tools (e.g., Puppeteer MCP server) and do testing as a human user would. This dramatically improved performance, as the agent could identify and fix bugs not obvious from code alone.

## Getting up to speed

Every coding agent runs through a series of steps to get its bearings:

1. Run `pwd` to see the working directory
2. Read git logs and progress files to understand recent work
3. Read the features list file and choose the highest-priority incomplete feature
4. Run `init.sh` to start the development server
5. Run basic end-to-end tests before implementing new features

### Typical session flow:

```
1. Get bearings (pwd, read progress file, read feature list, git log)
2. Check if app works (run init.sh, test basic functionality)
3. Review remaining features to implement
4. Work on the next feature
5. Commit and update progress
```

## Agent failure modes and solutions

| Problem | Initializer Agent Solution | Coding Agent Solution |
|---------|---------------------------|----------------------|
| Declares victory too early | Set up feature list file with structured JSON of end-to-end features | Read feature list, choose single feature to work on |
| Leaves environment buggy | Initial git repo and progress notes | Read progress + git log, test dev server, commit + update progress |
| Marks features done prematurely | Set up feature list file | Self-verify all features; only mark "passing" after careful testing |
| Has to figure out how to run app | Write init.sh script | Read init.sh to start servers |

## Future work

Open questions remain:

- Single general-purpose coding agent vs. multi-agent architecture (specialized testing, QA, code cleanup agents)
- Generalizing beyond full-stack web app development to scientific research, financial modeling
