---
title: "Initializer-Coding Agent Architecture"
tags: [concept, agent-architecture, long-running]
date: 2026-05-02
sources: ["sources/anthropic-effective-harnesses.md", "raw/text/anthropic-effective-harnesses.md"]
---

# Initializer-Coding Agent Architecture

A two-part agent architecture designed by Anthropic for effective long-running autonomous software engineering across many context windows.

## The Pattern

Split agent work into two distinct roles:

### Initializer Agent
- Runs **once** — the very first session
- Sets up the environment scaffolding that enables future incremental work
- Outputs:
  - `init.sh` — script to start the development server
  - Feature list file (JSON) — comprehensive breakdown of all required features
  - `claude-progress.txt` — empty progress log file
  - Initial git commit — baseline snapshot of setup files

### Coding Agent
- Runs **every subsequent session** — potentially hundreds of times
- Makes incremental progress: one feature at a time
- Leaves structured updates before ending each session
- Must maintain a clean state appropriate for merging to main

## Why Two Roles?

A single agent prompt fails in long-running tasks because:

1. **One-shotting:** Without setup scaffolding, the agent tries to build everything at once and runs out of context
2. **Premature completion:** After partial progress, the agent surveys the codebase and declares the job done

The initializer agent creates the constraints (feature list, progress tracking) that prevent these failure modes.

## Key Mechanisms

### Feature List File (JSON)

```json
{
  "category": "functional",
  "description": "New chat button creates a fresh conversation",
  "steps": ["..."],
  "passes": false
}
```

- All features initially marked `"passes": false`
- Coding agents can only change `passes` — cannot remove or edit test steps
- JSON format chosen because models less likely to inappropriately modify it vs Markdown
- claude.ai clone example: 200+ features

### Progress File (`claude-progress.txt`)

- Append-only log of what each agent session accomplished
- New agents read it first to understand the state of work
- Replaces the need to reconstruct context from scratch

### Git as Recovery Mechanism

- Every coding agent commits with descriptive messages
- Agents can `git log` to learn what was recently done
- Broken states can be reverted to last working commit

## Relationship to Other Patterns

- **[[generator-evaluator-architecture]]** — different pattern: gen/eval loop for quality; initializer-coding is about session continuity
- **[[guides-and-sensors]]** — the feature list acts as a guide; tests act as sensors
- **[[sprint-contracts]]** — the feature list serves as a form of sprint contract between initializer and coding agents
- **[[context-management-for-agents]]** — the architecture solves context degradation across sessions

## Source

- Anthropic: "Effective harnesses for long-running agents" ([2026](sources/anthropic-effective-harnesses.md))
- Authors: Justin Young, Anthropic Engineering team
