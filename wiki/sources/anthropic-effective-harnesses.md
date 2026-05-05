---
title: "Effective harnesses for long-running agents"
tags: [source, agent-architecture, long-running]
date: 2026-05-02
authors: [Justin Young, Anthropic Engineering]
url: https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
sources: ["raw/text/anthropic-effective-harnesses.md"]
---

# Effective harnesses for long-running agents

**Source:** Anthropic Engineering Blog
**Authors:** [[justin-young|Justin Young]] (writer), with contributions from David Hershey, [[prithvi-rajasekaran|Prithvi Rajasakeran]], Jeremy Hadfield, et al.
**Published:** ~2026

## Overview

Anthropic's research on enabling the Claude Agent SDK to work effectively across many context windows for long-running autonomous software engineering. The core insight: agents need an initializer to set up the environment, and coding agents must make incremental progress while leaving structured artifacts for the next session.

## Key Findings

### Two-part solution

1. **Initializer agent** — specialized prompt for the very first session:
   - Sets up `init.sh` script to run the development server
   - Creates `claude-progress.txt` for logging agent activity
   - Writes a comprehensive feature list file (JSON format)
   - Makes an initial git commit showing setup files

2. **Coding agent** — every subsequent session:
   - Makes incremental progress (one feature at a time)
   - Leaves structured updates (git commits + progress notes)
   - Maintains a clean state appropriate for merging to main

### Four common failure modes

| Failure Mode | Root Cause | Solution |
|---|---|---|
| **One-shotting** | Agent tries to build everything at once | Feature list file with 200+ granular features, all initially "failing" |
| **Premature completion** | Agent sees partial progress and declares done | Strong instructions to work incrementally, one feature per session |
| **Buggy/undocumented state** | Agent leaves code in broken state | Git commits + progress file; read at start of each session |
| **Premature test passing** | Agent tests but doesn't verify end-to-end | Browser automation (Puppeteer MCP); self-verify before marking passes |

### Feature list pattern

- Structured JSON file with detailed feature descriptions
- Each feature has: category, description, test steps, passes (boolean)
- Models less likely to inappropriately change JSON vs Markdown
- Coding agents can only change `passes` field — cannot remove/edit tests
- Example: claude.ai clone had 200+ features

### Typical coding agent session flow

```
1. pwd — check working directory
2. Read claude-progress.txt — understand recent work
3. Read feature list — find highest-priority incomplete feature
4. Git log --oneline -20 — review recent commits
5. Run init.sh — start dev server
6. End-to-end test — verify app isn't broken
7. Work on next feature
8. Commit + update progress
```

### Testing insights

- Without explicit prompting, Claude makes changes but fails to recognize features don't work end-to-end
- Browser automation tools (Puppeteer MCP) dramatically improve bug detection
- Claude's vision limitations: can't see browser-native alert modals → features relying on these are buggier

### Future directions

- **Multi-agent architecture:** specialized testing, QA, code cleanup agents vs. single general-purpose agent
- **Generalization:** beyond web apps to scientific research, financial modeling

## Related Wiki Pages

- [[harness-engineering]] — overarching methodology
- [[guides-and-sensors]] — feedforward vs feedback controls (feature list = guide, tests = sensors)
- [[generator-evaluator-architecture]] — related multi-agent pattern
- [[one-shot-agent]] — contrasted with incremental approach
- [[codex]] — agent harness that benefits from these patterns
- [[claude]] — the model being harnessed in this research
